Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44187C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 22:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0676A206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 22:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkgZrTL3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbfDCWi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 18:38:56 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42902 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfDCWi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 18:38:56 -0400
Received: by mail-ot1-f67.google.com with SMTP id 103so510251otd.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 15:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0YxX/DUB5kIbMUGhk9cYcrzc+Fvg0YYmoL5PkOL4j2Q=;
        b=dkgZrTL3wA4iHdfktXMmSml01jZGmg9FcVBo2hKFtmimju1vZGc59fjqot+URhG6m+
         4bI9Bs/Q3ij/Gd/bhFu63Hk7H31bsGCCX9lZd96XpJLNxub+SppHU4Y8IQh4y5DrYt48
         PgOFsszjaN7XhMwkMICPWnh9AD97mdLOoGA6XtUy2AN431ipR6jpvoflkGJrOpvCLr2G
         YKp+oCe5rBwsUkUDY3cLgAQyateGsCi+3OtHsp1cW6Cri9BmUxVIF++y/ZWccaXDN696
         6NuE7pi8E+F4vz/epjxDKn0zE/eZoRFLhkj+JB4fWy7xTqhx7/SfLOrN9QBqq173ULvp
         762g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0YxX/DUB5kIbMUGhk9cYcrzc+Fvg0YYmoL5PkOL4j2Q=;
        b=nEWWDgSgTv2GXkvNWUIO1uR4z9ondXj61E7S+hnmH6lrjZWRJ+SJHIK6GKxVgnJTrq
         75E9XMoO0lyVRIxS8rBhSLw8mIS/DyhfY8j+ZTHwB8cZkibSZRd+/5oh2+vQnHe1hd04
         DPI+bmlpj443EhY/3VwS7OTACDkMmC1OLIIXBonh+BxngjYhenKLjXJN8DCFp0X4z+cy
         UpQdXrl2ZqIFD90MPdBfbJs36/1YMrIobY1uOBOAe71drf3iOGU1TzpojxICtZ9Dqbsm
         bZ4+vnrWomV/B344frR5kB180NsipdC6hHbko9cGphXeSEfHf1bl4NkwQq1Lk0a9C3jz
         75Tw==
X-Gm-Message-State: APjAAAWsQZ8v7otojg0oh7EM0sTOxrP/s+uFX4CUqOdGzt6Kc4bKr/Km
        dN12aJDOHlmdP4accDfypZs=
X-Google-Smtp-Source: APXvYqw1M7NnH4LF/4m25aaIfuWws9rSZ+TRtmJ1mE8ATU2U/gRWsMYlpKZFbOQyyKPgti31/7OBwg==
X-Received: by 2002:a9d:68c7:: with SMTP id i7mr1544393oto.275.1554331135583;
        Wed, 03 Apr 2019 15:38:55 -0700 (PDT)
Received: from madhuleo ([2605:6000:1023:606d:1876:bc0b:8981:17be])
        by smtp.gmail.com with ESMTPSA id c145sm7289396oig.0.2019.04.03.15.38.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 15:38:54 -0700 (PDT)
From:   Madhumitha Prabakaran <madhumithabiw@gmail.com>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     Madhumitha Prabakaran <madhumithabiw@gmail.com>
Subject: [PATCH v2] Staging: rtlwifi: Remove unwanted parentheses
Date:   Wed,  3 Apr 2019 17:38:51 -0500
Message-Id: <20190403223851.22524-1-madhumithabiw@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unwanted parentheses and use !! idiom in place of ternary
operator to make code simple and more understandable.

Signed-off-by: Madhumitha Prabakaran <madhumithabiw@gmail.com>

---
Changes in v2:
- Changed commit log
- Replaced ternary operator with !! idiom
- Modified a BIT operator
---
 drivers/staging/rtlwifi/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtlwifi/core.c b/drivers/staging/rtlwifi/core.c
index a9902818ae7e..c70f062cf4b9 100644
--- a/drivers/staging/rtlwifi/core.c
+++ b/drivers/staging/rtlwifi/core.c
@@ -341,8 +341,8 @@ static u16 crc16_ccitt(u8 data, u16 crc)
 	u16 result;
 
 	for (i = 0; i < 8; i++) {
-		crc_bit15 = ((crc & BIT(15)) ? 1 : 0);
-		data_bit  = (data & (BIT(0) << i) ? 1 : 0);
+		crc_bit15 = !!(crc & BIT(15));
+		data_bit  = !!(data & BIT(i));
 		shift_in = crc_bit15 ^ data_bit;
 
 		result = crc << 1;
@@ -351,13 +351,13 @@ static u16 crc16_ccitt(u8 data, u16 crc)
 		else
 			result |= BIT(0);
 
-		crc_bit11 = ((crc & BIT(11)) ? 1 : 0) ^ shift_in;
+		crc_bit11 = !!(crc & BIT(11)) ^ shift_in;
 		if (crc_bit11 == 0)
 			result &= (~BIT(12));
 		else
 			result |= BIT(12);
 
-		crc_bit4 = ((crc & BIT(4)) ? 1 : 0) ^ shift_in;
+		crc_bit4 = !!(crc & BIT(4)) ^ shift_in;
 		if (crc_bit4 == 0)
 			result &= (~BIT(5));
 		else
-- 
2.17.1

