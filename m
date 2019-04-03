Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E492C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B23C206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="unEY+XY0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728634AbfDCQEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 12:04:49 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42532 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfDCQEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 12:04:49 -0400
Received: by mail-ot1-f68.google.com with SMTP id 103so15856498otd.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 09:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=fThzfm/a7c6EB2K1/Wy30MMxdASyeayvFiL8HhwazfY=;
        b=unEY+XY07+QBsUubkYjk4tAmuD5byOL2sqWwEREvrkJp8897pK0y8gH09MibXeJ1TL
         hMKb78QrA1znBaQbduso8TbYPv4auj8zbCxlhMPMAKtlPwAAf4f4ywGHc4IrOsjkLYI4
         lpNm6yiPOHuuiS9UEEVrLdDI/l0Zn8wFFAyjXvJPhVxdfQtflj7se2dltJA7fhmwenjR
         SzbP81thPQMNuGv5LYOuuf+ppPItRtumk0pjL+oazPOn8pJOl3T6Tsgx+4zw8up4E2In
         dqi9rdlBSIMxYHuun4xBhvljW3OEVmai8H7bitcMJS0IZpO0+iI7gsTuBoKniLFj8oIh
         2zVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fThzfm/a7c6EB2K1/Wy30MMxdASyeayvFiL8HhwazfY=;
        b=A5xa0VsCQ4d+EQibWrEfrHTjq4Rqhqpz0kXsniNBBRC1G+hMM6QmKcwEn2nrDFrTGk
         wfOs0MMehyuh/Kjt6ltqAJfagCCnOSoJYI8qxxao3egUbEvWdKtcCv9avlXZUEMUj4an
         IUZKv7NJOOpECRE7CZfZIxksnBzikz+Te+mGSe1q0guyKhV2abYkjumyBbLm8gm4iM30
         XB0Lhd8iwFAxUXefNuT0CtrQx4x5NlLB+ElyF/+tkA6MqB/9LxFZWzyn4TY5IwQQO3+B
         /KihDuJ6IS4OedW7LpGegs5ayIb554xZ5zJQz07fXDfuDZXbD/k2a8B136/6HKjrYVFH
         eS6g==
X-Gm-Message-State: APjAAAXBCAqpPcCZzI8ZYig2xeoDXbEx5Enk0xTry8nhuIpawzkEwmJr
        5aueUpUApAlvRkCWL7BC5Ho=
X-Google-Smtp-Source: APXvYqyFJLDeoXwqWbpl9pvZeODiGZO/EZOvlqYOBEPfLNkRaCJ1T+wxiWnh7JyiewzwEGNReLuKLw==
X-Received: by 2002:a9d:4c8d:: with SMTP id m13mr188504otf.145.1554307488164;
        Wed, 03 Apr 2019 09:04:48 -0700 (PDT)
Received: from madhuleo ([2605:6000:1023:606d:1876:bc0b:8981:17be])
        by smtp.gmail.com with ESMTPSA id s124sm6521160oia.24.2019.04.03.09.04.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 09:04:47 -0700 (PDT)
From:   Madhumitha Prabakaran <madhumithabiw@gmail.com>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     Madhumitha Prabakaran <madhumithabiw@gmail.com>
Subject: [PATCH] Staging: rtlwifi: Remove unwanted parentheses
Date:   Wed,  3 Apr 2019 11:04:45 -0500
Message-Id: <20190403160445.11110-1-madhumithabiw@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unwanted parentheses around right hand side of an assignment to
make code better and more understandable.

Issue found by Coccinelle.

Signed-off-by: Madhumitha Prabakaran <madhumithabiw@gmail.com>
---
 drivers/staging/rtlwifi/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtlwifi/core.c b/drivers/staging/rtlwifi/core.c
index a9902818ae7e..970343048b69 100644
--- a/drivers/staging/rtlwifi/core.c
+++ b/drivers/staging/rtlwifi/core.c
@@ -341,8 +341,8 @@ static u16 crc16_ccitt(u8 data, u16 crc)
 	u16 result;
 
 	for (i = 0; i < 8; i++) {
-		crc_bit15 = ((crc & BIT(15)) ? 1 : 0);
-		data_bit  = (data & (BIT(0) << i) ? 1 : 0);
+		crc_bit15 = (crc & BIT(15)) ? 1 : 0;
+		data_bit  = data & (BIT(0) << i) ? 1 : 0;
 		shift_in = crc_bit15 ^ data_bit;
 
 		result = crc << 1;
-- 
2.17.1

