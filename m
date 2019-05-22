Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B702AC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 16:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87BC620881
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 16:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYdFHYA6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730078AbfEVQSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 12:18:09 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40154 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728638AbfEVQSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 12:18:09 -0400
Received: by mail-qt1-f195.google.com with SMTP id k24so3052240qtq.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 09:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5r7mLmVPPFth7+eFY2KMboXUyB4CUWweOyXet2cfWe4=;
        b=cYdFHYA6ZmDy3NyhaNuQHlrkznEl6zfI8Dbsat13Gzl9D3jtlfi24dHhV/WOsEipDL
         wdgBbDTp0RzSS5LDoYElAYL0jbCyegxLbVMOU1+DULveAoIRgbR+IKqKPHjijSUzyiWA
         srhG26ZiE3H2xZZJw36Q8Yc6M+mFY+gKvoICqqEHNSRrFSJTsuxeAX5d+y4NGyZcbIqk
         f7EfNFdHHAr+I16sg9i96AmOtPDDVk+A0dJi4GpM8cYP9Yj328X3ClKz/7f7KgIvaof9
         pQE0Ns++Q/6tkZoAdvnyaT9r7L7E+G+9WNYBtPrRTpEwGobWGtNIMcbUrcxYIGB1O8fM
         tr1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5r7mLmVPPFth7+eFY2KMboXUyB4CUWweOyXet2cfWe4=;
        b=rmORat7/v2TloNF1ovWFMx3VRP1x7t3HARqMrz0+6mGudqeKBrrIUvO7XD4EqYr+NB
         8yx5A5gA3t2KuRqUm4so3LgnlhrL8tXyfg8BRWV+1I5BKbkOAclayXuypT3s56pDJDGz
         OR8dhq09scmeTsRVEg6XLETACPWp9VQokJBaOmv1so94s8hxtdV+c0QmmglB5l6hzcc0
         4g5UE5+UAgpdlVLciWmoD75lc+swn/kgxkULXuoFiIlqcluDN5qYAQ/RDXP7g0iTBM9i
         U8ZAEOOQi9N2I2VBgD3Wek0Bk/VNFEeMoKA+noXVG/41YDK8MZvs+DkUbqVhIpOz2bp7
         NoSw==
X-Gm-Message-State: APjAAAVX/7b5yvZ8PDvaaBe5SrsOn+Zf1KvuGhVNbOV6xBHCA7rVW+6R
        KpJRVxFZ/XnEeQ5ZZvJmFwg=
X-Google-Smtp-Source: APXvYqx3fKK1ZuJrxrTlErf9zwvscxj0S/FxpVUynR4w1WDQ+OiGBJxjbSOzR6p1EimiYuRLvDOOhg==
X-Received: by 2002:a0c:f40a:: with SMTP id h10mr5489019qvl.180.1558541888085;
        Wed, 22 May 2019 09:18:08 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([187.65.94.38])
        by smtp.gmail.com with ESMTPSA id w48sm3515487qtb.91.2019.05.22.09.18.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 22 May 2019 09:18:06 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 49837404A1; Wed, 22 May 2019 13:18:04 -0300 (-03)
Date:   Wed, 22 May 2019 13:18:04 -0300
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Song Liu <songliubraving@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: Re: [PATCH 12/12] perf script: Add --show-all-events option
Message-ID: <20190522161804.GG30271@kernel.org>
References: <20190508132010.14512-1-jolsa@kernel.org>
 <20190508132010.14512-13-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190508132010.14512-13-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, May 08, 2019 at 03:20:10PM +0200, Jiri Olsa escreveu:
> Adding --show-all-events option to show all
> side-bad events with single option, like:
> 
>   $ perf script --show-all-events
>   swapper     0 [000]     0.000000: PERF_RECORD_MMAP -1/0: [0xffffffffa6000000(0xc00e41) @ 0xffffffffa6000000]: x [kernel.kallsyms]_text
>   ...
>   swapper     0 [000]     0.000000: PERF_RECORD_KSYMBOL addr ffffffffc01bc362 len 229 type 1 flags 0x0 name bpf_prog_7be49e3934a125ba
>   swapper     0 [000]     0.000000: PERF_RECORD_BPF_EVENT type 1, flags 0, id 29
>   ...
>   swapper     0 [000]     0.000000: PERF_RECORD_FORK(1:1):(0:0)
>   systemd     0 [000]     0.000000: PERF_RECORD_COMM: systemd:1/1
>   ...
>   swapper     0 [000] 63587.039518:          1 cycles:  ffffffffa60698b4 [unknown] ([kernel.kallsyms])
>   swapper     0 [000] 63587.039522:          1 cycles:  ffffffffa60698b4 [unknown] ([kernel.kallsyms])

Strange:

[root@quaco pt]# 
[root@quaco pt]# perf evlist -v
intel_pt//ku: type: 8, size: 112, config: 0x300e601, { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|CPU|IDENTIFIER, read_format: ID, disabled: 1, inherit: 1, exclude_hv: 1, sample_id_all: 1
dummy:u: type: 1, size: 112, config: 0x9, { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|CPU|IDENTIFIER, read_format: ID, inherit: 1, exclude_kernel: 1, exclude_hv: 1, mmap: 1, comm: 1, task: 1, sample_id_all: 1, mmap2: 1, comm_exec: 1, context_switch: 1, ksymbol: 1, bpf_event: 1
[root@quaco pt]# 

Then:

[root@quaco pt]# perf script --show-bpf-events  | head
    0 PERF_RECORD_KSYMBOL addr ffffffffc029a6c3 len 229 type 1 flags 0x0 name bpf_prog_7be49e3934a125ba
    0 PERF_RECORD_BPF_EVENT type 1, flags 0, id 47
    0 PERF_RECORD_KSYMBOL addr ffffffffc029c1ae len 229 type 1 flags 0x0 name bpf_prog_2a142ef67aaad174
    0 PERF_RECORD_BPF_EVENT type 1, flags 0, id 48
    0 PERF_RECORD_KSYMBOL addr ffffffffc02ddd1c len 229 type 1 flags 0x0 name bpf_prog_7be49e3934a125ba
    0 PERF_RECORD_BPF_EVENT type 1, flags 0, id 49
    0 PERF_RECORD_KSYMBOL addr ffffffffc02dfc11 len 229 type 1 flags 0x0 name bpf_prog_2a142ef67aaad174
    0 PERF_RECORD_BPF_EVENT type 1, flags 0, id 50
    0 PERF_RECORD_KSYMBOL addr ffffffffc045da0a len 229 type 1 flags 0x0 name bpf_prog_7be49e3934a125ba
    0 PERF_RECORD_BPF_EVENT type 1, flags 0, id 51
[root@quaco pt]#

But:

[root@quaco pt]# perf script --show-all-events  | head
Intel Processor Trace requires ordered events
0x2a0 [0x60]: failed to process type: 1 [Invalid argument]
[root@quaco pt]#

So I have all patches but this last one, will test and push Ingo's way
so that we make progress, we can get this one later after we figure this
out.

- Arnaldo
