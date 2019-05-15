Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF0BC04AB4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 00:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F086B20843
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 00:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UUf39s/D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfEOAnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 20:43:06 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34920 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfEOAnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 20:43:06 -0400
Received: by mail-pl1-f196.google.com with SMTP id g5so429110plt.2;
        Tue, 14 May 2019 17:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=oob6Bnw6ZD2JDHEO9hSmCX2Sm7LzBRK9PB5FmaJ2j00=;
        b=UUf39s/Dl2lZm/CcBxcxYFyqbYTHE0NJdUNnIgOELpYu9CnP40+qZLFH4Y/3h9YSIU
         q4AJtW7iXfoHZCat1ZwFY/9afZYRyUN517DJwYCaGwg3EFv7fdAq4v2BosCymuHgVevC
         DYktO3cWesd8CdslhyFERxu61QfWYPy0o8rMgSM6xKqA/p5BYyERyU7GJWdSdKpUzqCK
         1jAY2grMGnIaHdn1KdoFNPYA/WoXTXk8x5ul76Bq6n+CcCpizlTSl8RHH3KAa0mOdfU0
         j4TfVpb4VC+YWs6h8DMItAb07vDsEy/zCFeWoA6eOGIqLxmWeGCoooTteQKVOC4/x7Nq
         iZ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oob6Bnw6ZD2JDHEO9hSmCX2Sm7LzBRK9PB5FmaJ2j00=;
        b=BOPNNPj3qfcDdyef/7IFe8wA3WI9co5fyvV5K32Hx70g2zz5qoooGKYn/Z9/2Rxq1L
         tuupYEIcLKfUphz5VWSR6JEEA9qKPUgBPYcxH25EpbCcOjz5pjqAbqwU+zzScTmZbg6I
         UXJuW7Mngf1xgNothJu3JF8TCtPWJrv5bxCE8vSKQiEzKxlYtSSKvuPbauRazx3wiYFD
         NoZ5Jhu6xZ/AcNO4ZCxS3ACsrG2v9NtZsP2vfIX4lkGw/2US6Zarp8fDWMIMWkIPpr5/
         ouG0tQTHdmY9lF7mNd5loSbuhboewuEAIOk1xPv9Kc4SmuO9bQ3Ga1s4mizBqux7yKd6
         9i8g==
X-Gm-Message-State: APjAAAUFUuceWJ+IrQ+NtE9hFPLGa7SqvrQidaPfMp4ESTEBZQD8houk
        abHbjTWbXifkyrDqh+5JJHA=
X-Google-Smtp-Source: APXvYqz97LOjrJpNeJQEXXjniMcNNNw+EyYBopGocN/YO4neBg98PGFlagYByXlrhMY99w40gEGhBw==
X-Received: by 2002:a17:902:2c01:: with SMTP id m1mr36533998plb.108.1557880985434;
        Tue, 14 May 2019 17:43:05 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn (89.208.248.35.16clouds.com. [89.208.248.35])
        by smtp.googlemail.com with ESMTPSA id 19sm315444pgz.24.2019.05.14.17.43.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 17:43:04 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Chas Williams <3chas3@gmail.com>,
        linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] atm: iphase: Avoid copying pointers to user space.
Date:   Wed, 15 May 2019 08:42:48 +0800
Message-Id: <20190515004248.9440-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the MEMDUMP_DEV case in ia_ioctl to avoid copy
pointers to user space.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/atm/iphase.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/atm/iphase.c b/drivers/atm/iphase.c
index 5278c57dce73..302cf0ba1600 100644
--- a/drivers/atm/iphase.c
+++ b/drivers/atm/iphase.c
@@ -2767,12 +2767,6 @@ static int ia_ioctl(struct atm_dev *dev, unsigned int cmd, void __user *arg)
    case MEMDUMP:
    {
 	switch (ia_cmds.sub_cmd) {
-       	  case MEMDUMP_DEV:     
-	     if (!capable(CAP_NET_ADMIN)) return -EPERM;
-	     if (copy_to_user(ia_cmds.buf, iadev, sizeof(IADEV)))
-                return -EFAULT;
-             ia_cmds.status = 0;
-             break;
           case MEMDUMP_SEGREG:
 	     if (!capable(CAP_NET_ADMIN)) return -EPERM;
              tmps = (u16 __user *)ia_cmds.buf;
-- 
2.11.0

