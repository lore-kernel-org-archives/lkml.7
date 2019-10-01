Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A54FA373E
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 08:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7792B21855
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 08:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569916820;
	bh=4BIstuF3OeZy0Al1z/yhXLKq06uL5yrbqBkdW/rFkyI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GFrPOeyKu8vMOqLdPvemwVbeyt+BIxAmjHJOWOdfOBb//Tun68AZChWIgEpss+hjY
	 yGSGQUZeJpRTRN/YOgifZFCoQm4Nky9W8K50X2AHFVmvzLMKKXggD+cNoEugdcKspp
	 7/82+qd6io1mvvnCLQRLX59Nm1OOzYbMhjvE2wz0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732648AbfJAIAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 04:00:20 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44009 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbfJAIAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 04:00:19 -0400
Received: by mail-lj1-f195.google.com with SMTP id n14so12257307ljj.10;
        Tue, 01 Oct 2019 01:00:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XuN/zCLmlv3rm0xUYm8rWAAuPLUNukAu+ki5n0j1ymc=;
        b=jIZgX2j0wL+Ueu9hlayX6s+q/SF7IJlY2WNqAUatOkLKK8y9FEffMpuZGKRNh1F9rV
         kn3kMwnY6NAzgtvIl2BUppGvkQmNQv/ZuqTiZ9Xp0N1Bt4yAgfqOBAaUfd7WbrnDgg72
         vVH0HunppYYOQCZi+Rr/ZcEuVSwXCIv8lIqA+zj7WvsEbcQLZNwRAbIMWEMzYKffOg0y
         yE2oB9alnuIBlYpWpBdiM3rcGXsTpJAKqLKHqlvcMVVhRcJBFy3FbKg7S7jej6bBX7bY
         RvohPil2TADbPr1K7dkSmj816ueivawT+kHq8LBJ10G9pU1Nx7/DvtBW+ABtbSGKwYEi
         KuKQ==
X-Gm-Message-State: APjAAAXWK5ZXj4KzvZG41fwfjbSkhL36Rmj6n55rmS6WDcU6odijJTyl
        uEnvnFovKQlNKBIqWADoNPI=
X-Google-Smtp-Source: APXvYqxodoLdIUYSSV68SkVanMJFEHFzU/Avo/Y2dEYZtJtkwNBOK1W3iwGslHorLW2qqpj1aQkWZg==
X-Received: by 2002:a2e:2416:: with SMTP id k22mr14730652ljk.216.1569916817278;
        Tue, 01 Oct 2019 01:00:17 -0700 (PDT)
Received: from xi.terra (c-51f1e055.07-184-6d6c6d4.bbcust.telenor.se. [85.224.241.81])
        by smtp.gmail.com with ESMTPSA id x3sm3785406ljm.103.2019.10.01.01.00.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2019 01:00:15 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92.2)
        (envelope-from <johan@kernel.org>)
        id 1iFD55-0008My-VI; Tue, 01 Oct 2019 10:00:24 +0200
Date:   Tue, 1 Oct 2019 10:00:23 +0200
From:   Johan Hovold <johan@kernel.org>
To:     syzbot <syzbot+224d4aba0201decca39c@syzkaller.appspotmail.com>
Cc:     dmg@turingmachine.org, glider@google.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: KMSAN: uninit-value in adu_disconnect
Message-ID: <20191001080023.GE13531@localhost>
References: <0000000000007d3cb00593d0f485@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000007d3cb00593d0f485@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2019 at 08:29:07PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    014077b5 DO-NOT-SUBMIT: usb-fuzzer: main usb gadget fuzzer..
> git tree:       https://github.com/google/kmsan.git master
> console output: https://syzkaller.appspot.com/x/log.txt?x=108b5826600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f03c659d0830ab8d
> dashboard link: https://syzkaller.appspot.com/bug?extid=224d4aba0201decca39c
> compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
> 80fee25776c2fb61e74c1ecb1a523375c2500b69)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15abd5c1600000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=168e3a3a600000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+224d4aba0201decca39c@syzkaller.appspotmail.com
> 
> usb 1-1: USB disconnect, device number 23
> ==================================================================
> BUG: KMSAN: uninit-value in adu_disconnect+0x302/0x360  
> drivers/usb/misc/adutux.c:774
> CPU: 0 PID: 3372 Comm: kworker/0:2 Not tainted 5.3.0-rc7+ #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
> Google 01/01/2011
> Workqueue: usb_hub_wq hub_event
> Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0x191/0x1f0 lib/dump_stack.c:113
>   kmsan_report+0x162/0x2d0 mm/kmsan/kmsan_report.c:109
>   __msan_warning+0x75/0xe0 mm/kmsan/kmsan_instr.c:294
>   adu_disconnect+0x302/0x360 drivers/usb/misc/adutux.c:774
>   usb_unbind_interface+0x3a2/0xdd0 drivers/usb/core/driver.c:423
>   __device_release_driver drivers/base/dd.c:1120 [inline]
>   device_release_driver_internal+0x911/0xd20 drivers/base/dd.c:1151
>   device_release_driver+0x4b/0x60 drivers/base/dd.c:1174
>   bus_remove_device+0x4bf/0x670 drivers/base/bus.c:556
>   device_del+0xcd5/0x1d10 drivers/base/core.c:2339
>   usb_disable_device+0x567/0x1150 drivers/usb/core/message.c:1241
>   usb_disconnect+0x51e/0xd60 drivers/usb/core/hub.c:2199
>   hub_port_connect drivers/usb/core/hub.c:4949 [inline]
>   hub_port_connect_change drivers/usb/core/hub.c:5213 [inline]
>   port_event drivers/usb/core/hub.c:5359 [inline]
>   hub_event+0x3fd0/0x72f0 drivers/usb/core/hub.c:5441
>   process_one_work+0x1572/0x1ef0 kernel/workqueue.c:2269
>   worker_thread+0x111b/0x2460 kernel/workqueue.c:2415
>   kthread+0x4b5/0x4f0 kernel/kthread.c:256
>   ret_from_fork+0x35/0x40 arch/x86/entry/entry_64.S:355
> 
> Uninit was created at:
>   kmsan_save_stack_with_flags mm/kmsan/kmsan.c:189 [inline]
>   kmsan_internal_poison_shadow+0x58/0xb0 mm/kmsan/kmsan.c:148
>   kmsan_slab_free+0x8d/0x100 mm/kmsan/kmsan_hooks.c:195
>   slab_free_freelist_hook mm/slub.c:1472 [inline]
>   slab_free mm/slub.c:3038 [inline]
>   kfree+0x4c1/0x2db0 mm/slub.c:3980
>   adu_delete drivers/usb/misc/adutux.c:151 [inline]
>   adu_release+0x95f/0xa50 drivers/usb/misc/adutux.c:332
>   __fput+0x4c9/0xba0 fs/file_table.c:280
>   ____fput+0x37/0x40 fs/file_table.c:313
>   task_work_run+0x22e/0x2a0 kernel/task_work.c:113
>   tracehook_notify_resume include/linux/tracehook.h:188 [inline]
>   exit_to_usermode_loop arch/x86/entry/common.c:163 [inline]
>   prepare_exit_to_usermode+0x39d/0x4d0 arch/x86/entry/common.c:194
>   syscall_return_slowpath+0x90/0x610 arch/x86/entry/common.c:274
>   do_syscall_64+0xe2/0xf0 arch/x86/entry/common.c:300
>   entry_SYSCALL_64_after_hwframe+0x63/0xe7
> ==================================================================

Likely another manifestation of

#sys dup: KASAN: use-after-free Read in adu_disconnect

Fix posted here

	https://lkml.kernel.org/r/20190925092913.8608-1-johan@kernel.org

Johan
