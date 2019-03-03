Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2B8C43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 07:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C8D420836
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 07:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ojfxmGFw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbfCCHu5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 02:50:57 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36554 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfCCHu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 02:50:56 -0500
Received: by mail-pg1-f193.google.com with SMTP id r124so1031831pgr.3;
        Sat, 02 Mar 2019 23:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UifkzEkFRqXu3yixaaw6yvTChu7M21y6ZQxvlg1zFMs=;
        b=ojfxmGFwRLFyuJDYOF9Bd8zYmbOX5hRQmO1fjeBXHYEdxDNCk6flfMYPtIFbF/Sosu
         QjwqzgGRRzUR/gH75F37vldJ64FXGmkznZTBs/I8bp7wJi+x6UTMG5/Uq3nl79IMn2HJ
         VRogi8HkGoEN2YeXoVDyWsCBHU+6x3Wv0ETXILjP7Jea3MPDNcl1LiVEel0zJR/QS5FM
         xlFADQCDFaLDH4BPluMBDDnyxXr2SEFY2i424dUS8hQE+ClDNnYTrltlMfApDQOmqTvz
         bw8Eb8gsTf8s32czH9FAQdATV0ueUid+zPCUt1o3lcs7tbuTUAt1jxHsgLoGa8BxD2A0
         7L8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UifkzEkFRqXu3yixaaw6yvTChu7M21y6ZQxvlg1zFMs=;
        b=nmvxPPgLBS8eUeDUPsoe6iMEZ3G1M70ZQtdoNd36R70TSR8MJN+9eIwLdHGpqvKuxR
         oAc6lmy5+YEDiAS2DPP3f5fmp48G9yTly8VTKtGHA2+2fKRncMkMHvaNbLdVyRzgdV8f
         gMYhVjUuJ86S65iLTz5zHT1mVgKIdxliCSufV5b6SBNwbno88yPe+tga/zFVCtMwXN2W
         IkPT2aOKS0Bnk8a9Ptpoq2vSiXtwkU4sNN5qQ+5eJsrWBwXzMymhDRH/Buj4P2o8Blaw
         nH2rp4bBaTzh69ANodsoxftN+kjTeURGG5t72gB9rtHEeeLBAbeuqpBWJ7K0ViTzUdnK
         rhHA==
X-Gm-Message-State: APjAAAXkRSiSPMdbYCLLQzEKjJBEqcg/+1UmtJEgQkQ3isxKQi+paK8t
        rgCWHsCgVSwJKmCQVc4fTEg=
X-Google-Smtp-Source: AHgI3IaRcnUNGGrMNo351mYUWL3BWUGU+5ZHcEvSSM8aSjLkbPbmGgKncncfSHeoBVILcIaVCq+gbA==
X-Received: by 2002:aa7:8299:: with SMTP id s25mr14222435pfm.56.1551599455604;
        Sat, 02 Mar 2019 23:50:55 -0800 (PST)
Received: from localhost.localdomain ([2001:268:c0a5:3b5c:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id y6sm4735357pfy.87.2019.03.02.23.50.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Mar 2019 23:50:55 -0800 (PST)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org
Cc:     akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        yamada.masahiro@socionext.com, bgolaszewski@baylibre.com,
        linux-arm-kernel@lists.infradead.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v9 9/9] gpio: uniphier: Utilize for_each_set_clump8 macro
Date:   Sun,  3 Mar 2019 16:51:43 +0900
Message-Id: <0840d55707dacd1121659723246fa9f55737f426.1551598603.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1551598603.git.vilhelm.gray@gmail.com>
References: <cover.1551598603.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace verbose implementation in set_multiple callback with
for_each_set_clump8 macro to simplify code and improve clarity. An
improvement in this case is that banks that are not masked will now be
skipped.

Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/gpio/gpio-uniphier.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/gpio/gpio-uniphier.c b/drivers/gpio/gpio-uniphier.c
index 0f662b297a95..df640cb29b9c 100644
--- a/drivers/gpio/gpio-uniphier.c
+++ b/drivers/gpio/gpio-uniphier.c
@@ -15,9 +15,6 @@
 #include <linux/spinlock.h>
 #include <dt-bindings/gpio/uniphier-gpio.h>
 
-#define UNIPHIER_GPIO_BANK_MASK		\
-				GENMASK((UNIPHIER_GPIO_LINES_PER_BANK) - 1, 0)
-
 #define UNIPHIER_GPIO_IRQ_MAX_NUM	24
 
 #define UNIPHIER_GPIO_PORT_DATA		0x0	/* data */
@@ -147,15 +144,14 @@ static void uniphier_gpio_set(struct gpio_chip *chip,
 static void uniphier_gpio_set_multiple(struct gpio_chip *chip,
 				       unsigned long *mask, unsigned long *bits)
 {
-	unsigned int bank, shift, bank_mask, bank_bits;
-	int i;
+	unsigned int i;
+	unsigned long bank_mask;
+	unsigned int bank;
+	unsigned int bank_bits;
 
-	for (i = 0; i < chip->ngpio; i += UNIPHIER_GPIO_LINES_PER_BANK) {
+	for_each_set_clump8(i, bank_mask, mask, chip->ngpio) {
 		bank = i / UNIPHIER_GPIO_LINES_PER_BANK;
-		shift = i % BITS_PER_LONG;
-		bank_mask = (mask[BIT_WORD(i)] >> shift) &
-						UNIPHIER_GPIO_BANK_MASK;
-		bank_bits = bits[BIT_WORD(i)] >> shift;
+		bank_bits = bitmap_get_value8(bits, chip->ngpio, i);
 
 		uniphier_gpio_bank_write(chip, bank, UNIPHIER_GPIO_PORT_DATA,
 					 bank_mask, bank_bits);
-- 
2.21.0

