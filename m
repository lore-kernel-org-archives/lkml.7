Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6068AC3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 15:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37D8C21872
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 15:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vetzc5gv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731644AbfHZPln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 11:41:43 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33092 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728221AbfHZPlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 11:41:42 -0400
Received: by mail-qt1-f196.google.com with SMTP id v38so18329057qtb.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 08:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z0AefaH8M69uTAvMvQKiPaJGHlGZfWziHal1Y2o9jmU=;
        b=vetzc5gvkMTXRTgbApTGm01HXB+1SVkocjGGPuOtsVnC+Bv9Bo/4FhHIQ8R+myxjzx
         dH0RnCRsW2UjyE1VSKVzBRvrYcbbwMjIjf9YNKCGLNz8ZBa2hM+k21iq6XWmLnVP7je7
         sRiIqAmUWaNb9NXTuBrbiA6+FUPL132QkSqmKnLs3z5r1My/nEY5S9z34jY25W54zy/v
         MnG7gQIpBBbn4PV/1rxXOyGYyZ0o0mZ4xOk4hQbNlJURsjkomXO/ma4grUINs6n3uRTn
         YeQbpjJTbfmHD84FjRl37qU7E7f+Rji0GzhRUM42n0MSR6yaZUJ8wl3jrD8JTxJqRXiz
         HijQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z0AefaH8M69uTAvMvQKiPaJGHlGZfWziHal1Y2o9jmU=;
        b=eM9YoL1wFYmFe9RK4H3t09lGQqsVQhxPY45dC6xd3+90rv4Rnr9Dtd1xUQ9i6nHcUE
         qZhM+Vz1SoT1bWgVDrxCs8hIutiRMngPPg+pakM0LgnfhY3+XyukijEwOHfUINA4bgi1
         K6VUtwzFo43oRVuX/NHxyzjDkJ6Hq5Py/frXeKM2LW+JXZ/GUGEeRXsLBJNYQ+gybne1
         72wZbYs8UanYMHAq7DytXghLg7vT2xILuChZEaV/l8UNfEJc//qSDc1LRcNqn4jAFrJm
         sZ7v8LHvRCajU0dnnYTx5GyG8NPdmdh3Bb3YQUCiCzt84d5uXyGJkBWeb6gQLd+VAMVa
         EvbA==
X-Gm-Message-State: APjAAAXAJGbsphAkaZCd8I30JH8unuGJ/a4/0eZV1a4VqKTjtXbsIZhH
        wi16t2wJ88CdXps6lLUJPo4=
X-Google-Smtp-Source: APXvYqzWLxECeww4OIBpUltfdXA72pHY1L+3n27eVAmGuqF3z0XNL7BNSbdHfMks5wNmAcds6mP1zQ==
X-Received: by 2002:a0c:f6c6:: with SMTP id d6mr16029637qvo.102.1566834101517;
        Mon, 26 Aug 2019 08:41:41 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id k25sm7919562qta.78.2019.08.26.08.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 08:41:40 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 44E6A40916; Mon, 26 Aug 2019 12:41:38 -0300 (-03)
Date:   Mon, 26 Aug 2019 12:41:38 -0300
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH 00/12] libperf: Add events to perf/event.h
Message-ID: <20190826154138.GD24801@kernel.org>
References: <20190825181752.722-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190825181752.722-1-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Aug 25, 2019 at 08:17:40PM +0200, Jiri Olsa escreveu:
> hi,
> as a preparation for sampling libperf interface, moving event
> definitions into the library header. Moving just the kernel 
> non-AUX events now.
> 
> In order to keep libperf simple, we switch 'u64/u32/u16/u8'
> types used events to their generic '__u*' versions.
> 
> Perf added 'u*' types mainly to ease up printing __u64 values
> as stated in the linux/types.h comment:
> 
>   /*
>    * We define u64 as uint64_t for every architecture
>    * so that we can print it with "%"PRIx64 without getting warnings.
>    *
>    * typedef __u64 u64;
>    * typedef __s64 s64;
>    */
> 
> Adding and using new PRI_lu64 and PRI_lx64 macros to be used for
> that.  Using extra '_' to ease up the reading and differentiate
> them from standard PRI*64 macros.

I think we should take advantage of this moment to rename those structs
to have the 'perf_record_' prefix on them, I guess we could even remove
the _event from them, i.e.:

'struct mmap_event' becomes 'perf_record_mmap', as it is the description
for the PERF_RECORD_MMAP meta-data event, are you ok with that?

I can go ahead and do it myself, updating each patch on this series to
do that.

- Arnaldo
 
> It's also available in here:
>   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
>   perf/fixes
> 
> thanks,
> jirka
> 
> 
> ---
> Jiri Olsa (12):
>       libperf: Add mmap_event to perf/event.h
>       libperf: Add mmap2_event to perf/event.h
>       libperf: Add comm_event to perf/event.h
>       libperf: Add namespaces_event to perf/event.h
>       libperf: Add fork_event to perf/event.h
>       libperf: Add lost_event to perf/event.h
>       libperf: Add lost_samples_event to perf/event.h
>       libperf: Add read_event to perf/event.h
>       libperf: Add throttle_event to perf/event.h
>       libperf: Add ksymbol_event to perf/event.h
>       libperf: Add bpf_event to perf/event.h
>       libperf: Add sample_event to perf/event.h
> 
>  tools/perf/builtin-sched.c          |   2 +-
>  tools/perf/lib/include/perf/event.h | 112 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tools/perf/util/event.c             |  12 ++++++------
>  tools/perf/util/event.h             | 104 +++-----------------------------------------------------------------------------------------------------
>  tools/perf/util/evlist.c            |   2 +-
>  tools/perf/util/evsel.c             |   8 ++++----
>  tools/perf/util/machine.c           |   4 ++--
>  tools/perf/util/python.c            |  14 +++++++-------
>  tools/perf/util/session.c           |   8 ++++----
>  9 files changed, 140 insertions(+), 126 deletions(-)
>  create mode 100644 tools/perf/lib/include/perf/event.h

-- 

- Arnaldo
