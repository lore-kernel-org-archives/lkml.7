Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E277EC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 18:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCAAE20679
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 18:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SkynIjmx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbfKTSWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 13:22:11 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42131 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727671AbfKTSWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 13:22:10 -0500
Received: by mail-wr1-f65.google.com with SMTP id a15so1017226wrf.9;
        Wed, 20 Nov 2019 10:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=eeX2JNGz9HgVPRGIoEvaZTiS7IkFyrAlD7or7JXr8vc=;
        b=SkynIjmxsxkmxh/wPmUK8pd7PNaphXdyhEUIdnq3SblLrQkpRfaBQ95P7IllqxCE1Q
         bYtNWuLYhAsujPXtTVtvu+Ec8gqz8k4KrLrcrzwzqBFTVDRLl5FCL5SSqpu9xJY/FUmO
         OiQJyBw1pzVcqb+GeRYMTMEp5MwcYYc0qO2it/cLFXLExE3BkxBXB7NpxJ4s7eksSI4I
         4ndtiez1cia0Mt6vB/KRO9T8K2+T6vk2/4YgN4pAGbK0oXClH+jWdvLsLmFMPWeymO01
         f4Wo29TPkN1Jm5DVID+ZcebefoVYBCUR/jwfe5B+HxqIWB5Rx+iQSsK4V5nk5Df05eNi
         klPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eeX2JNGz9HgVPRGIoEvaZTiS7IkFyrAlD7or7JXr8vc=;
        b=oOCa3ABozCLoGxg56+g0wlpcTGWcT3LfyupDW42pQGjh9JjbFlNtd3T/Fl/nKjfL7B
         +VVwuo/r+YKCErM/jsvQgqQcnSCs6lVq5Tty6tQAROnT7gITsM/MM0ZFwZx++Qo4rsRi
         qpHqglQexRjp9fR7Ihkpy0XGgnLPGgr/nwq7C/Doka8SgaugAqsd7Scnxj1eXjML/O52
         bWHxHsIOc6ufNLV7RNk/LXxU+cjoneY0lSab4gwit0tnHFtjSldiIgZxeuPSOQIM0ijU
         xWwqYWyYJIZTIAlRKumkGdmvXfmC+irDWiRkWNvFyJnMQZkLq1CdM3n+I2chrHvFUEdC
         OjBw==
X-Gm-Message-State: APjAAAVJTRNFSThDx3ZpluGVI5J3gU7MuzGYY1Bkfc/pLmYJwmWCJGRV
        tU72L8mWxwigAoNrVrCg+ZY=
X-Google-Smtp-Source: APXvYqydFnhbveIbTOtqqNnEIOn1jk8I2Y9/1K8cL2fZdPqDactkdjK8DhnZY+GtVUCkWTFR9vhWuw==
X-Received: by 2002:a5d:6746:: with SMTP id l6mr846246wrw.349.1574274127481;
        Wed, 20 Nov 2019 10:22:07 -0800 (PST)
Received: from mail.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id x205sm151153wmb.5.2019.11.20.10.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 10:22:06 -0800 (PST)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     linux-mtd@lists.infradead.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, Kamal Dasu <kdasu.kdev@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH 1/3] dt: bindings: brcmnand: Add support for flash-edu
Date:   Wed, 20 Nov 2019 13:20:57 -0500
Message-Id: <20191120182153.29732-1-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding support for EBI DMA unit (EDU).

Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
---
 .../devicetree/bindings/mtd/brcm,brcmnand.txt          | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.txt b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.txt
index 82156dc8f304..05651a654c66 100644
--- a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.txt
+++ b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.txt
@@ -35,11 +35,11 @@ Required properties:
                      (optional) NAND flash cache range (if at non-standard offset)
 - reg-names        : a list of the names corresponding to the previous register
                      ranges. Should contain "nand" and (optionally)
-                     "flash-dma" and/or "nand-cache".
-- interrupts       : The NAND CTLRDY interrupt and (if Flash DMA is available)
-                     FLASH_DMA_DONE
-- interrupt-names  : May be "nand_ctlrdy" or "flash_dma_done", if broken out as
-                     individual interrupts.
+                     "flash-dma" or "flash-edu" and/or "nand-cache".
+- interrupts       : The NAND CTLRDY interrupt, (if Flash DMA is available)
+                     FLASH_DMA_DONE and if EDU is avaialble and used FLASH_EDU_DONE
+- interrupt-names  : May be "nand_ctlrdy" or "flash_dma_done" or "flash_edu_done",
+                     if broken out as individual interrupts.
                      May be "nand", if the SoC has the individual NAND
                      interrupts multiplexed behind another custom piece of
                      hardware
-- 
2.17.1

