Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A88EC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 07:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C23DF23B6A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 07:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559202633;
	bh=tLT3QfyQSJBEL96GLZK1bnFg7jtZIYiRVXCtx0k4EZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qoff5IEgsmv+4w1fun3MGgszgaYdtXmtsE6cSB0WjC55agbvhXxMRN39ICQ/zDcyd
	 R4SBjryTPiTb32X/DUCI4xRqWKEfhbQgJbOPg/Kkm+fZ8CMqHj5dOMyKdxnR1/Fj04
	 /NrVODBJI6ypGGzbsYM98NQM1WdxFdfyhNXpDdVg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbfE3Huc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 03:50:32 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37267 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfE3Huc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 03:50:32 -0400
Received: by mail-wr1-f65.google.com with SMTP id h1so3485382wro.4;
        Thu, 30 May 2019 00:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MEzJw++sxs4GN+VaAjpQFl7ZJHw7AiJ3SBmZL8iPLAE=;
        b=WJV4BqNCNlDdFsclHIDg3aPsLVOoVSre22PwLZN79gw7Bxo90hgoUfo3NJq6Il9o7U
         Ad5J7lBHm1FhB8C+h8fFT3weHfkklQuFRZ8mZa0Ql4wHNXRluCtZnHl970HS+bkfKfCJ
         ECPlKz5tocrqTPKLGTkqf+DA6AU8twMHP/sfIKRIBdsBpBSp5z5s0LzOf3t08GIN8Krs
         KvL4f+qhKwAIL/CD6WRd+6VWQuXijJ82VpIxGDEPrX0OiUNQ4gqDO0JlTg8mtAkMBMQd
         KNyMzXsJtAoyP0fphu734EWbeKYlxBjaS2jv4RrVIJuouR7ngy8iCvVFDgWS8IsCm4eX
         WgNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=MEzJw++sxs4GN+VaAjpQFl7ZJHw7AiJ3SBmZL8iPLAE=;
        b=B6MhV5fK7ULLHTYOc0A6bV4UhNEHJXVGaFRSuYwdGwNtZLaRv2Cl562UGx9FTdGm6j
         v7PIZE+ZZbbcC1HgHzf0TY7mpEWcM9rVIErYKpB2ymvk+xv++FxI4mPv50WFcrMvpf8Y
         4sVE8ZryqKBLEPed0L5kv08AZqosec3n697h4wwpkkCw3nDmIC2Qh4bCQ+DCq3bh3Dxt
         Izeq8BtlFs+SZTjM4G+ZWzZ7vnFlX7OmEv8kkN/nY8lblDPowpM1YFHpiq/PQnogE+e7
         Ftaogqbie6WnFXOJ5T4g6xn5STmRKOCFBdrfkFO/ruVAD0u7UAcyb1Sk/HfQ9OFzrM3G
         MTAA==
X-Gm-Message-State: APjAAAWg6YusqpcW66wBlua5LN512mtdmQ6VA1K8usHs7D8xExsoypOf
        N4WEu5/gdFoEZ2+l8m8IPZQ=
X-Google-Smtp-Source: APXvYqxOnym7Z6YT0X41HWfvtp2XTY9XdBVQYVGPUvP74eRqEwUnw0WJBt3QOHIUCqRAsUbRSk7Qyw==
X-Received: by 2002:adf:fd09:: with SMTP id e9mr1579983wrr.292.1559202629148;
        Thu, 30 May 2019 00:50:29 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id k185sm7018748wma.3.2019.05.30.00.50.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 May 2019 00:50:28 -0700 (PDT)
Date:   Thu, 30 May 2019 09:50:26 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Donald Yandt <donald.yandt@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL] perf/core improvements and fixes for 5.3
Message-ID: <20190530075026.GA69730@gmail.com>
References: <20190529133605.21118-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529133605.21118-1-acme@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling, 
> 
> Best regards,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual, this time with the
> versions for the clang compilers used accross the various containers, to
> give a further view of the build test coverage for perf, libbpf,
> libtraceevent, etc.
> 
> Test results:
> 
> The following changes since commit 849e96f30068d4f6f8352715e02a10533a46deba:
> 
>   Merge tag 'perf-urgent-for-mingo-5.2-20190528' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent (2019-05-28 23:16:22 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.3-20190529
> 
> for you to fetch changes up to 14f1cfd4f7b4794e2f9d2ae214bcf049654b0b5c:
> 
>   perf intel-pt: Rationalize intel_pt_sync_switch()'s use of next_tid (2019-05-28 18:37:45 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> BPF:
> 
>   Jiri Olsa:
> 
>   - Preserve eBPF maps when loading kcore.
> 
>   - Fix up DSO name padding in 'perf script --call-trace', as BPF DSO names are
>     much larger than what we used to have there.
> 
>   - Add --show-bpf-events to 'perf script'.
> 
> perf trace:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Add string table generators and beautify arguments for the new fspick,
>     fsmount, fsconfig, fsopen, move_mount and open_tree syscalls, as well
>     as new values for arguments of clone and sync_file_range syscalls.
> 
> perf version:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Append 12 git SHA chars to the version string.
> 
> Namespaces:
> 
>   Namhyung Kim:
> 
>   - Add missing --namespaces option to 'perf top', to generate and process
>     namespace events, just like present for 'perf record'.
> 
> Intel PT:
> 
>   Andrian Hunter:
> 
>   - Fix itrace defaults for 'perf script', not using the 'use_browser' variable
>     to figure out what options are better for 'script' and 'report'
> 
>   - Allow root fixing up buildid cache permissions in the perf-with-kcore.sh
>     script when sharing that cache with another user.
> 
>   - Improve sync_switch, a facility used to synchronize decoding of HW
>     traces more closely with the point in the kerne where a context
>     switch took place, by processing the PERF_RECORD_CONTEXT_SWITCH "in"
>     metadata records too.
> 
>   - Make the exported-sql-viewer.py GUI also support pyside2, which
>     upgrades from qt4 used in pyside to qt5. Use the argparser module
>     for more easily addition of new command line args.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Adrian Hunter (11):
>       perf-with-kcore.sh: Always allow fix_buildid_cache_permissions
>       perf intel-pt: Fix itrace defaults for perf script
>       perf auxtrace: Fix itrace defaults for perf script
>       perf intel-pt: Fix itrace defaults for perf script intel-pt documentation
>       perf scripts python: exported-sql-viewer.py: Change python2 to python
>       perf scripts python: exported-sql-viewer.py: Use argparse module for argument parsing
>       perf scripts python: exported-sql-viewer.py: Add support for pyside2
>       perf scripts python: export-to-sqlite.py: Add support for pyside2
>       perf scripts python: export-to-postgresql.py: Add support for pyside2
>       perf intel-pt: Improve sync_switch by processing PERF_RECORD_SWITCH* in events
>       perf intel-pt: Rationalize intel_pt_sync_switch()'s use of next_tid
> 
> Arnaldo Carvalho de Melo (17):
>       perf augmented_raw_syscalls: Fix up comment
>       perf beauty: Add generator for 'move_mount' flags argument
>       perf trace: Beautify 'move_mount' arguments
>       perf beauty: Add generator for fspick's 'flags' arg values
>       perf trace: Beautify 'fspick' arguments
>       perf beauty: Add generator for fsconfig's 'cmd' arg values
>       perf trace: Beautify 'fsconfig' arguments
>       perf beauty: Add generator for fsmount's 'attr_flags' arg values
>       perf trace: Introduce syscall_arg__scnprintf_strarray_flags
>       perf trace: Beautify 'fsmount' arguments
>       perf trace beauty clone: Handle CLONE_PIDFD
>       perf beauty: Add generator for sync_file_range's 'flags' arg values
>       perf trace: Beautify 'sync_file_range' arguments
>       perf version: Append 12 git SHA chars to the version string
>       perf annotate TUI browser: Do not use member from variable within its own initialization
>       perf python: Remove -fstack-protector-strong if clang doesn't have it
>       perf top: Lower message level for failure on synthesizing events for pre-existing BPF programs
> 
> Donald Yandt (1):
>       perf machine: Return NULL instead of null-terminating /proc/version array
> 
> Jiri Olsa (10):
>       perf machine: Keep zero in pgoff BPF map
>       perf tools: Preserve eBPF maps when loading kcore
>       perf dso: Separate generic code in dso__data_file_size()
>       perf dso: Separate generic code in dso_cache__read
>       perf dso: Simplify dso_cache__read function
>       perf dso: Add BPF DSO read and size hooks
>       perf script: Pad DSO name for --call-trace
>       perf tests: Add map_groups__merge_in test
>       perf script: Add --show-bpf-events to show eBPF related events
>       perf script: Remove superfluous BPF event titles
> 
> Namhyung Kim (2):
>       perf top: Add --namespaces option
>       perf tools: Remove const from thread read accessors
> 
>  tools/include/linux/kernel.h                      |   1 +
>  tools/lib/vsprintf.c                              |  19 ++++
>  tools/perf/Documentation/intel-pt.txt             |  10 +-
>  tools/perf/Documentation/perf-script.txt          |   3 +
>  tools/perf/Documentation/perf-top.txt             |   5 +
>  tools/perf/Makefile.perf                          |  44 +++++++-
>  tools/perf/builtin-script.c                       |  43 ++++++++
>  tools/perf/builtin-top.c                          |   7 +-
>  tools/perf/builtin-trace.c                        |  35 ++++++
>  tools/perf/examples/bpf/augmented_raw_syscalls.c  |  15 ++-
>  tools/perf/perf-with-kcore.sh                     |   5 -
>  tools/perf/scripts/python/export-to-postgresql.py |  43 ++++++--
>  tools/perf/scripts/python/export-to-sqlite.py     |  44 ++++++--
>  tools/perf/scripts/python/exported-sql-viewer.py  |  51 ++++++---
>  tools/perf/tests/Build                            |   1 +
>  tools/perf/tests/builtin-test.c                   |   4 +
>  tools/perf/tests/map_groups.c                     | 120 +++++++++++++++++++++
>  tools/perf/tests/tests.h                          |   1 +
>  tools/perf/trace/beauty/Build                     |   4 +
>  tools/perf/trace/beauty/beauty.h                  |  15 +++
>  tools/perf/trace/beauty/clone.c                   |   1 +
>  tools/perf/trace/beauty/fsconfig.sh               |  17 +++
>  tools/perf/trace/beauty/fsmount.c                 |  34 ++++++
>  tools/perf/trace/beauty/fsmount.sh                |  22 ++++
>  tools/perf/trace/beauty/fspick.c                  |  24 +++++
>  tools/perf/trace/beauty/fspick.sh                 |  17 +++
>  tools/perf/trace/beauty/move_mount.c              |  24 +++++
>  tools/perf/trace/beauty/move_mount_flags.sh       |  17 +++
>  tools/perf/trace/beauty/sync_file_range.c         |  31 ++++++
>  tools/perf/trace/beauty/sync_file_range.sh        |  17 +++
>  tools/perf/ui/browsers/annotate.c                 |   5 +-
>  tools/perf/util/PERF-VERSION-GEN                  |   2 +-
>  tools/perf/util/auxtrace.c                        |   3 +-
>  tools/perf/util/dso.c                             | 125 +++++++++++++++-------
>  tools/perf/util/event.c                           |   4 +-
>  tools/perf/util/hist.c                            |   2 +-
>  tools/perf/util/intel-pt.c                        |  47 +++++++-
>  tools/perf/util/machine.c                         |   8 +-
>  tools/perf/util/map.c                             |   6 ++
>  tools/perf/util/map_groups.h                      |   2 +
>  tools/perf/util/setup.py                          |   2 +
>  tools/perf/util/symbol.c                          |  97 ++++++++++++++++-
>  tools/perf/util/symbol_conf.h                     |   1 +
>  tools/perf/util/thread.c                          |  12 +--
>  tools/perf/util/thread.h                          |   4 +-
>  45 files changed, 888 insertions(+), 106 deletions(-)
>  create mode 100644 tools/perf/tests/map_groups.c
>  create mode 100755 tools/perf/trace/beauty/fsconfig.sh
>  create mode 100644 tools/perf/trace/beauty/fsmount.c
>  create mode 100755 tools/perf/trace/beauty/fsmount.sh
>  create mode 100644 tools/perf/trace/beauty/fspick.c
>  create mode 100755 tools/perf/trace/beauty/fspick.sh
>  create mode 100644 tools/perf/trace/beauty/move_mount.c
>  create mode 100755 tools/perf/trace/beauty/move_mount_flags.sh
>  create mode 100644 tools/perf/trace/beauty/sync_file_range.c
>  create mode 100755 tools/perf/trace/beauty/sync_file_range.sh

Pulled, thanks a lot Arnaldo!

	Ingo
