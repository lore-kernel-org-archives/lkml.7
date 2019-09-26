Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FB2C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 11:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0F5F21A4A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 11:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbfIZLPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 07:15:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36262 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbfIZLPV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 07:15:21 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9B04E10C094D;
        Thu, 26 Sep 2019 11:15:21 +0000 (UTC)
Received: from krava (unknown [10.43.17.52])
        by smtp.corp.redhat.com (Postfix) with SMTP id A79295D9C9;
        Thu, 26 Sep 2019 11:15:19 +0000 (UTC)
Date:   Thu, 26 Sep 2019 13:15:18 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 57/66] perf evsel: Introduce evsel_fprintf.h
Message-ID: <20190926111518.GC24257@krava>
References: <20190926003244.13962-1-acme@kernel.org>
 <20190926003244.13962-58-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190926003244.13962-58-acme@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.66]); Thu, 26 Sep 2019 11:15:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 09:32:35PM -0300, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> We already had evsel_fprintf.c, add its counterpart, so that we can
> reduce evsel.h a bit more.
> 
> We needed a new perf_event_attr_fprintf.c file so as to have a separate
> object to link with the python binding in tools/perf/util/python-ext-sources
> and not drag symbol_conf, etc into the python binding.
> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Link: https://lkml.kernel.org/n/tip-06bdmt1062d9unzgqmxwlv88@git.kernel.org
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/builtin-evlist.c               |   1 +
>  tools/perf/builtin-sched.c                |   1 +
>  tools/perf/builtin-script.c               |   1 +
>  tools/perf/builtin-trace.c                |   2 +
>  tools/perf/util/Build                     |   1 +
>  tools/perf/util/evsel.c                   | 153 +---------------------
>  tools/perf/util/evsel.h                   |  51 +-------
>  tools/perf/util/evsel_fprintf.c           |   1 +
>  tools/perf/util/evsel_fprintf.h           |  50 +++++++
>  tools/perf/util/header.c                  |   1 +
>  tools/perf/util/perf_event_attr_fprintf.c | 148 +++++++++++++++++++++
>  tools/perf/util/python-ext-sources        |   1 +
>  12 files changed, 218 insertions(+), 193 deletions(-)
>  create mode 100644 tools/perf/util/evsel_fprintf.h
>  create mode 100644 tools/perf/util/perf_event_attr_fprintf.c

hum, I see this file in this patch, but not when I checkout yours perf/core

jirka
