Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFE8C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 19:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AA5B20882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 19:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JzcGgR67"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730425AbfDDTvo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 15:51:44 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36211 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729714AbfDDTvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 15:51:43 -0400
Received: by mail-oi1-f193.google.com with SMTP id l203so2968112oia.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 12:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=W60IMmg8wrXQQkcuSmXu1ogKgmIL9gWvwpxclaaQyOs=;
        b=JzcGgR67YKI8qreuInNsX5ud3MO6axb+vyOGioV7zBuyxUk1lcaV+o1lfnenRl2XE8
         vfH6har0WtxHwkSIRlTcRa8mUc8dWNBa0uKw2VIyjJt1dD06IMIauSgxYy7vbRS/ws5m
         U35OUhe5btTXP5D8DMEkqghJvns7lZX1IvVL4LPJXG80oYBpMrWBzOWj+TyjICupXJcw
         D+HJojn0krO7ITw9nkvJaU5rhOF5uOZxGHZl3GtxLEUZd6ON4y7n3EBo5TvU3L61x4Co
         C/vzyRfzD2XMySEER2MGkJ1GN9IoRZm6y5ssl0u0cniQDfn3qKW26zuQlQu2wAG4eb3o
         K6TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=W60IMmg8wrXQQkcuSmXu1ogKgmIL9gWvwpxclaaQyOs=;
        b=nNwwQtnF7R/20CcbuHhXPqyF1p0ixCTqwqjDTJzbgNSTYJej8uC/zzXFsHFUxFnL24
         usiDuiazUu4G6GjAKktX/g9g2Eyaui2hmE93iGTO1oALYI9E+Y+vcAwTFjykp2vlB+6t
         5+Wkk7cZUKM5Ektx4Nwk8DxWYDNQyVXuY0q72x4hbHzTYuKMczuO5Sx5cFbD6pYj7cPR
         Y/SeN6QTHaKX0A3J2FE+uOSaE/MnyUTpMu6HweGKVEQfNsuVLXP494TMpQTkVTw4FwBt
         bHQWZ2iGz4/G/yFzD60ZBZTumUtKAF1YwPPRuUamwIznM7TxOlNnbSdRKTZlSlV6XGo6
         er7g==
X-Gm-Message-State: APjAAAWgZNzNEdlYZvjYl5P1KVKoVSu6GciI2O6sYVG6A7X2y2DGvJhi
        Tg6yH0idxj7CYU91hqkF7sk=
X-Google-Smtp-Source: APXvYqyq6Y5QcWQ6wnqEcLEvavf9s9Pqf5pJVS0WEM8IBY+BiY10XhppY1OmHoZS8EpPHosdg8/NSQ==
X-Received: by 2002:aca:43d5:: with SMTP id q204mr4751522oia.100.1554407502946;
        Thu, 04 Apr 2019 12:51:42 -0700 (PDT)
Received: from madhuleo ([2605:6000:1023:606d:7549:4e85:9095:b601])
        by smtp.gmail.com with ESMTPSA id b17sm8081880otq.26.2019.04.04.12.51.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 12:51:42 -0700 (PDT)
From:   Madhumitha Prabakaran <madhumithabiw@gmail.com>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     Madhumitha Prabakaran <madhumithabiw@gmail.com>
Subject: [PATCH v3] Staging: rtlwifi: Cleanup crc16_ccitt()
Date:   Thu,  4 Apr 2019 14:51:27 -0500
Message-Id: <20190404195127.7162-1-madhumithabiw@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

crc16_ccitt() function does "BIT(0) << i" instead of "BIT(i)".
Using !! is slightly shorter than "foo ? 1: 0" and remove unnecessary
parentheses to make the code simple.

Issue suggested by Coccinelle.

Signed-off-by: Madhumitha Prabakaran <madhumithabiw@gmail.com>

---
Changes in v3:
- Changed subject line and commit log
- Removed unnecessary parentheses in the function

Changes in v2:
- Changed commit log
- Replaced ternary operator with !! idiom
- Modified a BIT operator
---
 drivers/staging/rtlwifi/core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtlwifi/core.c b/drivers/staging/rtlwifi/core.c
index a9902818ae7e..2cce65368f92 100644
--- a/drivers/staging/rtlwifi/core.c
+++ b/drivers/staging/rtlwifi/core.c
@@ -341,25 +341,25 @@ static u16 crc16_ccitt(u8 data, u16 crc)
 	u16 result;
 
 	for (i = 0; i < 8; i++) {
-		crc_bit15 = ((crc & BIT(15)) ? 1 : 0);
-		data_bit  = (data & (BIT(0) << i) ? 1 : 0);
+		crc_bit15 = !!(crc & BIT(15));
+		data_bit  = !!(data & BIT(i));
 		shift_in = crc_bit15 ^ data_bit;
 
 		result = crc << 1;
 		if (shift_in == 0)
-			result &= (~BIT(0));
+			result &= ~BIT(0);
 		else
 			result |= BIT(0);
 
-		crc_bit11 = ((crc & BIT(11)) ? 1 : 0) ^ shift_in;
+		crc_bit11 = !!(crc & BIT(11)) ^ shift_in;
 		if (crc_bit11 == 0)
-			result &= (~BIT(12));
+			result &= ~BIT(12);
 		else
 			result |= BIT(12);
 
-		crc_bit4 = ((crc & BIT(4)) ? 1 : 0) ^ shift_in;
+		crc_bit4 = !!(crc & BIT(4)) ^ shift_in;
 		if (crc_bit4 == 0)
-			result &= (~BIT(5));
+			result &= ~BIT(5);
 		else
 			result |= BIT(5);
 
-- 
2.17.1

