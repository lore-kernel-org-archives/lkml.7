Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D72FC5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 02:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE2AC21873
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 02:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eMgdo5cx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbfGCCPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 22:15:02 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45575 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfGCCPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 22:15:02 -0400
Received: by mail-pl1-f193.google.com with SMTP id bi6so299697plb.12;
        Tue, 02 Jul 2019 19:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Isqfps/O6LwRnu+dRSzriy5CxI0umRBIFUrqM+okdCs=;
        b=eMgdo5cxD8xocs0qEkS5EHNLEtNLZV+yO9aTlypZIbft8FBVAa/yS1ZqB/gmuI9J/0
         Y8Pu2DxexEkDszk9Vt58d1mBAWJBnWu1X/ISi5igs1bfkab1EeO/UYJxuIodJvv+bug8
         RLH6+zu3qy8OB+mCmUxEv2K/a6RmUkDmtOIcoYpld8hLAO5MFAPgxNp+m6D4M9n0Ouc3
         DHY9n/2eiMdeYjvHF07NkRPu7wpGYeBMmMZXtpBr1e91vJDDJf405wmxpI0DIi/xxU+x
         tuuOLTUVeWD5skWO0zu3+1OIW3Bq7UykHev7jtjweIeTsCh1C7mqHXKyVYOfCz+rDy+o
         mSPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Isqfps/O6LwRnu+dRSzriy5CxI0umRBIFUrqM+okdCs=;
        b=Aeavo+47bzaP0DLTpADFMMtDRqyFIN21vTuHT0oykWfA0sH1wajrDBV2i0dF5Xf084
         XUu7NH3rM9vbTCbhwcbJebcbZvp/T9gBQeNcGa8qN0SzTEyCyB8icjg3U948Qmbx6IDr
         8RnTIPCWbg/A7lZl7d9P+dcWhuXuKmTUA74yzhWCms0ASn8PmoYU9bqB99HxmEugOgfF
         oH/UH5HFoylAjLfMLaSQQML6CYpU0EYJCGIZVXIWUlwbvane7Q1k25a9WJVTp4CIcTvq
         oHu/TL77NNqXszzIg604TGu1JfHaCPpfFmZ4XQqJqhkDHfBkxvnYKhx4WENUL7tRTrV3
         VhgQ==
X-Gm-Message-State: APjAAAWtoVjybjiq8ADL66h6clmA+A7EqoyeqmmgdVMQM6Qn+wv6Ssxh
        B2d0iuaULxImOdOiD6oFDa4=
X-Google-Smtp-Source: APXvYqzbJaktcOHx/dP/TVDMSw89q+FpGXl/R5M9ermN1pbkJ4Zt5sJqY6gmBfin0c4K0V1idxIXQA==
X-Received: by 2002:a17:902:b944:: with SMTP id h4mr30236136pls.179.1562120101420;
        Tue, 02 Jul 2019 19:15:01 -0700 (PDT)
Received: from debian.net.fpt ([2405:4800:58f7:1cb1:98e0:87d3:2c8b:b6ed])
        by smtp.gmail.com with ESMTPSA id h2sm382955pgs.17.2019.07.02.19.14.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 19:15:00 -0700 (PDT)
From:   Phong Tran <tranmanphong@gmail.com>
To:     tranmanphong@gmail.com
Cc:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        hans.verkuil@cisco.com, keescook@chromium.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-usb@vger.kernel.org, mchehab@kernel.org,
        skhan@linuxfoundation.org,
        syzbot+eaaaf38a95427be88f4b@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, glider@google.com
Subject: [PATCH V2] media: usb: technisat-usb2: fix buffer overflow
Date:   Wed,  3 Jul 2019 09:14:44 +0700
Message-Id: <20190703021444.19954-1-tranmanphong@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190702140211.28399-1-tranmanphong@gmail.com>
References: <20190702140211.28399-1-tranmanphong@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The buffer will be overflow in case of the while loop can not break.
Add the checking buffer condition in while loop for avoiding
overlooping index.

This issue was reported by syzbot

Reported-by: syzbot+eaaaf38a95427be88f4b@syzkaller.appspotmail.com

Tested-by:
https://groups.google.com/d/msg/syzkaller-bugs/CySBCKuUOOs/t3PvVheSAAAJ

Signed-off-by: Phong Tran <tranmanphong@gmail.com>
---
Change Log:
 * V2: add IR_MAX_BUFFER_INDEX and adjust the while loop condition as comments
---
 drivers/media/usb/dvb-usb/technisat-usb2.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/dvb-usb/technisat-usb2.c b/drivers/media/usb/dvb-usb/technisat-usb2.c
index c659e18b358b..cdabff97c1ea 100644
--- a/drivers/media/usb/dvb-usb/technisat-usb2.c
+++ b/drivers/media/usb/dvb-usb/technisat-usb2.c
@@ -49,6 +49,7 @@ MODULE_PARM_DESC(disable_led_control,
 		"disable LED control of the device (default: 0 - LED control is active).");
 
 /* device private data */
+#define IR_MAX_BUFFER_INDEX	63
 struct technisat_usb2_state {
 	struct dvb_usb_device *dev;
 	struct delayed_work green_led_work;
@@ -56,7 +57,7 @@ struct technisat_usb2_state {
 
 	u16 last_scan_code;
 
-	u8 buf[64];
+	u8 buf[IR_MAX_BUFFER_INDEX + 1];
 };
 
 /* debug print helpers */
@@ -655,7 +656,7 @@ static int technisat_usb2_get_ir(struct dvb_usb_device *d)
 #endif
 
 	ev.pulse = 0;
-	while (1) {
+	while (b <= (buf + IR_MAX_BUFFER_INDEX)) {
 		ev.pulse = !ev.pulse;
 		ev.duration = (*b * FIRMWARE_CLOCK_DIVISOR * FIRMWARE_CLOCK_TICK) / 1000;
 		ir_raw_event_store(d->rc_dev, &ev);
-- 
2.11.0

