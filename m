Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD69C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 10:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34D1C20449
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 10:52:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfCNKws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 06:52:48 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:27273 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbfCNKws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 06:52:48 -0400
Received: from fsav102.sakura.ne.jp (fsav102.sakura.ne.jp [27.133.134.229])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x2EAqYN7005916;
        Thu, 14 Mar 2019 19:52:34 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav102.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav102.sakura.ne.jp);
 Thu, 14 Mar 2019 19:52:34 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav102.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x2EAqP3D005717
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Thu, 14 Mar 2019 19:52:34 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: INFO: rcu detected stall in sys_sendfile64 (2)
To:     Eric Biggers <ebiggers@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+1505c80c74256c6118a5@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>
References: <00000000000010b2fc057fcdfaba@google.com>
 <0000000000008c75b50583ddb5f8@google.com>
 <20190312040829.GQ2217@ZenIV.linux.org.uk>
 <491ff1c3-91d6-eaa7-f551-46a4f8b90f5a@i-love.sakura.ne.jp>
 <CACT4Y+ahcZpJ1Q-TKkCJkyhzGc07XFusuwBcKjg_rfAeos8RWA@mail.gmail.com>
 <92a4e5e5-33ca-7b39-16c0-82c7fb742d18@i-love.sakura.ne.jp>
 <CACT4Y+ZQD=raWY4Tp8nrUcpAAbwRt0D3sH65KrTP+JURtQ3n-Q@mail.gmail.com>
 <20190313234040.GH10169@gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <f3e25790-4edd-9e77-f656-e41d7a992945@i-love.sakura.ne.jp>
Date:   Thu, 14 Mar 2019 19:52:26 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190313234040.GH10169@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/03/14 8:40, Eric Biggers wrote:
> On Wed, Mar 13, 2019 at 07:43:38AM +0100, 'Dmitry Vyukov' via syzkaller-bugs wrote:
>>> Also, humans can sometimes find more simpler C reproducers from syzbot provided
>>> reproducers. It would be nice if syzbot can accept and use a user defined C
>>> reproducer for testing.
>>
>> It would be more useful to accept patches that make syzkaller create
>> better reproducers from these people. Manual work is not scalable. We
>> would need 10 reproducers per day for a dozen of OSes (incl some
>> private kernels/branches). Anybody is free to run syzkaller manually
>> and do full manual (perfect) reporting. But for us it become clear
>> very early that it won't work. Then see above, while that human is
>> sleeping/on weekend/vacation, syzbot will already bisect own
>> reproducer. Adding manual reproducer later won't help in any way.
>> syzkaller already does lots of smart work for reproducers. Let's not
>> give up on the last mile and switch back to all manual work.
>>
> 
> Well, it's very tough and not many people are familiar with the syzkaller
> codebase, let alone have time to contribute.

Right. I don't read/write go programs. I don't have access to environments
for running syzbot. But instead I try to write kernel patches.

Also, although anybody is free to do full manual (perfect) reporting,
I can't afford checking such reports posted to e.g. LKML. I can afford
checking only https://syzkaller.appspot.com/ .

I have seen a Japanese article which explains how to run syzbot. But I felt that
that article lacks what to do if syzbot found a bug. If people found a crash
by running syzbot in their environments, it would be nice if they can export
the report and import it to https://syzkaller.appspot.com/ (i.e. dashboard
acts as if a bugzilla).

>                                               But having simplified a lot of
> the syzkaller reproducers manually, the main things I do are:

Yes. I'm doing similar things. Other things not listed here are:

  Try to remove syscall() which passes EOF as fd argument, for it should be
  unrelated to the problem unless such call affects subtle timing.

  Try to remove code for testing fuse / tun etc. if the problem seems to be
  unrelated to fuse / tun etc.

syzbot gets pleased with finding one C reproducer, but I wish that syzbot
continues trying to find smaller C reproducers by e.g. eliminating unrelated
calls.

> 
> - Replace bare system calls with proper C library calls.  For example:
> 
> 	#include <sys/syscall.h>
> 
> 	syscall(__NR_socket, 0xa, 6, 0);
> 
>     becomes:
> 
> 	#include <sys/socket.h>
> 
>         socket(AF_INET, SOCK_DCCP, 0); 

Yes. It would be nice if C reproducers are provided using symbols. I run
syzbot provided C reproducers under strace because strace gives me more hints
about symbols and structures.

