Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E43DC74A26
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 14:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E5D52086D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 14:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="LPCmO4+G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ogKsKni1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbfGJONo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 10:13:44 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:52857 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727093AbfGJONl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 10:13:41 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id CC558220A3;
        Wed, 10 Jul 2019 10:13:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 10 Jul 2019 10:13:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=VBwKd1WghoPxV
        Q8wzPfjIXtSva+XbmOsRragjWyFYUQ=; b=LPCmO4+GRtWF9BPtH5D+ayPoF1/Zg
        ZofzbOiq3/cjoBtADKEh211SiAjgYEZZLvn7+yZZNoKmK1AqRdpvwodgo3lSQrAn
        bd/+C8gPJRikXjsHnWenph59OQejanHUV8jH4RZcbtjvnHehVsgyo94eT+t5wBgJ
        OJrWH83MOj95rVcqq8htN1G1ai9DVaBRWTARtlJVLcqmBRNHgm3ahrH2Z6ZyjLhs
        XvBqJuXPV73Kik8VicvVr6YVzfkDCRK+ya2SK0AijokRvY/UaXKxFfBoqRN2Sulu
        laQl686mF0znAX8LtebjpzWUvf/P+SpZSL28UuTQsqaGAqvXoHKo9UxDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=VBwKd1WghoPxVQ8wzPfjIXtSva+XbmOsRragjWyFYUQ=; b=ogKsKni1
        U6jdZMgMBUQlrSXpRnEkOZrGp3CdA2Fjtq/0AE7VglI95FayedoWp32FibhRw+L5
        D6d82FtF7Rx9cu6c1iBYoJJAmocv9yRT6MjxE53Bl5h39XLFEcVEnR69SpSQdhjZ
        vAqYTUezSQ1vPN4/sUH9hUrVy4KvXn4zdD50ZF/6q0BZtMNQip1QNZ3YHX3lTiS+
        NfRYh9+xejHzfh4kL/Cs+hSBEsbt7+PfHWnbhA/pY1Bx85mv3ZOd7Yho5dp/v0jg
        04i0E9nfByoXUQrTTMVv8NAaWaP2CxN6YZd8CCBIVySIEzKecn5JrOgIQFHTjx3W
        g6Jr5WdN8fzDCQ==
X-ME-Sender: <xms:lPIlXW-AujqhJfgvPDqlYu8KttD_IymGfhrwMu8NZF4Li1-p2LjhEA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrgeeigdejhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetnhgurhgvficulfgvfhhfvghrhicuoegrnhgurhgvfiesrghj
    rdhiugdrrghuqeenucfkphepudegrddvrdekhedrvddvnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgvrhfuihiivgepud
X-ME-Proxy: <xmx:lPIlXQCEqmMQx5sKMPZVhVr2jZyGHMH6mM1CIjp4F4FXiNPyvX1zSA>
    <xmx:lPIlXYbzd1LNkXY1ec2eaO1-sXTXYAJOMnEhoVBI45Y0kuKP-TemYg>
    <xmx:lPIlXWA0LTHVxBbHnhI0REUtUevUTERv3b5v19xYcPI8tSx527SASA>
    <xmx:lPIlXSxIJ02fV0e8lRKtGZOAb38_C7Jbu0umYQKNAPxT1kw1-vXp2w>
Received: from localhost.localdomain (ppp14-2-85-22.adl-apt-pir-bras31.tpg.internode.on.net [14.2.85.22])
        by mail.messagingengine.com (Postfix) with ESMTPA id F34EB380075;
        Wed, 10 Jul 2019 10:13:37 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-aspeed@lists.ozlabs.org
Cc:     Ryan Chen <ryanchen.aspeed@gmail.com>, joel@jms.id.au,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrew Jeffery <andrew@aj.id.au>
Subject: [PATCH 2/3] ARM: config: aspeed-g5: Enable SD Controller
Date:   Wed, 10 Jul 2019 23:43:24 +0930
Message-Id: <20190710141325.20888-3-andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190710141325.20888-1-andrew@aj.id.au>
References: <20190710141325.20888-1-andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ryan Chen <ryanchen.aspeed@gmail.com>

Enable various options necessary for building the driver for the ASPEED
SD controller.

Signed-off-by: Ryan Chen <ryanchen.aspeed@gmail.com>
Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 arch/arm/configs/aspeed_g5_defconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/configs/aspeed_g5_defconfig b/arch/arm/configs/aspeed_g5_defconfig
index 249eeeb55d59..9cb3cfd35a59 100644
--- a/arch/arm/configs/aspeed_g5_defconfig
+++ b/arch/arm/configs/aspeed_g5_defconfig
@@ -182,6 +182,13 @@ CONFIG_USB_CONFIGFS_F_LB_SS=y
 CONFIG_USB_CONFIGFS_F_FS=y
 CONFIG_USB_CONFIGFS_F_HID=y
 CONFIG_USB_CONFIGFS_F_PRINTER=y
+CONFIG_MMC=y
+CONFIG_MMC_BLOCK=y
+CONFIG_MMC_BLOCK_MINORS=8
+CONFIG_MMC_DEBUG=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_PLTFM=y
+CONFIG_MMC_SDHCI_OF_ASPEED=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_CLASS_FLASH=y
-- 
2.20.1

