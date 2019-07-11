Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1038EC74A41
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 02:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBFAD20844
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 02:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmKI/1OY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbfGKCpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 22:45:18 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42501 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfGKCpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 22:45:17 -0400
Received: by mail-ot1-f68.google.com with SMTP id l15so4311782otn.9;
        Wed, 10 Jul 2019 19:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=Qbv2ajCJoybKSCHk6U34S4w3N5YXbwdABLrNyMIOFjU=;
        b=OmKI/1OYqrb+UnpZfqjLqOfdc/u9TGckIXOgROvKJxlQGt2A1Kx6qHJtEphheqRMfY
         76AEcQ9Q/eeMFGaVSM2n4B6b7pOrtVAZEZekEPdYWpVrsHilu9raJQMROtOniHxmcpVK
         VolYLvRFmskpXHA5KGsOILvPBTWQvSTK7f5zzpjHW+IoKkGDhNIjkEUhO/R64Zpx0T07
         kX41HG/EPmTpT6KTVeegZB1crm1C3TFq+TFprVuzsqB0buNcWVEFwIb0ugcWSnVQxcvQ
         v1VohMm9Nkh4av+aWhd/Cjr4cAtIFgOdH+5S7FDZ7JQ0HAmOy2HK6OQsscNBo4GzR6zy
         +Tpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=Qbv2ajCJoybKSCHk6U34S4w3N5YXbwdABLrNyMIOFjU=;
        b=ik5cycMTRjT/kgb9XGlS5bL6jdF3RN6VYr5+mxrDuZcCNgqIE5ppjb69C0ZJ2YEiC/
         Fo8KAN5ZYhAY2ZoVtpdz/3DZ4hsK2d4spLSqkmXCBVTDCy/5bYATvLi7eCu/HY1cQztF
         EERnjvpMHYilHL+e+COzP6nUjFSoIKWdZC0EkAp9TCHaA7bTnNprSsBHfZv8jEMgO8GR
         QaIKI3nHnrtyZdeK5qedrVK3yP5nIo0yaxaEEBWmO8bC5XQrkMUDzVNakjFJVwhkT1l9
         D2TG+sIOkac3c0nyMFkmzhsHtYH+oHM4sYwvs1+ftha2NYq7/P2+c8Gq2pLmr00gU0oM
         +zJQ==
X-Gm-Message-State: APjAAAX5LOi99a6+pOC+3wDAwgiqyxKK/hLNMtEqwXKUAZDSRFZIzGdD
        0VgGuvfXl9PN4PeTVwMRewI=
X-Google-Smtp-Source: APXvYqwBpsX4X+cHsa9au4otSEaxauUfBFpVKnqpbq1k4/l6JomJbGSzjRjBR49Xc+4I1qYSteNcag==
X-Received: by 2002:a9d:6659:: with SMTP id q25mr1354219otm.272.1562813116651;
        Wed, 10 Jul 2019 19:45:16 -0700 (PDT)
Received: from localhost ([76.224.107.173])
        by smtp.gmail.com with ESMTPSA id j5sm1426216oih.52.2019.07.10.19.45.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 19:45:15 -0700 (PDT)
From:   Lei YU <mine260309@gmail.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Eddie James <eajames@linux.ibm.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Lei YU <mine260309@gmail.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon (occ): Fix division by zero issue
Date:   Thu, 11 Jul 2019 10:44:48 +0800
Message-Id: <1562813088-23708-1-git-send-email-mine260309@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code in occ_get_powr_avg() invokes div64_u64() without checking the
divisor. In case the divisor is zero, kernel gets an "Division by zero
in kernel" error.

Check the divisor and make it return 0 if the divisor is 0.

Signed-off-by: Lei YU <mine260309@gmail.com>
Reviewed-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/hwmon/occ/common.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/occ/common.c b/drivers/hwmon/occ/common.c
index 13a6290..f02aa40 100644
--- a/drivers/hwmon/occ/common.c
+++ b/drivers/hwmon/occ/common.c
@@ -402,8 +402,10 @@ static ssize_t occ_show_power_1(struct device *dev,
 
 static u64 occ_get_powr_avg(u64 *accum, u32 *samples)
 {
-	return div64_u64(get_unaligned_be64(accum) * 1000000ULL,
-			 get_unaligned_be32(samples));
+	u64 divisor = get_unaligned_be32(samples);
+
+	return (divisor == 0) ? 0 :
+		div64_u64(get_unaligned_be64(accum) * 1000000ULL, divisor);
 }
 
 static ssize_t occ_show_power_2(struct device *dev,
-- 
2.7.4

