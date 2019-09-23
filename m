Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33152C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 14:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0399720867
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 14:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730698AbfIWODv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 10:03:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56532 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728571AbfIWODu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 10:03:50 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E138D20FF;
        Mon, 23 Sep 2019 14:03:49 +0000 (UTC)
Received: from sandy.ghostprotocols.net (ovpn-112-16.phx2.redhat.com [10.3.112.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 70E545D717;
        Mon, 23 Sep 2019 14:03:49 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id CDAF511DF; Mon, 23 Sep 2019 11:03:45 -0300 (BRT)
Date:   Mon, 23 Sep 2019 11:03:45 -0300
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     Stephane Eranian <eranian@google.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@elte.hu,
        jolsa@redhat.com, namhyung@kernel.org
Subject: Re: [PATCH v2] perf record: fix priv level with branch sampling for
 paranoid=2
Message-ID: <20190923140345.GA3617@redhat.com>
References: <20190920230356.41420-1-eranian@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190920230356.41420-1-eranian@google.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.71]); Mon, 23 Sep 2019 14:03:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Sep 20, 2019 at 04:03:56PM -0700, Stephane Eranian escreveu:
> Now that the default perf_events paranoid level is set to 2, a regular user
> cannot monitor kernel level activity anymore. As such, with the following
> cmdline:
> 
> $ perf record -e cycles date
> 
> The perf tool first tries cycles:uk but then falls back to cycles:u
> as can be seen in the perf report --header-only output:
> 
>   cmdline : /export/hda3/tmp/perf.tip record -e cycles ls
>   event : name = cycles:u, , id = { 436186, ... }
> 
> This is okay as long as there is way to learn the priv level was changed
> internally by the tool.
> 
> But consider a similar example:
> 
> $ perf record -b -e cycles date
> Error:
> You may not have permission to collect stats.
> 
> Consider tweaking /proc/sys/kernel/perf_event_paranoid,
> which controls use of the performance events system by
> unprivileged users (without CAP_SYS_ADMIN).
> ...
> 
> Why is that treated differently given that the branch sampling inherits the
> priv level of the first event in this case, i.e., cycles:u? It turns out
> that the branch sampling code is more picky and also checks exclude_hv.
> 
> In the fallback path, perf record is setting exclude_kernel = 1, but it
> does not change exclude_hv. This does not seem to match the restriction
> imposed by paranoid = 2.
> 
> This patch fixes the problem by forcing exclude_hv = 1 in the fallback
> for paranoid=2. With this in place:
> 
> $ perf record -b -e cycles date
>   cmdline : /export/hda3/tmp/perf.tip record -b -e cycles ls
>   event : name = cycles:u, , id = { 436847, ... }
> 
> And the command succeeds as expected.
> 
> V2 fix a white space.

Thanks, tested added Jiri's Acked-by, applied, added this note:

Committer testing:

After aplying the patch we get:

  [acme@quaco ~]$ perf record -b -e cycles date
  WARNING: Kernel address maps (/proc/{kallsyms,modules}) are restricted,
  check /proc/sys/kernel/kptr_restrict and /proc/sys/kernel/perf_event_paranoid.

  Samples in kernel functions may not be resolved if a suitable vmlinux
  file is not found in the buildid cache or in the vmlinux path.

  Samples in kernel modules won't be resolved at all.

  If some relocation was applied (e.g. kexec) symbols may be misresolved
  even with a suitable vmlinux or kallsyms file.

  Mon 23 Sep 2019 11:00:59 AM -03
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.005 MB perf.data (14 samples) ]
  [acme@quaco ~]$ perf evlist -v
  cycles:u: size: 112, { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|PERIOD|BRANCH_STACK, read_format: ID, disabled: 1, inherit: 1, exclude_kernel: 1, exclude_hv: 1, mmap: 1, comm: 1, freq: 1, enable_on_exec: 1, task: 1, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1, ksymbol: 1, bpf_event: 1, branch_sample_type: ANY
  [acme@quaco ~]$

That warning about restricted kernel maps will be suppressed in a follow
up patch, as perf_event_attr.exclude_kernel is set, i.e. no samples for
the kernel will be taken and thus no need for those maps
