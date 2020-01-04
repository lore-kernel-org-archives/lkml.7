Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557A0C2D0C2
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 11:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32C3721734
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 11:11:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbgADLLw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 06:11:52 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:59725 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgADLLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 06:11:51 -0500
Received: from fsav304.sakura.ne.jp (fsav304.sakura.ne.jp [153.120.85.135])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 004B97TD090039;
        Sat, 4 Jan 2020 20:09:07 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav304.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav304.sakura.ne.jp);
 Sat, 04 Jan 2020 20:09:07 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav304.sakura.ne.jp)
Received: from [192.168.1.9] (softbank126040062084.bbtec.net [126.40.62.84])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 004B927x089997
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sat, 4 Jan 2020 20:09:06 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: INFO: rcu detected stall in sys_sendfile64
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+bcad772bbc241b4c6147@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        James Morris <jmorris@namei.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        "Serge E. Hallyn" <serge@hallyn.com>
References: <000000000000e728ec057d5c9d90@google.com>
 <a5478450-f975-228f-1ca6-886a45b654a1@I-love.SAKURA.ne.jp>
 <CACT4Y+YqWgZZFXdX2A2jVYEdHfY9ywGMgRRP5W4Uqdu__rA63g@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <bc53fe0b-2c17-4d4f-1c40-f290997d0521@i-love.sakura.ne.jp>
Date:   Sat, 4 Jan 2020 20:09:00 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CACT4Y+YqWgZZFXdX2A2jVYEdHfY9ywGMgRRP5W4Uqdu__rA63g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/12/20 3:42, Dmitry Vyukov wrote:
> On Wed, Dec 19, 2018 at 11:13 AM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>
>> On 2018/12/19 18:27, syzbot wrote:
>>> HEAD commit:    ddfbab46539f Merge tag 'scsi-fixes' of git://git.kernel.or..
>>> git tree:       upstream
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=15b87fa3400000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=861a3573f4e78ba1
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=bcad772bbc241b4c6147
>>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13912ccd400000
>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=145781db400000
>>
>> This is not a LSM problem, for the reproducer is calling
>> sched_setattr(SCHED_DEADLINE) with very large values.
>>
>>   sched_setattr(0, {size=0, sched_policy=0x6 /* SCHED_??? */, sched_flags=0, sched_nice=0, sched_priority=0, sched_runtime=2251799813724439, sched_deadline=4611686018427453437, sched_period=0}, 0) = 0
>>
>> I think that this problem is nothing but an insane sched_setattr() parameter.
>>
>> #syz invalid
> 
> Note there was another one with sched_setattr, which turned out to be
> some serious problem in kernel (sched_setattr should not cause CPU
> stall for 3 minutes):
> INFO: rcu detected stall in do_idle
> https://syzkaller.appspot.com/bug?extid=385468161961cee80c31
> https://groups.google.com/forum/#!msg/syzkaller-bugs/crrfvusGtwI/IoD_zus4BgAJ
> 
> Maybe it another incarnation of the same bug, that one is still not fixed.
> 

Can we let syzbot blacklist sched_setattr() for now? There are many stall reports
doing sched_setattr(SCHED_RR) which makes it difficult to find stall reports not
using sched_setattr().
