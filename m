Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA435C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 13:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BB2220650
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 13:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TThZtPzW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbfJJNVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 09:21:19 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39536 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387669AbfJJNVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 09:21:19 -0400
Received: by mail-pg1-f196.google.com with SMTP id e1so3667426pgj.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 06:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sNkcoz2qQQJzkBN7TPFJIs9Ujhr7nKC1loZQV/g1Ccw=;
        b=TThZtPzWNwtue6y9ZvOvLq6kR6ynBi2BIcoQKTknfEa20G6yABruMP0e6OSvYmKL1R
         xy0qmWhh+Dmj0wdywBiBYLDq5/efZroBtm0ys74wBJ363qjZH0aw/8QmT/GqT2lFbcKV
         xJl81Bb/6SqayixA/EZLwSqDCWirabUa8la2y3XTHjMI2l5KxKQ5FD9eNfwc/srsgnEA
         eOe8yAUdtzhVwqk+kSss+GeHaoy3FEx/gNw3paIOBUl4GsBPvxuWyEA4DwIMfOS4lbad
         y0APRmiuziMLmxPC/2afgJiUOqMLawyGSptp0hQerIjkLpff9qUJf9dsj+WDBxzOq23G
         YN9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sNkcoz2qQQJzkBN7TPFJIs9Ujhr7nKC1loZQV/g1Ccw=;
        b=NXmUxoguY6vExY9Fcyjj26EPhGHm+MIb0lPSTaNJW3T6t8ObDvQOf6xxQqHTgny/+L
         0gT+ZXKY6F1d2fHiPxnrNmTBMYLbjjVRfMawVjrhpbwdN3l1RYnhm9rL/gs9nY+TjtT9
         hEWeH6AvL6ROO/04IIMq+pSmue1nY0Pm08yx8w/8OXL+NvEMEWdAnQeFWrhGeIOS/5zf
         HeCXT6BRuB0M1LVLsXkQZh0afFirN0+rrhBb7Jwsu7UM3i+Igp53BIUeiod95a1AEqtz
         aBuH6FhdpJQD80lsy95PLU2PdGOhiaMsvgI3AWFrKPoB73D0d62pXzBjNJLnPpn0s9Ev
         ViiQ==
X-Gm-Message-State: APjAAAXpEYn5mw67ej8wKB2co/JMIQx6yTQnzO0/vn8WbW2lhfp2vC0d
        h8f/I+Zf3nFUgqVTojNkYKw=
X-Google-Smtp-Source: APXvYqxxC4XA4qnMxZf6DlRr2Y8MbCIXklm2si2jFX3l34k7sQf8bVDhfMiWHlrhxWxuRU0PD4GJig==
X-Received: by 2002:a63:215c:: with SMTP id s28mr9934229pgm.302.1570713678298;
        Thu, 10 Oct 2019 06:21:18 -0700 (PDT)
Received: from wambui.brck.local ([197.254.95.158])
        by smtp.googlemail.com with ESMTPSA id w189sm6619667pfw.101.2019.10.10.06.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 06:21:17 -0700 (PDT)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Wambui Karuga <wambui.karugax@gmail.com>
Subject: [PATCH] rtl8723bs: Remove comparison to NULL
Date:   Thu, 10 Oct 2019 16:20:58 +0300
Message-Id: <20191010132058.20887-1-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove comparison to NULL in drivers/staging/rtl8723bs/core/rtw_ap.c:1449.
Issue found by checkpatch.pl

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index 80027ac765d0..7117d16a30f9 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -1447,7 +1447,7 @@ u8 rtw_ap_set_pairwise_key(struct adapter *padapter, struct sta_info *psta)
 	u8 res = _SUCCESS;
 
 	ph2c = rtw_zmalloc(sizeof(struct cmd_obj));
-	if (ph2c == NULL) {
+	if (!ph2c) {
 		res = _FAIL;
 		goto exit;
 	}
-- 
2.23.0

