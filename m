Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DCD4C49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0449321924
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568931549;
	bh=8Oga840qT7mNdbKHWlniyreRrb6tdK+loARl/EV5NNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UdmgkDiPqnXCfCxfmQuWYDO8Al5WStsGuwZPlkqaL4jB7ssz6kkrW3gv/gxIpV5Qn
	 ApiwVlixANhcTZx4EX+RUDigwN3izuf9gc9Spgo//PGjulWsMwDVjCCTg1b7kxaoCI
	 xjiL586pZ/+8FH8EjkQpyCwbB4te2iZX6fHpS/RI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406634AbfISWTI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 18:19:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:60812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404569AbfISWTB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:19:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A119220678;
        Thu, 19 Sep 2019 22:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568931540;
        bh=8Oga840qT7mNdbKHWlniyreRrb6tdK+loARl/EV5NNI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nu2VvaY7wn7DhgOS8bhimpzGTR4bNZHLjDdOshZo5nUtxl/PpqzzwmllhlJt5HIqy
         QS7FNpOzzvkvod7UXSOlIf5ZNkN0++2cwBaENF5r73MJPwUIgaNpGY0wZ5O/1D/32A
         cVLl6NwpC0EgYlxMCXcE/6P9dreNmLuDw0+9R6JA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Douglas Anderson <dianders@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 4.9 23/74] clk: rockchip: Dont yell about bad mmc phases when getting
Date:   Fri, 20 Sep 2019 00:03:36 +0200
Message-Id: <20190919214807.033474114@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190919214800.519074117@linuxfoundation.org>
References: <20190919214800.519074117@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Douglas Anderson <dianders@chromium.org>

commit 6943b839721ad4a31ad2bacf6e71b21f2dfe3134 upstream.

At boot time, my rk3288-veyron devices yell with 8 lines that look
like this:
  [    0.000000] rockchip_mmc_get_phase: invalid clk rate

This is because the clock framework at clk_register() time tries to
get the phase but we don't have a parent yet.

While the errors appear to be harmless they are still ugly and, in
general, we don't want yells like this in the log unless they are
important.

There's no real reason to be yelling here.  We can still return
-EINVAL to indicate that the phase makes no sense without a parent.
If someone really tries to do tuning and the clock is reported as 0
then we'll see the yells in rockchip_mmc_set_phase().

Fixes: 4bf59902b500 ("clk: rockchip: Prevent calculating mmc phase if clock rate is zero")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clk/rockchip/clk-mmc-phase.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/clk/rockchip/clk-mmc-phase.c
+++ b/drivers/clk/rockchip/clk-mmc-phase.c
@@ -59,10 +59,8 @@ static int rockchip_mmc_get_phase(struct
 	u32 delay_num = 0;
 
 	/* See the comment for rockchip_mmc_set_phase below */
-	if (!rate) {
-		pr_err("%s: invalid clk rate\n", __func__);
+	if (!rate)
 		return -EINVAL;
-	}
 
 	raw_value = readl(mmc_clock->reg) >> (mmc_clock->shift);
 


