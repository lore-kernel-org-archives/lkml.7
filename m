Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 801A1C432C2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 17:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CBD02146E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 17:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GrQ96GoV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502058AbfIXRhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 13:37:32 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:40572 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728460AbfIXRhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 13:37:32 -0400
Received: by mail-vk1-f201.google.com with SMTP id 70so12469vkc.7
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 10:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=cqlaQgskXZZonmcDyxSMH60accriyGsyjcSMTQXFDVo=;
        b=GrQ96GoVZCaNN10oq89i4aHnK6PqT2oRCB+KP7YvdXoO+LiXCSCjS521zmlVq6Ngzw
         fM2S18l+9Km3sNnAmAbitUsbC6SBoKbGecKzFdVmVg1AxV6EUHdpe8i38U4Gj+i4HC0t
         lrej3ZbBabIukl5yDVt6G/jtjgKZC8hsElSG15QXzs6TipHUEECTZyCxOp2xv0c9a5hJ
         U+sLpWkh0OMCYw2zirPhoETlurM94zdCChQgipuBAFlG76p+hCpvnCjGoScdYPmbyYBb
         j8Cw160KdYDFqJY1r2MoFJESTBVjT6gMqXG/ZveD/85LX+62wRCDEewHYGBUeCbkQlmB
         0zdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=cqlaQgskXZZonmcDyxSMH60accriyGsyjcSMTQXFDVo=;
        b=Ad1pdvA1W5tfYX3WummEIzUtQuGK2fv1oTZhZgOE9t/0Jy1yX9udnwVVX3tBLEAh+q
         2ahbxA1ArW0CuApfs6exHnO2v3rxrOSVmZJFLas9PKd6CVFbdGb3wLyvFnptHT5QAcys
         xmRLDeEW6zjJXJC6h+otytEi7wBMJijzmLnL5YD9bdlSugyKi33vctBrwXnEu4dXLgpc
         ZrSrDx36W/byX99ylhYflZ7bCOyDzxDrXczQ9uFJ9s4u6nJRQjHbjv1hc4BHg1maPTpG
         J9elJWSgm/t6ApnK2Nfri/+J0B2vveCimJODxmKJl2Jbg8C2W5Upe1OP0AOz9LJgmTs8
         sDFA==
X-Gm-Message-State: APjAAAW6ZTFK9LOmXjVuOh3VIRXQKH/HX0miU9R6o2d3qjyQkp76Gh+B
        WWwm+WjCl2CUjoWEKmeVjbkTkB4LLuznhzPogyk=
X-Google-Smtp-Source: APXvYqwp66tsQmiz5d8XVId4w7Ks7XKk7COLEK7zfZ3+Dy6OZILbIEz4tLj9lQEHlx3kgsr4zSDdYHlbbXK9DV88IMY=
X-Received: by 2002:a1f:3f10:: with SMTP id m16mr11725vka.15.1569346649344;
 Tue, 24 Sep 2019 10:37:29 -0700 (PDT)
Date:   Tue, 24 Sep 2019 10:37:17 -0700
Message-Id: <20190924173717.198637-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: [PATCH] hwmon: (applesmc) fix UB and udelay overflow
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     linux@roeck-us.net
Cc:     clang-built-linux@googlegroups.com, jdelvare@suse.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        "=?UTF-8?q?Tomasz=20Pawe=C5=82=20Gajc?=" <tpgxyz@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following 2 issues in the driver:
1. Left shifting a signed integer is undefined behavior. Unsigned
   integral types should be used for bitwise operations.
2. The delay scales from 0x0010 to 0x20000 by powers of 2, but udelay
   will result in a linkage failure when given a constant that's greater
   than 20000 (0x4E20). Agressive loop unrolling can fully unroll the
   loop, resulting in later iterations overflowing the call to udelay.

2 is fixed via splitting the loop in two, iterating the first up to the
point where udelay would overflow, then switching to mdelay, as
suggested in Documentation/timers/timers-howto.rst.

Reported-by: Tomasz Pawe=C5=82 Gajc <tpgxyz@gmail.com>
Link: https://github.com/ClangBuiltLinux/linux/issues/678
Debugged-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 drivers/hwmon/applesmc.c | 35 +++++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
index 183ff3d25129..2bc12812f52f 100644
--- a/drivers/hwmon/applesmc.c
+++ b/drivers/hwmon/applesmc.c
@@ -46,6 +46,7 @@
 #define APPLESMC_MIN_WAIT	0x0010
 #define APPLESMC_RETRY_WAIT	0x0100
 #define APPLESMC_MAX_WAIT	0x20000
+#define APPLESMC_UDELAY_MAX	20000
=20
 #define APPLESMC_READ_CMD	0x10
 #define APPLESMC_WRITE_CMD	0x11
@@ -157,14 +158,23 @@ static struct workqueue_struct *applesmc_led_wq;
 static int wait_read(void)
 {
 	u8 status;
-	int us;
-	for (us =3D APPLESMC_MIN_WAIT; us < APPLESMC_MAX_WAIT; us <<=3D 1) {
+	unsigned int us;
+
+	for (us =3D APPLESMC_MIN_WAIT; us < APPLESMC_UDELAY_MAX; us <<=3D 1) {
 		udelay(us);
 		status =3D inb(APPLESMC_CMD_PORT);
 		/* read: wait for smc to settle */
 		if (status & 0x01)
 			return 0;
 	}
+	/* switch to mdelay for longer sleeps */
+	for (; us < APPLESMC_MAX_WAIT; us <<=3D 1) {
+		mdelay(us);
+		status =3D inb(APPLESMC_CMD_PORT);
+		/* read: wait for smc to settle */
+		if (status & 0x01)
+			return 0;
+	}
=20
 	pr_warn("wait_read() fail: 0x%02x\n", status);
 	return -EIO;
@@ -177,10 +187,10 @@ static int wait_read(void)
 static int send_byte(u8 cmd, u16 port)
 {
 	u8 status;
-	int us;
+	unsigned int us;
=20
 	outb(cmd, port);
-	for (us =3D APPLESMC_MIN_WAIT; us < APPLESMC_MAX_WAIT; us <<=3D 1) {
+	for (us =3D APPLESMC_MIN_WAIT; us < APPLESMC_UDELAY_MAX; us <<=3D 1) {
 		udelay(us);
 		status =3D inb(APPLESMC_CMD_PORT);
 		/* write: wait for smc to settle */
@@ -196,6 +206,23 @@ static int send_byte(u8 cmd, u16 port)
 		udelay(APPLESMC_RETRY_WAIT);
 		outb(cmd, port);
 	}
+	/* switch to mdelay for longer sleeps */
+	for (; us < APPLESMC_MAX_WAIT; us <<=3D 1) {
+		mdelay(us);
+		status =3D inb(APPLESMC_CMD_PORT);
+		/* write: wait for smc to settle */
+		if (status & 0x02)
+			continue;
+		/* ready: cmd accepted, return */
+		if (status & 0x04)
+			return 0;
+		/* timeout: give up */
+		if (us << 1 =3D=3D APPLESMC_MAX_WAIT)
+			break;
+		/* busy: long wait and resend */
+		udelay(APPLESMC_RETRY_WAIT);
+		outb(cmd, port);
+	}
=20
 	pr_warn("send_byte(0x%02x, 0x%04x) fail: 0x%02x\n", cmd, port, status);
 	return -EIO;
--=20
2.23.0.351.gc4317032e6-goog

