Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888F7C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 09:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 609A72087B
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 09:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbfHLJNw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 05:13:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33902 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727154AbfHLJNv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 05:13:51 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4FB5030BCB86;
        Mon, 12 Aug 2019 09:13:51 +0000 (UTC)
Received: from krava (unknown [10.43.17.33])
        by smtp.corp.redhat.com (Postfix) with SMTP id D192F19C65;
        Mon, 12 Aug 2019 09:13:48 +0000 (UTC)
Date:   Mon, 12 Aug 2019 11:13:48 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Igor Lubashev <ilubashe@akamai.com>
Cc:     linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        James Morris <jmorris@namei.org>
Subject: Re: [PATCH v3 0/4] perf: Use capabilities instead of uid and euid
Message-ID: <20190812091348.GA11946@krava>
References: <cover.1565188228.git.ilubashe@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1565188228.git.ilubashe@akamai.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Mon, 12 Aug 2019 09:13:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2019 at 10:44:13AM -0400, Igor Lubashev wrote:
> Series v1: https://lkml.kernel.org/lkml/1562112605-6235-1-git-send-email-ilubashe@akamai.com
> 
> 
> Kernel is using capabilities instead of uid and euid to restrict access to
> kernel pointers and tracing facilities.  This patch series updates the perf to
> better match the security model used by the kernel.
> 
> This series enables instructions in Documentation/admin-guide/perf-security.rst
> to actually work, even when kernel.perf_event_paranoid=2 and
> kernel.kptr_restrict=1.
> 
> The series consists of four patches:
> 
>   01: perf: Add capability-related utilities
>     Add utility functions to check capabilities and perf_event_paranoid checks,
>     if libcap-dev[el] is available. (Otherwise, assume no capabilities.)
> 
>   02: perf: Use CAP_SYS_ADMIN with perf_event_paranoid checks
>     Replace the use of euid==0 with a check for CAP_SYS_ADMIN whenever
>     perf_event_paranoid level is verified.
> 
>   03: perf: Use CAP_SYSLOG with kptr_restrict checks
>     Replace the use of uid and euid with a check for CAP_SYSLOG when
>     kptr_restrict is verified (similar to kernel/kallsyms.c and lib/vsprintf.c).
>     Consult perf_event_paranoid when kptr_restrict==0 (see kernel/kallsyms.c).
> 
>   04: perf: Use CAP_SYS_ADMIN instead of euid==0 with ftrace
>     Replace the use of euid==0 with a check for CAP_SYS_ADMIN before mounting
>     debugfs for ftrace.
> 
> I tested this by following Documentation/admin-guide/perf-security.rst
> guidelines and setting sysctls:
> 
>    kernel.perf_event_paranoid=2
>    kernel.kptr_restrict=1
> 
> As an unprivileged user who is in perf_users group (setup via instructions
> above), I executed:
>    perf record -a -- sleep 1
> 
> Without the patch, perf record did not capture any kernel functions.
> With the patch, perf included all kernel functions.
> 
> 
> Changelog:
> v3:  * Fix arm64 compilation (thanks, Alexey and Jiri)

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka


> v2:  * Added a build feature check for libcap-dev[el] as suggested by Arnaldo
> 
> 
> Igor Lubashev (4):
>   perf: Add capability-related utilities
>   perf: Use CAP_SYS_ADMIN with perf_event_paranoid checks
>   perf: Use CAP_SYSLOG with kptr_restrict checks
>   perf: Use CAP_SYS_ADMIN instead of euid==0 with ftrace
> 
>  tools/build/Makefile.feature         |  2 ++
>  tools/build/feature/Makefile         |  4 ++++
>  tools/build/feature/test-libcap.c    | 20 ++++++++++++++++++++
>  tools/perf/Makefile.config           | 11 +++++++++++
>  tools/perf/Makefile.perf             |  2 ++
>  tools/perf/arch/arm/util/cs-etm.c    |  3 ++-
>  tools/perf/arch/arm64/util/arm-spe.c |  3 ++-
>  tools/perf/arch/x86/util/intel-bts.c |  3 ++-
>  tools/perf/arch/x86/util/intel-pt.c  |  2 +-
>  tools/perf/builtin-ftrace.c          |  4 +++-
>  tools/perf/util/Build                |  2 ++
>  tools/perf/util/cap.c                | 29 +++++++++++++++++++++++++++++
>  tools/perf/util/cap.h                | 24 ++++++++++++++++++++++++
>  tools/perf/util/event.h              |  1 +
>  tools/perf/util/evsel.c              |  2 +-
>  tools/perf/util/python-ext-sources   |  1 +
>  tools/perf/util/symbol.c             | 15 +++++++++++----
>  tools/perf/util/util.c               |  9 +++++++++
>  18 files changed, 127 insertions(+), 10 deletions(-)
>  create mode 100644 tools/build/feature/test-libcap.c
>  create mode 100644 tools/perf/util/cap.c
>  create mode 100644 tools/perf/util/cap.h
> 
> -- 
> 2.7.4
> 
