Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BBEC10F0C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB734205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554370373;
	bh=XuH24fgkmdKrRZPKt4UsQEktP1TM2UB2K/YUBBsYHDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0d5wtF4qWBiF1+UeNYLrtjCLTljH2YtagsTsd0FnvL13RgD60INz8bLzbEoNcvI9L
	 mSZAju0qdVEyBwmAS+7m+GE90zNh4jz5rHgftVnUe/Rs5uUWuCE+n6ERnp1EKOmLYZ
	 evWrEogF4ZXx4WzOIhW7Gy6Nj4nZf18GPajPISu8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732691AbfDDJIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:08:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:47796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732048AbfDDJIk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:08:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39E2B21741;
        Thu,  4 Apr 2019 09:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368919;
        bh=XuH24fgkmdKrRZPKt4UsQEktP1TM2UB2K/YUBBsYHDA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wcO80lFSWidegeebwqURKgdHJ4eouRKbN3Ofmz8i/vGZoX+En57odqTtCGEiV4pSp
         ixgb+pHrpAaJXN/BQu0SNOUXBDCi1euIi6qxULcj+l5asT4C1qRbnujIKIMQw2AiyF
         Sad0JQ1AfuyNJiLFyGzeAAol8V83c4cEtQGI5bI8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tero Kristo <t-kristo@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 014/246] clk: ti: clkctrl: Fix clkdm_name regression for TI_CLK_CLKCTRL_COMPAT
Date:   Thu,  4 Apr 2019 10:45:14 +0200
Message-Id: <20190404084619.690847928@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit d17a718db40df2548e99a62dc3d7e5e2b38143cc ]

Commit a72d785021cb ("clk: ti: Prepare for remove of OF node name")
changed the code to use kasprintf() for provider->clkdm_name but also
changed the offset used later on by three. We don't need to change the
offset as we already have the extra three characters in the format for
kasprintf with "%pOFnxxx".

This caused the clocks with TI_CLK_CLKCTRL_COMPAT to have NULL
clk->clkdm_name for omap4 and 5. And null clkdm_name can cause module
reset, enable, and idle to fail.

The issue can also be seen also when enabling DEBUG for clkctrl.c
and then we start seeing "clock: could not associate" messages for
omap4 and 5 as the generated name is something like "l4_wkclkdm" instead
of "l4_wkup_clkdm" that's needed.

Let's fix the issue with a partial revert of commit a72d785021cb ("clk:
ti: Prepare for remove of OF node name").

ALso note that in general code should not depend on the dts node names.
And the node names should be generic types like clock-domain in this case.
This could be fixed later by using separate compatible properties for the
clockdomains, or by adding soc_device_match() table with reg offsets
to the driver. But let's fix the regression first.

Fixes: a72d785021cb ("clk: ti: Prepare for remove of OF node name")
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/ti/clkctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/ti/clkctrl.c b/drivers/clk/ti/clkctrl.c
index 40630eb950fc..85d7f301149b 100644
--- a/drivers/clk/ti/clkctrl.c
+++ b/drivers/clk/ti/clkctrl.c
@@ -530,7 +530,7 @@ static void __init _ti_omap4_clkctrl_setup(struct device_node *node)
 		 * Create default clkdm name, replace _cm from end of parent
 		 * node name with _clkdm
 		 */
-		provider->clkdm_name[strlen(provider->clkdm_name) - 5] = 0;
+		provider->clkdm_name[strlen(provider->clkdm_name) - 2] = 0;
 	} else {
 		provider->clkdm_name = kasprintf(GFP_KERNEL, "%pOFn", node);
 		if (!provider->clkdm_name) {
-- 
2.19.1



