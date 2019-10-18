Return-Path: <SRS0=/uHP=YM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D83FFCA9EA9
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 00:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A921721897
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 00:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="baAQReQx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390805AbfJSADi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 20:03:38 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39492 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730521AbfJSADi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 20:03:38 -0400
Received: by mail-wm1-f66.google.com with SMTP id v17so7576702wml.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 17:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=WAd+eoXj8rMBgjdwJQ/n/lojcxhy8TyVDnA3tTrrWOQ=;
        b=baAQReQxk6oaFS2zApSA26y2fVX/yf1YvO270iCIx5N9S2FJn9xbq8S3V/Ixxn86Ji
         MnXzioVccBIzj1yKb7Dp9SOSr/ZQ1RObfnDh2J2LW1jEOtVbxubAw5NXSMTwynu+hlPn
         qNmNaU0n3NA6LI2NhzbQQEggNIjVSk971V5i1DWc7f9kwFwoSqM/SL7kSUl4glHSMMlH
         2ZXoLBqESIwAHEGXrh1E/zJeDqW3RBtgI/iDM3MTiK6rt91d/pBf4jEtZGQuVlGJkF8N
         8WGnPWM/YQv/T5qd0oVbSdyZsjTbH6ksjBiSN2Xa7ZrAWww7+LoHY7NqhH6SGzffH503
         3ytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WAd+eoXj8rMBgjdwJQ/n/lojcxhy8TyVDnA3tTrrWOQ=;
        b=GvgHYY0yKKFVFLbN/x0+AEKNlhthf1ZokhGpoImGID6iYlQRZ2faxtEYvLoyhy9XZr
         3J3G3xSs8RQN61F+iKF6gFKXElQko/F8D3CSxEgNTzigqnIfGvUCXu04GuLjplYyqShc
         W8jU3UFwDoqdi0zQMb6BueRcardSUzH4rpJYn8e4lwOXa6cfZySofK1KMEthHjv8iyRr
         Q085nuLaZHfudBoAPuXo/dz8KA9MI/PEDdpE/Cer0TrEp1jUPOtjZgSeM+JQN3KeTpRp
         CaO7tnS/uh0l9Cj9BMDMqovU4A+AmgZTKEHaTtqxHiJFThCVaY65ZM4PIrdW8PTBBS/q
         M69g==
X-Gm-Message-State: APjAAAW2N/jqlHNDWkRFSAuvUR8i7wNSKznAWInS7DPpHjXwhjJuJr4S
        1YPuNwMdg9T0qaoR8AUSMfddh5iv
X-Google-Smtp-Source: APXvYqxof3tazM3aejcDp5mrzkrOBHEEWgX3P6zZRV+hbvxON0hRCN69++MGXx6cJSkWf0+D9ku2KA==
X-Received: by 2002:a05:600c:2319:: with SMTP id 25mr5327041wmo.3.1571443416275;
        Fri, 18 Oct 2019 17:03:36 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id n3sm7760800wrr.50.2019.10.18.17.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 17:03:35 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org (open list:BROADCOM STB NAND FLASH DRIVER),
        bcm-kernel-feedback-list@broadcom.com (open list:BROADCOM STB NAND
        FLASH DRIVER), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] mtd: rawnand: brcmnand: Fix sparse warning in has_flash_dma()
Date:   Fri, 18 Oct 2019 16:38:44 -0700
Message-Id: <20191018233844.23838-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse rightfully complained about has_flash_dma():
+drivers/mtd/nand/brcmnand/brcmnand.c:951:40: warning: Using plain integer as NULL pointer [sparse]

Fixes: 27c5b17cd1b1 ("mtd: nand: add NAND driver "library" for Broadcom STB NAND controller")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index 15ef30b368a5..73f7a0945399 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -909,7 +909,7 @@ static inline void brcmnand_set_wp(struct brcmnand_controller *ctrl, bool en)
 
 static inline bool has_flash_dma(struct brcmnand_controller *ctrl)
 {
-	return ctrl->flash_dma_base;
+	return ctrl->flash_dma_base != NULL;
 }
 
 static inline void disable_ctrl_irqs(struct brcmnand_controller *ctrl)
-- 
2.17.1

