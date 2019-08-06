Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283F2C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 12:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB09E2173C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 12:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1Cpzj/7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730788AbfHFM3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 08:29:01 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46978 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbfHFM3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 08:29:01 -0400
Received: by mail-pg1-f195.google.com with SMTP id w3so4315393pgt.13
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 05:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=TAkr50ijx8uYBSMvjJlZB0+VJTs1FTT2VnuFaShQXNo=;
        b=M1Cpzj/7rNIxbHRqUPvLOeU/gHQtCssc9hYvhmUxHsnJOd0HVPukRZF2hERxcIqtVW
         VCsbXTgZm8u5jYdkXoG/rW8Ox5LUTICEr0sQtAUXDcIxMmvgKiTnQqnvuyms5MtWb+2D
         r9VRIXaqjscdeZOPFg5Cd0zfC0nX09fumWnv2CkgUnV3QoC4qqOWvoVe6nJiqpXLREMq
         DrN4sH9xBT3ZVS7ghP+nQIoXUKYDHnwbSDusV132j6NxPV3e9cb5sc7zGXRG/VnxpfYA
         cGI0Yai5rcUN6pq2NXVIr93Q2ioqwf8tG8rLPXeXhrd048n467rF8MzaEn8+5deOK/IK
         6Gvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=TAkr50ijx8uYBSMvjJlZB0+VJTs1FTT2VnuFaShQXNo=;
        b=Bp2GlLzfUUJpjELd3vWQyp+XXvqrmBsAkMM0yhoeHwTTTO50GGoChJPtPKcpJfH4VZ
         kA+fGphemhYE6RCqcsmut2ZUEwwgJpdV1PC2ts7k9+KG1tscqgEACfRCgGo7QJxWsV93
         Z8c28E/yRdceRB7r5HTS7ZWskC1OzhZUJre2a+DHDciXm59ErW4HtfDqnunrTEwJzyGW
         zBYcOU69+MxG4bdl16zpcFn3ApJiVyOXyj0nyAAGVGqcA1GFfT8FtiMy/+Q3UHJDlvkQ
         710TorDzGMowW2vEGvtZvHzyYdITmRH9SUggtZannRcSCppww6mdqpwwQ35s9ssoqarW
         JrNw==
X-Gm-Message-State: APjAAAU0T89QhpLpQDd22WRKrcUm8Pvt6MWIkpufzOpa9xE8j0e+Xl6V
        qanpo+6Fc4ZYJjZ+OfhV5ko=
X-Google-Smtp-Source: APXvYqywhiZJSJjgzafUW390rY+y8rUndAU2xen9Y11XFEmgMYEMpJ3sitE9HVud3KQFoUPLdQHnBw==
X-Received: by 2002:a63:6f81:: with SMTP id k123mr2938399pgc.12.1565094540469;
        Tue, 06 Aug 2019 05:29:00 -0700 (PDT)
Received: from IoT-COE ([2401:4900:2712:6d:6061:e04e:e2af:fb26])
        by smtp.gmail.com with ESMTPSA id u128sm100439738pfu.48.2019.08.06.05.28.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Aug 2019 05:29:00 -0700 (PDT)
Date:   Tue, 6 Aug 2019 17:58:49 +0530
From:   Merwin Trever Ferrao <merwintf@gmail.com>
To:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        dan.carpenter@oracle.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        merwintf@gmail.com
Subject: [PATCH] Staging: rtl8188eu: core: rtw_security: tidy up crc32_init()
Message-ID: <20190806122849.GA25628@IoT-COE>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code generates checkpatch warning:

WARNING: else is not generally useful after a break or return

Moving the declaration to the top of the function we can pull the
code back one tab and it makes it more readable.

Signed-off-by: Merwin Trever Ferrao <merwintf@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_security.c | 41 +++++++++----------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_security.c b/drivers/staging/rtl8188eu/core/rtw_security.c
index 2f90f60f1681..435c0fbec54a 100644
--- a/drivers/staging/rtl8188eu/core/rtw_security.c
+++ b/drivers/staging/rtl8188eu/core/rtw_security.c
@@ -87,29 +87,28 @@ static u8 crc32_reverseBit(u8 data)
 
 static void crc32_init(void)
 {
-	if (bcrc32initialized == 1) {
+	int i, j;
+	u32 c;
+	u8 *p = (u8 *)&c, *p1;
+	u8 k;
+
+	if (bcrc32initialized == 1)
 		return;
-	} else {
-		int i, j;
-		u32 c;
-		u8 *p = (u8 *)&c, *p1;
-		u8 k;
-
-		c = 0x12340000;
-
-		for (i = 0; i < 256; ++i) {
-			k = crc32_reverseBit((u8)i);
-			for (c = ((u32)k) << 24, j = 8; j > 0; --j)
-				c = c & 0x80000000 ? (c << 1) ^ CRC32_POLY : (c << 1);
-			p1 = (u8 *)&crc32_table[i];
-
-			p1[0] = crc32_reverseBit(p[3]);
-			p1[1] = crc32_reverseBit(p[2]);
-			p1[2] = crc32_reverseBit(p[1]);
-			p1[3] = crc32_reverseBit(p[0]);
-		}
-		bcrc32initialized = 1;
+
+	c = 0x12340000;
+
+	for (i = 0; i < 256; ++i) {
+		k = crc32_reverseBit((u8)i);
+		for (c = ((u32)k) << 24, j = 8; j > 0; --j)
+			c = c & 0x80000000 ? (c << 1) ^ CRC32_POLY : (c << 1);
+		p1 = (u8 *)&crc32_table[i];
+
+		p1[0] = crc32_reverseBit(p[3]);
+		p1[1] = crc32_reverseBit(p[2]);
+		p1[2] = crc32_reverseBit(p[1]);
+		p1[3] = crc32_reverseBit(p[0]);
 	}
+	bcrc32initialized = 1;
 }
 
 static __le32 getcrc32(u8 *buf, int len)
-- 
2.17.1

