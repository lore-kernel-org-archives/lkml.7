Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D84FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D60FB2171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551339083;
	bh=T0kefpK1SXg0Tqa407ozfnt8aOG7HIYzamw7cVd5aeE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qIQngsgw3U4+SOz2aeSfdGuWYDOFKDlG053CSsE5dCDHKiS7HGDsyNYrmsv2G3Gz0
	 FSaahB6/iW+gPvXPYNl6b/SBkV1hggX+k37LuEqOfLHYj5LrdjXh+/mk1ZPccOKd+v
	 Qn+A/hven1RrzXEJFASCW9pKRtN4iYcx9ggt2G5U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731682AbfB1HbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 02:31:21 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35864 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfB1HbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 02:31:21 -0500
Received: by mail-wr1-f65.google.com with SMTP id o17so20740788wrw.3;
        Wed, 27 Feb 2019 23:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MF4gAj0sBkuzUrHhhpvnk7fe23FwqTfpdVDmiLeRl4E=;
        b=pdzkeqSPMnd+C8at5/MvLBT7BxWxfhIFl63NWYixkzRWxZpkKHiYF6ORGJx7Osdi9V
         2UI1t/gh8GSa47SIyDbtL9B1jil5C/sxJW/o9wdNwhHedjB8JORhC0zzR4HjAUDuScyn
         Nsg1K+jKimj9XuD/tnCAf1We5TDGRHKBbGTGpYv9BI1Ecz061HZlzAZsErKF32gQ9t4d
         5+Gdyc2b8MZgtkr+ltUHWOM1zVj47PTqVTezIULViJuNL9YxBTXWAfEhm0dhy4K3CrKT
         SPJYcFw8r+ZXwUPWRJ7y11C2S/208vPjnv25WnPtRbHipnCht5A8X3JQW4lbWTxRtvOT
         FdYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=MF4gAj0sBkuzUrHhhpvnk7fe23FwqTfpdVDmiLeRl4E=;
        b=LZvAQWOfTxVUB8CFSa8JmjPih9rbfOVBOujHTmGb8lNfKYHcwFov8cCAAgqfc39H25
         hcs406dv91jL91qRCToXjdm0UiDP+tG67JJ26N15aav04HDJcHNmTfC6+L3742ZjQR2w
         nKw7WeTqpRyL+VAGDCahs983NHEgCuO7t3lMGa28M+zxBV8zxpc6f+M4moJVwiVnyXUj
         lleXJPUXbGgNCkRW3F6vbYFwXlRdkycFDt0ibRZZ6m3phz3eRT61iO2p/EUsiV1/Ohvz
         jwzcNGF7LbPKd0JiG+fy7thr28AjNP9UFBfGUplygnBwllppQfcsL/sxwVD07Chw+OIN
         eO4g==
X-Gm-Message-State: APjAAAVmcCPHl0DWnixRG6B9W2PLAAZx4hZ623k97wBUXcnAXYQluGbT
        BhJhJVROOO/3uWS3a7Xfsto=
X-Google-Smtp-Source: APXvYqyhA0l6Wm9qqaW531yQVXCnMWzYohJI2DxQXhGbKifVE04ksOjN+hmwduccKkhrg2wjj17TOQ==
X-Received: by 2002:a5d:4e52:: with SMTP id r18mr4931461wrt.7.1551339078449;
        Wed, 27 Feb 2019 23:31:18 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id d9sm19745117wrn.72.2019.02.27.23.31.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Feb 2019 23:31:17 -0800 (PST)
Date:   Thu, 28 Feb 2019 08:31:15 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Mansour Alharthi <malharthi9@gatech.edu>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>,
        Tony Jones <tonyj@suse.de>, Wei Li <liwei391@huawei.com>
Subject: Re: [GIT PULL] perf/core improvements and fixes
Message-ID: <20190228073115.GB59852@gmail.com>
References: <20190225212035.24781-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190225212035.24781-1-acme@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling, this is on top of my previous pull
> request, perf-core-for-mingo-5.1-20190220.
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit b4409ae112caa6315f6ee678e953b9fc93e6919c:
> 
>   perf tools: Make rm_rf() remove single file (2019-02-20 17:09:28 -0300)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.1-20190225
> 
> for you to fetch changes up to de667cce7f4f96b6e22da8fd9c065b961f355080:
> 
>   perf script python: Add Python3 support to syscall-counts-by-pid.py (2019-02-25 17:17:13 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> perf annotate:
> 
>   Wei Li:
> 
>   - Fix getting source line failure.
> 
> perf script:
> 
>   Andi Kleen:
> 
>   - Handle missing fields with -F +...
> 
> perf data:
> 
>   Jiri Olsa:
> 
>   - Prep work to support per-cpu files in a directory.
> 
> Intel PT:
> 
>   Adrian Hunter:
> 
>   - Improve thread_stack__no_call_return()
> 
>   - Hide x86 retpolines in thread stacks.
> 
>   - exported SQL viewer refactorings, new 'top calls' report.
> 
>   Alexander Shishkin:
> 
>   - Copy parent's address filter offsets on clone.
> 
>   - Fix address filters for vmas with non-zero offset. Applies to
>     ARM's CoreSight as well.
> 
> python scripts:
> 
>   Tony Jones:
> 
>   - Python3 support for several 'perf script' python scripts.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Adrian Hunter (13):
>       perf thread-stack: Improve thread_stack__no_call_return()
>       perf thread-stack: Hide x86 retpolines
>       perf scripts python: exported-sql-viewer.py: Fix missing shebang
>       perf scripts python: exported-sql-viewer.py: Remove leftover debugging prints
>       perf scripts python: exported-sql-viewer.py: Hide Call Graph option if no calls table
>       perf scripts python: exported-sql-viewer.py: Move column headers
>       perf scripts python: exported-sql-viewer.py: Factor out ReportDialogBase
>       perf scripts python: exported-sql-viewer.py: Factor out ReportVars
>       perf scripts python: exported-sql-viewer.py: Move report name into ReportVars
>       perf scripts python: exported-sql-viewer.py: Create new dialog data item classes
>       perf scripts python: exported-sql-viewer.py: Remove SQLTableDialogDataItem
>       perf scripts python: exported-sql-viewer.py: Remove no selection error
>       perf scripts python: exported-sql-viewer.py: Add top calls report
> 
> Alexander Shishkin (2):
>       perf: Copy parent's address filter offsets on clone
>       perf, pt, coresight: Fix address filters for vmas with non-zero offset
> 
> Andi Kleen (2):
>       perf script: Handle missing fields with -F +..
>       perf tools: Add perf_exe() helper to find perf binary
> 
> Jiri Olsa (9):
>       perf data: Move size to struct perf_data_file
>       perf data: Add global path holder
>       perf tools: Add depth checking to rm_rf
>       perf tools: Add pattern name checking to rm_rf
>       perf tools: Add rm_rf_perf_data function
>       perf data: Make check_backup work over directories
>       perf data: Fail check_backup in case of error
>       perf data: Add perf_data__(create_dir|close_dir) functions
>       perf data: Add perf_data__open_dir_data function
> 
> Tony Jones (10):
>       perf script python: Add Python3 support to netdev-times.py
>       perf script python: Add Python3 support to failed-syscalls-by-pid.py
>       perf script python: Add Python3 support to mem-phys-addr.py
>       perf script python: Add Python3 support to net_dropmonitor.py
>       perf script python: Add Python3 support to powerpc-hcalls.py
>       perf script python: Add Python3 support to sctop.py
>       perf script python: Add Python3 support to stackcollapse.py
>       perf script python: Add Python3 support to stat-cpi.py
>       perf script python: Add Python3 support to syscall-counts.py
>       perf script python: Add Python3 support to syscall-counts-by-pid.py
> 
> Wei Li (1):
>       perf annotate: Fix getting source line failure
> 
>  arch/x86/events/intel/pt.c                         |   9 +-
>  drivers/hwtracing/coresight/coresight-etm-perf.c   |   7 +-
>  include/linux/perf_event.h                         |   7 +-
>  kernel/events/core.c                               |  90 ++--
>  tools/perf/builtin-annotate.c                      |   4 +-
>  tools/perf/builtin-buildid-cache.c                 |   4 +-
>  tools/perf/builtin-buildid-list.c                  |   8 +-
>  tools/perf/builtin-c2c.c                           |   4 +-
>  tools/perf/builtin-diff.c                          |  12 +-
>  tools/perf/builtin-evlist.c                        |   4 +-
>  tools/perf/builtin-inject.c                        |  10 +-
>  tools/perf/builtin-kmem.c                          |   2 +-
>  tools/perf/builtin-kvm.c                           |   8 +-
>  tools/perf/builtin-lock.c                          |   8 +-
>  tools/perf/builtin-mem.c                           |   8 +-
>  tools/perf/builtin-record.c                        |  11 +-
>  tools/perf/builtin-report.c                        |   6 +-
>  tools/perf/builtin-sched.c                         |  16 +-
>  tools/perf/builtin-script.c                        |  22 +-
>  tools/perf/builtin-stat.c                          |   6 +-
>  tools/perf/builtin-timechart.c                     |   8 +-
>  tools/perf/builtin-trace.c                         |   8 +-
>  tools/perf/scripts/python/exported-sql-viewer.py   | 510 ++++++++++++++-------
>  .../perf/scripts/python/failed-syscalls-by-pid.py  |  21 +-
>  tools/perf/scripts/python/mem-phys-addr.py         |  24 +-
>  tools/perf/scripts/python/net_dropmonitor.py       |  10 +-
>  tools/perf/scripts/python/netdev-times.py          |  82 ++--
>  tools/perf/scripts/python/powerpc-hcalls.py        |  18 +-
>  tools/perf/scripts/python/sctop.py                 |  24 +-
>  tools/perf/scripts/python/stackcollapse.py         |   7 +-
>  tools/perf/scripts/python/stat-cpi.py              |  10 +-
>  tools/perf/scripts/python/syscall-counts-by-pid.py |  22 +-
>  tools/perf/scripts/python/syscall-counts.py        |  18 +-
>  tools/perf/util/annotate.c                         |   4 +-
>  tools/perf/util/data-convert-bt.c                  |   4 +-
>  tools/perf/util/data.c                             | 175 ++++++-
>  tools/perf/util/data.h                             |  16 +-
>  tools/perf/util/header.c                           |  12 +-
>  tools/perf/util/thread-stack.c                     | 161 ++++++-
>  tools/perf/util/util.c                             |  65 ++-
>  tools/perf/util/util.h                             |   3 +
>  41 files changed, 1019 insertions(+), 429 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
