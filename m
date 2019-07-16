Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A544C76192
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 10:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 750ED2053B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 10:51:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387475AbfGPKvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 06:51:14 -0400
Received: from mga07.intel.com ([134.134.136.100]:16635 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728235AbfGPKvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 06:51:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jul 2019 03:51:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,498,1557212400"; 
   d="scan'208";a="190875560"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 16 Jul 2019 03:51:11 -0700
Received: from [10.125.253.40] (abudanko-mobl.ccr.corp.intel.com [10.125.253.40])
        by linux.intel.com (Postfix) with ESMTP id C29B15802AF;
        Tue, 16 Jul 2019 03:51:07 -0700 (PDT)
Subject: Re: [PATCH 0/3] perf: Use capabilities instead of uid and euid
To:     Igor Lubashev <ilubashe@akamai.com>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        James Morris <jmorris@namei.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <1562112605-6235-1-git-send-email-ilubashe@akamai.com>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <cf6398f2-8862-9062-8765-80f930c019e2@linux.intel.com>
Date:   Tue, 16 Jul 2019 13:51:06 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1562112605-6235-1-git-send-email-ilubashe@akamai.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.07.2019 3:10, Igor Lubashev wrote:
> Kernel is using capabilities instead of uid and euid to restrict access to
> kernel pointers and tracing facilities.  This patch series updates the perf to
> better match the security model used by the kernel.
> 
> This series enables instructions in Documentation/admin-guide/perf-security.rst
> to actually work, even when kernel.perf_event_paranoid=2 and
> kernel.kptr_restrict=1.
> 
> The series consists of three patches:
> 
>   01: perf: Add capability-related utilities
>     Add utility functions to check capabilities and perf_event_paranoid checks.
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
> I tested this by following Documentation/admin-guide/perf-security.rst
> guidelines and setting sysctls:
> 
>    kernel.perf_event_paranoid=2
>    kernel.kptr_restrict=1
> 
> As an unpriviledged user who is in perf_users group (setup via instructions
> above), I executed:
>    perf record -a -- sleep 1
> 
> Without the patch, perf record did not capture any kernel functions.
> With the patch, perf included all kernel funcitons.

Acked-by: Alexey Budankov <alexey.budankov@linux.intel.com>

Valuable contribution, thanks! And I see the continuation of the effort started 
in this patch set. Some dedicated CAP_SYS_PERFMON capability could be introduced 
and used for performance monitoring related security checks, as in the kernel as 
in the user mode, because CAP_SYS_ADMIN grants much wider credentials that are 
required, at least for Perf related monitoring and, yet more, CAP_SYS_ADMIN could 
be unloaded addressing the concerns here [1]:

 CAP_SYS_ADMIN
       	   Note: this capability is overloaded; see Notes to kernel developers, below.
 ...
 Notes to kernel developers:
	   When adding a new kernel feature that should be governed by a
	   capability, consider the following points.
	   *  The goal of capabilities is divide the power of superuser into
	       pieces, such that if a program that has one or more capabilities
	       is compromised, its power to do damage to the system would be less
	       than the same program running with root privilege.
	   *  You have the choice of either creating a new capability for your
	       new feature, or associating the feature with one of the existing
	       capabilities.  In order to keep the set of capabilities to a
	       manageable size, the latter option is preferable, unless there are
	       compelling reasons to take the former option.  (There is also a
	       technical limit: the size of capability sets is currently limited
	       to 64 bits.)
	       . . .
	    * Don't choose CAP_SYS_ADMIN if you can possibly avoid it!  A vast
	       proportion of existing capability checks are associated with this
	       capability (see the partial list above).  It can plausibly be
	       called "the new root", since on the one hand, it confers a wide
	       range of powers, and on the other hand, its broad scope means that
	       this is the capability that is required by many privileged
	       programs.  Don't make the problem worse.  The only new features
	       that should be associated with CAP_SYS_ADMIN are ones that closely
	       match existing uses in that silo.
	    * If you have determined that it really is necessary to create a new
	       capability for your feature, don't make or name it as a "single-
	       use" capability.  Thus, for example, the addition of the highly
	       specific CAP_SYS_PACCT was probably a mistake.  Instead, try to
	       identify and name your new capability as a broader silo into which
           other related future use cases might fit.”

Regards,
Alexey

[1] http://man7.org/linux/man-pages/man7/capabilities.7.html

> 
> Igor Lubashev (3):
>   perf: Add capability-related utilities
>   perf: Use CAP_SYS_ADMIN with perf_event_paranoid checks
>   perf: Use CAP_SYSLOG with kptr_restrict checks
> 
>  tools/perf/Makefile.config           |  2 +-
>  tools/perf/arch/arm/util/cs-etm.c    |  3 ++-
>  tools/perf/arch/arm64/util/arm-spe.c |  3 ++-
>  tools/perf/arch/x86/util/intel-bts.c |  3 ++-
>  tools/perf/arch/x86/util/intel-pt.c  |  2 +-
>  tools/perf/util/Build                |  1 +
>  tools/perf/util/cap.c                | 24 ++++++++++++++++++++++++
>  tools/perf/util/cap.h                | 10 ++++++++++
>  tools/perf/util/event.h              |  1 +
>  tools/perf/util/evsel.c              |  2 +-
>  tools/perf/util/python-ext-sources   |  1 +
>  tools/perf/util/symbol.c             | 15 +++++++++++----
>  tools/perf/util/util.c               |  9 +++++++++
>  13 files changed, 66 insertions(+), 10 deletions(-)
>  create mode 100644 tools/perf/util/cap.c
>  create mode 100644 tools/perf/util/cap.h
> 
