Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F631C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 10:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EF6A218A6
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 10:42:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730680AbfC3Kkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 06:40:52 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:58612 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730372AbfC3Kkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 06:40:52 -0400
Received: from fsav102.sakura.ne.jp (fsav102.sakura.ne.jp [27.133.134.229])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x2UAeFaD031863;
        Sat, 30 Mar 2019 19:40:15 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav102.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav102.sakura.ne.jp);
 Sat, 30 Mar 2019 19:40:15 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav102.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126072090247.bbtec.net [126.72.90.247])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x2UAeBJx031815
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Sat, 30 Mar 2019 19:40:15 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: INFO: rcu detected stall in corrupted (3)
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     syzbot <syzbot+65cecdd27b726c261799@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>, mingo@redhat.com,
        x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>
References: <000000000000b08190058543449f@google.com>
 <8ecb5bc9-5761-64d0-64b2-1310300a64ec@I-love.SAKURA.ne.jp>
 <alpine.DEB.2.21.1903300843230.2476@nanos.tec.linutronix.de>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <daec0343-b905-f483-602b-9c0b9e9b1379@i-love.sakura.ne.jp>
Date:   Sat, 30 Mar 2019 19:40:11 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1903300843230.2476@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/03/30 16:46, Thomas Gleixner wrote:
> On Sat, 30 Mar 2019, Tetsuo Handa wrote:
>> This reproducer does sched_setattr(SCHED_DEADLINE) with bogus value, as with
>> a reproducer for "INFO: rcu detected stall in sys_sendfile64" did.
>>
>> sched_setattr(0, {size=0, sched_policy=0x6 /* SCHED_DEADLINE */,
>> sched_flags=0, sched_nice=0, sched_priority=0, sched_runtime=65535,
>> sched_deadline=4611686018427453437, sched_period=0}, 0) = 0
>>
>> #syz invalid
> 
> Marking this invalid is not really the right thing to do. Bogus deadline
> parameters should not cause RCU stalls. They either need to be rejected or
> handled gracefully.

But how can the scheduler be aware of various watchdogs' thresholds?

The scheduler behaves differently based on watchdog's remaining grace periods?
That sounds quite strange. If administrator tunes watchdog thresholds in a way
schedulers can't survive (or vice versa), it must be an administrator's fault.

Since this stall might occur with any combination, not closing this kind of
report will result in flood of stall reports...
