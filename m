Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB1C6CA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 14:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E93E222BD
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 14:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571409550;
	bh=lHuRLSOSgV6KcIVWuHfrYjsQ0Yi/gXasSp2cKArf0pY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uYyOpHFJ0OJTzRoKtXT5KzBJOHmtbCbAjVfRUWbAg2d1ja+KaT69fRXc6Z6Ir7SU0
	 EtLieIQ367z4lspEhwUuDp9ravC9Tpov+0jr0l5YX7n9iT35Nummxm4ZdnYgF9KT6o
	 5/t0LuUGYgH+dy/dsyuYE47jp7q0v8sprog86dUA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442880AbfJROjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 10:39:09 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35800 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389378AbfJROjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 10:39:09 -0400
Received: by mail-lj1-f194.google.com with SMTP id m7so6503115lji.2;
        Fri, 18 Oct 2019 07:39:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LbCFg90tZn9EApNaH07+5wKWNZp+7rMtEw6dw5RX9Zs=;
        b=TmgopnJpXXlmIsIkm/fkvnHLFEBVnBjYS2CMin79qkHrJuS48bZBeehwHNYoYlknLs
         FefyKKxWjxM5RA14tYzUZR3J1MuOk9eX6u4Yoo0ov79eizKYuETvBA2IQkShUks+eQam
         PBqOxS398xkzlySyct3OpJNyh9xI6VPsGXGVXq+lMQIMtgvdiSmOL0vwui+zdNWJ02Ug
         WxTHVWzyJvpbrEWbr3Fr/kaJFzT9qENs97aztiLd9AibZP87XA/arq6MLbYACO7SNteV
         7Z0VnS9tMoVZq8P37Cg+MoSbgu3vfqDJiQEUP1mMtuDUtqsqRH78HtIxPwCW/zuBqnm4
         7Lbw==
X-Gm-Message-State: APjAAAXSu7S7lrUBo0TFG408FTSi1Wf0mDT9WUGX9+tWh1etUhJApUFz
        COWY/f2L9erOCG/JehyxVz8=
X-Google-Smtp-Source: APXvYqyGv2tx0rzBfzTwUSQeBXVBVRdDweWYs8Gas8dPP4WfNjelb8SuupVTrDcmoZUC+DujkM7V5A==
X-Received: by 2002:a2e:908d:: with SMTP id l13mr5996494ljg.165.1571409545484;
        Fri, 18 Oct 2019 07:39:05 -0700 (PDT)
Received: from xi.terra (c-51f1e055.07-184-6d6c6d4.bbcust.telenor.se. [85.224.241.81])
        by smtp.gmail.com with ESMTPSA id x2sm2355956ljj.94.2019.10.18.07.39.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Oct 2019 07:39:04 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92.2)
        (envelope-from <johan@kernel.org>)
        id 1iLTPQ-0006QJ-35; Fri, 18 Oct 2019 16:39:16 +0200
Date:   Fri, 18 Oct 2019 16:39:16 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     syzbot <syzbot+45b2f40f0778cfa7634e@syzkaller.appspotmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: BUG: bad usercopy in ld_usb_read
Message-ID: <20191018143916.GF21827@localhost>
References: <0000000000005c056c058f9a5437@google.com>
 <CAAeHK+wcAgqNvEO_S_EXgdvhBN2qkQbPii8XVT_7UVnS1WaB6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAeHK+wcAgqNvEO_S_EXgdvhBN2qkQbPii8XVT_7UVnS1WaB6g@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 02:06:08PM +0200, Andrey Konovalov wrote:
> On Thu, Aug 8, 2019 at 2:38 PM syzbot
> <syzbot+45b2f40f0778cfa7634e@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    e96407b4 usb-fuzzer: main usb gadget fuzzer driver
> > git tree:       https://github.com/google/kasan.git usb-fuzzer
> > console output: https://syzkaller.appspot.com/x/log.txt?x=13aeaece600000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=cfa2c18fb6a8068e
> > dashboard link: https://syzkaller.appspot.com/bug?extid=45b2f40f0778cfa7634e
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> >
> > Unfortunately, I don't have any reproducer for this crash yet.
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+45b2f40f0778cfa7634e@syzkaller.appspotmail.com
> >
> > ldusb 6-1:0.124: Read buffer overflow, -131383996186150 bytes dropped
> > usercopy: Kernel memory exposure attempt detected from SLUB
> > object 'kmalloc-2k' (offset 8, size 65062)!
> > ------------[ cut here ]------------
> > kernel BUG at mm/usercopy.c:98!
> > invalid opcode: 0000 [#1] SMP KASAN
> > CPU: 0 PID: 15185 Comm: syz-executor.2 Not tainted 5.3.0-rc2+ #25
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > Google 01/01/2011
> > RIP: 0010:usercopy_abort+0xb9/0xbb mm/usercopy.c:98
> > Code: e8 c1 f7 d6 ff 49 89 d9 4d 89 e8 4c 89 e1 41 56 48 89 ee 48 c7 c7 e0
> > f3 cd 85 ff 74 24 08 41 57 48 8b 54 24 20 e8 15 98 c1 ff <0f> 0b e8 95 f7
> > d6 ff e8 80 9f fd ff 8b 54 24 04 49 89 d8 4c 89 e1
> > RSP: 0018:ffff8881ccb3fc38 EFLAGS: 00010286
> > RAX: 0000000000000067 RBX: ffffffff86a659d4 RCX: 0000000000000000
> > RDX: 0000000000000000 RSI: ffffffff8128a0fd RDI: ffffed1039967f79
> > RBP: ffffffff85cdf2c0 R08: 0000000000000067 R09: fffffbfff11acdaa
> > R10: fffffbfff11acda9 R11: ffffffff88d66d4f R12: ffffffff86a696e8
> > R13: ffffffff85cdf180 R14: 000000000000fe26 R15: ffffffff85cdf140
> > FS:  00007ff6daf91700(0000) GS:ffff8881db200000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007f1de6600000 CR3: 00000001ca554000 CR4: 00000000001406f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >   __check_heap_object+0xdd/0x110 mm/slub.c:3914
> >   check_heap_object mm/usercopy.c:234 [inline]
> >   __check_object_size mm/usercopy.c:280 [inline]
> >   __check_object_size+0x32d/0x39b mm/usercopy.c:250
> >   check_object_size include/linux/thread_info.h:119 [inline]
> >   check_copy_size include/linux/thread_info.h:150 [inline]
> >   copy_to_user include/linux/uaccess.h:151 [inline]
> >   ld_usb_read+0x304/0x780 drivers/usb/misc/ldusb.c:495
> 
> #syz dup: KASAN: use-after-free Read in ld_usb_release

This was a different bug. Mark as dup of the latest report:

#syz dup: KASAN: slab-out-of-bounds Read in ld_usb_read (3)

Johan
