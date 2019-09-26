Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BACDC352A9
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 15:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B0DF206E0
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 15:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6+Txyh+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbfIZPGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 11:06:13 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42372 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfIZPGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 11:06:13 -0400
Received: by mail-qt1-f193.google.com with SMTP id w14so3229973qto.9;
        Thu, 26 Sep 2019 08:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YT2h5auAZLMx5mCPaPjK7ZAOsvr5JYRIYLnQ6WStIIA=;
        b=c6+Txyh+ndDrD5lWJUMcZvA7vfgQAeGOwg8cNNj3r//DHnLHJFWFLrFSHWL0zsi7I5
         Nlt4SUzLdmXKQRWGhqpU3fD+hfuO4KvzgfKVsXRVTkVUmfPeFqTkVJDnuO4LFO0X2CqV
         VTeMwozVPd6wueKDkVi7dkGaZalJHpmj+LLWdEzI8jZd3Ynfa2jKFiT1GB3HyZ2uNGr1
         ydj19Arph+1hEpz/psADuqbTcci9SCvbIHqK+mLYmLywDtTtbbmcQrY5ME14vq60WCo1
         anx6wLIPrhcnkzSD0kWx9sC34EKrYJkWSvBYyQlUyglYJH6wGyRS2lCpw1Sv9wubhlsM
         PnFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YT2h5auAZLMx5mCPaPjK7ZAOsvr5JYRIYLnQ6WStIIA=;
        b=OSk9Zty1hesrz0M1RId1c5AWIcvodxd0IRcYD8NCcCKCK2NEzWICdP+39YUQZjT5yR
         /S6Ku2Rhb94sYWKoXUVe5Z3mbtc0FMWOYEWruoZDry3nfJEFwrmLilIPaulJy9wxTY6U
         Rjg33yldRBnam2zi+HI/tUq/T77Pb7nAJRYntMjm4Vo9aj3UJI6w4V9Ob6T8+HCm2z0j
         IXa79zyquC67XcQ5uz1snaHjzJP+NsgMV6mdH0yDJRP+xoK5c+naozfqZhpbogOiBiYT
         n/aMy2dpvfyMbEHOH6jS4genA2zbsXAF6ij0aZ4keSupZAt4w6dYykpJJSsfVUlxH2mr
         dnog==
X-Gm-Message-State: APjAAAWYsJBehkdvLkPO6luOWFc+YYUGevNDAtT/uA+Rqjf9HNkgu/M/
        uQQcwRlD4ORT3rkFAlUQ8rM=
X-Google-Smtp-Source: APXvYqw0ferc1lEhwbm0u5JOqKCX4hM8thl4bpfo1Z1RfKK2zn4jykDVceRxrlVif4LQ9m5qurgLEw==
X-Received: by 2002:ac8:5147:: with SMTP id h7mr4429877qtn.117.1569510372393;
        Thu, 26 Sep 2019 08:06:12 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id l15sm1244835qkj.16.2019.09.26.08.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 08:06:11 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3176940396; Thu, 26 Sep 2019 12:06:09 -0300 (-03)
Date:   Thu, 26 Sep 2019 12:06:09 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 57/66] perf evsel: Introduce evsel_fprintf.h
Message-ID: <20190926150609.GA10129@kernel.org>
References: <20190926003244.13962-1-acme@kernel.org>
 <20190926003244.13962-58-acme@kernel.org>
 <20190926111518.GC24257@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190926111518.GC24257@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Sep 26, 2019 at 01:15:18PM +0200, Jiri Olsa escreveu:
> On Wed, Sep 25, 2019 at 09:32:35PM -0300, Arnaldo Carvalho de Melo wrote:
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 
> > We already had evsel_fprintf.c, add its counterpart, so that we can
> > reduce evsel.h a bit more.
> > 
> > We needed a new perf_event_attr_fprintf.c file so as to have a separate
> > object to link with the python binding in tools/perf/util/python-ext-sources
> > and not drag symbol_conf, etc into the python binding.
> > 
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Link: https://lkml.kernel.org/n/tip-06bdmt1062d9unzgqmxwlv88@git.kernel.org
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >  tools/perf/builtin-evlist.c               |   1 +
> >  tools/perf/builtin-sched.c                |   1 +
> >  tools/perf/builtin-script.c               |   1 +
> >  tools/perf/builtin-trace.c                |   2 +
> >  tools/perf/util/Build                     |   1 +
> >  tools/perf/util/evsel.c                   | 153 +---------------------
> >  tools/perf/util/evsel.h                   |  51 +-------
> >  tools/perf/util/evsel_fprintf.c           |   1 +
> >  tools/perf/util/evsel_fprintf.h           |  50 +++++++
> >  tools/perf/util/header.c                  |   1 +
> >  tools/perf/util/perf_event_attr_fprintf.c | 148 +++++++++++++++++++++
> >  tools/perf/util/python-ext-sources        |   1 +
> >  12 files changed, 218 insertions(+), 193 deletions(-)
> >  create mode 100644 tools/perf/util/evsel_fprintf.h
> >  create mode 100644 tools/perf/util/perf_event_attr_fprintf.c
> 
> hum, I see this file in this patch, but not when I checkout yours perf/core

I made a mistake and had to force push it, it went on the signed tag to
Ingo, so what made upstream is sane, now what is in my perf/core branch
should be as well:

https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/evsel_fprintf.h?h=perf/core
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/perf_event_attr_fprintf.c?h=perf/core

- Arnaldo
