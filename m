Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C76C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D4B02173C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730126AbfC3ANe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 20:13:34 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:15631 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729963AbfC3ANe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 20:13:34 -0400
Received: from fsav103.sakura.ne.jp (fsav103.sakura.ne.jp [27.133.134.230])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x2U0D7L8037310;
        Sat, 30 Mar 2019 09:13:07 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav103.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav103.sakura.ne.jp);
 Sat, 30 Mar 2019 09:13:07 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav103.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126072090247.bbtec.net [126.72.90.247])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x2U0D7qO037307
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Sat, 30 Mar 2019 09:13:07 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: INFO: rcu detected stall in corrupted (3)
To:     syzbot <syzbot+65cecdd27b726c261799@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com
References: <000000000000b08190058543449f@google.com>
Cc:     bp@alien8.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
        luto@kernel.org, mingo@redhat.com, tglx@linutronix.de,
        x86@kernel.org
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <8ecb5bc9-5761-64d0-64b2-1310300a64ec@I-love.SAKURA.ne.jp>
Date:   Sat, 30 Mar 2019 09:13:07 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <000000000000b08190058543449f@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/03/30 7:34, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    8c2ffd91 Linux 5.1-rc2
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15099d2b200000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8dcdce25ea72bedf
> dashboard link: https://syzkaller.appspot.com/bug?extid=65cecdd27b726c261799
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17d3c67d200000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11d4f317200000
> 
> Bisection is inconclusive: the bug happens on the oldest tested release.

This reproducer does sched_setattr(SCHED_DEADLINE) with bogus value, as with
a reproducer for "INFO: rcu detected stall in sys_sendfile64" did.

  sched_setattr(0, {size=0, sched_policy=0x6 /* SCHED_DEADLINE */, sched_flags=0, sched_nice=0, sched_priority=0, sched_runtime=65535, sched_deadline=4611686018427453437, sched_period=0}, 0) = 0

#syz invalid
