Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D89EC282DC
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 17:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D992B262E8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 17:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559497198;
	bh=Iq0CpTW0ukJMjNWkyaNmDwKV6c15wjmCPLd5hRbRowE=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=Igmc99jfQC52+lhBIo3zu12Uiqe1l+igrwKcYl/7ffN7RJPjFVCKcIfkln4Zxtzeg
	 0M9wcg81kCUpwD0JgL4aRQc+OV5j6GnkaxrIFieeyP0mXAeEGH2IGtWdZJSbrgp98m
	 h+qDbiuCfYJ3Uyz2skszg2aBPcfAift2x5KZfCRA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfFBRj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 13:39:58 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39073 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbfFBRj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 13:39:57 -0400
Received: by mail-wr1-f65.google.com with SMTP id x4so9771889wrt.6
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2019 10:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=kZNw/ckwc2s5GyZb2ARCrIQNL0FAo29qnCwNB3a8SwQ=;
        b=LD6NiyvUh0RktGXfAxvQZS46uuP2KUmAPqiZdl7dBNusIt8s+y6Mr/wO1YMp2fv1qQ
         OR5XivCSfm6YiDfrJheb/E9HCU6CBul4FF3CVMzuYk3Kht9z0li68GvIYJLlu61tbviN
         Ahsbq9dvs/KabMMRaETYW8JML/Ih8vaXcqSGI8ZFHkwpPliiu6fjMHfABeB0Y5/7DQyv
         pFQFfPBnuCZkabYPECU/LbeYa34ncm/Gd3f1x2K3z1Gbqvx2JPZ+SWQ+E5jpUoydvzYu
         4Sll78AgFQZo0LS6GlUWB5bwIakgqp/zJzaXSZDNHm6ERZVaBrw1T/4eR8euw93yLgOe
         FSnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=kZNw/ckwc2s5GyZb2ARCrIQNL0FAo29qnCwNB3a8SwQ=;
        b=RaHVIlMVLmt37M4EECc/i0jF75Cnftu+IeU0FPpoJWO6B6R+HYpKcdMPel7z5jDtbK
         8tAaSt1Iv3Y1CzRMjhvxIYMaGdoIAzg0tOIPMdBVNxnX2ODIaCPm4jeJMvyR6GCxvGFf
         IKTDA6EZYJH5KQ3Oc1SiGnxjiVWATwFj6BPuoYDZYIcTKNT5iV106yoVirI+KlNJgdZM
         oCUA/hYN2jjFYsCUZdz+e8T7yymaM0GVvRJmM6GWyGq9LNVxrPU4ssDjtKitRj/PxvlD
         2SB7h97rsiXJUq16EZvOKyEJ2LxtHDjHrOsuxJ18iDgTrJAsZbLNuFD8j0DywkHAeHtb
         h46w==
X-Gm-Message-State: APjAAAU5BNV6DpxS62/oJlqrBdT4v+FJuJx/MoLVffvSeYPsj6UQQErf
        zAphT1/jw8EkR6gc+DZAlqo=
X-Google-Smtp-Source: APXvYqzG3y8NfRunLU1pL/4lno8mg38t0+GsLIMuGTC7+ZffWVcatPQuMBdElVryAa4LPatriTPqoQ==
X-Received: by 2002:a5d:4310:: with SMTP id h16mr14177683wrq.331.1559497195821;
        Sun, 02 Jun 2019 10:39:55 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id c2sm17658372wrf.75.2019.06.02.10.39.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 02 Jun 2019 10:39:55 -0700 (PDT)
Date:   Sun, 2 Jun 2019 19:39:53 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] perf fixes
Message-ID: <20190602173953.GA109592@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest perf-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

   # HEAD: 849e96f30068d4f6f8352715e02a10533a46deba Merge tag 'perf-urgent-for-mingo-5.2-20190528' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent

On the kernel side there's a bunch of ring-buffer ordering fixes for a 
reproducible bug, plus a PEBS constraints regression fix - plus tooling 
fixes.

 Thanks,

	Ingo

------------------>
Arnaldo Carvalho de Melo (8):
      tools include UAPI: Update copy of files related to new fspick, fsmount, fsconfig, fsopen, move_mount and open_tree syscalls
      tools arch x86: Sync asm/cpufeatures.h with the with the kernel
      tools headers UAPI: Sync linux/sched.h with the kernel
      tools headers UAPI: Sync linux/fs.h with the kernel
      tools headers UAPI: Sync drm/i915_drm.h with the kernel
      tools headers UAPI: Sync drm/drm.h with the kernel
      perf test vmlinux-kallsyms: Ignore aliases to _etext when searching on kallsyms
      tools headers UAPI: Sync kvm.h headers with the kernel sources

Jiri Olsa (1):
      perf machine: Read also the end of the kernel

Namhyung Kim (2):
      perf namespace: Protect reading thread's namespace
      perf session: Add missing swap ops for namespace events

Peter Zijlstra (3):
      perf/ring_buffer: Add ordering to rb->nest increment
      perf/ring-buffer: Always use {READ,WRITE}_ONCE() for rb->user_page data
      perf/ring-buffer: Use regular variables for nesting

Shawn Landden (1):
      perf data: Fix 'strncat may truncate' build failure with recent gcc

Stephane Eranian (1):
      perf/x86/intel/ds: Fix EVENT vs. UEVENT PEBS constraints

Thomas Richter (1):
      perf record: Fix s390 missing module symbol and warning for non-root users

Vitaly Chikunov (1):
      perf arm64: Fix mksyscalltbl when system kernel headers are ahead of the kernel

Yabin Cui (1):
      perf/ring_buffer: Fix exposing a temporarily decreased data_head


 arch/x86/events/intel/ds.c                        |  28 +--
 kernel/events/internal.h                          |   4 +-
 kernel/events/ring_buffer.c                       |  64 ++++--
 tools/arch/arm64/include/uapi/asm/kvm.h           |  43 ++++
 tools/arch/powerpc/include/uapi/asm/kvm.h         |  46 ++++
 tools/arch/s390/include/uapi/asm/kvm.h            |   4 +-
 tools/arch/x86/include/asm/cpufeatures.h          |   3 +
 tools/include/uapi/asm-generic/unistd.h           |  14 +-
 tools/include/uapi/drm/drm.h                      |  37 ++++
 tools/include/uapi/drm/i915_drm.h                 | 254 +++++++++++++++-------
 tools/include/uapi/linux/fcntl.h                  |   2 +
 tools/include/uapi/linux/fs.h                     |   3 +
 tools/include/uapi/linux/kvm.h                    |  15 +-
 tools/include/uapi/linux/mount.h                  |  62 ++++++
 tools/include/uapi/linux/sched.h                  |   1 +
 tools/perf/arch/arm64/entry/syscalls/mksyscalltbl |   2 +-
 tools/perf/arch/s390/util/machine.c               |   9 +-
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl |   6 +
 tools/perf/tests/vmlinux-kallsyms.c               |   9 +-
 tools/perf/util/data-convert-bt.c                 |   2 +-
 tools/perf/util/machine.c                         |  27 ++-
 tools/perf/util/session.c                         |  21 ++
 tools/perf/util/thread.c                          |  15 +-
 23 files changed, 547 insertions(+), 124 deletions(-)
