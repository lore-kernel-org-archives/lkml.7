Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F70C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 10:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC1B4206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 10:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732379AbfG3KMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 06:12:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:43896 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726078AbfG3KMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 06:12:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2735DAFB1;
        Tue, 30 Jul 2019 10:12:20 +0000 (UTC)
Message-ID: <1564481531.25582.22.camel@suse.com>
Subject: Re: WARNING in usbtouch_open
From:   Oliver Neukum <oneukum@suse.com>
To:     syzbot <syzbot+199ea16c7f26418b4365@syzkaller.appspotmail.com>,
        rydberg@bitmath.org, mpe@ellerman.id.au, dmitry.torokhov@gmail.com,
        andreyknvl@google.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, gregkh@linuxfoundation.org,
        kstewart@linuxfoundation.org, allison@lohutok.net,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Date:   Tue, 30 Jul 2019 12:12:11 +0200
In-Reply-To: <000000000000394df0058ed48487@google.com>
References: <000000000000394df0058ed48487@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, den 29.07.2019, 09:38 -0700 schrieb syzbot:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    7f7867ff usb-fuzzer: main usb gadget fuzzer driver
> git tree:       https://github.com/google/kasan.git usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=1503f4ec600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=792eb47789f57810
> dashboard link: https://syzkaller.appspot.com/bug?extid=199ea16c7f26418b4365
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=173e4442600000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=115482b2600000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+199ea16c7f26418b4365@syzkaller.appspotmail.com

#syz test: https://github.com/google/kasan.git usb-fuzzer

From 29b755588bd353d0e10ae384c2c551dffa1b3e7b Mon Sep 17 00:00:00 2001
From: Oliver Neukum <oneukum@suse.com>
Date: Tue, 30 Jul 2019 12:00:27 +0200
Subject: [PATCH] usbtouchscreen: add proper initialization

Mutexes shall be initialized before they are used.

Fixes: 12e510dbc57b2 ("Input: usbtouchscreen - fix deadlock in autosuspend")
Reported-by: syzbot+199ea16c7f26418b4365@syzkaller.appspotmail.com
Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/input/touchscreen/usbtouchscreen.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/touchscreen/usbtouchscreen.c b/drivers/input/touchscreen/usbtouchscreen.c
index a2cec6cacf57..caacf211f51b 100644
--- a/drivers/input/touchscreen/usbtouchscreen.c
+++ b/drivers/input/touchscreen/usbtouchscreen.c
@@ -1658,6 +1658,7 @@ static int usbtouch_probe(struct usb_interface *intf,
 	input_dev = input_allocate_device();
 	if (!usbtouch || !input_dev)
 		goto out_free;
+	mutex_init(&usbtouch->pm_mutex);
 
 	type = &usbtouch_dev_info[id->driver_info];
 	usbtouch->type = type;
-- 
2.16.4

