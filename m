Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D1DC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 02:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FEA521775
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 02:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ua9B3XHd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfLRCkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 21:40:22 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38042 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfLRCkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 21:40:21 -0500
Received: by mail-oi1-f194.google.com with SMTP id b8so329479oiy.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 18:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sqEP7gqkrCGOJNW3vRMCvtaiD1RqfKXzjUhoLGSDR0Q=;
        b=Ua9B3XHd/NB0fahFKPg3sdKPbluXuUSnmX/ItE0CVdBXgCD6uVcZKMApCrLnhHgwZ+
         4Xutrv0KuaFddTtAfuX/WzPS6F8f8EwDP7c0cgAfMEtKlMBXq2xCht/Y6Hpzgs6WzbNK
         5BgRMdqWyVxusAxie55Wfjreqh4QPQbd8wQ8oawM3b0lpfK1w6urAoz1ghpszS3337ic
         Q+An3hZKWzEzTUavT/nOFgf6zpdrXemf6+Quv1DGqXVl23Vp7MnD7+c6KaS8gypusvMU
         /MnbIleQda4wu+McuDZkoscjHILgAmNaNJALAVXdkk6CRbPGQpgPWbADGZKVALpPZxZM
         5xCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sqEP7gqkrCGOJNW3vRMCvtaiD1RqfKXzjUhoLGSDR0Q=;
        b=GbJxI/aOxu4/CNT1BCt2sS0ExzAXeTlYomm7NJfWS944NE5UPQpvV2zMzThapHYU00
         IcPc2xjVCFfpnK4Ek7a0FStq1lc4XfjhhbZZqC9OT7SsvubWBYlZU7a6LyAtb5R/QZq+
         t5upAwUxmokLyyOc1DEVpUJxUWAs/baEhn6uONJoYMvhakcYNqe6FF5RNY6nnR0OZ2Mw
         ygw/Zr2TNtkrqf3vZJcvBzvrXQqhKNgV6itOKCTgacCY5gboqECp0BFujd1GohzFKt4x
         ygxmoKCs4+GDT+HKqg/jHEIMjDTL4XmRTmTjllzubbd2JbtitCir0J68PrcIxvpOVG/7
         SI4g==
X-Gm-Message-State: APjAAAU3ULikuiyyQTb055anXHFSOVaDYtb10UjzrFJfnTysBeOhw41h
        CXTn34nNmXmKtCcEocfMEwA=
X-Google-Smtp-Source: APXvYqxI/RUy8g9sV8PfQI9L8yWi7uU4uNjDHVt76r+n7rGNEpFWTRZ84xojWPwPRKqDaIROEhTPdw==
X-Received: by 2002:aca:4712:: with SMTP id u18mr126536oia.93.1576636818831;
        Tue, 17 Dec 2019 18:40:18 -0800 (PST)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id n22sm282267otj.36.2019.12.17.18.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 18:40:18 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] tty: synclink_gt: Adjust indentation in several functions
Date:   Tue, 17 Dec 2019 19:39:13 -0700
Message-Id: <20191218023912.13827-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

../drivers/tty/synclink_gt.c:1337:3: warning: misleading indentation;
statement is not part of the previous 'if' [-Wmisleading-indentation]
        if (C_CRTSCTS(tty)) {
        ^
../drivers/tty/synclink_gt.c:1335:2: note: previous statement is here
        if (I_IXOFF(tty))
        ^
../drivers/tty/synclink_gt.c:2563:3: warning: misleading indentation;
statement is not part of the previous 'if' [-Wmisleading-indentation]
        if (I_BRKINT(info->port.tty) || I_PARMRK(info->port.tty))
        ^
../drivers/tty/synclink_gt.c:2561:2: note: previous statement is here
        if (I_INPCK(info->port.tty))
        ^
../drivers/tty/synclink_gt.c:3221:3: warning: misleading indentation;
statement is not part of the previous 'else' [-Wmisleading-indentation]
        set_signals(info);
        ^
../drivers/tty/synclink_gt.c:3219:2: note: previous statement is here
        else
        ^
3 warnings generated.

The indentation on these lines is not at all consistent, tabs and spaces
are mixed together. Convert to just using tabs to be consistent with the
Linux kernel coding style and eliminate these warnings from clang.

Link: https://github.com/ClangBuiltLinux/linux/issues/822
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

NOTE: There are several more instances of mixing spaces with tabs in
this file but I didn't want to do every instance because that would be a
lot of churn. I took the conservative approach of fixing the warnings
and the few instances I saw around them.

 drivers/tty/synclink_gt.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/synclink_gt.c b/drivers/tty/synclink_gt.c
index 5d59e2369c8a..57ca38df7a8b 100644
--- a/drivers/tty/synclink_gt.c
+++ b/drivers/tty/synclink_gt.c
@@ -1334,10 +1334,10 @@ static void throttle(struct tty_struct * tty)
 	DBGINFO(("%s throttle\n", info->device_name));
 	if (I_IXOFF(tty))
 		send_xchar(tty, STOP_CHAR(tty));
- 	if (C_CRTSCTS(tty)) {
+	if (C_CRTSCTS(tty)) {
 		spin_lock_irqsave(&info->lock,flags);
 		info->signals &= ~SerialSignal_RTS;
-	 	set_signals(info);
+		set_signals(info);
 		spin_unlock_irqrestore(&info->lock,flags);
 	}
 }
@@ -1359,10 +1359,10 @@ static void unthrottle(struct tty_struct * tty)
 		else
 			send_xchar(tty, START_CHAR(tty));
 	}
- 	if (C_CRTSCTS(tty)) {
+	if (C_CRTSCTS(tty)) {
 		spin_lock_irqsave(&info->lock,flags);
 		info->signals |= SerialSignal_RTS;
-	 	set_signals(info);
+		set_signals(info);
 		spin_unlock_irqrestore(&info->lock,flags);
 	}
 }
@@ -2560,8 +2560,8 @@ static void change_params(struct slgt_info *info)
 	info->read_status_mask = IRQ_RXOVER;
 	if (I_INPCK(info->port.tty))
 		info->read_status_mask |= MASK_PARITY | MASK_FRAMING;
- 	if (I_BRKINT(info->port.tty) || I_PARMRK(info->port.tty))
- 		info->read_status_mask |= MASK_BREAK;
+	if (I_BRKINT(info->port.tty) || I_PARMRK(info->port.tty))
+		info->read_status_mask |= MASK_BREAK;
 	if (I_IGNPAR(info->port.tty))
 		info->ignore_status_mask |= MASK_PARITY | MASK_FRAMING;
 	if (I_IGNBRK(info->port.tty)) {
@@ -3192,7 +3192,7 @@ static int tiocmset(struct tty_struct *tty,
 		info->signals &= ~SerialSignal_DTR;
 
 	spin_lock_irqsave(&info->lock,flags);
- 	set_signals(info);
+	set_signals(info);
 	spin_unlock_irqrestore(&info->lock,flags);
 	return 0;
 }
@@ -3203,7 +3203,7 @@ static int carrier_raised(struct tty_port *port)
 	struct slgt_info *info = container_of(port, struct slgt_info, port);
 
 	spin_lock_irqsave(&info->lock,flags);
- 	get_signals(info);
+	get_signals(info);
 	spin_unlock_irqrestore(&info->lock,flags);
 	return (info->signals & SerialSignal_DCD) ? 1 : 0;
 }
@@ -3218,7 +3218,7 @@ static void dtr_rts(struct tty_port *port, int on)
 		info->signals |= SerialSignal_RTS | SerialSignal_DTR;
 	else
 		info->signals &= ~(SerialSignal_RTS | SerialSignal_DTR);
- 	set_signals(info);
+	set_signals(info);
 	spin_unlock_irqrestore(&info->lock,flags);
 }
 
-- 
2.24.1

