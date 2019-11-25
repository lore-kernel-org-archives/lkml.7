Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 040DBC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 18:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFC82207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 18:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTbZqiu4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfKYSVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 13:21:47 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36434 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbfKYSVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 13:21:47 -0500
Received: by mail-wr1-f68.google.com with SMTP id z3so19344157wru.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 10:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vb72jc4spAcABwLaDNL79fswtIsTkbWjFqxfZ/KoMkQ=;
        b=jTbZqiu4pU5t9GAi8Ew/rS5jX46DbqBzjHRiabZ3RX6fpWN7MkfBhZARlKYohl81N3
         w7lGxUzXCP7hOom9OqIFyluDH4P/t4qdshPMJR4leAIVBzM9ObZPjo1NJQZ2mG56PWYc
         0nMyX7+fYZtre7TM6jaIhfMxEFvRiPPb5R5+47bqjeOx3CC3eEXj2I2NlWZyaWGwx4MU
         IGpD/yEQoSNT5FM3dMqLEMK7+gox/omJkkOB348XLeZ0aIls3831Lc6KOgIzphKMvuuv
         VtPjyeKGqsJ+zVQJfO5/MONQSovoGnXHpnG0gB+/2uIv851mi4epMdOaJ7jMMrvaCcYr
         uIWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vb72jc4spAcABwLaDNL79fswtIsTkbWjFqxfZ/KoMkQ=;
        b=XVFixqaO5xhlXyQgGz1h8F6uwSAKl6zml8jS166I/pQgNy1hSF9OjVVNwhzYBVwzE8
         kznCHFiwjt6BYSojMdrEzxVZCZVKkZv86xhXjxztXpdkUV1H8tY5lzdNkVZKU0xQkQyS
         QZZz87UAcX4pyLNBx82vvuQLJrbuA3rhVSKJ9RlZB0gqcjf3zU15k90ltDPFgu49rYmy
         KVq6DfOVjZWQfQEUdddhZsNTcbFFTWLrMdJEhEtUPV0gRDUQs0EYyWGk1letZ8UnvqQh
         Mr/GlU6Y/yfke7AxGwN9dxRnR8qxNGlHKcEmb6SCOelpMCp5W5J+81ZhH1Jn1P2KFDyX
         pbeQ==
X-Gm-Message-State: APjAAAUhW4iPtDhoYjOCI21fFyV0cz2zsJ9u+ztn6P4uqjVi3b2OXWsA
        xGHOmPmlZ5xbcWrUhYvOgyLEFBHeOsI=
X-Google-Smtp-Source: APXvYqzFCMPW3yedym/OwFKYzbEU6lEjZLmdWeKNuMK3SyTNIMk/VE9izvqB4jw39WFQtaVgVV3V+A==
X-Received: by 2002:a5d:4983:: with SMTP id r3mr16384651wrq.134.1574706105297;
        Mon, 25 Nov 2019 10:21:45 -0800 (PST)
Received: from localhost.localdomain (dslb-002-204-142-242.002.204.pools.vodafone-ip.de. [2.204.142.242])
        by smtp.gmail.com with ESMTPSA id e16sm111294wme.35.2019.11.25.10.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 10:21:44 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8188eu: use break to exit while loop
Date:   Mon, 25 Nov 2019 19:21:30 +0100
Message-Id: <20191125182130.172602-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable bContinual in Efuse_PgPacketRead() is only used to break
out of a while loop. Remove the variable and use break instead.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_efuse.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_efuse.c b/drivers/staging/rtl8188eu/core/rtw_efuse.c
index d9b0f9e6235c..0b86ae8338d9 100644
--- a/drivers/staging/rtl8188eu/core/rtw_efuse.c
+++ b/drivers/staging/rtl8188eu/core/rtw_efuse.c
@@ -402,7 +402,6 @@ static u16 Efuse_GetCurrentSize(struct adapter *pAdapter)
 int Efuse_PgPacketRead(struct adapter *pAdapter, u8 offset, u8 *data)
 {
 	u8 ReadState = PG_STATE_HEADER;
-	int	bContinual = true;
 	int	bDataEmpty = true;
 	u8 efuse_data, word_cnts = 0;
 	u16	efuse_addr = 0;
@@ -422,7 +421,7 @@ int Efuse_PgPacketRead(struct adapter *pAdapter, u8 offset, u8 *data)
 	/*  <Roger_TODO> Efuse has been pre-programmed dummy 5Bytes at the end of Efuse by CP. */
 	/*  Skip dummy parts to prevent unexpected data read from Efuse. */
 	/*  By pass right now. 2009.02.19. */
-	while (bContinual && AVAILABLE_EFUSE_ADDR(efuse_addr)) {
+	while (AVAILABLE_EFUSE_ADDR(efuse_addr)) {
 		/*   Header Read ------------- */
 		if (ReadState & PG_STATE_HEADER) {
 			if (efuse_OneByteRead(pAdapter, efuse_addr, &efuse_data) && (efuse_data != 0xFF)) {
@@ -464,7 +463,7 @@ int Efuse_PgPacketRead(struct adapter *pAdapter, u8 offset, u8 *data)
 					ReadState = PG_STATE_HEADER;
 				}
 			} else {
-				bContinual = false;
+				break;
 			}
 		} else if (ReadState & PG_STATE_DATA) {
 			/*   Data section Read ------------- */
-- 
2.24.0

