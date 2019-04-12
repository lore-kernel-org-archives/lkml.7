Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3ED8C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 16:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E6F92077C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 16:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555086794;
	bh=2wx1+apMTnRGNuKD3tgm7r3k9DmHxlxFVgoHd8EHAyI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UTxUtSLQxMyU1iqSwpRl8mNHjDuPclTKZrGKAmpHFM/gozxE6QvVl4wgR527ETRsX
	 DFptqW0GcYXeqtqy6WDtQvUxqoq2KHqQzBEyMe4fUBzRKT3AkmMeQkKQluxW9eXTHM
	 bVgxpG3QJpUsu2vbCSHAvShMGaOs2cQFmJkI3oWo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbfDLQdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 12:33:13 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33270 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726624AbfDLQdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 12:33:12 -0400
Received: by mail-wr1-f66.google.com with SMTP id q1so12792404wrp.0;
        Fri, 12 Apr 2019 09:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XJNmKEBdfFUrL/nt29mqK6iM2F19WOZZ9h0QmQ3PoWM=;
        b=tGMSxm6QH4GQ87ZhNACwiou+IQJr747bozJpiyVVOTJhAx3gNRhijHV4vcp5qE9mwY
         ENpFs6O503uJCnbk72Wxn5z9AoFugXm395dpymLkh0gPejpyU1gLxBpp7GXFNfqgYH/v
         a+KxcfdM6upCUUPiSvWulwlblTP6+SJRNXcn2q4brHcVmysmzqjDA3nY/hWLEKBvaySU
         O+WmcKFTqTHSsi5bIW0qkRaRSiL56X+rDXrDCs7dtY+pWpoqj/K3P4EoTLXLUVGCUHLM
         JdDRMM+G/ScHeNsJebN9Eboxv4lUQi3jckGAlwB/lTeGV9VjAOlFu8d4jWgQvoIYih+N
         1MpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=XJNmKEBdfFUrL/nt29mqK6iM2F19WOZZ9h0QmQ3PoWM=;
        b=aSSmwP4KVWC3tPJwCKrezUeml7HiRohkc9YSVOsaJbePncjN8wK3FtQ0sCiMajZGZu
         yW7f8i782+hMfcB5xIDPYBcnTLB4rkZlp+lyJ9JUyAziTBiNFze0JrO7Pkl1u1hvw74r
         zSmEXz++G9p4Fw9hJvBNz01fRlL1Pn+ssKFoYoVtwl2+y+ZYv4o7m+570nyJzA9rx0o6
         Rdh4MoT3fg1qo0+tym7ZxzDD5a0xKWwOu4vXF8mvjoAcVMAR4heKwod5PywlBtkCFASn
         b41r/zCGe0b16Z1y9siV1/s466ZbbbV4GgB8XXLp0cSw7XG/CPZVTcCkHJyH3Dg92zZ2
         cTCg==
X-Gm-Message-State: APjAAAUMwz2Bu8wYRDkZdgeTPq9WD/7AAENsyBNxGOLT3NUAtuEJZFtq
        mne+ImrrxQnvaFiv8xcGiIY=
X-Google-Smtp-Source: APXvYqwfocOryRYn8gfuTIufwn1WMACLHBycK/ptJ7zgc+t1AC/5Tud2y6kkS/JlQMBr6g7o6qV7rg==
X-Received: by 2002:adf:dd0f:: with SMTP id a15mr423993wrm.221.1555086790776;
        Fri, 12 Apr 2019 09:33:10 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id o17sm50753401wrw.73.2019.04.12.09.33.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 09:33:09 -0700 (PDT)
Date:   Fri, 12 Apr 2019 18:33:07 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Mao Han <han_mao@c-sky.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL 0/7] perf/urgent fixes
Message-ID: <20190412163307.GB123006@gmail.com>
References: <20190412142946.21966-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190412142946.21966-1-acme@kernel.org>
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
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit 6d3edaae16c6c7d238360f2841212c2b26774d5e:
> 
>   x86/perf/amd: Resolve NMI latency issues for active PMCs (2019-04-03 11:40:32 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-5.1-20190412
> 
> for you to fetch changes up to 21e6dfe04861c2c1b529f2759850bc62a80ca050:
> 
>   perf evsel: Use hweight64() instead of hweight_long(attr.sample_regs_user) (2019-04-10 10:25:28 -0300)
> 
> ----------------------------------------------------------------
> perf/urgent fixes:
> 
> core:
> 
>   Mao Han:
> 
>   - Use hweight64() instead of hweight_long(attr.sample_regs_user) when parsing
>     samples, this is what the kernel uses and fixes de problem in 32-bit
>     architectures such as C-SKY that have more than 32 registers that can come
>     in a sample.
> 
> perf stat:
> 
>   Jiri Olsa:
> 
>   - Disable DIR_FORMAT feature for 'perf stat record', fixing an assert()
>     failure.
> 
> Intel PT:
> 
>   Adrian Hunter:
> 
>   - Fix use of parent_id in calls_view in export-to-sqlite.py.
> 
> BPF:
> 
>   Gustavo A. R. Silva:
> 
>   - Fix lock/unlock imbalances when processing BPF/BTF info, found by the
>     coverity tool.
> 
> libtraceevent:
> 
>   Rikard Falkeborn:
> 
>   - Fix missing equality check for strcmp(), detected by the cppcheck tool.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Adrian Hunter (1):
>       perf scripts python: export-to-sqlite.py: Fix use of parent_id in calls_view
> 
> Gustavo A. R. Silva (1):
>       perf header: Fix lock/unlock imbalances when processing BPF/BTF info
> 
> Jiri Olsa (1):
>       perf stat: Disable DIR_FORMAT feature for 'perf stat record'
> 
> Lendacky, Thomas (2):
>       x86/perf/amd: Remove need to check "running" bit in NMI handler
>       x86/perf/amd: Fix build failure when CONFIG_HAVE_NMI_WATCHDOG is not set
> 
> Mao Han (1):
>       perf evsel: Use hweight64() instead of hweight_long(attr.sample_regs_user)
> 
> Rikard Falkeborn (1):
>       tools lib traceevent: Fix missing equality check for strcmp
> 
>  arch/x86/events/amd/core.c                    | 21 +++++++++++++++++++--
>  arch/x86/events/core.c                        | 13 +++----------
>  tools/lib/traceevent/event-parse.c            |  2 +-
>  tools/perf/builtin-stat.c                     |  1 +
>  tools/perf/scripts/python/export-to-sqlite.py |  2 +-
>  tools/perf/util/evsel.c                       | 12 ++++++------
>  tools/perf/util/header.c                      | 22 +++++++++++++---------
>  7 files changed, 44 insertions(+), 29 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
