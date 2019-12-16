Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C7C9C2D0CE
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 02:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 621272467B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 02:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="pA+cRFbn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sAyLaezl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfLPC03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 21:26:29 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:39725 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726299AbfLPC02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 21:26:28 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 689E067AB;
        Sun, 15 Dec 2019 21:26:27 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sun, 15 Dec 2019 21:26:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=LMvNcL8FAR0Bl
        X1niTXZqCp51Bk+aavvUIWGJqthYZY=; b=pA+cRFbnpoLewByXQES392IPTTQSc
        SoDYUpKkgsRpJ4jCjKwJcJIoRtHUxfyPxvjFZOptkQvDAJvvGpBG9eJrWsg1rV0y
        uHnap82HcG2n2JffaTn48i77ec9m4/LXYD8EMHrJmkIuTwq+U2W6M3ljcqPiuaUQ
        AFG7vmIL/0SKnrKIiSOdc4coq8JVMF4Crbe6OPQtezw5pQ75gYztO7dEFwAXWCGC
        sQLGJv2/BFF4Gjl56xg9AHkqhBI6+Yp4Evh1XgxEcBbXt5n22sClND7VQXB2S+Vo
        zkORhdd5DrLogFqssQJ2SD2/0LUIkPpI/RkA9OReJaGU9RlgSRPpt1VqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=LMvNcL8FAR0BlX1niTXZqCp51Bk+aavvUIWGJqthYZY=; b=sAyLaezl
        nVDa7nWa/lv2KmmTKv+iVaX8/aBXtMuolc6l5o7T+rKwjOUb2HmFlOd87KBTNXRe
        phiIRXjTjiUBg6BC4TVWARHUEeLcvRKxwXTb09ot4KV/7TC1Y+rR6Xtb/NXtlOu+
        Yy0pRqUVYfBDD0JUEREi1gJm/ooTzCS7g4KXNvquwEuHE4LKI2IVtco9GjKEh3ET
        AUQoG5XaeshjGjyDQrF88EmEnsnqbTYQLoeqGiqkXMa3sG+O6zGlEKN05TS3UdQc
        3G4ZfNB+o+CJhy6D6ugZ+Rr4sFPJnlzj7UoVtB/RiUp86I9r9bndxMuI7fs2L6gk
        ekvHRHeCn2CJBg==
X-ME-Sender: <xms:U-v2Xf6AQiqUufcV_jnLE3Avuin4bP9kxxMx6EGXAYfVauVzIxsdeg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvddtgedggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehnughrvgifucflvghffhgvrhihuceorghnughrvgifsegr
    jhdrihgurdgruheqnecukfhppedvtddvrdekuddrudekrdeftdenucfrrghrrghmpehmrg
    hilhhfrhhomheprghnughrvgifsegrjhdrihgurdgruhenucevlhhushhtvghrufhiiigv
    pedt
X-ME-Proxy: <xmx:U-v2XZIVgo2FIv_cN7HNg_92Z50Du8rFRhcsbl8TgYMkuSF5y2dP7g>
    <xmx:U-v2XRdIB2CrZYlEGDY4vtG4NIhf_Ia20TdbuERk-Kaq_fnbudT4tQ>
    <xmx:U-v2XUdlEeSWBqbRUI8D7nJVJqBkpo97-8vloDnZHmGfiUlLnPOdpw>
    <xmx:U-v2XXL7MmRPmlLBoMOoJnPT0zvIzjCkvyfY85Q0fWNoBnH-iacL4w>
Received: from mistburn.au.ibm.com (bh02i525f01.au.ibm.com [202.81.18.30])
        by mail.messagingengine.com (Postfix) with ESMTPA id D5B4980059;
        Sun, 15 Dec 2019 21:26:22 -0500 (EST)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     openipmi-developer@lists.sourceforge.net
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        haiyue.wang@linux.intel.com, minyard@acm.org, arnd@arndb.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, robh+dt@kernel.org, joel@jms.id.au,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/3] ipmi: kcs: Finish configuring ASPEED KCS device before enable
Date:   Mon, 16 Dec 2019 12:57:41 +1030
Message-Id: <c0aba2c9dfe2d0525e9cefd37995983ead0ec242.1576462051.git-series.andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.fe20dfec1a7c91771c6bb574814ffb4bb49e2136.1576462051.git-series.andrew@aj.id.au>
References: <cover.fe20dfec1a7c91771c6bb574814ffb4bb49e2136.1576462051.git-series.andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The interrupts were configured after the channel was enabled. Configure
them beforehand so they will work.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Haiyue Wang <haiyue.wang@linux.intel.com>
---
v2: Update the commit message based on Corey's suggestion

 drivers/char/ipmi/kcs_bmc_aspeed.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/char/ipmi/kcs_bmc_aspeed.c b/drivers/char/ipmi/kcs_bmc_aspeed.c
index 3c955946e647..e3dd09022589 100644
--- a/drivers/char/ipmi/kcs_bmc_aspeed.c
+++ b/drivers/char/ipmi/kcs_bmc_aspeed.c
@@ -268,13 +268,14 @@ static int aspeed_kcs_probe(struct platform_device *pdev)
 	kcs_bmc->io_inputb = aspeed_kcs_inb;
 	kcs_bmc->io_outputb = aspeed_kcs_outb;
 
+	rc = aspeed_kcs_config_irq(kcs_bmc, pdev);
+	if (rc)
+		return rc;
+
 	dev_set_drvdata(dev, kcs_bmc);
 
 	aspeed_kcs_set_address(kcs_bmc, addr);
 	aspeed_kcs_enable_channel(kcs_bmc, true);
-	rc = aspeed_kcs_config_irq(kcs_bmc, pdev);
-	if (rc)
-		return rc;
 
 	rc = misc_register(&kcs_bmc->miscdev);
 	if (rc) {
-- 
git-series 0.9.1
