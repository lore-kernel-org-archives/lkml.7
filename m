Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24518C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 14:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F383D207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 14:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732658AbfIWORn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 10:17:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52899 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730669AbfIWORm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 10:17:42 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9032A356C9;
        Mon, 23 Sep 2019 14:17:42 +0000 (UTC)
Received: from sandy.ghostprotocols.net (ovpn-112-16.phx2.redhat.com [10.3.112.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5A92B60852;
        Mon, 23 Sep 2019 14:17:41 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id 2170011DF; Mon, 23 Sep 2019 11:17:38 -0300 (BRT)
Date:   Mon, 23 Sep 2019 11:17:38 -0300
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     Stephane Eranian <eranian@google.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@elte.hu,
        jolsa@redhat.com, namhyung@kernel.org
Subject: Re: [PATCH v2] perf record: fix priv level with branch sampling for
 paranoid=2
Message-ID: <20190923141738.GB3617@redhat.com>
References: <20190920230356.41420-1-eranian@google.com>
 <20190923140345.GA3617@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923140345.GA3617@redhat.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Mon, 23 Sep 2019 14:17:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Sep 23, 2019 at 11:03:45AM -0300, Arnaldo Carvalho de Melo escreveu:
> Thanks, tested added Jiri's Acked-by, applied, added this note:
> 
> Committer testing:
> 
> After aplying the patch we get:
> 
>   [acme@quaco ~]$ perf record -b -e cycles date
>   WARNING: Kernel address maps (/proc/{kallsyms,modules}) are restricted,
>   check /proc/sys/kernel/kptr_restrict and /proc/sys/kernel/perf_event_paranoid.
> 
>   Samples in kernel functions may not be resolved if a suitable vmlinux
>   file is not found in the buildid cache or in the vmlinux path.
> 
>   Samples in kernel modules won't be resolved at all.
> 
>   If some relocation was applied (e.g. kexec) symbols may be misresolved
>   even with a suitable vmlinux or kallsyms file.
> 
>   Mon 23 Sep 2019 11:00:59 AM -03
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.005 MB perf.data (14 samples) ]
>   [acme@quaco ~]$ perf evlist -v
>   cycles:u: size: 112, { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|PERIOD|BRANCH_STACK, read_format: ID, disabled: 1, inherit: 1, exclude_kernel: 1, exclude_hv: 1, mmap: 1, comm: 1, freq: 1, enable_on_exec: 1, task: 1, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1, ksymbol: 1, bpf_event: 1, branch_sample_type: ANY
>   [acme@quaco ~]$
> 
> That warning about restricted kernel maps will be suppressed in a follow
> up patch, as perf_event_attr.exclude_kernel is set, i.e. no samples for
> the kernel will be taken and thus no need for those maps

Its there:

https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/commit/?h=perf/core&id=c8b567c8a96a35acff746b1eef6f859e2a9fc195

- Arnaldo
