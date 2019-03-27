Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F90C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 912662075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553715220;
	bh=rEYuKFJ2Cscjzc31Ovq2NcrqoB0i5CBvRuOemQu/+7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zjRyb/UvjeIYyWrNr+NsDi7+1qi54WJVRp48ErsBkw+7A0mAZg4zmORmSsqQogyzc
	 H9ggIYfZaAQVzif4eFl0cdr0tFwBUmDb//Y+kDUUqQ3AusljxLMFKJKeXr3KuCxH99
	 mi8Gx1lW0gakJ5k9OXPSRobb9yjJoXrOA0raQeiU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387655AbfC0Tdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:33:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:42360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730522AbfC0SC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:02:28 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBE1821738;
        Wed, 27 Mar 2019 18:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553709747;
        bh=rEYuKFJ2Cscjzc31Ovq2NcrqoB0i5CBvRuOemQu/+7o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rb10KEBDqVovp5sYjvewhd+OPbf/P4LbUkxzQlMohxRabjdWuEF6UEvazonEijqRM
         ZJlRNG6p8BkioMbUnHW5gmln6gNxIuF1yvQWlZ3BJVGDGEtLJki2oI4CsAIzS5vIXV
         5nRcz8Bpkfn7HQ8qm8ecYHiiPB48DX67Y8k+kVQs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 017/262] clk: ti: clkctrl: Fix clkdm_name regression for TI_CLK_CLKCTRL_COMPAT
Date:   Wed, 27 Mar 2019 13:57:52 -0400
Message-Id: <20190327180158.10245-17-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

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

