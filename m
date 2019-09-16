Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C928C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 18:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B3D3214DE
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 18:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390511AbfIPSjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 14:39:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:15496 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390492AbfIPSjU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 14:39:20 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AEFDCC010923;
        Mon, 16 Sep 2019 18:39:20 +0000 (UTC)
Received: from treble (ovpn-120-32.rdu2.redhat.com [10.10.120.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BA8FE61F40;
        Mon, 16 Sep 2019 18:39:19 +0000 (UTC)
Date:   Mon, 16 Sep 2019 13:39:16 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: warning: objtool: mce_panic()+0x11b: unreachable instruction
Message-ID: <20190916183916.y4jkgkxogpus7sio@treble>
References: <20190914124328.GC28054@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190914124328.GC28054@zn.tnic>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 16 Sep 2019 18:39:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 14, 2019 at 02:43:28PM +0200, Borislav Petkov wrote:
> Hey Josh,
> 
> I'm seeing
> 
> arch/x86/kernel/cpu/mce/core.o: warning: objtool: mce_panic()+0x11b: unreachable instruction
> 
> on a brand new debian install here with gcc9: gcc (Debian 9.2.1-4) 9.2.1 20190821
> 
> and thought should run it by you, you might've seen it already.
> 
> So mce_panic is at ffffffff8102f390, which makes the offset
> 0xffffffff8102f4ab and at that I have:
> 
>   ffffffff8102f497:       48 83 c4 08             add    $0x8,%rsp
>   ffffffff8102f49b:       5b                      pop    %rbx
>   ffffffff8102f49c:       5d                      pop    %rbp
>   ffffffff8102f49d:       41 5c                   pop    %r12
>   ffffffff8102f49f:       41 5d                   pop    %r13
>   ffffffff8102f4a1:       41 5e                   pop    %r14
>   ffffffff8102f4a3:       41 5f                   pop    %r15
>   ffffffff8102f4a5:       c3                      retq
> 
> <---
> 
>   ffffffff8102f4a6:       e8 b5 fe ff ff          callq  ffffffff8102f360 <wait_for_panic>
>   ffffffff8102f4ab:       e9 23 ff ff ff          jmpq   ffffffff8102f3d3 <mce_panic+0x43>
> 
>   ffffffff8102f4b0 <mce_timed_out>:
>   ffffffff8102f4b0:       e8 eb 21 7d 00          callq  ffffffff818016a0 <__fentry__>
>   ffffffff8102f4b5:       55                      push   %rbp
>   ffffffff8102f4b6:       48 89 f5                mov    %rsi,%rbp
>   ...

I'm guessing mce_panic() is effectively 'noreturn' because it calls
noreturn panic() instead of returning, and objtool has detected that.
Normally GCC also detects that, and doesn't insert instructions in the
path after the call.  So this could be a GCC issue.

Can you share the .o?  What code branch is this?

> Btw, I have a couple of those warnings on gcc9:
> 
> arch/x86/kernel/cpu/mce/core.o: warning: objtool: mce_panic()+0x11b: unreachable instruction
> kernel/exit.o: warning: objtool: __x64_sys_exit_group()+0x14: unreachable instruction
> fs/btrfs/extent_io.o: warning: objtool: __set_extent_bit.cold()+0xd: unreachable instruction
> fs/btrfs/relocation.o: warning: objtool: add_tree_block.isra.0.cold()+0xc: unreachable instruction
> net/core/skbuff.o: warning: objtool: skb_push.cold()+0x15: unreachable instruction

Some of these might have the same cause, though this particular warning
can have many different causes.

-- 
Josh
