Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 047B8C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 23:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE1082146E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 23:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552520446;
	bh=VJqfGSqWBoD+VeaggCk+/fHRWhRXpjDzSgbYDwoic6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xmOY+PGaDMlJfR+SVVU0jOibcm89HyeLc60k99iohVo8ROnMcbG+AwUC4QU6bN5LX
	 cHpMVN7NSe08iqMcngISSqd3QDn+1MGKGSRGVeaj1b9gtsYMNUbFuU5BqR9rFzQenS
	 YwKYowQOq+w+5Opp+SLVmvQJKr7hLLOz4tOBzerY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbfCMXkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 19:40:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:45128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726435AbfCMXko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 19:40:44 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B7BD213A2;
        Wed, 13 Mar 2019 23:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552520443;
        bh=VJqfGSqWBoD+VeaggCk+/fHRWhRXpjDzSgbYDwoic6M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S1Tm/xkCnrh9EvDc/0PREKeGIXbEmXHKHC2be0hbXvszAiNh+70AInV6LkRhzNi+9
         X6+mcABOe74XYF272URCJGno69sfvf01qzHrf331mxkog8a3wJKZx0sl24S2DcyWKB
         FV7ZrX8j6OoCNaKdFXZfyKUL2GM99FIer3sBkiXs=
Date:   Wed, 13 Mar 2019 16:40:41 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzbot <syzbot+1505c80c74256c6118a5@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: INFO: rcu detected stall in sys_sendfile64 (2)
Message-ID: <20190313234040.GH10169@gmail.com>
References: <00000000000010b2fc057fcdfaba@google.com>
 <0000000000008c75b50583ddb5f8@google.com>
 <20190312040829.GQ2217@ZenIV.linux.org.uk>
 <491ff1c3-91d6-eaa7-f551-46a4f8b90f5a@i-love.sakura.ne.jp>
 <CACT4Y+ahcZpJ1Q-TKkCJkyhzGc07XFusuwBcKjg_rfAeos8RWA@mail.gmail.com>
 <92a4e5e5-33ca-7b39-16c0-82c7fb742d18@i-love.sakura.ne.jp>
 <CACT4Y+ZQD=raWY4Tp8nrUcpAAbwRt0D3sH65KrTP+JURtQ3n-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+ZQD=raWY4Tp8nrUcpAAbwRt0D3sH65KrTP+JURtQ3n-Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 07:43:38AM +0100, 'Dmitry Vyukov' via syzkaller-bugs wrote:
> > Also, humans can sometimes find more simpler C reproducers from syzbot provided
> > reproducers. It would be nice if syzbot can accept and use a user defined C
> > reproducer for testing.
> 
> It would be more useful to accept patches that make syzkaller create
> better reproducers from these people. Manual work is not scalable. We
> would need 10 reproducers per day for a dozen of OSes (incl some
> private kernels/branches). Anybody is free to run syzkaller manually
> and do full manual (perfect) reporting. But for us it become clear
> very early that it won't work. Then see above, while that human is
> sleeping/on weekend/vacation, syzbot will already bisect own
> reproducer. Adding manual reproducer later won't help in any way.
> syzkaller already does lots of smart work for reproducers. Let's not
> give up on the last mile and switch back to all manual work.
> 

Well, it's very tough and not many people are familiar with the syzkaller
codebase, let alone have time to contribute.  But having simplified a lot of
the syzkaller reproducers manually, the main things I do are:

- Replace bare system calls with proper C library calls.  For example:

	#include <sys/syscall.h>

	syscall(__NR_socket, 0xa, 6, 0);

    becomes:

	#include <sys/socket.h>

        socket(AF_INET, SOCK_DCCP, 0); 

- Do the same for structs.  Use the appropriate C header rather than filling in
  each struct manually.  For example:

	*(uint16_t*)0x20000000 = 0xa;
	*(uint16_t*)0x20000002 = htobe16(0x4e20);
	*(uint32_t*)0x20000004 = 0;
	*(uint8_t*)0x20000008 = 0;
	*(uint8_t*)0x20000009 = 0;
	*(uint8_t*)0x2000000a = 0;
	*(uint8_t*)0x2000000b = 0;
	*(uint8_t*)0x2000000c = 0;
	*(uint8_t*)0x2000000d = 0;
	*(uint8_t*)0x2000000e = 0;
	*(uint8_t*)0x2000000f = 0;
	*(uint8_t*)0x20000010 = 0;
	*(uint8_t*)0x20000011 = 0;
	*(uint8_t*)0x20000012 = 0;
	*(uint8_t*)0x20000013 = 0;
	*(uint8_t*)0x20000014 = 0;
	*(uint8_t*)0x20000015 = 0;
	*(uint8_t*)0x20000016 = 0;
	*(uint8_t*)0x20000017 = 0;
	*(uint32_t*)0x20000018 = 0;

    becomes:

	struct sockaddr_in6 addr = { .sin6_family = AF_INET6, .sin6_port = htobe16(0x4e20) };

- Put arguments on the stack rather than in a mmap'd region, if possible.

- Simplify any calls to the helper functions that syzkaller emits, e.g.
  syz_open_dev(), syz_kvm_setup_vcpu(), or the networking setup stuff.  Usually
  the reproducer needs a small subset of the functionality to work.

- For multithreaded reproducers, try to incrementally simplify the threading
  strategy.  For example, reduce the number of threads by combining operations.
  Also try running the operations in loops.  Also, using fork() can often result
  in a simpler reproducer than pthreads.

- Instead of using the 'r[]' array to hold all integer return values, give them
  appropriate names.

- Remove duplicate #includes.

- Considering the actual kernel code and the bug, if possible find a different
  way to trigger the same bug that's simpler or more reliable.  If the problem
  is obvious it may be possible to jump right to this step from the beginning.

Some gotchas:

- fault-nth injections are fragile, since the number of memory allocations in a
  particular system call varies by kernel config and kernel version.
  Incrementing n starting from 1 is more reliable.

- Some of the perf_event_open() reproducers are fragile because they hardcode a
  trace event ID, which can change in every kernel version.  Reading the trace
  event ID from /sys/kernel/debug/tracing/events/ is more reliable.

- Reproducers using the KVM API sometimes only work on certain processors (e.g.
  Intel but not AMD) or even depend on the host kernel.

- Reproducers that access the local filesystem sometimes assume that it's ext4.
