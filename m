Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99314C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 11:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C34420748
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 11:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OyaN94NX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfKRLmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 06:42:00 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39740 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfKRLl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 06:41:59 -0500
Received: by mail-pg1-f193.google.com with SMTP id 29so9522662pgm.6;
        Mon, 18 Nov 2019 03:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GUSVLZmMqCMWMeD0FT4xlPzHbtQaXySLAxO0s7N20fw=;
        b=OyaN94NXMpCVElZ8Jw1WSv1yyO+jM2NeUo+yFOKhRx4WUNFccidxt6IWuwEiFy84z+
         tNQg5QGqeNbQPOTBhrRHcHxbWgMkT157Ebb4Dz1jWP/askkCcH8pofzUjkl8IDLGkhC0
         Wr9nznlGpUgn+s3PUWzUS0mwNmyJPLvXaYhWsRrOuZixx63Bn7APNEKGoqcr7pV9LImk
         QU++7ig0TwtFloemfAXCPH9Pu8q1dVP8nAillJt4c6ATNHv54emIlGz6FX0EuTXP2xWJ
         ZXUK9J8VmhbowEhKNbgtceawRPuCkvQXlDFiRTo6I7mm+WemE1CBJ8P4uboM+bPfoO1f
         Ln8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GUSVLZmMqCMWMeD0FT4xlPzHbtQaXySLAxO0s7N20fw=;
        b=M76rl0tuEw8cH0ub+2KLN2oIq1h7sL0CIhgm6pF8R+wwQ7jVO58krhDUmtAOgr3PC/
         FEOsi0rcLUvsVhy5LviiIGzjotrBRg7nLRYhGrgElgZgVk4cHGe0dEVKdxClk8HqJDgK
         bPomTiteX93QQOEMp08arU7K6WkB95Qvpd0q0dQ4zXL/Xx8bUsZeKiYR6vtGVZM3Rvvq
         eQgOKMmEvV4beyC01q1qkQVgGqXWKVFX8v8XehOg7jAXzHtQ2mBhKnBeCRVbWK19SFva
         EGU4TYQPdLtFFHkW7/sVlsmaa7g7BsCV2wJ2f893/pM94yW4Xf6IkiM7RRyx3Ws8YLtr
         X1vw==
X-Gm-Message-State: APjAAAVpwHQXVV9zGdMvhm82i2YHUaxUBWYIMyKsdJGiAdLaQPwsd2TI
        tF9PDrVBTh+29cqGPD2S56LORvP37NM=
X-Google-Smtp-Source: APXvYqwlZhctfGUcf61eKwA95+64A55BOSGDXtVe6j8GQMt1TABUbYCgPWwT7eZpn3YAxZAoBaB9dw==
X-Received: by 2002:aa7:80d2:: with SMTP id a18mr15473101pfn.29.1574077319270;
        Mon, 18 Nov 2019 03:41:59 -0800 (PST)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id m19sm19455324pgh.31.2019.11.18.03.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 03:41:58 -0800 (PST)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] video: ssd1307fb: add the missed regulator_disable
Date:   Mon, 18 Nov 2019 19:41:50 +0800
Message-Id: <20191118114150.25724-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver forgets to disable the regulator in remove like what is done
in probe failure.
Add the missed call to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/video/fbdev/ssd1307fb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index 78ca7ffc40c2..819fbee18dda 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -791,6 +791,8 @@ static int ssd1307fb_remove(struct i2c_client *client)
 		pwm_disable(par->pwm);
 		pwm_put(par->pwm);
 	}
+	if (par->vbat_reg)
+		regulator_disable(par->vbat_reg);
 	fb_deferred_io_cleanup(info);
 	__free_pages(__va(info->fix.smem_start), get_order(info->fix.smem_len));
 	framebuffer_release(info);
-- 
2.24.0

