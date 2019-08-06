Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C527C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 01:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6848A2147A
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 01:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6z6O7r3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731336AbfHFBdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 21:33:36 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41817 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728870AbfHFBdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 21:33:36 -0400
Received: by mail-qt1-f196.google.com with SMTP id d17so4059152qtj.8
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 18:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=3Q58zsuke6wL53H4L04d0Bb7ddU3CfSaVopOCua6A/0=;
        b=I6z6O7r3bTflfnCWcqkpvE2mqzgQuHYLFT6MkZp0mZMZMQY8RyQ+feZCfoS9hi3Xqy
         TP8h6xHhaLdVoXbxc2okS54YaAbAltMFH8zPZq3Ag5qF/VYe8cPESBjzbU2lJOgLsjZ+
         +gNqKtoMHFU7pT188vUoWhF2H2j4niN/M61rt+rGI/+x4MEaNAoiagXLhdWm+lYZXV7c
         x6udGDlR3vLoKsZN5GOD0cS9qjZoMpt16TPV0TKjD2BkWCS5tqOfwwwItNc1U8j5pO6w
         +tq9kNvuMw73Yagz6yl3Y8W7xC1w6CxaPEf2qJXZu1ni+JvZ9yhtpklqEUFl4TsmfpsR
         Ug5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=3Q58zsuke6wL53H4L04d0Bb7ddU3CfSaVopOCua6A/0=;
        b=hVNymI+iFOES82674+wYFWmk2wWQEtoEEi5h8wH9fuQX9cLVpnkf/ktDX3byzzUbA3
         ECF6O6uRVCr5hhJAs2hnKPpt1vgFrczvYPc+oNV0GXHIDCV6h1Qk6gag64/xMtRRETcV
         Snhq9LjR7VUPY9uoFY6pgTJzoBc35ef9W/Ubuie/p9lxgQGxR8/u92xc5zT7u9GMTnvk
         MrgpZG2oSFY4IwMq1cdvWWga+xUONxUqHhFh2NR0L6ctRYFqWqjbEv8rwLvh6bsweHT+
         HZj3erF/75svEpUrogc8/LOcdXHlzV/wp+vuxfSe9FFuLJTQLFm/ssR9t3u6+ZWnDaeo
         2uzQ==
X-Gm-Message-State: APjAAAXOXTAJKxL1TcCw4Gj1h9A63gnZRfuPJYCAQ11mzaL+s97leFOO
        s9gvkIrsEgy4TRfgJ4MhF95aW2TkYf9OnQ==
X-Google-Smtp-Source: APXvYqzgRzdHJOOQyzxpSYifLO5Qk5rHQG71pSzz//XeqGOwQ18oRylnPv1yxUlNr/5FHtW0umMFUA==
X-Received: by 2002:ac8:2774:: with SMTP id h49mr855184qth.97.1565055214743;
        Mon, 05 Aug 2019 18:33:34 -0700 (PDT)
Received: from localhost.localdomain ([2804:431:c7f0:2195:b8bc:4baa:a575:e6c8])
        by smtp.gmail.com with ESMTPSA id k123sm34789574qkf.13.2019.08.05.18.33.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 18:33:33 -0700 (PDT)
From:   Jose Carlos Cazarin Filho <joseespiriki@gmail.com>
To:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org
Subject: [PATCH] rtl8712: rtl871x_ioctl_linux.c: fix unnecessary typecast
Date:   Mon,  5 Aug 2019 22:33:29 -0300
Message-Id: <20190806013329.28574-1-joseespiriki@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpath warning:
WARNING: Unnecessary typecast of c90 int constant

Signed-off-by: Jose Carlos Cazarin Filho <joseespiriki@gmail.com>
---
 Hello all!
 This is my first commit to the Linux Kernel, I'm doing this to learn and be able
 to contribute more in the future
 Peace all! 
 drivers/staging/rtl8712/rtl871x_ioctl_linux.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c b/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
index 944336e0d..da371072e 100644
--- a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
+++ b/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
@@ -665,8 +665,8 @@ static int r8711_wx_set_freq(struct net_device *dev,
 
 /* If setting by frequency, convert to a channel */
 	if ((fwrq->e == 1) &&
-	  (fwrq->m >= (int) 2.412e8) &&
-	  (fwrq->m <= (int) 2.487e8)) {
+	  (fwrq->m >= 2.412e8) &&
+	  (fwrq->m <= 2.487e8)) {
 		int f = fwrq->m / 100000;
 		int c = 0;
 
-- 
2.17.1

