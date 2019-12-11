Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4E9C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2EB322B48
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576077919;
	bh=B3UhKAqWVlq8iHx8Xvx/hiWVPkC7YtwfvTyR+6T9d2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F8ZwnL01SUi9NMD6rtKHWird8PMD6+oapZAhL5kZFLlwwKRNiYAB4IPz9jKcdhkB9
	 uyNcCDWL2DTkYIxXTrfN+PxblXEGIKKbwlVgPR/4eL/e52no3BB+0w9Xq2ojqaIj1Z
	 xUT/Bwl7iGvkrOz8+yG2wjXOVc4U9bRlM8bq80iw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732803AbfLKPZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:25:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:57106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732659AbfLKPZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:25:16 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 538FF22B48;
        Wed, 11 Dec 2019 15:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077915;
        bh=B3UhKAqWVlq8iHx8Xvx/hiWVPkC7YtwfvTyR+6T9d2A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TkEEUt8cgP4cFmhXh4rw8XyMg1BVh8lNRoOWsK8trqVNsP2w8aJliCYWh8x/gFvVo
         y7DzflsFU/W8Dxc004qx7xImhAQtChDbyHZpLr1PRfupFAxHq/r3Cb3q8gxFUOMB2Z
         iRNyPTspqo0VTBuf80lqZY15t4KBWFyr3ZbK0yHg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+19340dff067c2d3835c0@syzkaller.appspotmail.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.19 218/243] tty: vt: keyboard: reject invalid keycodes
Date:   Wed, 11 Dec 2019 16:06:20 +0100
Message-Id: <20191211150354.051637725@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191211150339.185439726@linuxfoundation.org>
References: <20191211150339.185439726@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

commit b2b2dd71e0859436d4e05b2f61f86140250ed3f8 upstream.

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
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20191122204220.GA129459@dtor-ws
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/vt/keyboard.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -1491,7 +1491,7 @@ static void kbd_event(struct input_handl
 
 	if (event_type == EV_MSC && event_code == MSC_RAW && HW_RAW(handle->dev))
 		kbd_rawcode(value);
-	if (event_type == EV_KEY)
+	if (event_type == EV_KEY && event_code <= KEY_MAX)
 		kbd_keycode(event_code, value, HW_RAW(handle->dev));
 
 	spin_unlock(&kbd_event_lock);


