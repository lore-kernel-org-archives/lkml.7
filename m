Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBCE1C04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 17:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9952420675
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 17:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558199584;
	bh=nmdo8ZJK0/p+F11iWtSFcN99wRo5h65/7E1Ixk2rO/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Mf1x7PWymma5S5LeOUHMl2LIH6KkFVwWX0bQqdCfensrT4ID5IIer1f9pifwHS7jg
	 xfh1KMOT+S31kN9X+ffaRRRni9Z8Gww+GAwit4TQXcEItlE4Nw/2667ebntPYn8fnj
	 9Zfzj5y4yhkQWgHo6GoszuolPstXtRVfCiku3tqo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729658AbfERRNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 13:13:02 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44692 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbfERRNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 13:13:02 -0400
Received: by mail-wr1-f68.google.com with SMTP id c5so10139997wrs.11;
        Sat, 18 May 2019 10:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i1ZkvSC9qEDjJRBBCcoHhDcW4ofyXizhMjs0hdkL93E=;
        b=f7za4ZNuutGAB3AVszSj4o8NW1mCzJT3ofXx0NMJt83cQC1hBoXZ1MHcPFc79Utz3b
         PiGvDOvzhymVI+qgKqVy7sDz4nuhzAoNGV44uWj7Z62HVsxiYU+1X6nyrwoJZIeu8IDj
         DM7Mt7SNAsqrdbAZcPb5AYnKqz2/bMMCLsLzyotMcQE9pDYLBkjQJIiJBhaj/zxf1tOB
         sKbz9z/13QHSE3YL4a8iMHRQynB3dY2aFfjikOJsFgiPilZZ2j85QAq492MnWCxRdjtR
         J8jx/6PBLTO2EHYLm+7MCkCJqB9Ei77wJOZAi88oIEjeLMdUxqtcHisTWHOiPI9W+JHZ
         Ymkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=i1ZkvSC9qEDjJRBBCcoHhDcW4ofyXizhMjs0hdkL93E=;
        b=WKxuj+4E1bjFbE2/jXjn4Iy67ZcQe6KLA3OkMkplnSY0VUY3TP2OZna+aBdOwgxLRw
         fbCE+Zv9Xj2PVjDXXhx3Xvwz8DlMV8N676Jt0Ct89fiWksVLJUvoZlr4zD3m8HiUM2aN
         pjI7vyKNlNIYifkTe+44nxHoGLUyTgtradvxG9eibA2S3wbGLZYHB2lWu32owGgHRHoR
         21EBqrH2S9Sv+ZtUJkobb18pNOXn/do9N5Zck9t7ZVUPOvIba/N+nIlp64WME6Uljdi2
         1qdtCoQ/DWrrhuAOtDntVp7Oe0a9pWAmyHuR1iPsuSpxMGPL85AQZkmJMzv+N3/KGSUq
         aNuQ==
X-Gm-Message-State: APjAAAXKIPsR5UQiLVezE6Q5XtEPq+qH93xzVWH66BYdritOMZsNpEG/
        e5Gcp0SW17T251cH/AUx2sQ=
X-Google-Smtp-Source: APXvYqzdLGHF/k3fyVG/fq5yc9N/UEfndnbGQwNgtrsSL53p1TO6qicc4myCrnyYQPJDTZiAP2AQXQ==
X-Received: by 2002:adf:cd09:: with SMTP id w9mr2687672wrm.242.1558199580102;
        Sat, 18 May 2019 10:13:00 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id n63sm11026167wmn.38.2019.05.18.10.12.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 May 2019 10:12:59 -0700 (PDT)
Date:   Sat, 18 May 2019 19:12:57 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Colin King <colin.king@canonical.com>,
        Donald Yandt <donald.yandt@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Guo Ren <ren_guo@c-sky.com>, Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Mao Han <han_mao@c-sky.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Stanislav Kozina <skozina@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH] tools/headers: Synchronize kernel ABI headers
Message-ID: <20190518171257.GA50600@gmail.com>
References: <20190517193611.4974-1-acme@kernel.org>
 <20190518084223.GB85914@gmail.com>
 <20190518133923.GA7969@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190518133923.GA7969@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Em Sat, May 18, 2019 at 10:42:23AM +0200, Ingo Molnar escreveu:
> > Pick up the latest v5.2-to-be kernel ABI headers and synchronize them with tooling:
> > 
> >  - arch/x86/entry/syscalls/syscall_64.tbl   => tools/perf/arch/x86/entry/syscalls/syscall_64.tbl  # new syscalls
> >  - arch/x86/include/asm/cpufeatures.h       => tools/arch/x86/include/asm/cpufeatures.h           # new CPUID flags
> >  - include/uapi/drm/drm.h                   => tools/include/uapi/drm/drm.h                       # new 'syncobj' DRM ABI
> >  - include/uapi/drm/i915_drm.h              => tools/include/uapi/drm/i915_drm.h                  # new extensible DRM ABI
> >  - include/uapi/linux/fcntl.h               => tools/include/uapi/linux/fcntl.h                   # new AT_RECURSIVE
> >  - include/uapi/linux/fs.h                  => tools/include/uapi/linux/fs.h                      # new SYNC_FILE_RANGE_WRITE_AND_WAIT
> >  - include/uapi/linux/mount.h               => tools/include/uapi/linux/mount.h                   # new VFS system calls: fspick, fsmount, fsconfig, fsopen, move_mount, open_tree
> >  - include/uapi/linux/sched.h               => tools/include/uapi/linux/sched.h                   # new CLONE_PIDFD
> > 
> > All of these are new ABI additions with no impact on existing tooling,
> 
> There is some impact in a number of them, for instance:
> 
> [acme@quaco perf]$ diff -u tools/perf/arch/x86/entry/syscalls/syscall_64.tbl arch/x86/entry/syscalls/syscall_64.tbl
> --- tools/perf/arch/x86/entry/syscalls/syscall_64.tbl	2019-05-13 14:46:03.915894924 -0300
> +++ arch/x86/entry/syscalls/syscall_64.tbl	2019-05-18 10:27:04.273395657 -0300
> @@ -343,6 +343,12 @@
>  332	common	statx			__x64_sys_statx
>  333	common	io_pgetevents		__x64_sys_io_pgetevents
>  334	common	rseq			__x64_sys_rseq
> +335	common	open_tree		__x64_sys_open_tree
> +336	common	move_mount		__x64_sys_move_mount
> +337	common	fsopen			__x64_sys_fsopen
> +338	common	fsconfig		__x64_sys_fsconfig
> +339	common	fsmount			__x64_sys_fsmount
> +340	common	fspick			__x64_sys_fspick
>  # don't use numbers 387 through 423, add new calls after the last
>  # 'common' entry
>  424	common	pidfd_send_signal	__x64_sys_pidfd_send_signal
> [acme@quaco perf]$
> 
> These will enable 'perf trace' to know about these syscalls, i.e. we
> will be able to say:
> 
>     perf trace -e fs*
> 
> And have it trace just those fsopen, fsconfig, fsmount and fspick
> syscalls (or any other that starts with fs, that is). Looking at this
> makes one think if we should have a new syscall group like we have here:
> 
> [acme@quaco perf]$ ls -la tools/perf/trace/strace/groups/
> total 16
> drwxrwxr-x. 2 acme acme 4096 May 13 14:46 .
> drwxrwxr-x. 3 acme acme 4096 Apr 10 10:20 ..
> -rw-rw-r--. 1 acme acme  136 May 13 14:46 file
> -rw-rw-r--. 1 acme acme  584 May 13 14:46 string
> [acme@quaco perf]$ 
> 
> One for file oriented syscalls, the other for syscalls that operate on
> strings (pathnames, etc).

Good point, I missed that!

> So I'll check that tools/perf/trace/beauty/drm_ioctl.sh is sane wrt any
> new additions to that header, ditto for the other headers, I'll go thru
> them soon.

Thanks!

	Ingo
