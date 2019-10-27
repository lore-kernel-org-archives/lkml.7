Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B61CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 22:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E33EE2067B
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 22:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBgbiSD9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbfJ0WYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 18:24:47 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35916 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbfJ0WYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 18:24:47 -0400
Received: by mail-io1-f67.google.com with SMTP id c16so8554175ioc.3;
        Sun, 27 Oct 2019 15:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=IuRwGRk7x+c1HDFpnoYWVpNlHoOuaVBA3+hE2ZH8FK4=;
        b=JBgbiSD94Uilc/YaI073TPNQC+ivetme2bg50jRGwxZNIu52pOarGxrn5e3QMAJhrl
         45pDZQzkIx4TwQYH+OhQg2bGTIiiyeqOYCQRq1eurc/OwcQ2DozRS/Bryn3dm3Ef2K42
         SEYFZAOCTMP4v0w8dMEsSWcfoW4ETrGd4Sav+0PM/cZalS/JDOdsak7252h4t1MC7Pfq
         dq5lTv1FIj70KuTGUbUzM7ZuVhX4PPBRjRQWmO5Zg5+y6N0rTwvE46I0AQ+ORyWI7r1q
         E2ge9V7naz/HITAsVj4XbJBQS79qyomaQHFVFhSrzv68FAY9jH9ZIjqPiy7ky/6JE8/v
         dsSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IuRwGRk7x+c1HDFpnoYWVpNlHoOuaVBA3+hE2ZH8FK4=;
        b=nM9B39FEZWeU+1y5my+GeTNDvZ9vTel2tqjIM5ImAUvE6PaJz0CyfFY5cfTGVpihQ8
         LBJ+2POfydBUxAkPipanIphAjDT5xlrCZMIzczgJbLdWy8dwbmM/T7BhfHLTyJChwT3O
         DxBvl0VCJXwi1sOne3LTUDR/nUBAofRfnvprlw/TNqUh/5ZiOrIcZje6llPd8HqIjH1K
         oNVHI81aNgi3VJ+rKcO0ZZjiCkC4rY5uUFAloVkPT3PIjd2DRwCXuUijFxgAzv+Pf08h
         lPNkvZAEhkz8y7TyLTbyiI/Spsx9HbHJ17RzuDppaISumHEOCXqi0mRwnA/m3LEyY1KP
         ugyA==
X-Gm-Message-State: APjAAAWOKXRYnS9Tq3uQthxLTFA427Jx0bVntAIuPMbYE+nX9wVE9NqD
        UNPlEbakgWGTbuQmwDlgLjE=
X-Google-Smtp-Source: APXvYqzQwQ5yzAHOxcnhPUzPd9jpDS06ADygJ2qikrCjjGh/RUY/FXxt0t0pZQhoj3gdXLxvTeHqwQ==
X-Received: by 2002:a05:6638:20a:: with SMTP id e10mr14973482jaq.27.1572215086319;
        Sun, 27 Oct 2019 15:24:46 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id v28sm1077021ill.74.2019.10.27.15.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2019 15:24:45 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Richard Fontana <rfontana@redhat.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: dvb: Fix memory leak in af9005_identify_state
Date:   Sun, 27 Oct 2019 17:24:35 -0500
Message-Id: <20191027222438.16208-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the implementation of af9005_identify_state() there is a memory leak
when checking the reply of af9005_boot_packet(). Go to error path to
release buf.

Fixes: af4e067e1dcf ("V4L/DVB (5625): Add support for the AF9005 demodulator from Afatech")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/media/usb/dvb-usb/af9005.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/dvb-usb/af9005.c b/drivers/media/usb/dvb-usb/af9005.c
index 02697d86e8c1..cfaf630be4d8 100644
--- a/drivers/media/usb/dvb-usb/af9005.c
+++ b/drivers/media/usb/dvb-usb/af9005.c
@@ -975,8 +975,10 @@ static int af9005_identify_state(struct usb_device *udev,
 		*cold = 1;
 	else if (reply == 0x02)
 		*cold = 0;
-	else
-		return -EIO;
+	else {
+		ret = -EIO;
+		goto err;
+	}
 	deb_info("Identify state cold = %d\n", *cold);
 
 err:
-- 
2.17.1

