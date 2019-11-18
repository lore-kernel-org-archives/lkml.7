Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1AEDC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 13:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 756BD20748
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 13:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfKRNoe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 08:44:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:42934 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726490AbfKRNoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 08:44:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2F90BABCD;
        Mon, 18 Nov 2019 13:44:32 +0000 (UTC)
Message-ID: <1574084670.2698.7.camel@suse.com>
Subject: Re: KASAN: use-after-free Read in si470x_int_in_callback (2)
From:   Oliver Neukum <oneukum@suse.com>
To:     syzbot <syzbot+9ca7a12fd736d93e0232@syzkaller.appspotmail.com>,
        andreyknvl@google.com, hverkuil@xs4all.nl,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-usb@vger.kernel.org, mchehab@kernel.org,
        syzkaller-bugs@googlegroups.com
Date:   Mon, 18 Nov 2019 14:44:30 +0100
In-Reply-To: <000000000000f47f0b0595307ddc@google.com>
References: <000000000000f47f0b0595307ddc@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, den 18.10.2019, 07:53 -0700 schrieb syzbot:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    22be26f7 usb-fuzzer: main usb gadget fuzzer driver
> git tree:       https://github.com/google/kasan.git usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=102b65cf600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=387eccb7ac68ec5
> dashboard link: https://syzkaller.appspot.com/bug?extid=9ca7a12fd736d93e0232
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=143b9060e00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15d3b94b600000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+9ca7a12fd736d93e0232@syzkaller.appspotmail.com

#syz test: https://github.com/google/kasan.git 22be26f7

From e7c30d32a1d9b3589c31593ce18b8df45989a27c Mon Sep 17 00:00:00 2001
From: Oliver Neukum <oneukum@suse.com>
Date: Mon, 18 Nov 2019 14:41:51 +0100
Subject: [PATCH] si470x: prevent resubmission

Poison the URB in case probe fails to remove any chance
of a resubmission from the callback.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/media/radio/si470x/radio-si470x-usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/radio/si470x/radio-si470x-usb.c b/drivers/media/radio/si470x/radio-si470x-usb.c
index fedff68d8c49..b6e25d5c7c53 100644
--- a/drivers/media/radio/si470x/radio-si470x-usb.c
+++ b/drivers/media/radio/si470x/radio-si470x-usb.c
@@ -749,7 +749,7 @@ static int si470x_usb_driver_probe(struct usb_interface *intf,
 
 	return 0;
 err_all:
-	usb_kill_urb(radio->int_in_urb);
+	usb_poison_urb(radio->int_in_urb);
 err_buf:
 	kfree(radio->buffer);
 err_ctrl:
-- 
2.16.4

