Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2431C282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F26B222EC
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555697869;
	bh=46Ab5fG4awRp8lnT/i9DtCe4MfwbWdwt8Kqp+8Na11M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ra/A5NvJOSoEavFwLPNa00Kqnms/r81vT6tY96JzMPXSLEG0Pl7tAZ5kvkq5Gud3h
	 wno4tIRp5Hm10QOhW4h4l/WRrb9kbyaTlxAQPqzAJ/+4P1YPzM5N+wLoJlY7M1wdjh
	 4Z2/PGqtBiL+gBUwp1sGhADnK3cwtbStpYHytd8Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbfDSSRs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:17:48 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44679 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727367AbfDSSRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:17:46 -0400
Received: by mail-wr1-f66.google.com with SMTP id w18so7781606wrv.11;
        Fri, 19 Apr 2019 11:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AGxXhmzuaKFXWCs+DV6DoQBcLIQ4CS7QgIYycO0XNP8=;
        b=HOOuZhbLDrtwaKqGbN9MjErDMnJk7P8HfZAaArMBQryHaSjHDsXuXitLWirplEuDUm
         Edt5jq326X/G+a6WFKEgsJJyIeYzLX8+x6r72R3d253g8GZneoAaLoZdk68MwHLBiAf/
         R4fJA6rpOC/BLverbefBUIoqH9grN7/2cdfeRf+eFelg7eNdiaDJ1SxNrMCJX3IkiUv0
         QELt3HP8HxAwmtMtUmzcnJzz/kBnmtnYYaOxs5NVASy6VCBHljGS16C2CZG5+672F+HY
         ymM8a4f2ixIADTvPCk8XtttOWIleWaHIVcRJZORK4KsWzA3TTjsFOVKjzcpxu9Y+AfwK
         MtPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=AGxXhmzuaKFXWCs+DV6DoQBcLIQ4CS7QgIYycO0XNP8=;
        b=ZNdn6hgjBEVGDkOQF4/1qrv5FZWh4F6rolmeuwekVZYqd9umTVzej0rPcenJUOXiac
         Dn78bnxk2tZqFz2JtCRud8cAQmPW8i7eu5ilVc2Fc4adjzn04kZtObzl2z25joQmMA7X
         NrJyVPK6owH9sZ/9eSsuY8V0OOZV0vTnI+CWKnZhGTTB1S1PYyn02XywJMip39w2WQ3b
         Jz70f9GZyDEUAQMy1lB5EA1+tSrqDCYtrjGicOYAdQlPH1KeQ9R9PRqr0FivJ5NJHkN0
         3ekzy2f08VM3qwelHR8ATnzomGd9KLhHhFeFkiM3dyiCxrRKw6nSku5y44O0g/StA/DF
         zElw==
X-Gm-Message-State: APjAAAXQ0kBLDyHGx0P1bYSOet8T8/bgZYhBDXLAIl+IyWAVT1HoN+KF
        h1LhYMCinKtlxu7RMtbPh8LH9LWf
X-Google-Smtp-Source: APXvYqyrGzH7+lEaL2gGHbwXt6dSc68rTxKoacxg8yrRiO7l+Ce+3kcUkYuX+QXLg7IEJgbA1OPtJg==
X-Received: by 2002:a5d:4a4d:: with SMTP id v13mr3563557wrs.169.1555693911552;
        Fri, 19 Apr 2019 10:11:51 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id o10sm8259280wru.54.2019.04.19.10.11.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Apr 2019 10:11:50 -0700 (PDT)
Date:   Fri, 19 Apr 2019 19:11:48 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Bastian Beischer <bastian.beischer@rwth-aachen.de>,
        Song Liu <songliubraving@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL 0/7] perf/urgent fixes
Message-ID: <20190419171148.GA115669@gmail.com>
References: <20190419123029.11328-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190419123029.11328-1-acme@kernel.org>
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
> The following changes since commit b24131eb77429f7ac52d5ab5a4313fccff64c411:
> 
>   Merge tag 'perf-urgent-for-mingo-5.1-20190416' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent (2019-04-16 17:24:14 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-5.1-20190419
> 
> for you to fetch changes up to 2db7b1e0bd49d2b0e7d16949e167b1cfaf5c07cf:
> 
>   perf bpf: Return NULL when RB tree lookup fails in perf_env__find_btf() (2019-04-17 14:30:23 -0300)
> 
> ----------------------------------------------------------------
> perf/urgent fixes:
> 
> perf top:
> 
>   Jiri Olsa:
> 
>   - Fix 'perf top --pid', it needs PERF_SAMPLE_TIME since we switched to using
>     a different thread to sort the events and then even for just a single
>     thread we now need timestamps.
> 
> BPF:
> 
>   Jiri Olsa:
> 
>   - Fix bpf_prog and btf lookup functions failure path to to properly return
>     NULL.
> 
>   - Fix side band thread draining, used to process PERF_RECORD_BPF_EVENT
>     metadata records.
> 
> core:
> 
>   Jiri Olsa:
> 
>   - Fix map lookup by name to get a refcount when the name is already in
>     the tree. Found
> 
>   Song Liu:
> 
>   - Fix __map__is_kmodule() by taking into account recently added BPF
>     maps.
> 
> UAPI:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Sync sound/asound.h copy
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (1):
>       tools include uapi: Sync sound/asound.h copy
> 
> Jiri Olsa (5):
>       perf top: Always sample time to satisfy needs of use of ordered queuing
>       perf bpf: Return NULL when RB tree lookup fails in perf_env__find_bpf_prog_info()
>       perf evlist: Fix side band thread draining
>       perf tools: Fix map reference counting
>       perf bpf: Return NULL when RB tree lookup fails in perf_env__find_btf()
> 
> Song Liu (1):
>       perf tools: Check maps for bpf programs
> 
>  tools/include/uapi/sound/asound.h |  1 +
>  tools/perf/builtin-top.c          |  1 +
>  tools/perf/util/env.c             |  8 ++++++--
>  tools/perf/util/evlist.c          | 14 +++++++++-----
>  tools/perf/util/map.c             | 20 +++++++++++++++++---
>  tools/perf/util/map.h             |  4 +++-
>  6 files changed, 37 insertions(+), 11 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
