Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8ED0C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 21:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BD5F20B7C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 21:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559078283;
	bh=RQt0MYcsrj2YfAfufPagBuTAramftdXvJORm2piEfFE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uH0f//b8hFF0fvXBIFeKnrGcex/q5nBdm1Lkto6zLDCvG+P5y81Vd21FuVBpujc5Z
	 e3QpM6qaU4/Uwk3qK2xquW3bWn0LUTayKbh86Fphq29KnZcQCKbTjace2G9/S/HuzC
	 Q6aj8qZYKv/VYm2QxupYzj+sZZOTfXSxQ3KDqVhE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbfE1VSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 17:18:02 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43090 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbfE1VSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 17:18:02 -0400
Received: by mail-wr1-f68.google.com with SMTP id l17so136110wrm.10;
        Tue, 28 May 2019 14:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Nu2PBKefTEboHZyJFL1DxHjrLJAMe2LcS2THvq8WhzQ=;
        b=hdjlynKmqUm+SqG9JFIsYLM/n5qM0mUyIyuIKpKaXSAkn153UojXr9IJgDEDlc9yxG
         SDvqtBGona3FGqktVDhTW3nBhJXipHPDQn3zltCVC7w6HZEfvUcgTRNuaJYIa1WEOTxS
         +t1A4c7YHVsBK4BQC6StDnMQ0Jb65WnyNHJfPqX5t+hMJ52jHd7Za69c/KrAbiMF3AkM
         UYcYYBTEOObmulDrUe+pPTaFLVULTRsvPLlr8p1muj+WLtkm/o7DwAT/w5pWEwZOlZIY
         pP536JzuH8mpDHfAfQ0LksoepgyLreHiorRiae5djSDRXVJZAwNEcZgekv+N1qjtd/ph
         S2Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Nu2PBKefTEboHZyJFL1DxHjrLJAMe2LcS2THvq8WhzQ=;
        b=Bj4UcBpaG/HjMu3O1ucldlNMzhbFEB/aMXFw0/SoO148dN0VZXrcLVa6dbaCVs8Uym
         XVMz8HfAjwfzUm2hGhBDs02Rr/QM4OHO/QKnIlahwwL5Mn6Lf7SSUo4iweyum5mBvuFp
         cE31KF1cUVOueHxRcX0r+ls/+ypv8G8nsBa5vtcoIxjdEN/A/34wgr3cTFdK+3uc4Q2X
         f+90Pe5iXX0YuIPROhWVeOxeyPnBFxEHy4wD0cGuYnct+Kjzcz+uzJJXdMYSu251d7he
         t73sJViUCDSr5fLZIjQr7tw+T97DmLylmuh0BYXVq/IU4/liMThn5pOectgQ5jVq4UVh
         +GIQ==
X-Gm-Message-State: APjAAAXJT45p7yAQunOh3AypiWUIhtpfi9wmu7QWvCBAgy0X+mzHD0V5
        AJdTiDOMhec1lwCFgrkFoMM=
X-Google-Smtp-Source: APXvYqxUxZU4kA00IKfLx5MY1h+s6YnIZpCBe6ZHxtqGTCHYzf3BnK2ViMai0fAjLAhDPAl9F8z1XA==
X-Received: by 2002:a5d:4104:: with SMTP id l4mr2398171wrp.302.1559078279600;
        Tue, 28 May 2019 14:17:59 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id b5sm244623wrx.22.2019.05.28.14.17.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 May 2019 14:17:58 -0700 (PDT)
Date:   Tue, 28 May 2019 23:17:56 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Michael Petlan <mpetlan@redhat.com>,
        Shawn Landden <shawn@git.icu>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL] perf/urgent fixes for 5.2
Message-ID: <20190528211756.GA46600@gmail.com>
References: <20190528175020.13343-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528175020.13343-1-acme@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling, that is a trimmed down set from
> yesterday's pull req, with just fixes.
> 
> 	The other stuff, mostly acting on the warnings for the UAPI
> changes are being packaged into a perf/core pull request I'll send for
> 5.3.
> 
> 	I had it mostly done earlier, but then I noticed the fix for
> the syscall numbers, and backtracked to avoid sending yet another pull
> req, got too late in the -rc game, so 5.3 they go.
> 
> 	I'm not reposting them, the only change was adding an Acked-by
> for one of the UAPI syncs, the drm.h one.
> 
>         I did all the tests again, find them below, after the new signed
> tag.
> 
> Best regards,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit 5bdd9ad875b6edf213f54ec3986ed9e8640c5cf9:
> 
>   Merge tag 'kbuild-fixes-v5.2' of git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild (2019-05-20 17:22:17 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-5.2-20190528
> 
> for you to fetch changes up to a7350998a25ac10cdca5b33dee1d343a74debbfe:
> 
>   tools headers UAPI: Sync kvm.h headers with the kernel sources (2019-05-28 09:52:23 -0300)
> 
> ----------------------------------------------------------------
> perf/urgent fixes:
> 
> BPF:
> 
>   Jiri Olsa:
> 
>   - Fixup determination of end of kernel map, to avoid having BPF programs,
>     that are after the kernel headers and just before module texts mixed up in
>     the kernel map.
> 
> tools UAPI header copies:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Update copy of files related to new fspick, fsmount, fsconfig, fsopen,
>     move_mount and open_tree syscalls.
> 
>   - Sync cpufeatures.h, sched.h, fs.h, drm.h, i915_drm.h and kvm.h headers.
> 
> Namespaces:
> 
>   Namhyung Kim:
> 
>   - Add missing byte swap ops for namespace events when processing records from
>     perf.data files that could have been recorded in a arch with a different
>     endianness.
> 
>   - Fix access to the thread namespaces list by using the namespaces_lock.
> 
> perf data:
> 
>   Shawn Landden:
> 
>   - Fix 'strncat may truncate' build failure with recent gcc.
> 
> s/390
> 
>   Thomas Richter:
> 
>   - Fix s390 missing module symbol and warning for non-root users in 'perf record'.
> 
> arm64:
> 
>   Vitaly Chikunov:
> 
>   - Fix mksyscalltbl when system kernel headers are ahead of the kernel.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (8):
>       tools include UAPI: Update copy of files related to new fspick, fsmount, fsconfig, fsopen, move_mount and open_tree syscalls
>       tools arch x86: Sync asm/cpufeatures.h with the with the kernel
>       tools headers UAPI: Sync linux/sched.h with the kernel
>       tools headers UAPI: Sync linux/fs.h with the kernel
>       tools headers UAPI: Sync drm/i915_drm.h with the kernel
>       tools headers UAPI: Sync drm/drm.h with the kernel
>       perf test vmlinux-kallsyms: Ignore aliases to _etext when searching on kallsyms
>       tools headers UAPI: Sync kvm.h headers with the kernel sources
> 
> Jiri Olsa (1):
>       perf machine: Read also the end of the kernel
> 
> Namhyung Kim (2):
>       perf namespace: Protect reading thread's namespace
>       perf session: Add missing swap ops for namespace events
> 
> Shawn Landden (1):
>       perf data: Fix 'strncat may truncate' build failure with recent gcc
> 
> Thomas Richter (1):
>       perf record: Fix s390 missing module symbol and warning for non-root users
> 
> Vitaly Chikunov (1):
>       perf arm64: Fix mksyscalltbl when system kernel headers are ahead of the kernel
> 
>  tools/arch/arm64/include/uapi/asm/kvm.h           |  43 ++++
>  tools/arch/powerpc/include/uapi/asm/kvm.h         |  46 ++++
>  tools/arch/s390/include/uapi/asm/kvm.h            |   4 +-
>  tools/arch/x86/include/asm/cpufeatures.h          |   3 +
>  tools/include/uapi/asm-generic/unistd.h           |  14 +-
>  tools/include/uapi/drm/drm.h                      |  37 ++++
>  tools/include/uapi/drm/i915_drm.h                 | 254 +++++++++++++++-------
>  tools/include/uapi/linux/fcntl.h                  |   2 +
>  tools/include/uapi/linux/fs.h                     |   3 +
>  tools/include/uapi/linux/kvm.h                    |  15 +-
>  tools/include/uapi/linux/mount.h                  |  62 ++++++
>  tools/include/uapi/linux/sched.h                  |   1 +
>  tools/perf/arch/arm64/entry/syscalls/mksyscalltbl |   2 +-
>  tools/perf/arch/s390/util/machine.c               |   9 +-
>  tools/perf/arch/x86/entry/syscalls/syscall_64.tbl |   6 +
>  tools/perf/tests/vmlinux-kallsyms.c               |   9 +-
>  tools/perf/util/data-convert-bt.c                 |   2 +-
>  tools/perf/util/machine.c                         |  27 ++-
>  tools/perf/util/session.c                         |  21 ++
>  tools/perf/util/thread.c                          |  15 +-
>  20 files changed, 481 insertions(+), 94 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
