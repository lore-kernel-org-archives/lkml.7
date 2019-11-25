Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98062C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 16:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63FF72071A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 16:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574698592;
	bh=LbeK490dtTKnopD1Y4NfCpwKGsM1gH9a/RhebP6QoqU=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=tLfba3ewpIDxxKzmpZtagUwtm8oSLAfxuX0boeZ8OBLPCzPX1blvVg0+AQsN33ziq
	 UBjyGLoktnQyxcBBJbSL4V0Iy9O5wFd7wpgzde7bXJN1+Tz4iqe9GcfOjIPonCy4wf
	 FIhxeMoeuLpGbtAz/xi1T5VL0ru8Rdwnrm5voZ2g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728791AbfKYQQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 11:16:31 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43740 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728660AbfKYQQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 11:16:30 -0500
Received: by mail-wr1-f66.google.com with SMTP id n1so18835372wra.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 08:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=a6ttbE9cHcRYf8vQoG+NYprr9PidmSQZatMLde5ZozA=;
        b=fW1rxmMPa81pLbFvBgXwQ9+vIeOot0Em31EOUw8HgIw/j9RXJEsaEodMtePMu7EzJc
         UP86VHUViuD+Hst8lsgiK+gy/cxK++tVADIN9fy7+gAUKnTge0RRHHQwrsgF05cUQRGh
         jZokl9qaSPN90XurdFR8yrp7Op5jNv5oBpQtH8D/8Q9gBuK5oJhvaX+o+tncMnJdwEYd
         CIkas8oYUdrxjKFYKEbseBW29hMDdO/SW0b6ikkv1Y9eC3gL9VAwGp5UUuzxctPaxrux
         YWmc4Uofz04IeqiPKiatF28h9feNH/4V9tUSQLh9C+F0zT/jsTJZjdq4umV0kTLrZvB3
         PTNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=a6ttbE9cHcRYf8vQoG+NYprr9PidmSQZatMLde5ZozA=;
        b=TwAb8qLsLXpUCfeqA1ZVfKyiAHDY46G6nvQNwqEdAkRyua74H2GEpE91dzJQXmFZ77
         RNMJNTbYCwBoTitSUSO5FCKNz9hb4RIWpdCwn+5rdqp4QBo1m0tVnnXC36YjeT9TlSbQ
         Zzr9T99AP4wi6iWQ7KZ46bPa80ENR370ZDfeEHnqlz95QYdaI8KIz2uQs29SUNGgdOSf
         eM0q3XsGFCM5xYUzYjtxIOUu8uffznZeYbE0jlbfJLQYYAJQ/eFeN/ln17QgF8H8rU1Z
         l0Pypg0t9ADC/fqAJHj/ureaQoZuSNrxZusCqCdsijBhf7Cq05i831VoX4RniyXgTlxD
         K+Lw==
X-Gm-Message-State: APjAAAXSMAsJ92vx5EyjLZB6zG3xTNQ9UOHml2UsDGyrvS82fNP3/FNT
        RpFipCKSWC/tZ0r1+gO/GNg=
X-Google-Smtp-Source: APXvYqxfp04xHoKEd2pFVOHP462yxxTEU4dpbgPLMc4SwawozRQxYWKmEWTumNbC/QWzD8LldVbQQA==
X-Received: by 2002:adf:f985:: with SMTP id f5mr32740299wrr.364.1574698588571;
        Mon, 25 Nov 2019 08:16:28 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id o21sm8686825wmc.17.2019.11.25.08.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 08:16:27 -0800 (PST)
Date:   Mon, 25 Nov 2019 17:16:26 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [GIT PULL] x86/iopl changes for v5.5
Message-ID: <20191125161626.GA956@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-iopl-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-iopl-for-linus

   # HEAD: e3cb0c7102f04c83bf1a7cb1d052e92749310b46 x86/ioperm: Fix use of deprecated config option

This tree implements a nice simplification of the iopl and ioperm code 
that Thomas Gleixner discovered: we can implement the IO privilege 
features of the iopl system call by using the IO permission bitmap in 
permissive mode, while trapping CLI/STI/POPF/PUSHF uses in user-space if 
they change the interrupt flag.

This tree implements that feature, with testing facilities and related 
cleanups.

 Thanks,

	Ingo

------------------>
Alexander Duyck (1):
      x86/ioperm: Fix use of deprecated config option

Thomas Gleixner (21):
      x86/ptrace: Prevent truncation of bitmap size
      x86/process: Unify copy_thread_tls()
      x86/cpu: Unify cpu_init()
      x86/tss: Fix and move VMX BUILD_BUG_ON()
      x86/iopl: Cleanup include maze
      x86/ioperm: Simplify first ioperm() invocation logic
      x86/ioperm: Avoid bitmap allocation if no permissions are set
      x86/io: Speedup schedule out of I/O bitmap user
      x86/tss: Move I/O bitmap data into a seperate struct
      x86/ioperm: Move iobitmap data into a struct
      x86/ioperm: Add bitmap sequence number
      x86/ioperm: Move TSS bitmap update to exit to user work
      x86/ioperm: Remove bitmap if all permissions dropped
      x86/ioperm: Share I/O bitmap if identical
      selftests/x86/ioperm: Extend testing so the shared bitmap is exercised
      x86/iopl: Fixup misleading comment
      x86/iopl: Restrict iopl() permission scope
      x86/iopl: Remove legacy IOPL option
      x86/ioperm: Extend IOPL config to control ioperm() as well
      selftests/x86/iopl: Extend test to cover IOPL emulation
      x86/entry/32: Clarify register saving in __switch_to_asm()


 arch/x86/Kconfig                        |  18 +++
 arch/x86/entry/common.c                 |   4 +
 arch/x86/entry/entry_32.S               |   8 +-
 arch/x86/include/asm/io_bitmap.h        |  29 +++++
 arch/x86/include/asm/paravirt.h         |   4 -
 arch/x86/include/asm/paravirt_types.h   |   2 -
 arch/x86/include/asm/pgtable_32_types.h |   2 +-
 arch/x86/include/asm/processor.h        | 113 ++++++++++-------
 arch/x86/include/asm/ptrace.h           |   6 +
 arch/x86/include/asm/switch_to.h        |  10 ++
 arch/x86/include/asm/thread_info.h      |  14 ++-
 arch/x86/include/asm/xen/hypervisor.h   |   2 -
 arch/x86/kernel/cpu/common.c            | 188 ++++++++++++----------------
 arch/x86/kernel/doublefault.c           |   2 +-
 arch/x86/kernel/ioport.c                | 209 +++++++++++++++++++++-----------
 arch/x86/kernel/paravirt.c              |   2 -
 arch/x86/kernel/process.c               | 205 ++++++++++++++++++++++++-------
 arch/x86/kernel/process_32.c            |  77 ------------
 arch/x86/kernel/process_64.c            |  86 -------------
 arch/x86/kernel/ptrace.c                |  12 +-
 arch/x86/kvm/vmx/vmx.c                  |   8 --
 arch/x86/mm/cpu_entry_area.c            |   8 ++
 arch/x86/xen/enlighten_pv.c             |  10 --
 tools/testing/selftests/x86/ioperm.c    |  16 ++-
 tools/testing/selftests/x86/iopl.c      | 129 ++++++++++++++++++--
 25 files changed, 686 insertions(+), 478 deletions(-)
 create mode 100644 arch/x86/include/asm/io_bitmap.h
