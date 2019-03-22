Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD009C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F05D218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553258374;
	bh=IqUEDCE0cizzz/gnqrwfl3SyK713O3JeJ/vN/vWFX4E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GcHmPJKyIo8yr44PqNrMcwCBbgE5eDbWVX/YbMdFWBY2nPv3RJRTlMGtihqC0spn3
	 wabO/V/+CPk1E+QuINR0bSl+aDpTYeTKiK8JMdweI6sH4l5JKCogDrsWMO74UBn471
	 EgS5PQPB8axYWYm6rqWYWxGB3aIwlboZ9uz4tJKY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388607AbfCVMHf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:07:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:45820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388812AbfCVMHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:07:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6201421929;
        Fri, 22 Mar 2019 12:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256444;
        bh=IqUEDCE0cizzz/gnqrwfl3SyK713O3JeJ/vN/vWFX4E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eiCxca60TnBEEuNlZxfvJOPN0BVM+SSmAd5lvSLT7G0mYpx/1mXGxd2Poc0wztd65
         JkzGmUDskoUS8ce8+EuitzzRvybOUdJnw5TUrs1VYXoQ4zHw8jAn7fX/BAU41Am3zY
         Q+t3qDuR+tBfnRqjTD7J8F9AMviX477SPPHxtbzo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Misael Lopez Cruz <misael.lopez@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 4.19 192/280] clk: clk-twl6040: Fix imprecise external abort for pdmclk
Date:   Fri, 22 Mar 2019 12:15:45 +0100
Message-Id: <20190322111328.858182060@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tony Lindgren <tony@atomide.com>

commit 5ae51d67aec95f6f9386aa8dd5db424964895575 upstream.

I noticed that modprobe clk-twl6040 can fail after a cold boot with:
abe_cm:clk:0010:0: failed to enable
...
Unhandled fault: imprecise external abort (0x1406) at 0xbe896b20

WARNING: CPU: 1 PID: 29 at drivers/clk/clk.c:828 clk_core_disable_lock+0x18/0x24
...
(clk_core_disable_lock) from [<c0123534>] (_disable_clocks+0x18/0x90)
(_disable_clocks) from [<c0124040>] (_idle+0x17c/0x244)
(_idle) from [<c0125ad4>] (omap_hwmod_idle+0x24/0x44)
(omap_hwmod_idle) from [<c053a038>] (sysc_runtime_suspend+0x48/0x108)
(sysc_runtime_suspend) from [<c06084c4>] (__rpm_callback+0x144/0x1d8)
(__rpm_callback) from [<c0608578>] (rpm_callback+0x20/0x80)
(rpm_callback) from [<c0607034>] (rpm_suspend+0x120/0x694)
(rpm_suspend) from [<c0607a78>] (__pm_runtime_idle+0x60/0x84)
(__pm_runtime_idle) from [<c053aaf0>] (sysc_probe+0x874/0xf2c)
(sysc_probe) from [<c05fecd4>] (platform_drv_probe+0x48/0x98)

After searching around for a similar issue, I came across an earlier fix
that never got merged upstream in the Android tree for glass-omap-xrr02.
There is patch "MFD: twl6040-codec: Implement PDMCLK cold temp errata"
by Misael Lopez Cruz <misael.lopez@ti.com>.

Based on my observations, this fix is also needed when cold booting
devices, and not just for deeper idle modes. Since we now have a clock
driver for pdmclk, let's fix the issue in twl6040_pdmclk_prepare().

Cc: Misael Lopez Cruz <misael.lopez@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clk/clk-twl6040.c |   53 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 51 insertions(+), 2 deletions(-)

--- a/drivers/clk/clk-twl6040.c
+++ b/drivers/clk/clk-twl6040.c
@@ -41,6 +41,43 @@ static int twl6040_pdmclk_is_prepared(st
 	return pdmclk->enabled;
 }
 
+static int twl6040_pdmclk_reset_one_clock(struct twl6040_pdmclk *pdmclk,
+					  unsigned int reg)
+{
+	const u8 reset_mask = TWL6040_HPLLRST;	/* Same for HPPLL and LPPLL */
+	int ret;
+
+	ret = twl6040_set_bits(pdmclk->twl6040, reg, reset_mask);
+	if (ret < 0)
+		return ret;
+
+	ret = twl6040_clear_bits(pdmclk->twl6040, reg, reset_mask);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+/*
+ * TWL6040A2 Phoenix Audio IC erratum #6: "PDM Clock Generation Issue At
+ * Cold Temperature". This affects cold boot and deeper idle states it
+ * seems. The workaround consists of resetting HPPLL and LPPLL.
+ */
+static int twl6040_pdmclk_quirk_reset_clocks(struct twl6040_pdmclk *pdmclk)
+{
+	int ret;
+
+	ret = twl6040_pdmclk_reset_one_clock(pdmclk, TWL6040_REG_HPPLLCTL);
+	if (ret)
+		return ret;
+
+	ret = twl6040_pdmclk_reset_one_clock(pdmclk, TWL6040_REG_LPPLLCTL);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static int twl6040_pdmclk_prepare(struct clk_hw *hw)
 {
 	struct twl6040_pdmclk *pdmclk = container_of(hw, struct twl6040_pdmclk,
@@ -48,8 +85,20 @@ static int twl6040_pdmclk_prepare(struct
 	int ret;
 
 	ret = twl6040_power(pdmclk->twl6040, 1);
-	if (!ret)
-		pdmclk->enabled = 1;
+	if (ret)
+		return ret;
+
+	ret = twl6040_pdmclk_quirk_reset_clocks(pdmclk);
+	if (ret)
+		goto out_err;
+
+	pdmclk->enabled = 1;
+
+	return 0;
+
+out_err:
+	dev_err(pdmclk->dev, "%s: error %i\n", __func__, ret);
+	twl6040_power(pdmclk->twl6040, 0);
 
 	return ret;
 }


