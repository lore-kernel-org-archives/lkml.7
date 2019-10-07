Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61166ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A1D8205F4
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:55:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbfJGMza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 08:55:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59182 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728592AbfJGMz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 08:55:26 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D38B430842AF;
        Mon,  7 Oct 2019 12:55:25 +0000 (UTC)
Received: from krava (unknown [10.43.17.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0C14560C18;
        Mon,  7 Oct 2019 12:55:24 +0000 (UTC)
Date:   Mon, 7 Oct 2019 14:55:24 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] perf record: Put a copy of kcore into the perf.data
 directory
Message-ID: <20191007125524.GH6919@krava>
References: <20191004083121.12182-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191004083121.12182-1-adrian.hunter@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Mon, 07 Oct 2019 12:55:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2019 at 11:31:16AM +0300, Adrian Hunter wrote:
> Hi
> 
> Here are patches to add a new 'perf record' option '--kcore' which will put
> a copy of /proc/kcore, kallsyms and modules into a perf.data directory.
> Note, that without the --kcore option, output goes to a file as previously.
> The tools' -o and -i options work with either a file name or directory
> name.
> 
> Example:
> 
>  $ sudo perf record --kcore uname
> 
>  $ sudo tree perf.data
>  perf.data
>  ├── kcore_dir
>  │   ├── kallsyms
>  │   ├── kcore
>  │   └── modules
>  └── data
> 
>  $ sudo perf script -v
>  build id event received for vmlinux: 1eaa285996affce2d74d8e66dcea09a80c9941de
>  build id event received for [vdso]: 8bbaf5dc62a9b644b4d4e4539737e104e4a84541
>  Samples for 'cycles' event do not have CPU attribute set. Skipping 'cpu' field.
>  Using CPUID GenuineIntel-6-8E-A
>  Using perf.data/kcore_dir/kcore for kernel data
>  Using perf.data/kcore_dir/kallsyms for symbols
>              perf 19058 506778.423729:          1 cycles:  ffffffffa2caa548 native_write_msr+0x8 (vmlinux)
>              perf 19058 506778.423733:          1 cycles:  ffffffffa2caa548 native_write_msr+0x8 (vmlinux)
>              perf 19058 506778.423734:          7 cycles:  ffffffffa2caa548 native_write_msr+0x8 (vmlinux)
>              perf 19058 506778.423736:        117 cycles:  ffffffffa2caa54a native_write_msr+0xa (vmlinux)
>              perf 19058 506778.423738:       2092 cycles:  ffffffffa2c9b7b0 native_apic_msr_write+0x0 (vmlinux)
>              perf 19058 506778.423740:      37380 cycles:  ffffffffa2f121d0 perf_event_addr_filters_exec+0x0 (vmlinux)
>             uname 19058 506778.423751:     582673 cycles:  ffffffffa303a407 propagate_protected_usage+0x147 (vmlinux)
>             uname 19058 506778.423892:    2241841 cycles:  ffffffffa2cae0c9 unwind_next_frame.part.5+0x79 (vmlinux)
>             uname 19058 506778.424430:    2457397 cycles:  ffffffffa3019232 check_memory_region+0x52 (vmlinux)
> 
> 
> Adrian Hunter (5):
>       perf data: Correctly identify directory data files
>       perf data: Move perf_dir_version into data.h
>       perf data: Rename directory "header" file to "data"
>       perf tools: Support single perf.data file directory
>       perf record: Put a copy of kcore into the perf.data directory

Reviewed-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> 
>  tools/perf/Documentation/perf-record.txt           |  3 ++
>  .../Documentation/perf.data-directory-format.txt   | 63 ++++++++++++++++++++++
>  tools/perf/builtin-record.c                        | 54 ++++++++++++++++++-
>  tools/perf/util/data.c                             | 46 ++++++++++++++--
>  tools/perf/util/data.h                             | 12 +++++
>  tools/perf/util/header.h                           |  4 --
>  tools/perf/util/record.h                           |  1 +
>  tools/perf/util/session.c                          |  4 ++
>  tools/perf/util/util.c                             | 19 ++++++-
>  9 files changed, 197 insertions(+), 9 deletions(-)
>  create mode 100644 tools/perf/Documentation/perf.data-directory-format.txt
> 
> 
> Regards
> Adrian
