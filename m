Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6871AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 09:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40D012184E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 09:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfCTJ4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 05:56:44 -0400
Received: from relay.sw.ru ([185.231.240.75]:52770 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725905AbfCTJ4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 05:56:43 -0400
Received: from [172.16.25.12]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1h6XxM-0007BT-M9; Wed, 20 Mar 2019 12:56:20 +0300
Subject: Re: kernel panic: corrupted stack end in wb_workfn
To:     syzbot <syzbot+ec1b7575afef85a0e5ca@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, cai@lca.pw, davem@davemloft.net,
        dvyukov@google.com, guro@fb.com, hannes@cmpxchg.org, jbacik@fb.com,
        ktkhai@virtuozzo.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-sctp@vger.kernel.org,
        mgorman@techsingularity.net, mhocko@suse.com,
        netdev@vger.kernel.org, nhorman@tuxdriver.com, shakeelb@google.com,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        vyasevich@gmail.com, willy@infradead.org
References: <000000000000db3d130584506672@google.com>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     Xin Long <lucien.xin@gmail.com>
Message-ID: <d9e4e36d-1e7a-caaf-f96e-b05592405b5f@virtuozzo.com>
Date:   Wed, 20 Mar 2019 12:56:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <000000000000db3d130584506672@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/17/19 11:49 PM, syzbot wrote:
> syzbot has bisected this bug to:
> 
> commit c981f254cc82f50f8cb864ce6432097b23195b9c
> Author: Al Viro <viro@zeniv.linux.org.uk>
> Date:   Sun Jan 7 18:19:09 2018 +0000
> 
>     sctp: use vmemdup_user() rather than badly open-coding memdup_user()
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=137bcecf200000
> start commit:   c981f254 sctp: use vmemdup_user() rather than badly open-c..
> git tree:       upstream
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=10fbcecf200000
> console output: https://syzkaller.appspot.com/x/log.txt?x=177bcecf200000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5e7dc790609552d7
> dashboard link: https://syzkaller.appspot.com/bug?extid=ec1b7575afef85a0e5ca
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16a9a84b400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17199bb3400000
> 
> Reported-by: syzbot+ec1b7575afef85a0e5ca@syzkaller.appspotmail.com
> Fixes: c981f254 ("sctp: use vmemdup_user() rather than badly open-coding memdup_user()")

From bisection log:

	testing release v4.17
	testing commit 29dcea88779c856c7dc92040a0c01233263101d4 with gcc (GCC) 8.1.0
	run #0: crashed: kernel panic: corrupted stack end in wb_workfn
	run #1: crashed: kernel panic: corrupted stack end in worker_thread
	run #2: crashed: kernel panic: Out of memory and no killable processes...
	run #3: crashed: kernel panic: corrupted stack end in wb_workfn
	run #4: crashed: kernel panic: corrupted stack end in wb_workfn
	run #5: crashed: kernel panic: corrupted stack end in wb_workfn
	run #6: crashed: kernel panic: corrupted stack end in wb_workfn
	run #7: crashed: kernel panic: corrupted stack end in wb_workfn
	run #8: crashed: kernel panic: Out of memory and no killable processes...
	run #9: crashed: kernel panic: corrupted stack end in wb_workfn
	testing release v4.16
	testing commit 0adb32858b0bddf4ada5f364a84ed60b196dbcda with gcc (GCC) 8.1.0
	run #0: OK
	run #1: OK
	run #2: OK
	run #3: OK
	run #4: OK
	run #5: crashed: kernel panic: Out of memory and no killable processes...
	run #6: OK
	run #7: crashed: kernel panic: Out of memory and no killable processes...
	run #8: OK
	run #9: OK
	testing release v4.15
	testing commit d8a5b80568a9cb66810e75b182018e9edb68e8ff with gcc (GCC) 8.1.0
	all runs: OK
	# git bisect start v4.16 v4.15

Why bisect started between 4.16 4.15 instead of 4.17 4.16?


	testing commit c14376de3a1befa70d9811ca2872d47367b48767 with gcc (GCC) 8.1.0
	run #0: crashed: kernel panic: Out of memory and no killable processes...
	run #1: crashed: kernel panic: Out of memory and no killable processes...
	run #2: crashed: kernel panic: Out of memory and no killable processes...
	run #3: crashed: kernel panic: Out of memory and no killable processes...
	run #4: OK
	run #5: OK
	run #6: crashed: WARNING: ODEBUG bug in netdev_freemem
	run #7: crashed: no output from test machine
	run #8: OK
	run #9: OK
	# git bisect bad c14376de3a1befa70d9811ca2872d47367b48767

Why c14376de3a1befa70d9811ca2872d47367b48767 is bad? There was no stack corruption.
It looks like the syzbot were bisecting a different bug - "kernel panic: Out of memory and no killable processes..."
And bisection for that bug seems to be correct. kvmalloc() in vmemdup_user() may eat up all memory unlike kmalloc which is limited by KMALLOC_MAX_SIZE (4MB usually).
