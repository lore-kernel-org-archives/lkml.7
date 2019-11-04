Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D175CA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 11:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F6932184C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 11:32:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OHmyzytr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbfKDLcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 06:32:08 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37149 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfKDLcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 06:32:08 -0500
Received: by mail-oi1-f194.google.com with SMTP id y194so13780363oie.4
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 03:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LgK+yAXuBBasyZlWcSy8HTFWOw5g+0dw6fAMvS9UmrQ=;
        b=OHmyzytro2YzBNG3SNr0z31QSSdHpKzEutYNYHaU9Ms5b6NIGkRHtBftKmDNBbp4Q9
         RdJPJXHklTFobFkqhBHaYa50e4/yxwA+f9YqDPaWQDW//J1RK2uEC1J3wAdbufykSPQc
         5B4UZt0Zlt5x2X6b4V5v9NT1XuQdfOn8OSSwzmuU2epgRJVAAcYiUQEPEqN39w23S7tJ
         pAtQjqpKjLqeVc1DgUa2STvmoOLnMwtSknc3JXgTmjQwTio+RIUSE1SuACHujCbtAXok
         jw+rvdfVxjmAku+AzzxOnOuBKT12aCqyfWC5l38kldDU+chHG9nMo1ENGGCftsRpEo7R
         OBRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LgK+yAXuBBasyZlWcSy8HTFWOw5g+0dw6fAMvS9UmrQ=;
        b=O4lBUCPqP2Ki5LHa5Ygyn8pxflSOaE5Y1Cqx0/kdvOp1pCalp6DKbDQfZVowY2T78p
         3hAQzd6Bz8oRnhPgJfLrF9QZDZB11u91/234hC1EowGLhrbYjCkFsRtUwkEXzb8FIEtJ
         f6XGGEcWBsCxozMJ/pGLj0HanB5VzEBGBIhA2oyoGCb/MQc8yc02qb9+aYYn9Ss36HLd
         OsQVNTNJQXGHgAJERHncKLsndaRlKz14/4bFfqueJ0DaYwkJK/+3ohWTc1015/1qFLLD
         ZVinF0gPETgeYAvtEwLdtc+aiRAyn56taiiVbnIKxe42OVCeBG+0Ht29N7HMTkQj+UCi
         NoYQ==
X-Gm-Message-State: APjAAAUMhHM73W1dPikF7SmKUwkGB43mQHXbmBjzOQpfUDhI+jGr4goN
        00npfCoqbmT/rgOx34WfOQ/h0GhhHoAOrFgSeZQOIA==
X-Google-Smtp-Source: APXvYqwADTIAT8nVr1eUwu4FhyvANdA/5Zaz3r24TqGuctDzs9xfuRnjxZD8+K8Iwhg6IrLZ4exm40/42RMat0Q8I8U=
X-Received: by 2002:aca:5413:: with SMTP id i19mr15923461oib.121.1572867127172;
 Mon, 04 Nov 2019 03:32:07 -0800 (PST)
MIME-Version: 1.0
References: <000000000000b587670596839fab@google.com>
In-Reply-To: <000000000000b587670596839fab@google.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 4 Nov 2019 12:31:56 +0100
Message-ID: <CANpmjNPpvyxZv9N042Uz1gQb7R0B1MOmCa255-czqWsc7SiOxg@mail.gmail.com>
Subject: Re: KCSAN: data-race in process_srcu / synchronize_srcu
To:     syzbot <syzbot+08f3e9d26e5541e1ecf2@syzkaller.appspotmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>
Cc:     axboe@kernel.dk, justin@coraid.com, linux-block@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+RCU folks, since this is probably a data race in RCU.

On Mon, 4 Nov 2019 at 12:29, syzbot
<syzbot+08f3e9d26e5541e1ecf2@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    05f22368 x86, kcsan: Enable KCSAN for x86
> git tree:       https://github.com/google/ktsan.git kcsan
> console output: https://syzkaller.appspot.com/x/log.txt?x=17ade7ef600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=87d111955f40591f
> dashboard link: https://syzkaller.appspot.com/bug?extid=08f3e9d26e5541e1ecf2
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+08f3e9d26e5541e1ecf2@syzkaller.appspotmail.com
>
> ==================================================================
> BUG: KCSAN: data-race in process_srcu / synchronize_srcu
>
> write to 0xffffffff8604e8a0 of 8 bytes by task 17 on cpu 1:
>   srcu_gp_end kernel/rcu/srcutree.c:533 [inline]
>   srcu_advance_state kernel/rcu/srcutree.c:1146 [inline]
>   process_srcu+0x207/0x780 kernel/rcu/srcutree.c:1237
>   process_one_work+0x3d4/0x890 kernel/workqueue.c:2269
>   worker_thread+0xa0/0x800 kernel/workqueue.c:2415
>   kthread+0x1d4/0x200 drivers/block/aoe/aoecmd.c:1253
>   ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:352
>
> read to 0xffffffff8604e8a0 of 8 bytes by task 12515 on cpu 0:
>   srcu_might_be_idle kernel/rcu/srcutree.c:784 [inline]
>   synchronize_srcu+0x107/0x214 kernel/rcu/srcutree.c:996
>   fsnotify_connector_destroy_workfn+0x63/0xb0 fs/notify/mark.c:164
>   process_one_work+0x3d4/0x890 kernel/workqueue.c:2269
>   worker_thread+0xa0/0x800 kernel/workqueue.c:2415
>   kthread+0x1d4/0x200 drivers/block/aoe/aoecmd.c:1253
>   ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:352
>
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 0 PID: 12515 Comm: kworker/u4:8 Not tainted 5.4.0-rc3+ #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Workqueue: events_unbound fsnotify_connector_destroy_workfn
> ==================================================================
> Kernel panic - not syncing: panic_on_warn set ...
> CPU: 0 PID: 12515 Comm: kworker/u4:8 Not tainted 5.4.0-rc3+ #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Workqueue: events_unbound fsnotify_connector_destroy_workfn
> Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0xf5/0x159 lib/dump_stack.c:113
>   panic+0x210/0x640 kernel/panic.c:221
>   kcsan_report.cold+0xc/0x10 kernel/kcsan/report.c:302
>   __kcsan_setup_watchpoint+0x32e/0x4a0 kernel/kcsan/core.c:411
>   __tsan_read8 kernel/kcsan/kcsan.c:36 [inline]
>   __tsan_read8+0x2c/0x30 kernel/kcsan/kcsan.c:36
>   srcu_might_be_idle kernel/rcu/srcutree.c:784 [inline]
>   synchronize_srcu+0x107/0x214 kernel/rcu/srcutree.c:996
>   fsnotify_connector_destroy_workfn+0x63/0xb0 fs/notify/mark.c:164
>   process_one_work+0x3d4/0x890 kernel/workqueue.c:2269
>   worker_thread+0xa0/0x800 kernel/workqueue.c:2415
>   kthread+0x1d4/0x200 drivers/block/aoe/aoecmd.c:1253
>   ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:352
> Kernel Offset: disabled
> Rebooting in 86400 seconds..
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
