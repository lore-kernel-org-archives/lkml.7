Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E48CC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 19:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39B39214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 19:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566330004;
	bh=uPaqG+Dd4CNC5PLjH1Jh+esIDfZJotzE2i1/69k+IBs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0AmHpsNqTL2VyKL0k3eKUDhOXK8seQhMltiLM7Sy1TS1Mxu8kZA1sNb1/deMsMxBF
	 ybd3NXd0juyxW2J4d15rDUKV3a375U5aOPoKrb/n+WlawePAERRg8rWBVOdXF6s9iD
	 R9E/6MAKjD+VIwR1BeXIca/zmDe8vo5TDgPMEmpk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730680AbfHTTkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 15:40:03 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43779 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbfHTTkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 15:40:03 -0400
Received: by mail-wr1-f68.google.com with SMTP id y8so13575782wrn.10;
        Tue, 20 Aug 2019 12:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vVf8dfWLJA7Slipj/H4TM0wj7ifbcyuzlcTKgYVOtyE=;
        b=M4UOUxyzIgF9XLs7JwcxDoBcZW2C4282REjJ+e1QEONUJ4ZNGUkZc2lM/BLEnNQ27L
         OQPo31+uGWQzcD7QVkfu+08uVF50BJ/wTaZvauBd/Lk+XELOpkc7m12C0peyXWjPqGQT
         6qulvSqhKELvIhaG4+Mevo3Sw3yVi25FUAOlHbQBogDa/NdZOwsq9EDGTpBkHg5V48yp
         HbOskYJO+wfqFyAJvOSWbP9b9QHGc3Qg4NorbyIcp0L142SKt9fx8/uSsAwx745WfUk7
         Su4lfFg2GYqN+gyHGqjL6xnrzsJt3r31T7jHE+RAJLyJ99ESUXeYNrFs3AGEKhx2CRCo
         LN4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=vVf8dfWLJA7Slipj/H4TM0wj7ifbcyuzlcTKgYVOtyE=;
        b=sE6J4kDWJ49oHcBhn37hCZyVS8hBNKVOk7jcAkRIn/IR7UzxzR7Bt2g7sKigVsckv/
         vRyaW+vK7jplE+N65lti73fCEJTSjjow2QvD/FT7ahWueaVRq7zfatG5nCyFvwrGozlH
         i8UQ0LK79sjFG0PktIzXDKyTcnaaN2fkNZrUtQKtgtqL3IOETecaQJDki7ya4Q6Doh4B
         fm8qkMnkYClfdomiFzak28DIf8Xw8pLmFXEHQkrPq6H8fyxLXGcjuqOZTo1joA/BOj9O
         VdEBbH6nyraGJqgLvR3+4TxRctwlH2+ikaiGvE0O7+zpx63rlI1tQyHcwUaiHP1gYjRO
         acBg==
X-Gm-Message-State: APjAAAX/jYPpOAFPDEGi05J91d5hM1RDwuV01Lq5fWDkWi/u2OGfjzEe
        0x2wsom77tWxUj2j9ysRzGCcKw8e
X-Google-Smtp-Source: APXvYqxTd4MHMUFbkcmT0V74EDY+yNRbT6EJW8us8XdCvr7wiYQpaEIjUrdiNMM6Qt72JA3+WOw/nA==
X-Received: by 2002:a5d:5388:: with SMTP id d8mr36170427wrv.299.1566329996110;
        Tue, 20 Aug 2019 12:39:56 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id n8sm16506676wro.89.2019.08.20.12.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 12:39:55 -0700 (PDT)
Date:   Tue, 20 Aug 2019 21:39:53 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL] perf/core improvements and fixes
Message-ID: <20190820193953.GA12100@gmail.com>
References: <20190820192733.19180-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820192733.19180-1-acme@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo/Thomas,
> 
> 	Please consider pulling,
> 
> Best regards,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit cfb104ca8a26affb28d81720a4ed49c30b2a3b01:
> 
>   Merge tag 'perf-core-for-mingo-5.4-20190816' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core (2019-08-16 22:43:42 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.4-20190820
> 
> for you to fetch changes up to b81d39c7a1efb83caa3f4419939a46e96191abb6:
> 
>   libperf: Fix arch include paths (2019-08-20 12:29:36 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> callchains:
> 
>    Alexey Budankov:
> 
>   - Allow collecting LBR together with DWARF callchains, for workloads
>     where the userspace stack size collected is not big enough for
>     pure DWARF based unwinding.
> 
>   - Dump the LBR call stack in 'perf report -D'.
> 
> perf top:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Show visual cue at start to state that the minimal set of samples
>     are being collected prior to sorting/bucketizing/displaying.
> 
> CoreSight (ARM hardware tracing):
> 
>   Leo Yan:
> 
>   - Support sample flags 'insn' and 'insnlen'.
> 
> core:
> 
>   Adrian Hunter:
> 
>   - Add comment for 'idx' member in 'struct perf_sample_id.
> 
> tools headers:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Synchronize linux/bits.h, which required grabbing a copy of the kernel
>     const.h headers and some changes in the ordering of header directories.
> 
>   - Sync x86's asm/cpufeatures.h with the with the kernel, no change in
>     any of the tools.
> 
> libperf:
> 
>   Jiri Olsa:
> 
>   - Fix arch include paths.
> 
> libtraceevent:
> 
>   Steven Rostedt (VMware):
> 
>   - Fix "robust" test of do_generate_dynamic_list_file.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Adrian Hunter (1):
>       perf evsel: Add comment for 'idx' member in 'struct perf_sample_id
> 
> Alexey Budankov (3):
>       perf record: Enable LBR callstack capture jointly with thread stack
>       perf report: Dump LBR callstack data by -D jointly with thread stack
>       perf report: Prefer DWARF callstacks to LBR ones when captured both
> 
> Arnaldo Carvalho de Melo (10):
>       tools headers: Add limits.h to access __WORDSIZE
>       perf tools: tools/include should come before tools/uapi/include
>       tools headers: Grab copy of linux/const.h, needed by linux/bits.h
>       tools headers: Synchronize linux/bits.h with the kernel sources
>       tools arch x86: Sync asm/cpufeatures.h with the with the kernel
>       perf ui: Make 'exit_msg' optional in ui__question_window()
>       perf ui: Introduce non-interactive ui__info_window() function
>       perf ui browser: Allow specifying message to show when no samples are available to display
>       perf top: Show info message while collecting samples
>       tools headers: Fixup bitsperlong per arch includes
> 
> Jiri Olsa (1):
>       libperf: Fix arch include paths
> 
> Leo Yan (1):
>       perf cs-etm: Support sample flags 'insn' and 'insnlen'
> 
> Steven Rostedt (VMware) (1):
>       tools lib traceevent: Fix "robust" test of do_generate_dynamic_list_file
> 
>  tools/arch/x86/include/asm/cpufeatures.h |  3 +++
>  tools/include/linux/bitops.h             |  1 +
>  tools/include/linux/bits.h               | 17 +++++++++------
>  tools/include/linux/const.h              |  9 ++++++++
>  tools/include/uapi/asm/bitsperlong.h     | 18 ++++++++--------
>  tools/include/uapi/linux/const.h         | 31 ++++++++++++++++++++++++++
>  tools/lib/traceevent/Makefile            |  4 ++--
>  tools/perf/Makefile.config               |  2 +-
>  tools/perf/builtin-report.c              |  2 ++
>  tools/perf/check-headers.sh              |  2 ++
>  tools/perf/lib/Makefile                  |  2 +-
>  tools/perf/ui/browser.c                  |  2 ++
>  tools/perf/ui/browser.h                  |  1 +
>  tools/perf/ui/browsers/hists.c           |  3 +++
>  tools/perf/ui/tui/util.c                 | 37 ++++++++++++++++++++++----------
>  tools/perf/ui/util.h                     |  2 ++
>  tools/perf/util/cs-etm.c                 | 35 +++++++++++++++++++++++++++++-
>  tools/perf/util/evsel.h                  |  7 ++++++
>  tools/perf/util/parse-branch-options.c   |  1 +
>  tools/perf/util/session.c                | 31 +++++++++++++++-----------
>  20 files changed, 166 insertions(+), 44 deletions(-)
>  create mode 100644 tools/include/linux/const.h
>  create mode 100644 tools/include/uapi/linux/const.h

Pulled, thanks a lot Arnaldo!

This one's very nice:

> Arnaldo Carvalho de Melo (10):
>       perf top: Show info message while collecting samples

:-)

	Ingo
