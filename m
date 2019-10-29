Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A26E5CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 14:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 749A92087E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 14:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8phSevz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389718AbfJ2Ozo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 10:55:44 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33909 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389131AbfJ2Ozn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 10:55:43 -0400
Received: by mail-qt1-f194.google.com with SMTP id e14so20660495qto.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 07:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OXHkKi/QhwruZ8D2A/Di0N1vIvUmUT5HCPHPe9Q0o9g=;
        b=V8phSevzPXZporM9ZBf66iJVi31774Tl/mJFyAPYX+/rfffVkhsVaP7EktFU1QX1/8
         fiY8GDogWNK1PWTSsE6TNQep+FBprGmbwkO1a1daQ1Wy0xVgSSFFV4x23rleaXZfFwas
         5U03td2CVB91kORy2l0Y5bSXXbrhg8oOJ0ZYYCVOmU++0irDudF7/wEwt0rvwTKDWHLi
         u+bW+w5y4aH6AFLjcrfTmZz6lALxTUFUP+HWnPZGRo6ZRyyEYp1QTpiOWAEcdMs4R3ev
         JQt/bHRAaOMNE3RmQhoeNaK6d7fk34J6zaBXIM8DAGAA24zlFTOVn5UBHfHzdQN0znE8
         QYOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OXHkKi/QhwruZ8D2A/Di0N1vIvUmUT5HCPHPe9Q0o9g=;
        b=RPYJfQsLRRo7rMnDn0bGG76WCww1dCf1gUgs3M32TEGZ3W9UgpKBBjT5ooxEirTw6Q
         ElWDYlghSFIPLt+779wA7p6DFKSV9jSiHsi0v60/dGP/KQ7a1HPUz7PRC2IMUok983Xt
         /IeCGlJ0MJDdKlv7XAurU4DvacUWoBgQOaC4kVgQ2rNWDlo9NrJx6r1F3D4i7cVUD1Ro
         mqPjpjCSZSZzH68fSe9TYlPaTm9ImUbJbOnvMc1B7iR3SuEW+xExNu8dmBUMSupzpwR6
         +38ECCgCLIeNFItU9jgQtT24pxK4wntLE7hzZJc7m6sRsxSWMwCZKwg8dUbEmJWxIVhc
         SocQ==
X-Gm-Message-State: APjAAAUN0yQADTHDEv0IpBiZwlGnWfPsg+sYG9Mdu39ISTz5Wv8/ldbj
        6WFwh04JjdKp2iKhhbNjoKsyHTIT3aU=
X-Google-Smtp-Source: APXvYqxjS+LTEeEXVGP2auJgR/hHHzDmraegLUz52Qu9Os9gNotaYrebxUczgeTFGyEJcejc+YCN1A==
X-Received: by 2002:a0c:e646:: with SMTP id c6mr17753583qvn.162.1572360941068;
        Tue, 29 Oct 2019 07:55:41 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:483:ade:87ad:69fb:5b32:cf88])
        by smtp.gmail.com with ESMTPSA id g17sm5978069qte.89.2019.10.29.07.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 07:55:40 -0700 (PDT)
From:   Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
To:     outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        kim.jamie.bradley@gmail.com, nishkadg.linux@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org
Cc:     Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
Subject: [PATCH v2 2/3] staging: rts5208: Eliminate the use of Camel Case in files xd
Date:   Tue, 29 Oct 2019 11:55:16 -0300
Message-Id: <20191029145517.630-3-gabrielabittencourt00@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191029145517.630-1-gabrielabittencourt00@gmail.com>
References: <20191029145517.630-1-gabrielabittencourt00@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleans up checks of "Avoid CamelCase" in file xd.h and xd.c

Signed-off-by: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
---
 drivers/staging/rts5208/xd.c | 8 ++++----
 drivers/staging/rts5208/xd.h | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rts5208/xd.c b/drivers/staging/rts5208/xd.c
index f3dc96a4c59d..0f369935fb6c 100644
--- a/drivers/staging/rts5208/xd.c
+++ b/drivers/staging/rts5208/xd.c
@@ -630,13 +630,13 @@ static int reset_xd(struct rtsx_chip *chip)
 			xd_card->zone_cnt = 32;
 			xd_card->capacity = 1024000;
 			break;
-		case xD_1G_X8_512:
+		case XD_1G_X8_512:
 			XD_PAGE_512(xd_card);
 			xd_card->addr_cycle = 4;
 			xd_card->zone_cnt = 64;
 			xd_card->capacity = 2048000;
 			break;
-		case xD_2G_X8_512:
+		case XD_2G_X8_512:
 			XD_PAGE_512(xd_card);
 			xd_card->addr_cycle = 4;
 			xd_card->zone_cnt = 128;
@@ -669,10 +669,10 @@ static int reset_xd(struct rtsx_chip *chip)
 		return STATUS_FAIL;
 	}
 
-	retval = xd_read_id(chip, READ_xD_ID, id_buf, 4);
+	retval = xd_read_id(chip, READ_XD_ID, id_buf, 4);
 	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	dev_dbg(rtsx_dev(chip), "READ_xD_ID: 0x%x 0x%x 0x%x 0x%x\n",
+	dev_dbg(rtsx_dev(chip), "READ_XD_ID: 0x%x 0x%x 0x%x 0x%x\n",
 		id_buf[0], id_buf[1], id_buf[2], id_buf[3]);
 	if (id_buf[2] != XD_ID_CODE)
 		return STATUS_FAIL;
diff --git a/drivers/staging/rts5208/xd.h b/drivers/staging/rts5208/xd.h
index 57b94129b26f..98c00f268e56 100644
--- a/drivers/staging/rts5208/xd.h
+++ b/drivers/staging/rts5208/xd.h
@@ -36,7 +36,7 @@
 #define	BLK_ERASE_1			0x60
 #define	BLK_ERASE_2			0xD0
 #define READ_STS			0x70
-#define READ_xD_ID			0x9A
+#define READ_XD_ID			0x9A
 #define	COPY_BACK_512			0x8A
 #define	COPY_BACK_2K			0x85
 #define	READ1_1_2			0x30
@@ -72,8 +72,8 @@
 #define	XD_128M_X16_2048		0xC1
 #define	XD_4M_X8_512_1			0xE3
 #define	XD_4M_X8_512_2			0xE5
-#define	xD_1G_X8_512			0xD3
-#define	xD_2G_X8_512			0xD5
+#define	XD_1G_X8_512			0xD3
+#define	XD_2G_X8_512			0xD5
 
 #define	XD_ID_CODE			0xB5
 
-- 
2.20.1

