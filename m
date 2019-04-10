Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7607C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 19:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B675220850
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 19:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qNNRePeJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfDJT7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 15:59:05 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46227 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbfDJT7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 15:59:04 -0400
Received: by mail-lj1-f194.google.com with SMTP id h21so3248526ljk.13
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 12:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wcVt5VTKGlyZxp0vS8+Fu1r59HHgCfHanefStNqWyW4=;
        b=qNNRePeJKdY7jFnfDSk9PmpyTxY6zSzPSAtVRIWK+uHxJMacppvEn/3kXlOkTwFnk1
         uz5S+S6k/szSe3cRBRXt7t8V+Jl9+asGbYFbEE2UxvSsy2DAtX8ivFvuT+BfK7OydkmQ
         BprZTTXTXlQLr3aIH9y11wPdFzohP2cKdOqdWWNLaYOOj/Voob1MY0TFa9bX3nPi8WPm
         5ZfZGAMDo0rVka+2OC4SmA6bIzpRpR4LL9WKgiGhfxWkkrtRhMq2lg7DzmbvV73VK0is
         usC5IT+TGuKBi+D1/bvXF/whPmT2wDCf9DUMxxjSwXnrqVV7oEtpHwvtlKbH8HhvXgW9
         3paQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wcVt5VTKGlyZxp0vS8+Fu1r59HHgCfHanefStNqWyW4=;
        b=V7aqyuAHSc5u3Uk27gWxy2qo5U2PORDhymwXMTXIKAfbey4BHXYlh74LstbbJqXDUI
         yaGwnMLzIEJgfLbhphPTVZ/OWQXMK0elykBrUqiPir4+GFsz6VxznnxdJB8NEv64Xq8p
         6D9oJgTUQx4IEPqRiAiEBLFP+TNRFiWBHXtUsexy28gm2l9Fxoh35BFfuJ16b016kVWS
         ikUn7CihF+sEO3KLDjGVyj09djnztcmqDjtPG+Lx5j74HCyRhOcbaj3gXJSLFmRlQ3kC
         wqTfgcEk2k85OF5EsATxt/2g5ak+aE0W2ojj0kDzaBz5zDw+J3dy4MeGOhoS3Fib2w9n
         2Kbw==
X-Gm-Message-State: APjAAAUCnOiLcsmr3tDS/1pg+3YSo9O+yqxo5Cy8l8LXhTE1wKnZy1lX
        qrT/ka0HUWBKP92ryJYbG9rpDA==
X-Google-Smtp-Source: APXvYqzEU+l46yVUS0tw1cyCFtByDwJvoWU6r0hypUQaIJ8ibKACU2J4bsFIzFVDIBR8LGvfED1Lcg==
X-Received: by 2002:a2e:6c0f:: with SMTP id h15mr23337379ljc.155.1554926342648;
        Wed, 10 Apr 2019 12:59:02 -0700 (PDT)
Received: from localhost (c-573670d5.07-21-73746f28.bbcust.telenor.se. [213.112.54.87])
        by smtp.gmail.com with ESMTPSA id w3sm7398594lji.59.2019.04.10.12.59.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Apr 2019 12:59:01 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     dwmw2@infradead.org, computersforpeace@gmail.com,
        bbrezillon@kernel.org, marek.vasut@gmail.com, richard@nod.at
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH 1/2] mtd: nand: Kconfig: correct the MTD_NAND_ECC_SW_BCH select
Date:   Wed, 10 Apr 2019 21:58:51 +0200
Message-Id: <20190410195852.4066-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Config fragments should not have the prefix 'CONFIG_'.

Rework to remove the prefix 'CONFIG_' from 'CONFIG_MTD_NAND_ECC_SW_BCH'.

Fixes: 51ef1d0b2095 ("mtd: nand: Clarify Kconfig entry for software BCH ECC algorithm")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/mtd/devices/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/devices/Kconfig b/drivers/mtd/devices/Kconfig
index 7fcdaf6c279d..f9258d666846 100644
--- a/drivers/mtd/devices/Kconfig
+++ b/drivers/mtd/devices/Kconfig
@@ -207,7 +207,7 @@ comment "Disk-On-Chip Device Drivers"
 config MTD_DOCG3
 	tristate "M-Systems Disk-On-Chip G3"
 	select BCH
-	select BCH_CONST_PARAMS if !CONFIG_MTD_NAND_ECC_SW_BCH
+	select BCH_CONST_PARAMS if !MTD_NAND_ECC_SW_BCH
 	select BITREVERSE
 	help
 	  This provides an MTD device driver for the M-Systems DiskOnChip
-- 
2.20.1

