Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3233C5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 01:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CD8420673
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 01:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zQMpxxLG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfGCBsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 21:48:22 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39971 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfGCBsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 21:48:21 -0400
Received: by mail-ot1-f67.google.com with SMTP id e8so612828otl.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 18:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/lRiznl/b3k1Ie9ScyJ4jBFeaEoI2ZI3USYbKQfR1J0=;
        b=zQMpxxLGrM0XjdsgBPT6ATLcrb7qA9zfpedH99WHA29nFWVTZMn5gYEGkwE/NO+j58
         O0GelD0oUhq/t5UuQIzLN40ZYkRP2zzc1N3lAkXaYN9SpFI6oXBDfRYUYW0DDL7N5Irl
         PT0IswXptUa0vycB9GEwZibK3zlJafP0FDM+ksQm3Eur3ySQZwANF62OBiy4caGXFFEz
         8QPTMYNIwkiFEzQ2hfjAKMDgj9RuvrXBgl2U6TQF3njQH25/FcQL80t57ieCV/qnWoLd
         Hmf7MuHoNwUEoProeXVs3712q03rie79FXvO9UhNfh702kuBuyTYFuf81Laf6+Jnq97N
         h3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/lRiznl/b3k1Ie9ScyJ4jBFeaEoI2ZI3USYbKQfR1J0=;
        b=d/x5E3dpTglDrq0dz3b6uiELB1rPIas/gdD28J9R6+LqykZuPczhpLD+cuMmnMtG3p
         CqF+DzVWnyIS6LArrKEAbC4zknAWhP5pSX1rPIt2AO0YszZXUIrP7qwzw8PF0Fmy1+dM
         Cq/Hx1zMVLGGsdQWm4i1Wg2sHvMWlNgREDl658OK+1+g2jWRV0skrKDMSoNLS78WefCj
         zSCvgFygPEz4LS5FHn7aiw5FEGAQqlgE0f7Bza780W3FmWyWijUB5Vho+ArGBKdneinj
         VLD6lqPYfDiLWSzaIWM/MlBXvBDhRDM7bKQwnzDl/cg5eAAqaFFNG/bMKoOgW17ftUmU
         +wnw==
X-Gm-Message-State: APjAAAWc2JnI9/yS82hVFkDf2S37CEw5+HRh6vjE9yGwi9vJ2iSMzksR
        GpQTJZnaXb4yRP9w684YxXIQOg==
X-Google-Smtp-Source: APXvYqyH/Q87O4oDhQWm0UZHg0a9eu6n/1GxkkIumbyNvNvII6KOW/H5NXHLQOuBpr2GbdpYym7ZGg==
X-Received: by 2002:a9d:61d8:: with SMTP id h24mr6357738otk.53.1562118501240;
        Tue, 02 Jul 2019 18:48:21 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li964-79.members.linode.com. [45.33.10.79])
        by smtp.gmail.com with ESMTPSA id p2sm313927otl.59.2019.07.02.18.48.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Jul 2019 18:48:20 -0700 (PDT)
Date:   Wed, 3 Jul 2019 09:48:08 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Andi Kleen <ak@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jin Yao <yao.jin@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Changbin Du <changbin.du@intel.com>,
        Eric Saint-Etienne <eric.saint.etienne@oracle.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 00/11] perf: Fix errors detected by Smatch
Message-ID: <20190703014808.GC6852@leoy-ThinkPad-X240s>
References: <20190702103420.27540-1-leo.yan@linaro.org>
 <20190702110743.GA12694@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702110743.GA12694@krava>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2019 at 01:07:43PM +0200, Jiri Olsa wrote:
> On Tue, Jul 02, 2019 at 06:34:09PM +0800, Leo Yan wrote:
> > When I used static checker Smatch for perf building, the main target is
> > to check if there have any potential issues in Arm cs-etm code.  So
> > finally I get many reporting for errors/warnings.
> > 
> > I used below command for using static checker with perf building:
> > 
> >   # make VF=1 CORESIGHT=1 -C tools/perf/ \
> >     CHECK="/root/Work/smatch/smatch --full-path" \
> >     CC=/root/Work/smatch/cgcc | tee smatch_reports.txt
> > 
> > I reviewed the errors one by one, if I understood some of these errors
> > so changed the code as I can, this patch set is the working result; but
> > still leave some errors due to I don't know what's the best way to fix
> > it.  There also have many inconsistent indenting warnings.  So I firstly
> > send out this patch set and let's see what's the feedback from public
> > reviewing.
> > 
> > Leo Yan (11):
> >   perf report: Smatch: Fix potential NULL pointer dereference
> >   perf stat: Smatch: Fix use-after-freed pointer
> >   perf top: Smatch: Fix potential NULL pointer dereference
> >   perf annotate: Smatch: Fix dereferencing freed memory
> >   perf trace: Smatch: Fix potential NULL pointer dereference
> >   perf hists: Smatch: Fix potential NULL pointer dereference
> >   perf map: Smatch: Fix potential NULL pointer dereference
> >   perf session: Smatch: Fix potential NULL pointer dereference
> >   perf intel-bts: Smatch: Fix potential NULL pointer dereference
> >   perf intel-pt: Smatch: Fix potential NULL pointer dereference
> >   perf cs-etm: Smatch: Fix potential NULL pointer dereference
> 
> from quick look it all looks good to me, nice tool ;-)
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Thanks for reviewing, Jiri.

@Arnaldo, Just want to check, will you firstly pick up 01~05, 07,
08/11 patches if you think they are okay?  Or you want to wait me to
spin new patch set with all patches after I gather all comments?

Thanks,
Leo Yan

> >  tools/perf/builtin-report.c    |  4 ++--
> >  tools/perf/builtin-stat.c      |  2 +-
> >  tools/perf/builtin-top.c       |  8 ++++++--
> >  tools/perf/builtin-trace.c     |  5 +++--
> >  tools/perf/ui/browsers/hists.c | 13 +++++++++----
> >  tools/perf/util/annotate.c     |  6 ++----
> >  tools/perf/util/cs-etm.c       |  2 +-
> >  tools/perf/util/intel-bts.c    |  5 ++---
> >  tools/perf/util/intel-pt.c     |  5 ++---
> >  tools/perf/util/map.c          |  7 +++++--
> >  tools/perf/util/session.c      |  3 +++
> >  11 files changed, 36 insertions(+), 24 deletions(-)
> > 
> > -- 
> > 2.17.1
> > 
