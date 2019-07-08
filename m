Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787F8C606AC
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 12:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E5AA2086D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 12:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562588576;
	bh=uI08iN9onlzZE+3rVqxnipjDz+/V2QQY0umjPFwDvb0=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=Yyn+gOmUEQIWYsBiKZGBGeR0k9fL3yVZVeybGQ0FeBj16AkZPjFY6uClg0Y10LiE+
	 vm6aPbCFXmXPyNgm31mpF8vSgmPJheUTrEr2nEB+5dVjzkDAIvdJnpE0YPmQbKwaix
	 QbnbukScQwwbsCJb8KSoa+zJYALQDvGcaXvBDoyw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729564AbfGHMWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 08:22:52 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33379 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728964AbfGHMWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 08:22:52 -0400
Received: by mail-wr1-f67.google.com with SMTP id n9so16890107wru.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 05:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=VSHgprMF/xNOhzhA/x3mx1w+pNXUwZlVxxYysZPa1LA=;
        b=UiLXJGon6Iue2YzyIVBALec7w7YYTYg+Tkmcr91NyaQHdM9aSo/ti7UBlyurp6mL0/
         G0HeIFIvFEfxOo4qH6rjM99v4PPlhhtfoh4NKeAuM6Q2n/NDqjVBvChCdCxy7aEQMGyj
         8z8LYptMKZjXcvCvsuR25e8HxjpiFhXAbfKCKnR0Gma76ZrdiBoSRbo7wJbZ7vANbKdN
         Ipti60KHZQyXgF63llPoR0msMZOy5gLPhD1S+gHb2+0OGooXVZDkENVVXKgb8O4DLONv
         bUln8Wg0EZYsGzm/hov5jx8Nh7Z+2gq+vVQW96l/yNti2M/23wzn2gUs1Jr55bcJ/q91
         /dLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=VSHgprMF/xNOhzhA/x3mx1w+pNXUwZlVxxYysZPa1LA=;
        b=Mh+A9P/JRkQrpQQSyaT7vtgoEYMn+uiFjx6nSEQLAVw0/qu7DKgN4HlPQvh61xB0dn
         KmssW087M26xBEPLtunIRfmKi7a+AW4Eb4TqrWE+hXmEOhubb6gZ9mDlQLfJS55+FHsB
         irgwCIr0R3J63GAceh0JF0DiXqVIWeJkZbbrKpzemA/LdZidNBYZzT2Y98ufUqwBLL4Y
         76yY09NzXtFT80sA5ojZ+Nn8ZY11yb7jYj5YNTKaaFtE3tiNN4So1Nek0230dX0q3nVj
         sAYUaKt7bvQB2rWRvIuYmEjZw+hs2hTNMckH7e+WmBKv+sPrkDXn95Ot/ZdPlB+VPQQ1
         1MMA==
X-Gm-Message-State: APjAAAVYNGL/4nuRIcOLV477qPotRm0gFck3o/wFSdhDFJJwgWqrfju3
        wuiC8lxUJyxTddZpUFKEalk=
X-Google-Smtp-Source: APXvYqzbbY7c1ZfaLPHI8lr4FFL63fuNGvVFT/ww5hdbOZRGva+LdhWvT/zRIf53uvSjA0cw3zwPQQ==
X-Received: by 2002:a5d:4309:: with SMTP id h9mr18230200wrq.221.1562588569853;
        Mon, 08 Jul 2019 05:22:49 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id f17sm12699580wmf.27.2019.07.08.05.22.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 05:22:49 -0700 (PDT)
Date:   Mon, 8 Jul 2019 14:22:47 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/asm changes for v5.3
Message-ID: <20190708122247.GA57237@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-asm-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-asm-for-linus

   # HEAD: 7457c0da024b181a9143988d740001f9bc98698d x86/alternatives: Add int3_emulate_call() selftest

Most of the changes relate to Peter Zijlstra's cleanup of ptregs 
handling, in particular the i386 part is now much simplified and 
standardized - no more partial ptregs stack frames via the esp/ss oddity. 
This simplifies ftrace, kprobes, the unwinder, ptrace, kdump and kgdb.

There's also a CR4 hardening enhancements by Kees Cook, to make the 
generic platform functions such as native_write_cr4() less useful as ROP 
gadgets that disable SMEP/SMAP. Also protect the WP bit of CR0 against 
similar attacks.

The rest is smaller cleanups/fixes.

 Thanks,

	Ingo

------------------>
Ira Weiny (1):
      Documentation/x86: Fix path to entry_32.S

Kees Cook (2):
      x86/asm: Pin sensitive CR4 bits
      x86/asm: Pin sensitive CR0 bits

Peter Zijlstra (7):
      x86/entry/32: Clean up return from interrupt preemption path
      x86/stackframe: Move ENCODE_FRAME_POINTER to asm/frame.h
      x86/stackframe, x86/kprobes: Fix frame pointer annotations
      x86/stackframe, x86/ftrace: Add pt_regs frame annotations
      x86/stackframe/32: Provide consistent pt_regs
      x86/stackframe/32: Allow int3_emulate_push()
      x86/alternatives: Add int3_emulate_call() selftest

Steven Rostedt (VMware) (1):
      x86/asm: Remove unused TASK_TI_flags from asm-offsets.c


 Documentation/x86/exception-tables.rst |   2 +-
 arch/x86/entry/calling.h               |  15 ----
 arch/x86/entry/entry_32.S              | 145 ++++++++++++++++++++++++---------
 arch/x86/include/asm/frame.h           |  49 +++++++++++
 arch/x86/include/asm/kexec.h           |  17 ----
 arch/x86/include/asm/ptrace.h          |  17 +---
 arch/x86/include/asm/special_insns.h   |  37 ++++++++-
 arch/x86/include/asm/stacktrace.h      |   2 +-
 arch/x86/include/asm/text-patching.h   |   2 -
 arch/x86/kernel/alternative.c          |  81 +++++++++++++++++-
 arch/x86/kernel/asm-offsets.c          |   1 -
 arch/x86/kernel/cpu/common.c           |  20 +++++
 arch/x86/kernel/crash.c                |   8 --
 arch/x86/kernel/ftrace.c               |   7 --
 arch/x86/kernel/ftrace_32.S            |  78 ++++++++++--------
 arch/x86/kernel/ftrace_64.S            |   3 +
 arch/x86/kernel/kgdb.c                 |   8 --
 arch/x86/kernel/kprobes/common.h       |  28 +++----
 arch/x86/kernel/kprobes/core.c         |  29 +++----
 arch/x86/kernel/kprobes/opt.c          |  20 +++--
 arch/x86/kernel/process_32.c           |  16 ++--
 arch/x86/kernel/ptrace.c               |  29 -------
 arch/x86/kernel/smpboot.c              |   8 +-
 arch/x86/kernel/time.c                 |   3 +-
 arch/x86/kernel/unwind_frame.c         |  32 +-------
 arch/x86/kernel/unwind_orc.c           |   2 +-
 26 files changed, 394 insertions(+), 265 deletions(-)

