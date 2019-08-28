Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73463C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 18:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DE9A2070B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 18:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XXzNM0G+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfH1S3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 14:29:12 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34028 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbfH1S3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 14:29:07 -0400
Received: by mail-qt1-f196.google.com with SMTP id a13so695306qtj.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 11:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2qvNYEMMGJNTjB5I27Rkau20ZtcbZt6SrXihS7hG0ag=;
        b=XXzNM0G+3jiKo+q+FIdNWm7fK6hAHTdJhMr7uoznQKh+QOmvDqvJPHfltNvE9fi8yd
         5YBLA3eswrbvOlYR2BHqGtmHcHhO/ubROmpQXqJwo1ILZu5Y7ro7j5eVvLd9OYYmKDhF
         xrLG2RNT+ob2ucxclPvxVtm3zNa2wlz2DdU3Z+BlxU3vynQ4zkrGfNeHGTdiLa/m9qGW
         bR2U2InqgUSR6HMCeNUcFTzjKB8+J002nBQV0Lv8co3vo/MS4hTiEyE4aMNXJuXAJ1xh
         vKqygbXMemBAN/isvCLvwF+ilXSoM6mMwJhZa9iPRoy+xEZB0pPIVazSSY+lbKGetspw
         B1Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2qvNYEMMGJNTjB5I27Rkau20ZtcbZt6SrXihS7hG0ag=;
        b=jr2wyHP8B9JqvR9WWgiyFBvQ0BbmcntERmrBOXryTU+rdoF98hCLrVHfRjUAkzdHJ/
         YPBdxst2L7XB6xlQbl3vUiPD81p9BcqlZu/N6rQib4HtYs25ZK/Hm9gEl+yZ2jCbwCa3
         xcXnAvkmu4gOtzBVQo6obINFXixJ/mZFKUQupiSaZyxSyj+QdYtRnH2h6yX3p6LFI08y
         6ZjVqUUuRHIym928lBNPSkrDuwDoLCOeI/LsGzrTlynaOMcRo0iTBwv4Mf+fT9qP6XUm
         e9PeOS+90oMgu6bISBC4swGY4PmY/nrKKiJN7lQY0mfe3isT/hROqrQxy4l/Z7I0SLYz
         aXFw==
X-Gm-Message-State: APjAAAUTZmyFn9BVO6ngeaGSCSiujXh3glh7TfgGfId+6KpK5xUQKkrC
        6DkzLg+Gnfq9bBZSnGABEqc=
X-Google-Smtp-Source: APXvYqx/ST+YeW431M3+ay9mgZNVS2xoNx6HMKmPcnXYBUF6XpjRAr00zE2/eBchtblEZlVWbVNEIg==
X-Received: by 2002:ac8:41d7:: with SMTP id o23mr5952175qtm.268.1567016945538;
        Wed, 28 Aug 2019 11:29:05 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([177.195.212.29])
        by smtp.gmail.com with ESMTPSA id x15sm1513758qtp.66.2019.08.28.11.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 11:29:04 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 38B6A41146; Wed, 28 Aug 2019 15:29:01 -0300 (-03)
Date:   Wed, 28 Aug 2019 15:29:01 -0300
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH 00/23] libperf: Add rest of events to perf/event.h
Message-ID: <20190828182901.GF26569@kernel.org>
References: <20190828135717.7245-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828135717.7245-1-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Aug 28, 2019 at 03:56:54PM +0200, Jiri Olsa escreveu:
> hi,
> to export 'union perf_event' we need to export the rest of events.

Thanks, applied to perf/core.

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
> Jiri Olsa (23):
>       libperf: Add PERF_RECORD_HEADER_ATTR 'struct attr_event' to perf/event.h
>       libperf: Add PERF_RECORD_CPU_MAP 'struct cpu_map_event' to perf/event.h
>       libperf: Add PERF_RECORD_EVENT_UPDATE 'struct event_update_event' to perf/event.h
>       libperf: Add PERF_RECORD_HEADER_EVENT_TYPE 'struct event_type_event' to perf/event.h
>       libperf: Add PERF_RECORD_HEADER_TRACING_DATA 'struct tracing_data_event' to perf/event.h
>       libperf: Add PERF_RECORD_HEADER_BUILD_ID 'struct build_id_event' to perf/event.h
>       libperf: Add PERF_RECORD_ID_INDEX 'struct id_index_event' to perf/event.h
>       libperf: Add PERF_RECORD_AUXTRACE_INFO 'struct auxtrace_info_event' to perf/event.h
>       libperf: Add PERF_RECORD_AUXTRACE 'struct auxtrace_event' to perf/event.h
>       libperf: Add PERF_RECORD_AUXTRACE_ERROR 'struct auxtrace_error_event' to perf/event.h
>       libperf: Add PERF_RECORD_AUX 'struct aux_event' to perf/event.h
>       libperf: Add PERF_RECORD_ITRACE_START 'struct itrace_start_event' to perf/event.h
>       libperf: Add PERF_RECORD_SWITCH 'struct context_switch_event' to perf/event.h
>       libperf: Add PERF_RECORD_THREAD_MAP 'struct thread_map_event' to perf/event.h
>       libperf: Add PERF_RECORD_STAT_CONFIG 'struct stat_config_event' to perf/event.h
>       libperf: Add PERF_RECORD_STAT 'struct stat_event' to perf/event.h
>       libperf: Add PERF_RECORD_STAT_ROUND 'struct stat_round_event' to perf/event.h
>       libperf: Add PERF_RECORD_TIME_CONV 'struct time_conv_event' to perf/event.h
>       libperf: Add PERF_RECORD_HEADER_FEATURE 'struct feature_event' to perf/event.h
>       libperf: Add PERF_RECORD_COMPRESSED 'struct compressed_event' to perf/event.h
>       libperf: Add 'union perf_event' to perf/event.h
>       libperf: Rename the PERF_RECORD_ structs to have a "perf" prefix
>       libperf: Move 'enum perf_user_event_type' to perf/event.h
> 
>  tools/perf/arch/arm/util/cs-etm.c    |   4 +--
>  tools/perf/arch/arm64/util/arm-spe.c |   2 +-
>  tools/perf/arch/s390/util/auxtrace.c |   2 +-
>  tools/perf/arch/x86/util/intel-bts.c |   2 +-
>  tools/perf/arch/x86/util/intel-pt.c  |   4 +--
>  tools/perf/arch/x86/util/tsc.c       |   2 +-
>  tools/perf/builtin-record.c          |   4 +--
>  tools/perf/builtin-report.c          |   2 +-
>  tools/perf/builtin-script.c          |   2 +-
>  tools/perf/builtin-stat.c            |   2 +-
>  tools/perf/lib/include/perf/event.h  | 273 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tools/perf/tests/cpumap.c            |  12 ++++----
>  tools/perf/tests/event_update.c      |  16 +++++-----
>  tools/perf/tests/stat.c              |   8 ++---
>  tools/perf/tests/thread-map.c        |   2 +-
>  tools/perf/util/arm-spe.c            |   6 ++--
>  tools/perf/util/auxtrace.c           |  20 ++++++------
>  tools/perf/util/auxtrace.h           |   8 ++---
>  tools/perf/util/build-id.c           |   2 +-
>  tools/perf/util/cpumap.c             |   6 ++--
>  tools/perf/util/cpumap.h             |   4 +--
>  tools/perf/util/cs-etm.c             |   2 +-
>  tools/perf/util/event.c              |  38 +++++++++++------------
>  tools/perf/util/event.h              | 278 +++--------------------------------------------------------------------------------------------------------------------------------------------------------------------
>  tools/perf/util/header.c             |  56 +++++++++++++++++-----------------
>  tools/perf/util/intel-bts.c          |   6 ++--
>  tools/perf/util/intel-pt.c           |  12 ++++----
>  tools/perf/util/python.c             |   4 +--
>  tools/perf/util/s390-cpumsf.c        |   4 +--
>  tools/perf/util/session.c            |  28 ++++++++---------
>  tools/perf/util/session.h            |   2 +-
>  tools/perf/util/stat.c               |  12 ++++----
>  tools/perf/util/thread_map.c         |   4 +--
>  tools/perf/util/thread_map.h         |   4 +--
>  34 files changed, 418 insertions(+), 415 deletions(-)

-- 

- Arnaldo
