Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2AA6C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F4662081B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551979039;
	bh=0hjvF6pRVdFPKp6ojTdrmuOnkceNUadJICcK92XtGIY=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=uV4Cur43xKGIkRpRStjP+rwUT7M0FvTmkqz4x76Fn4S1xRavo0chu6dJL869ZN63y
	 zG2voQGDY7Ncnl+yYZWNlKeky1DD8rIyqlKCV5b96H+5zZ0hE0aJ5fQ79q/9s2LVvg
	 jL57gJ8vwRR7Rv6q7Zrb5msosEzp683ZUTiGPiEE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbfCGRRS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:17:18 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]:37868 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbfCGRRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:17:14 -0500
Received: by mail-wm1-f49.google.com with SMTP id x10so9961507wmg.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 09:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=zqrg4NAisFU6QbGw0vD0DZ3BKggXoX0qtyJ09tNOA2g=;
        b=o+rQkO0fCecbhwoIEXmPpo+3NAVzx17c8KgQY9qGg3t8QMyw04ply1q5nd3m66iPzw
         QOv7NeqIUr2OgupX7xad7z7EEVXc5+iwRaAroP+DYvkoLsY/58aRtQKjgn9CD+IA+DEo
         xtFejjZu1xifu4NH0vYznEZIU/R2+y8m8tIVOR4DtnX+DaYG+902/MxJOkSeEsKkFCpU
         apjtYa6zYcXIn+ddoDg8Yr85BDCkFiK+sSeD0c/EBmYsfCUeQJclUTseMWDJF+hrrMQa
         tLiBFhE+0CSQYq7qNCQxFC74AnJCE87HhY6xiqI1yw3ilwZKt3LiO41F+IhKwg3cIanD
         eDDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=zqrg4NAisFU6QbGw0vD0DZ3BKggXoX0qtyJ09tNOA2g=;
        b=jMcECuHPcCci0qq/+kwDCDiw54ZKorF5W/DzymbB3iBQ5OaBy+upanW9UUDTsrxm01
         DxMPF4d2H8Op/9okFcMecQuOSbcqOEUCN5PFbBf3jmNLDRD9Btah/RGbAj2yAn75tuDa
         jAguz57CkXsoLSZ5tVT2j4xPwQzUqM+kejD3z8XgKWrApcvwdh5HcA6U3ROYwZfO5s6q
         JenIiTVbplpaihr7TMX1FOFbp5tif2jgmGNsKFdAHMTQdiSCrhyyD9NJEkR+KdzFhIPQ
         XIfmU+e6grQWtEkc87PACogkE19uPiNv81Ca2gWm7dbBx8fawYsu47hXEQNoG1OG+oiN
         /wUw==
X-Gm-Message-State: APjAAAVgN7Zy9Ege77OmC/iQqjoDfloJzai02NSSiGve7Wxc55/hD8vk
        fLjGSvCNaMWYs/4hUgnnbRY=
X-Google-Smtp-Source: APXvYqyEEeo3E2qkv04oAfHuqnC9n8Gn6joNw9bbcdcIGVz91tVKwYBHSm8EZdkzadS20V3jzBuzVg==
X-Received: by 2002:a1c:4884:: with SMTP id v126mr6545101wma.118.1551979032528;
        Thu, 07 Mar 2019 09:17:12 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id s3sm8255416wrt.81.2019.03.07.09.17.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 09:17:11 -0800 (PST)
Date:   Thu, 7 Mar 2019 18:17:09 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/cleanups for v5.1
Message-ID: <20190307171709.GA85168@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-cleanups-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cleanups-for-linus

   # HEAD: 2e7614c0736de93c8796bb2d58debb8871a59db8 x86/uaccess: Remove unused __addr_ok() macro

Various cleanups and simplifications, none of them really stands out, 
they are all over the place.

  out-of-topic modifications in x86-cleanups-for-linus:
  -------------------------------------------------------
  include/linux/kprobes.h            # fab940755d1d: x86/hw_breakpoints, kprobes:

 Thanks,

	Ingo

------------------>
Bo Yu (1):
      x86/mtrr: Remove unused variable

Borislav Petkov (2):
      x86/hw_breakpoints, kprobes: Remove kprobes ifdeffery
      x86/uaccess: Remove unused __addr_ok() macro

Brajeswar Ghosh (1):
      x86/asm-prototypes: Remove duplicate include <asm/page.h>

Cao jin (1):
      x86/boot: Save several bytes in decompressor

Gustavo A. R. Silva (4):
      x86/platform/UV: Replace kmalloc() and memset() with k[cz]alloc() calls
      x86/insn-eval: Mark expected switch-case fall-through
      x86/kernel: Mark expected switch-case fall-throughs
      x86/events: Mark expected switch-case fall-throughs

Huang Zijiang (1):
      x86/e820: Replace kmalloc() + memcpy() with kmemdup()

Jiri Slaby (1):
      x86/asm/suspend: Drop ENTRY from local data

Kirill A. Shutemov (1):
      x86/boot/compressed/64: Explain paging_prepare()'s return value

Pingfan Liu (1):
      x86/trap: Remove useless declaration

Reinette Chatre (1):
      x86/resctrl: Remove duplicate MSR_MISC_FEATURE_CONTROL definition

Sergey Senozhatsky (2):
      x86/cpu_entry_area: Move percpu_setup_debug_store() to __init section
      x86/fpu: Move init_xstate_size() to __init section

Shaokun Zhang (3):
      x86/mm/tlb: Remove unused cpu variable
      x86/mm/dump_pagetables: Remove the unused prev_pud variable
      x86/smpboot: Remove unused phys_id variable


 arch/x86/boot/compressed/head_64.S        | 11 ++++++-----
 arch/x86/events/intel/core.c              |  2 ++
 arch/x86/events/intel/lbr.c               |  1 +
 arch/x86/include/asm/asm-prototypes.h     |  1 -
 arch/x86/include/asm/processor.h          |  1 -
 arch/x86/include/asm/uaccess.h            |  3 ---
 arch/x86/kernel/acpi/wakeup_32.S          |  2 +-
 arch/x86/kernel/acpi/wakeup_64.S          | 12 ++++++------
 arch/x86/kernel/apic/io_apic.c            |  2 ++
 arch/x86/kernel/cpu/cacheinfo.c           |  1 +
 arch/x86/kernel/cpu/mtrr/cleanup.c        |  3 +--
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  7 -------
 arch/x86/kernel/e820.c                    |  9 +++------
 arch/x86/kernel/fpu/xstate.c              |  2 +-
 arch/x86/kernel/hw_breakpoint.c           |  5 +----
 arch/x86/kernel/kgdb.c                    |  1 +
 arch/x86/kernel/smpboot.c                 |  7 +------
 arch/x86/kernel/uprobes.c                 |  1 +
 arch/x86/lib/insn-eval.c                  |  2 ++
 arch/x86/mm/cpu_entry_area.c              |  2 +-
 arch/x86/mm/dump_pagetables.c             |  2 --
 arch/x86/mm/tlb.c                         |  3 ---
 arch/x86/platform/uv/tlb_uv.c             |  8 ++------
 include/linux/kprobes.h                   |  5 +++++
 24 files changed, 38 insertions(+), 55 deletions(-)

