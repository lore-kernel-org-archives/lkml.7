Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 604B0C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 13:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39F04207FC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 13:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfKMNze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 08:55:34 -0500
Received: from foss.arm.com ([217.140.110.172]:52874 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726190AbfKMNze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 08:55:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B0747A7;
        Wed, 13 Nov 2019 05:55:33 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EEAEE3F6C4;
        Wed, 13 Nov 2019 05:55:31 -0800 (PST)
Subject: Re: [QUESTION] Hung task warning while running syzkaller test
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Zhihao Cheng <chengzhihao1@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, peterz@infradead.org,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        patrick.bellasi@arm.com, tglx@linutronix.de
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        "zhangyi (F)" <yi.zhang@huawei.com>
References: <0d7aa66d-d2b9-775c-56b3-543d132fdb84@huawei.com>
 <1693d19e-56c7-9d6f-8e80-10fe82101cff@arm.com>
 <aa5d0f35-e707-f5e3-251e-f940c0b0232b@huawei.com>
 <4ca01869-7997-cfce-edce-e75337d3a6fa@arm.com>
 <abba880d-cfa6-3485-7831-9998db290396@huawei.com>
 <d7e9f62e-d7a6-50ec-6fb5-76ad136506df@arm.com>
 <4453942d-c4f2-bbbe-64a9-4313c0fccfbf@huawei.com>
 <6d78bdbc-e4f8-7ff7-8445-c9dc07b0614a@arm.com>
Message-ID: <de1782a5-6933-5580-3ed2-bd7429e3af8e@arm.com>
Date:   Wed, 13 Nov 2019 13:55:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <6d78bdbc-e4f8-7ff7-8445-c9dc07b0614a@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/10/2019 01:36, Valentin Schneider wrote:
> On 29/10/2019 03:25, Zhihao Cheng wrote:
>> I don't know much about the freezer mechanism of CGroup, but I tried it. I turned off all the CGroup related config options and reproduced the hung task on a fresh busybox-made root file system. I added rootfs in attachment. So, I guess hung task has nothing to do with CGroup(freezer).
>>
> 
> That's good to know, thanks for digging some more. I'm on the move ATM but if
> I find some time I'll try to stare some more at the C reproducer.
> 

After fumbling a bit I managed to generate the same C code from your
syzkaller reproducer with:

  $ syz-prog2c -tmpdir -sandbox none -repeat -1 -segv -threaded -collide -enable close_fds -prog repro

And now I realize the actual "juicy bits" (i.e. what I get without all of
above optional arguments) is straight up asm written to some mmap'd region
that is then executed. It does seem to start up with a syscall, but there's
tons more instructions that follow:

  4007b8:	f2 aa                	repnz stos %al,%es:(%rdi)
  4007ba:	98                   	cwtl   
  4007bb:	44 13 e8             	adc    %eax,%r13d
  4007be:	0f 05                	syscall 
  <~200 more insns>

Figuring out what is in %eax and %r13d is another indirection layer,
the execution being preceded by

  asm volatile("" ::"r"(0l), "r"(1l), "r"(2l), "r"(3l), "r"(4l), "r"(5l),
	       "r"(6l), "r"(7l), "r"(8l), "r"(9l), "r"(10l), "r"(11l), "r"(12l),
	       "r"(13l));

I have no idea which registers are supposed to be picked here (I would
assume it is implementation defined?), so through objdump it goes:

  400631:	b8 00 00 00 00       	mov    $0x0,%eax
  400636:	ba 01 00 00 00       	mov    $0x1,%edx
  40063b:	b9 02 00 00 00       	mov    $0x2,%ecx
  400640:	be 03 00 00 00       	mov    $0x3,%esi
  400645:	bf 04 00 00 00       	mov    $0x4,%edi
  40064a:	41 b8 05 00 00 00    	mov    $0x5,%r8d
  400650:	41 b9 06 00 00 00    	mov    $0x6,%r9d
  400656:	41 ba 07 00 00 00    	mov    $0x7,%r10d
  40065c:	41 bb 08 00 00 00    	mov    $0x8,%r11d
  400662:	bb 09 00 00 00       	mov    $0x9,%ebx
  400667:	41 bc 0a 00 00 00    	mov    $0xa,%r12d
  40066d:	41 bd 0b 00 00 00    	mov    $0xb,%r13d
  400673:	41 be 0c 00 00 00    	mov    $0xc,%r14d
  400679:	41 bf 0d 00 00 00    	mov    $0xd,%r15d

So that should be syscall 11 (munmap for x86_64 IIUC). And it still doesn't
tell me what the thing is actually doing.

Interestingly running that on an x86_64 box gives me a segfault. Running
the version with all of the right syz-prog2c arguments just hangs on
wait4() (I let it run overnight). I suppose I'll have to rely on execprog
to run the thing, but I have to grumble about running stuff I have no idea
what it does.
