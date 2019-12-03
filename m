Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870D0C432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 12:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E5772068E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 12:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="K6UKXHMt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="x/m6vK9v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfLCMgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 07:36:53 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:58839 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725997AbfLCMgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 07:36:52 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 977F26E85;
        Tue,  3 Dec 2019 07:36:51 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 03 Dec 2019 07:36:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=AOngRiTxh05CH
        c+UEUsafbobBZ4W/uuHTrMYg0GNvQ0=; b=K6UKXHMtMTt+v5izg/FIaaOlfWIFx
        QKYJDjdBLuiPwveORL/Z7ZLqKLtMCxJRHJKBFe3S7YTLYkgPg/R9XF3ttt8hME1d
        kLuIRvmd3jjzfMNKPW1r8sYa7MY6COKm9orTx3D8AmY7J3UcU2FucQwOhZ4D0knV
        4ZjtQ8WcDbtBnak2CZlWdq8m+1oACZ5YoWtxKlkjNxuhFrzc+AEdljhYu2A1DMuz
        JZcYpkC2e1TDhX/s1VZ2N5A+DACFaKATb+wwD7miq7Kq03T3vsLwQK9G6+3rI10j
        U5+DhpevETDEW5Kj4BY3H6eXQNs7/rFf3VDPk4nBIwfQKtfcPMD1isIxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=AOngRiTxh05CHc+UEUsafbobBZ4W/uuHTrMYg0GNvQ0=; b=x/m6vK9v
        aD6N1e8pg1RiacnJjH5ClB/vRaIObK4ns/1Mshh/9q+gTrY6xvBV68m/xCwRabYz
        rnoV0eUwo+4Idx2DmWz+mC0NHAwE6k/Ko/DiNNBNvPVKTrNjQA/zh4J1O/kzhO+A
        b2W4eYJIUrdo+m6xntQI7fGRV7N3Ms7sFGq69sXPQte9iel94Boch5XOmjLcprlA
        2QeHA+g8JyVU+dX3/QHb2/63vC1ddaIvOcYi6qGzwkNvQZGIRT5TnfrY8R2TTH58
        +oYynpoIXNYE1AI7rvcmU36W1wL8G9ZvOoNoZOvoRjcyWXz3LEz653FoYfwlylNr
        J1/+YV9rYFuSWg==
X-ME-Sender: <xms:41bmXdQPNfT-Xk4pNrzu3Qjh2adO7GnC3PcHJVIAreIvMRD2wuac7w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudejjedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeetnhgurhgv
    ficulfgvfhhfvghrhicuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucfkphepudduke
    drvdduuddrledvrddufeenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvgifsegr
    jhdrihgurdgruhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:41bmXaMRxaaCkffEGZTaXDhawKltHxAWoW13bcJs5prKeWvjuLuuKA>
    <xmx:41bmXfkNoPeEBXK_pq_cNSN9vq4AV9NiwPQQyMm2rcVPBlUORF_4-w>
    <xmx:41bmXYaWfX9VanLCyYhINZjLp49kbbTNITPv3c8bN6ujn9363MCGrA>
    <xmx:41bmXWIW2rkDzbb1WnNe4fcZdtpq-Qcr4VMMMJ37_w4UQEblksPOXg>
Received: from mistburn.lan (unknown [118.211.92.13])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1C20430600D2;
        Tue,  3 Dec 2019 07:36:46 -0500 (EST)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     openipmi-developer@lists.sourceforge.net
Cc:     minyard@acm.org, robh+dt@kernel.org, mark.rutland@arm.com,
        joel@jms.id.au, arnd@arndb.de, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Haiyue Wang <haiyue.wang@linux.intel.com>
Subject: [PATCH 2/3] ipmi: kcs: Finish configuring ASPEED KCS device before enable
Date:   Tue,  3 Dec 2019 23:08:24 +1030
Message-Id: <84315a29b453068373c096c03433e3a326731988.1575376664.git-series.andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.5630f63168ad5cddf02e9796106f8e086c196907.1575376664.git-series.andrew@aj.id.au>
References: <cover.5630f63168ad5cddf02e9796106f8e086c196907.1575376664.git-series.andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The currently interrupts are configured after the channel was enabled.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Haiyue Wang <haiyue.wang@linux.intel.com>
---
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
