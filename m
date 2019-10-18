Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24128CA9EA4
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 06:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F20E9222C3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 06:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571380101;
	bh=2sAV9MIxvfW4D3lwI++VMNmiCrHsgSPOP+vf1ydVlGQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZCcZFDs02OgZWEaGWrtmzlSiwF5QFTd9HbCLsOPO4/m+HYd1uwrvPYetCl/wOOmN5
	 iWvnoBghF5eGo0hPkoZrngt25d8ZtzNN806Vo3kKvBPfTIL9TewR1zzZhPRqYSpTA+
	 i/pRvfbbZeF7g5MUGfGiByR0yY72DA4pPV+F3Zvo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504384AbfJRG2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 02:28:20 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41094 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392981AbfJRG2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 02:28:19 -0400
Received: by mail-lf1-f67.google.com with SMTP id r2so3766686lfn.8;
        Thu, 17 Oct 2019 23:28:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HA+v2crwooYFKSKrTiGe2KsjMCQ2nDCEIwDutBW6fgI=;
        b=imT+hKvvaiKMrTZ1GLTI3q/pa9qJvg3WuBqYTz7DfYLRFNfIOcMbARaXpKTUcduTR6
         UEcAYIF/xQ5k/w68H04BnHMRlHPKcHQ05hSAJ+cIBzYxTAMyIepvHtrTFUy723Egt1Lo
         BQziNs8p9BoCWhSoHfArRwkyeK9bZK6RQQwKMcgUDsaBvpWrkVBPZAe5twXVmONG8Z4D
         J5aCwq4UrQNlNDUNDEYysm6RhTw6nVvBU77lOul/noqw8p3c214HDzUN71/GcV0nvr3y
         DiJ/rH76gssko7wzE217R4/eOXTdmL8vh2YOPCGwigmY7T5mfI7RuNmZJxYL2p9zA8P9
         8+3Q==
X-Gm-Message-State: APjAAAVvB+Q6s6922eJZupu2vRRnU1YEIJUqL5oKO0QBR5aLEFVLLrEV
        RJ/uEVKVsXX2I2vpKywxjzg=
X-Google-Smtp-Source: APXvYqzYWf+hwmnBslcKf7OLM8O+vbY5mJy2SnP1mey2Y2WQsHGJ2XjBYRttmQ9ZsUAhZeLspQsE/A==
X-Received: by 2002:ac2:555e:: with SMTP id l30mr4730572lfk.163.1571380096494;
        Thu, 17 Oct 2019 23:28:16 -0700 (PDT)
Received: from xi.terra (c-51f1e055.07-184-6d6c6d4.bbcust.telenor.se. [85.224.241.81])
        by smtp.gmail.com with ESMTPSA id d25sm2017001lfj.15.2019.10.17.23.28.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 23:28:15 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92.2)
        (envelope-from <johan@kernel.org>)
        id 1iLLkQ-0001pj-P3; Fri, 18 Oct 2019 08:28:26 +0200
Date:   Fri, 18 Oct 2019 08:28:26 +0200
From:   Johan Hovold <johan@kernel.org>
To:     syzbot <syzbot+acee996f6938b9ded381@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, andreyknvl@google.com, cai@lca.pw,
        info@metux.net, isaacm@codeaurora.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, willy@infradead.org
Subject: Re: BUG: bad usercopy in ld_usb_read (3)
Message-ID: <20191018062826.GE21827@localhost>
References: <00000000000087ce3a0595115382@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000087ce3a0595115382@google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 06:42:11PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    22be26f7 usb-fuzzer: main usb gadget fuzzer driver
> git tree:       https://github.com/google/kasan.git usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=1756ff77600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=387eccb7ac68ec5
> dashboard link: https://syzkaller.appspot.com/bug?extid=acee996f6938b9ded381
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+acee996f6938b9ded381@syzkaller.appspotmail.com
> 
> ldusb 5-1:0.28: Read buffer overflow, 177886378725897 bytes dropped
> usercopy: Kernel memory exposure attempt detected from process stack  
> (offset 0, size 2147479552)!
> ------------[ cut here ]------------
> kernel BUG at mm/usercopy.c:99!
> invalid opcode: 0000 [#1] SMP KASAN
> CPU: 1 PID: 6543 Comm: syz-executor.5 Not tainted 5.4.0-rc3+ #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
> Google 01/01/2011
> RIP: 0010:usercopy_abort+0xb9/0xbb mm/usercopy.c:99
> Code: e8 32 51 d6 ff 49 89 d9 4d 89 e8 4c 89 e1 41 56 48 89 ee 48 c7 c7 40  
> d9 cd 85 ff 74 24 08 41 57 48 8b 54 24 20 e8 46 e3 c0 ff <0f> 0b e8 06 51  
> d6 ff e8 31 8b fd ff 8b 54 24 04 49 89 d8 4c 89 e1
> RSP: 0018:ffff8881d35f7c58 EFLAGS: 00010282
> RAX: 0000000000000061 RBX: ffffffff85cdd660 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: ffffffff8128bcbd RDI: ffffed103a6bef7d
> RBP: ffffffff85cdd820 R08: 0000000000000061 R09: fffffbfff11b23be
> R10: fffffbfff11b23bd R11: ffffffff88d91def R12: ffffffff85cdda40
> R13: ffffffff85cdd660 R14: 000000007ffff000 R15: ffffffff85cdd660
> FS:  00007fb330338700(0000) GS:ffff8881db300000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f07cea47000 CR3: 00000001cc11e000 CR4: 00000000001406e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   __check_object_size mm/usercopy.c:282 [inline]
>   __check_object_size.cold+0x91/0xbb mm/usercopy.c:256
>   check_object_size include/linux/thread_info.h:119 [inline]
>   check_copy_size include/linux/thread_info.h:150 [inline]
>   copy_to_user include/linux/uaccess.h:151 [inline]
>   ld_usb_read+0x31a/0x760 drivers/usb/misc/ldusb.c:492
>   __vfs_read+0x76/0x100 fs/read_write.c:425
>   vfs_read+0x1ea/0x430 fs/read_write.c:461
>   ksys_read+0x1e8/0x250 fs/read_write.c:587
>   do_syscall_64+0xb7/0x580 arch/x86/entry/common.c:290
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x459a59
> Code: fd b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
> ff 0f 83 cb b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007fb330337c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000459a59
> RDX: 00000000ffffffad RSI: 0000000020003200 RDI: 0000000000000004
> RBP: 000000000075bfc8 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007fb3303386d4
> R13: 00000000004c7120 R14: 00000000004dcae8 R15: 00000000ffffffff
> Modules linked in:
> ---[ end trace 0fa22c64036b6ebe ]---
> RIP: 0010:usercopy_abort+0xb9/0xbb mm/usercopy.c:99
> Code: e8 32 51 d6 ff 49 89 d9 4d 89 e8 4c 89 e1 41 56 48 89 ee 48 c7 c7 40  
> d9 cd 85 ff 74 24 08 41 57 48 8b 54 24 20 e8 46 e3 c0 ff <0f> 0b e8 06 51  
> d6 ff e8 31 8b fd ff 8b 54 24 04 49 89 d8 4c 89 e1
> RSP: 0018:ffff8881d35f7c58 EFLAGS: 00010282
> RAX: 0000000000000061 RBX: ffffffff85cdd660 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: ffffffff8128bcbd RDI: ffffed103a6bef7d
> RBP: ffffffff85cdd820 R08: 0000000000000061 R09: fffffbfff11b23be
> R10: fffffbfff11b23bd R11: ffffffff88d91def R12: ffffffff85cdda40
> R13: ffffffff85cdd660 R14: 000000007ffff000 R15: ffffffff85cdd660
> FS:  00007fb330338700(0000) GS:ffff8881db300000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f07cea47000 CR3: 00000001cc11e000 CR4: 00000000001406e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

#syz dup: KASAN: slab-out-of-bounds Read in ld_usb_read (3)

Fix under way.

Johan
