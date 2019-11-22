Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95106C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 20:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62B3620704
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 20:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TgamuQAA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbfKVUmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 15:42:25 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33743 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfKVUmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 15:42:24 -0500
Received: by mail-pf1-f193.google.com with SMTP id c184so4048822pfb.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 12:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=lkSiArHUwBNm+WvcY+WNVziWupycIGgOCaH0d9L4oKM=;
        b=TgamuQAAJ93US1tb5tbp9AaWRgBUc4Y04v2m6yGq64/K/nhuBIIi7E9Uxp1tPVF6zI
         kuXABQZmoKhNRMV8088BHMa7GQH8QnBWQMIXoJC8ciamallOPVfart3gsrgCz3+p05hp
         RwyC8u1/Sg5N1O3sXuaBhQTLdClNrQN5+YuI20SDPa5w6Lf4In70bewKP7xC5Y8Zi9LH
         yXY5m7mR1CiKUybUMuRgYiMnFb97Kq4NIgfTHpxwp0DZ9WH3e1njW0D7SrVJBslG59Nn
         yrsJkRiphkh7XMe9ecLBBnBH2CfphLOKBmiyF/DL4lazvY3ORclXJplPyVgNuXTYHYUO
         wUBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=lkSiArHUwBNm+WvcY+WNVziWupycIGgOCaH0d9L4oKM=;
        b=BxpGH16J6tXJXkHIuWP1iC5ErcJ531JkH2+aqP+iB/vINg/uNzkl8LQ/m1/cIQC1AA
         yaLG6Wg9do+1PfpU3N8FGSTb9soZ85tIkZulS9eVidOk5DhMPXcqcravMreDWQ2S22f/
         1ShznFATWmNVNKKtg++DACSZJ8WLExzL4CCQZ4WomBnMfdwNoXq87QBQy0nMiAWth+H1
         sVBmQu9HlX9+pSCrYxQ3LJqFzIO7aWDYLbKmtoofa5/RPOWoauIysIXgbd6AKPriQCVb
         951T2eES/uxXa4Z9M8oqlwh5QJnCuyRUpZszPNEFJc2ly6+bJtbT/98pW5c/THReETl6
         Fx2w==
X-Gm-Message-State: APjAAAWkojgF4GpyAlDE7aph/2H6loB6mBX55+QiIdaRteQk1txKb3aP
        WNBrB/GxVcZbRU1MwSNO5kU=
X-Google-Smtp-Source: APXvYqyT0NnGGcHmV/xr/2z5gLJLLyY78cNeCEVHdicx7gpTJF6MBh0vm/Nf3aE9N5tat3em6Dux9g==
X-Received: by 2002:a63:3181:: with SMTP id x123mr4283097pgx.267.1574455343576;
        Fri, 22 Nov 2019 12:42:23 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id q184sm8516014pfc.111.2019.11.22.12.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 12:42:22 -0800 (PST)
Date:   Fri, 22 Nov 2019 12:42:20 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] tty: vt: keyboard: reject invalid keycodes
Message-ID: <20191122204220.GA129459@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not try to handle keycodes that are too big, otherwise we risk doing
out-of-bounds writes:

BUG: KASAN: global-out-of-bounds in clear_bit include/asm-generic/bitops-instrumented.h:56 [inline]
BUG: KASAN: global-out-of-bounds in kbd_keycode drivers/tty/vt/keyboard.c:1411 [inline]
BUG: KASAN: global-out-of-bounds in kbd_event+0xe6b/0x3790 drivers/tty/vt/keyboard.c:1495
Write of size 8 at addr ffffffff89a1b2d8 by task syz-executor108/1722
...
 kbd_keycode drivers/tty/vt/keyboard.c:1411 [inline]
 kbd_event+0xe6b/0x3790 drivers/tty/vt/keyboard.c:1495
 input_to_handler+0x3b6/0x4c0 drivers/input/input.c:118
 input_pass_values.part.0+0x2e3/0x720 drivers/input/input.c:145
 input_pass_values drivers/input/input.c:949 [inline]
 input_set_keycode+0x290/0x320 drivers/input/input.c:954
 evdev_handle_set_keycode_v2+0xc4/0x120 drivers/input/evdev.c:882
 evdev_do_ioctl drivers/input/evdev.c:1150 [inline]

In this case we were dealing with a fuzzed HID device that declared over
12K buttons, and while HID layer should not be reporting to us such big
keycodes, we should also be defensive and reject invalid data ourselves as
well.

Reported-by: syzbot+19340dff067c2d3835c0@syzkaller.appspotmail.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/tty/vt/keyboard.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index 515fc095e3b4..15d33fa0c925 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -1491,7 +1491,7 @@ static void kbd_event(struct input_handle *handle, unsigned int event_type,
 
 	if (event_type == EV_MSC && event_code == MSC_RAW && HW_RAW(handle->dev))
 		kbd_rawcode(value);
-	if (event_type == EV_KEY)
+	if (event_type == EV_KEY && event_code <= KEY_MAX)
 		kbd_keycode(event_code, value, HW_RAW(handle->dev));
 
 	spin_unlock(&kbd_event_lock);
-- 
2.24.0.432.g9d3f5f5b63-goog


-- 
Dmitry
