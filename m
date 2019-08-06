Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC1BC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 11:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 477FD20C01
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 11:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCYBj3FQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730877AbfHFLyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 07:54:50 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34175 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbfHFLyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 07:54:50 -0400
Received: by mail-pg1-f193.google.com with SMTP id n9so35255678pgc.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 04:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=gZItrYoYJjlkO/ZSFT6aP95X89vdMB+Sl7boPAmKeP0=;
        b=UCYBj3FQarjSM+e8s8LmJJQpUwL8r7yJiIHQ46oHczydYm/enMPksBrMubdGdT+BXO
         GqdGKwsfNk4k+cQy9yh9ocJPOSV8yPaQOV5Sd9i8LBSgWEYVF/awi9ylyoxv9A5uzBx8
         2hKV6mgRZp3HauZtZQfC1fjtzn3UwhSolRlY+QE+WMp8AZOEsI/5j+xmlfsbty2dsbxQ
         XfDW5KksCsG1oE85bpN8HXIQm8Oykb/DVXkRMUwHlJsSPAH1PNSAiR/S/VRhYzkRCIOL
         BAsfhVXr3YztzLXXnrHswqzLTC4ud8i1o8GbjCVrEVUHIMs6J3+DjlkC1Pee7pBPnVsT
         Oyng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=gZItrYoYJjlkO/ZSFT6aP95X89vdMB+Sl7boPAmKeP0=;
        b=qWlMG+yJTOBClwhKGJy9P4ELntHRsdtSAmTaJBgg6cKl/54Z7nDyAmHPlZI95LFC6O
         0OVHxTFpbH++NGcTVPeLK+GOpECs9Sza/XVA0/iRlzt8UvRxeXDvZ8u/tF1rVJEozg8I
         d3FZ+UW6dG6kLBsycy8KyINgwIR63Z/pLT9oCrBWPYDkqUkK3KLyQ9ztW7vOmyvwOGWK
         Vs0r77yCeh+F1sfcEdI/r1gK4D0KGHjWbmUyOEKpQoEo6b3eoVEBxLYk4G9kAAC0qUjQ
         492CUHdS5u7UVtr/jd4hEzepA/tA81k0FGeaTrhArs7Lo5mdjlySh2bFi0tSyOFDBm2w
         Q3vA==
X-Gm-Message-State: APjAAAX7fblhUcnVdlE+++AVH3mhDhu5IOVbPL2VpWAz+CaszeyFTW1O
        L7QjAX8fnFQMUFy8aoXqj74=
X-Google-Smtp-Source: APXvYqyyI1puDPB9eUlJf/dQb8d5nnW8Yqi7aE4yT07Et3OKYiX4QaKqSUyEhvsBfWV6RyRP429C9A==
X-Received: by 2002:aa7:858b:: with SMTP id w11mr3167671pfn.68.1565092489772;
        Tue, 06 Aug 2019 04:54:49 -0700 (PDT)
Received: from IoT-COE ([2401:4900:2712:6d:44cc:cdec:b41d:4713])
        by smtp.gmail.com with ESMTPSA id s24sm87562512pfh.133.2019.08.06.04.54.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Aug 2019 04:54:49 -0700 (PDT)
Date:   Tue, 6 Aug 2019 17:24:38 +0530
From:   Merwin Trever Ferrao <merwintf@gmail.com>
To:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        dan.carpenter@oracle.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        merwintf@gmail.com
Subject: [PATCH] Staging: rtl8188eu: core: rtw_security: fixed a coding style
 issue
Message-ID: <20190806115438.GA24258@IoT-COE>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed WARNING: else is not generally useful after a break or return
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

