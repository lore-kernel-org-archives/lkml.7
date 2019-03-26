Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F7EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 20:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8350020823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 20:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQ50Vj5y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732642AbfCZUec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 16:34:32 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35295 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731617AbfCZUeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 16:34:31 -0400
Received: by mail-pg1-f193.google.com with SMTP id g8so8819377pgf.2;
        Tue, 26 Mar 2019 13:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=77QbSwwpZwxT2nAljwXCx6lYbZ5cGL1YooiRmXK1O5M=;
        b=GQ50Vj5yK0QDlmVkzRZF9PWUpv/jUCniRoeOVJWbQ/raDDf9z4F3Xxy+XIu3Z/X/Dy
         iwGWawkxPOLKBzh+r4TO8MrS0oSjsWSPtVGIRKqEnDQWDUzg/zuCuQpt98Gnib/3XYYa
         At/4JFv7VuZiukwaGEqb0Gu7EsCimxI3NR2hBSidBBLjdyhz/WM1MGlAfLEwZ7Fr4NNT
         hSRkNxiRIRM4769ojKWNqMDIKLQEROWqCcbfWB0zWgtqXu8l5ib24/okd+We32ixG2ik
         1jBMqzVF/MxZAOXLM8MM9kxsFS1QReWT4n85QMZTvK1U768uvPWJLq/CE9a4MQTwZksG
         mOFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=77QbSwwpZwxT2nAljwXCx6lYbZ5cGL1YooiRmXK1O5M=;
        b=f2xzs4H/mL2ECdgq56OVmHl3wQzIWnGGmUQIz/E53GhQ+dCC4IDIG1SfbmGY8NcGwc
         TRZ6TB9dehWctfnKJbfCOmTaLv+UgXkCEv89GrtP7hD+oQC9PO5U4YxyKVJDWbfOCo0Q
         y6uteH0HhamSM0vzg647evzlXrZTtpfsWe/24crrKXeA+EvEl5EpmRU8PsV3XvUM3/eX
         f8FhYzXfXnwdyLsPIm1f6S8xTNPddhl0lILw4dUFiyC0q3oEOqAKUl0kVPcvsTnqK9I6
         Wpy2AKIUdFiLC2kXFCZKYV6UP/5ehHzVa2WknWGFGn9c8qgU0Rlrc3e9LoEj/ozU1QqO
         x+6w==
X-Gm-Message-State: APjAAAUAn1vhT3r0bquEpIXZAq8SGEeP/uTLhhsHtT+6TJ/FSCMXX4i5
        ZYZn1p6dXQxTUi//HItCN68=
X-Google-Smtp-Source: APXvYqxpzBJScqj2FhU5BX5WvztKps+bdB9ML/VQWPkALH+ao6H1qeTAlJkIIwl63AowYMupQskTMw==
X-Received: by 2002:a65:4bce:: with SMTP id p14mr31290225pgr.68.1553632470482;
        Tue, 26 Mar 2019 13:34:30 -0700 (PDT)
Received: from ast-mbp ([2620:10d:c090:200::1:f1fc])
        by smtp.gmail.com with ESMTPSA id e184sm30761964pfc.143.2019.03.26.13.34.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 13:34:29 -0700 (PDT)
Date:   Tue, 26 Mar 2019 13:34:28 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrey Ignatov <rdna@fb.com>
Cc:     netdev@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        guro@fb.com, kernel-team@fb.com,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 bpf-next 00/21] bpf: Sysctl hook
Message-ID: <20190326203426.5qni5nnbeyr5rf52@ast-mbp>
References: <cover.1553560620.git.rdna@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1553560620.git.rdna@fb.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 05:43:26PM -0700, Andrey Ignatov wrote:
> v1->v2:
> - add fs/proc/proc_sysctl.c mainteners to Cc:.

Kees, Luis,
any concerns with bpf hook in sysctl ?
Pls take a look at patch 2 where it touches fs/proc/proc_sysctl.c
This facility is for root to monitor dumb root tasks.
More detailed description below and in patches.

> The patch set introduces new BPF hook for sysctl.
> 
> It adds new program type BPF_PROG_TYPE_CGROUP_SYSCTL and attach type
> BPF_CGROUP_SYSCTL.
> 
> BPF_CGROUP_SYSCTL hook is placed before calling to sysctl's proc_handler so
> that accesses (read/write) to sysctl can be controlled for specific cgroup
> and either allowed or denied, or traced.
> 
> The hook has access to sysctl name, current sysctl value and (on write
> only) to new sysctl value via corresponding helpers. New sysctl value can
> be overridden by program. Both name and values (current/new) are
> represented as strings same way they're visible in /proc/sys/. It is up to
> program to parse these strings.
> 
> To help with parsing the most common kind of sysctl value, vector of
> integers, two new helpers are provided: bpf_strtol and bpf_strtoul with
> semantic similar to user space strtol(3) and strtoul(3).
> 
> The hook also provides bpf_sysctl context with two fields:
> * @write indicates whether sysctl is being read (= 0) or written (= 1);
> * @file_pos is sysctl file position to read from or write to, can be
>   overridden.
> 
> The hook allows to make better isolation for containerized applications
> that are run as root so that one container can't change a sysctl and affect
> all other containers on a host, make changes to allowed sysctl in a safer
> way and simplify sysctl tracing for cgroups.
> 
> Patch 1 is preliminary refactoring.
> Patch 2 adds new program and attach types.
> Patches 3-5 implement helpers to access sysctl name and value.
> Patch 6 adds file_pos field to bpf_sysctl context.
> Patch 7 updates UAPI in tools.
> Patches 8-9 add support for the new hook to libbpf and corresponding test.
> Patches 10-14 add selftests for the new hook.
> Patch 15 adds support for new arg types to verifier: pointer to integer.
> Patch 16 adds bpf_strto{l,ul} helpers to parse integers from sysctl value.
> Patch 17 updates UAPI in tools.
> Patch 18 updates bpf_helpers.h.
> Patch 19 adds selftests for pointer to integer in verifier.
> Patches 20-21 add selftests for bpf_strto{l,ul}, including integration
>               C based test for sysctl value parsing.
> 
> 
> Andrey Ignatov (21):
>   bpf: Add base proto function for cgroup-bpf programs
>   bpf: Sysctl hook
>   bpf: Introduce bpf_sysctl_get_name helper
>   bpf: Introduce bpf_sysctl_get_current_value helper
>   bpf: Introduce bpf_sysctl_{get,set}_new_value helpers
>   bpf: Add file_pos field to bpf_sysctl ctx
>   bpf: Sync bpf.h to tools/
>   libbpf: Support sysctl hook
>   selftests/bpf: Test sysctl section name
>   selftests/bpf: Test BPF_CGROUP_SYSCTL
>   selftests/bpf: Test bpf_sysctl_get_name helper
>   selftests/bpf: Test sysctl_get_current_value helper
>   selftests/bpf: Test bpf_sysctl_{get,set}_new_value helpers
>   selftests/bpf: Test file_pos field in bpf_sysctl ctx
>   bpf: Introduce ARG_PTR_TO_{INT,LONG} arg types
>   bpf: Introduce bpf_strtol and bpf_strtoul helpers
>   bpf: Sync bpf.h to tools/
>   selftests/bpf: Add sysctl and strtoX helpers to bpf_helpers.h
>   selftests/bpf: Test ARG_PTR_TO_LONG arg type
>   selftests/bpf: Test bpf_strtol and bpf_strtoul helpers
>   selftests/bpf: C based test for sysctl and strtoX
> 
>  fs/proc/proc_sysctl.c                         |   25 +-
>  include/linux/bpf-cgroup.h                    |   21 +
>  include/linux/bpf.h                           |    4 +
>  include/linux/bpf_types.h                     |    1 +
>  include/linux/filter.h                        |   16 +
>  include/uapi/linux/bpf.h                      |  139 +-
>  kernel/bpf/cgroup.c                           |  364 +++-
>  kernel/bpf/helpers.c                          |  131 ++
>  kernel/bpf/syscall.c                          |    7 +
>  kernel/bpf/verifier.c                         |   30 +
>  tools/include/uapi/linux/bpf.h                |  139 +-
>  tools/lib/bpf/libbpf.c                        |    3 +
>  tools/lib/bpf/libbpf_probes.c                 |    1 +
>  tools/testing/selftests/bpf/Makefile          |    3 +-
>  tools/testing/selftests/bpf/bpf_helpers.h     |   19 +
>  .../selftests/bpf/progs/test_sysctl_prog.c    |   89 +
>  .../selftests/bpf/test_section_names.c        |    5 +
>  tools/testing/selftests/bpf/test_sysctl.c     | 1567 +++++++++++++++++
>  .../testing/selftests/bpf/verifier/int_ptr.c  |  160 ++
>  19 files changed, 2716 insertions(+), 8 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/test_sysctl_prog.c
>  create mode 100644 tools/testing/selftests/bpf/test_sysctl.c
>  create mode 100644 tools/testing/selftests/bpf/verifier/int_ptr.c
> 
> -- 
> 2.17.1
> 
