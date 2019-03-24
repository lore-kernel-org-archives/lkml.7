Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E50EC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 17:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17D8120989
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 17:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yjm/F8MK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbfCXRWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 13:22:03 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35236 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfCXRWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 13:22:03 -0400
Received: by mail-wm1-f66.google.com with SMTP id y197so6673022wmd.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 10:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uFUakpoH3VF0hB3WSj+bCAWmqp4ldfkThHsxP9fCXOc=;
        b=Yjm/F8MKQj+kWM5BzTMOPMBUm4bCIdsB3M1lOYVChKySLVhZCHCXhiuGFGLD9LZ4Zp
         ZFqblnleM8E+upFuWlWy+ZYsP1CiICagov15yp0m8uyVnvTtR3ymlsV/VSHmlA/oMS1X
         b6vMyiP4RrIGE1wwlV1csDg21QxCQk+XwXOG0jANK82yPhyrN0AneqYOcvAOx03+/jtn
         5apTRZw00kGdTZD7wc6Gs5/C/7eQT+3vPfa8hUYwNUt6bd1ac81KZvSE9XvYAvp0Gm/j
         Ylk2StZGNy2H30hF1y7y71BKvWQDqaky1PgBtlYMahB9tQ9GLBJzscnCcAQbmFUmRk0j
         +86A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uFUakpoH3VF0hB3WSj+bCAWmqp4ldfkThHsxP9fCXOc=;
        b=HE0R7FxFidaDRYmjg+v1fgCZlDA0Ces9VTp7M5Q/jVbQa51eK8F20tA2WxOvgWDcDt
         K0i0qMJs4ATMMxhpV69wegYNkZaViG/MGwrItAtuGCpmIx5DNDHKT8hOcCQaxzFhuNb2
         iaM57AJtSpZGG77F2BBCYATdS7+iTveXR8foVEWr0KItcYS3eLlqYNp9qFXcZIqXl/xX
         DgihPtI5bHUXTV+yUnCTJ5xjwPiQteeMF16RMC5w33lfJFYAwNKW58sPq99/uZVzjacO
         KEN0wbxv8kofY/OaGpmI1Puk8ixFNH2yZdQHosbpHRXvKByDNj1Z1W2XybfbB44tHFMf
         n6EQ==
X-Gm-Message-State: APjAAAXDiKBdcWufTZikq9qe+/ko3AsVm9L4F/gROL/aMiK3DNlYTC0/
        /9SObj+mBCw2Zxiuw/qsn3Q=
X-Google-Smtp-Source: APXvYqzgIV891cLw+PTe5eETTOSdgQA5P6YCwn7zdtjKmuzWawmQ3gctiYz4W6J50GfOPxoA+xIHZw==
X-Received: by 2002:a7b:c34d:: with SMTP id l13mr8801463wmj.37.1553448121692;
        Sun, 24 Mar 2019 10:22:01 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb85.dynamic.kabel-deutschland.de. [95.90.187.133])
        by smtp.gmail.com with ESMTPSA id z19sm7278009wml.44.2019.03.24.10.22.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 10:22:01 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8188eu: cleanup long line in odm.c
Date:   Sun, 24 Mar 2019 18:21:51 +0100
Message-Id: <20190324172151.25237-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align a comment to clear a line over 80 characters
checkpatch warning.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/odm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/hal/odm.c b/drivers/staging/rtl8188eu/hal/odm.c
index ba3c3e5a8216..95a8fc23e62c 100644
--- a/drivers/staging/rtl8188eu/hal/odm.c
+++ b/drivers/staging/rtl8188eu/hal/odm.c
@@ -107,7 +107,7 @@ u8 CCKSwingTable_Ch1_Ch13[CCK_TABLE_SIZE][8] = {
 	{0x0a, 0x0a, 0x09, 0x07, 0x05, 0x03, 0x02, 0x01}, /*  29, -14.5dB */
 	{0x0a, 0x09, 0x08, 0x07, 0x05, 0x03, 0x02, 0x01}, /*  30, -15.0dB */
 	{0x09, 0x09, 0x08, 0x06, 0x05, 0x03, 0x01, 0x01}, /*  31, -15.5dB */
-	{0x09, 0x08, 0x07, 0x06, 0x04, 0x03, 0x01, 0x01}	/*  32, -16.0dB */
+	{0x09, 0x08, 0x07, 0x06, 0x04, 0x03, 0x01, 0x01}  /*  32, -16.0dB */
 };
 
 u8 CCKSwingTable_Ch14[CCK_TABLE_SIZE][8] = {
-- 
2.21.0

