Return-Path: <SRS0=tewG=XJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62FC3C4CEC9
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 12:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C16820717
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 12:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="ari6sTbt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388275AbfINMni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Sep 2019 08:43:38 -0400
Received: from mail.skyhub.de ([5.9.137.197]:47476 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388208AbfINMnh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 08:43:37 -0400
Received: from zn.tnic (p200300EC2F1C980034573B7FA7489B3A.dip0.t-ipconnect.de [IPv6:2003:ec:2f1c:9800:3457:3b7f:a748:9b3a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D8C791EC0C49;
        Sat, 14 Sep 2019 14:43:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1568465016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=KNDHYUun6+Z2GuYwMPyVeb+EeyOo+IxkoSWxYJ/kY48=;
        b=ari6sTbtBQFf8Wghn1Yl+f/6oosz687d4/WCq8OwpKO4w6pqbqLTUIFlfhpMQfhSlvYP1f
        Be0BscKRk2i4zsF2sEhqOjdsC35vIN50rAxOXU87pxipz2XDW/PnednuJYkph2eQSU3SES
        LX20zbfp+PAu8wcyXLOdParQCtksWNo=
Date:   Sat, 14 Sep 2019 14:43:28 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: warning: objtool: mce_panic()+0x11b: unreachable instruction
Message-ID: <20190914124328.GC28054@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Josh,

I'm seeing

arch/x86/kernel/cpu/mce/core.o: warning: objtool: mce_panic()+0x11b: unreachable instruction

on a brand new debian install here with gcc9: gcc (Debian 9.2.1-4) 9.2.1 20190821

and thought should run it by you, you might've seen it already.

So mce_panic is at ffffffff8102f390, which makes the offset
0xffffffff8102f4ab and at that I have:

  ffffffff8102f497:       48 83 c4 08             add    $0x8,%rsp
  ffffffff8102f49b:       5b                      pop    %rbx
  ffffffff8102f49c:       5d                      pop    %rbp
  ffffffff8102f49d:       41 5c                   pop    %r12
  ffffffff8102f49f:       41 5d                   pop    %r13
  ffffffff8102f4a1:       41 5e                   pop    %r14
  ffffffff8102f4a3:       41 5f                   pop    %r15
  ffffffff8102f4a5:       c3                      retq

<---

  ffffffff8102f4a6:       e8 b5 fe ff ff          callq  ffffffff8102f360 <wait_for_panic>
  ffffffff8102f4ab:       e9 23 ff ff ff          jmpq   ffffffff8102f3d3 <mce_panic+0x43>

  ffffffff8102f4b0 <mce_timed_out>:
  ffffffff8102f4b0:       e8 eb 21 7d 00          callq  ffffffff818016a0 <__fentry__>
  ffffffff8102f4b5:       55                      push   %rbp
  ffffffff8102f4b6:       48 89 f5                mov    %rsi,%rbp
  ...

which is two instructions which gcc has put after the RET. Looking at
gcc8 output, I have that too:

  ffffffff8102e39b:       0f 8e 72 ff ff ff       jle    ffffffff8102e313 <mce_panic+0x73>
  ffffffff8102e3a1:       48 8b 5c 24 10          mov    0x10(%rsp),%rbx
  ffffffff8102e3a6:       48 8b 6c 24 18          mov    0x18(%rsp),%rbp
  ffffffff8102e3ab:       4c 8b 64 24 20          mov    0x20(%rsp),%r12
  ffffffff8102e3b0:       4c 8b 6c 24 28          mov    0x28(%rsp),%r13
  ffffffff8102e3b5:       4c 8b 74 24 30          mov    0x30(%rsp),%r14
  ffffffff8102e3ba:       4c 8b 7c 24 38          mov    0x38(%rsp),%r15
  ffffffff8102e3bf:       48 83 c4 40             add    $0x40,%rsp
  ffffffff8102e3c3:       c3                      retq

<---

  ffffffff8102e3c4:       49 3b 16                cmp    (%r14),%rdx
  ffffffff8102e3c7:       75 9e                   jne    ffffffff8102e367 <mce_panic+0xc7>
  ffffffff8102e3c9:       49 8b 4e 10             mov    0x10(%r14),%rcx
  ffffffff8102e3cd:       48 39 4d 18             cmp    %rcx,0x18(%rbp)
  ffffffff8102e3d1:       75 94                   jne    ffffffff8102e367 <mce_panic+0xc7>
  ffffffff8102e3d3:       49 8b 4e 08             mov    0x8(%r14),%rcx
  ffffffff8102e3d7:       48 39 4d 10             cmp    %rcx,0x10(%rbp)
  ffffffff8102e3db:       75 8a                   jne    ffffffff8102e367 <mce_panic+0xc7>
  ffffffff8102e3dd:       eb a2                   jmp    ffffffff8102e381 <mce_panic+0xe1>
  ffffffff8102e3df:       e8 8c fe ff ff          callq  ffffffff8102e270 <wait_for_panic>
  ffffffff8102e3e4:       4d 85 f6                test   %r14,%r14
  ffffffff8102e3e7:       0f 85 4c 26 00 00       jne    ffffffff81030a39 <mce_panic.cold.50+0xad>
  ffffffff8102e3ed:       0f 1f 00                nopl   (%rax)
  ffffffff8102e3f0:       e9 b2 25 00 00          jmpq   ffffffff810309a7 <mce_panic.cold.50+0x1b>
  ffffffff8102e3f5:       66 66 2e 0f 1f 84 00    data16 nopw %cs:0x0(%rax,%rax,1)
  ffffffff8102e3fc:       00 00 00 00

  ffffffff8102e400 <__start_timer>:
  ffffffff8102e400:       e8 eb 2f 7d 00          callq  ffffffff818013f0 <__fentry__>
  ffffffff8102e405:       48 83 ec 10             sub    $0x10,%rsp
  ffffffff8102e409:       48 8b 05 f0 6b fd 00    mov    0xfd6bf0(%rip),%rax        # ffffffff82005000 <jiffies>
  ...

but objtool doesn't complain there, for some reason.

Thoughts?

Btw, I have a couple of those warnings on gcc9:

arch/x86/kernel/cpu/mce/core.o: warning: objtool: mce_panic()+0x11b: unreachable instruction
kernel/exit.o: warning: objtool: __x64_sys_exit_group()+0x14: unreachable instruction
fs/btrfs/extent_io.o: warning: objtool: __set_extent_bit.cold()+0xd: unreachable instruction
fs/btrfs/relocation.o: warning: objtool: add_tree_block.isra.0.cold()+0xc: unreachable instruction
net/core/skbuff.o: warning: objtool: skb_push.cold()+0x15: unreachable instruction

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
