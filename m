Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94761C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 14:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ACFA2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 14:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHC4PF3M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbfEUOUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 10:20:14 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42493 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727534AbfEUOUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 10:20:14 -0400
Received: by mail-io1-f67.google.com with SMTP id g16so14060948iom.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 07:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Q1andz6G42MN5WlN0t4f5hbDfxStL/K8hK98k6OKJJY=;
        b=CHC4PF3M62d4QI3/P8InHsH6i0+ClTgutpCwfaKLG8+dJl/qduMVqN9ejzBNghDbkT
         1NKgFXga6yUkQNXyD886S4IF35e9jN38JqF9Lzp7Q1d0hVipIcBF6JQP+1IYyD6h/TmB
         BA5iZ0/7JonUSrN6MoXVbxoJS/g6vK8x3SC7g4D91DRp2HRsNCtoIz0sqKtgNLFuDiTl
         5DN5cKYpnvPQV+J2kFINli0EsbxkHjsX+7CKUy3BO7DW9IfKDyrdep0KJdLq5iADCZTJ
         kB1AlRtMP3WmjQwKAnSAevh1ABM5fWeNB0AINYkZ8ioEQ21yaLKZoZ8hzGSay0320AkN
         Uoug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Q1andz6G42MN5WlN0t4f5hbDfxStL/K8hK98k6OKJJY=;
        b=QC908igsrNojd+xkYojFe4KIiWI10o1n5AuVE4HhJJRhunKlKGQOSCr6OXumN9eXpB
         Ize89h1wNPbforsO5BzeDcUQsP+Pz/W3LtmyoUYPGOPFHExVooZgCZV1SujY7hk2BMC7
         sR/vm0uRAT0n8tT6eKCZltUbhHUq7Zdbkb/DU4kcaFiYyzgrSlkkP62YjDCj/VGX0iF1
         AMsuM3I4cRwI88XVPaQH1PlTo7bY0gn4FYbtFXAI5CM/VE77sWs0YgTCXyCnidhRxOLq
         yg611x+da1+jx42m0DhJjRzsysUsDyeyqgHdwgy1UPzuISmnVT8W2xkGn0hcPxVuo8qY
         LKOQ==
X-Gm-Message-State: APjAAAWiogfbqXPdIipRdi9fkCrRtpdzZjQtg4ug9yeeyp2Pc+qCOWHM
        PFL/AEedWIgFD7mZkFcBQQU=
X-Google-Smtp-Source: APXvYqwtyHGX8IC/jfGZ0uUS4Gi8VVwcgEcNozPhlks5OV9EXtD3UwdiNBncn/2q/asawtGzu4vfXA==
X-Received: by 2002:a6b:f70b:: with SMTP id k11mr3587023iog.148.1558448413605;
        Tue, 21 May 2019 07:20:13 -0700 (PDT)
Received: from svens-asus.arcx.com ([184.94.50.30])
        by smtp.gmail.com with ESMTPSA id u5sm4393045iob.7.2019.05.21.07.20.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 07:20:13 -0700 (PDT)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@gmail.com>
To:     Oscar Gomez Fuente <oscargomezf@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] staging: fieldbus: core: fix ->poll() annotation
Date:   Tue, 21 May 2019 10:20:09 -0400
Message-Id: <20190521142009.7331-1-TheSven73@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Gomez Fuente <oscargomezf@gmail.com>

->poll() functions should return __poll_t, but the fieldbus
core's poll() does not. This generates a sparse warning.

Fix the ->poll() return value, and use recommended __poll_t
constants (EPOLLxxx).

Signed-off-by: Oscar Gomez Fuente <oscargomezf@gmail.com>
---
 drivers/staging/fieldbus/dev_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/fieldbus/dev_core.c b/drivers/staging/fieldbus/dev_core.c
index 60b85140675a..f6f5b92ba914 100644
--- a/drivers/staging/fieldbus/dev_core.c
+++ b/drivers/staging/fieldbus/dev_core.c
@@ -211,16 +211,16 @@ static ssize_t fieldbus_write(struct file *filp, const char __user *buf,
 	return fbdev->write_area(fbdev, buf, size, offset);
 }
 
-static unsigned int fieldbus_poll(struct file *filp, poll_table *wait)
+static __poll_t fieldbus_poll(struct file *filp, poll_table *wait)
 {
 	struct fb_open_file *of = filp->private_data;
 	struct fieldbus_dev *fbdev = of->fbdev;
-	unsigned int mask = POLLIN | POLLRDNORM | POLLOUT | POLLWRNORM;
+	__poll_t mask = EPOLLIN | EPOLLRDNORM | EPOLLOUT | EPOLLWRNORM;
 
 	poll_wait(filp, &fbdev->dc_wq, wait);
 	/* data changed ? */
 	if (fbdev->dc_event != of->dc_event)
-		mask |= POLLPRI | POLLERR;
+		mask |= EPOLLPRI | EPOLLERR;
 	return mask;
 }
 
-- 
2.17.1

