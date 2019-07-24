Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC59AC7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 14:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A162222ADB
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 14:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387422AbfGXORs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 10:17:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:34516 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726287AbfGXORs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 10:17:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BF428AE44;
        Wed, 24 Jul 2019 14:17:46 +0000 (UTC)
Message-ID: <1563977855.4670.8.camel@suse.com>
Subject: Re: KASAN: use-after-free Read in usbhid_power
From:   Oliver Neukum <oneukum@suse.com>
To:     syzbot <syzbot+ef5de9c4f99c4edb4e49@syzkaller.appspotmail.com>,
        andreyknvl@google.com, syzkaller-bugs@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Date:   Wed, 24 Jul 2019 16:17:35 +0200
In-Reply-To: <000000000000bb4247058e589a20@google.com>
References: <000000000000bb4247058e589a20@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, den 23.07.2019, 05:48 -0700 schrieb syzbot:
> 
> Freed by task 243:
>   save_stack+0x1b/0x80 /mm/kasan/common.c:71
>   set_track /mm/kasan/common.c:79 [inline]
>   __kasan_slab_free+0x130/0x180 /mm/kasan/common.c:451
>   slab_free_hook /mm/slub.c:1421 [inline]
>   slab_free_freelist_hook /mm/slub.c:1448 [inline]
>   slab_free /mm/slub.c:2994 [inline]
>   kfree+0xd7/0x280 /mm/slub.c:3949
>   skb_free_head+0x8b/0xa0 /net/core/skbuff.c:588
>   skb_release_data+0x41f/0x7c0 /net/core/skbuff.c:608
>   skb_release_all+0x46/0x60 /net/core/skbuff.c:662
>   __kfree_skb /net/core/skbuff.c:676 [inline]
>   consume_skb /net/core/skbuff.c:736 [inline]
>   consume_skb+0xc0/0x2f0 /net/core/skbuff.c:730
>   skb_free_datagram+0x16/0xf0 /net/core/datagram.c:328
>   netlink_recvmsg+0x65e/0xea0 /net/netlink/af_netlink.c:2001
>   sock_recvmsg_nosec /net/socket.c:877 [inline]
>   sock_recvmsg /net/socket.c:894 [inline]
>   sock_recvmsg+0xca/0x110 /net/socket.c:890
>   ___sys_recvmsg+0x271/0x5a0 /net/socket.c:2448
>   __sys_recvmsg+0xe9/0x1b0 /net/socket.c:2497
>   do_syscall_64+0xb7/0x560 /arch/x86/entry/common.c:301
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe

How reliable is this trace? It seems very likely to me that this bug
is the same bug as

syzbot <syzbot+ded1794a717e3b235226@syzkaller.appspotmail.com>
KASAN: use-after-free Read in hidraw_ioctl

which shows a race with disconnect() instead of some networking code,
which I really cannot fathom.

	Regards
		Oliver

