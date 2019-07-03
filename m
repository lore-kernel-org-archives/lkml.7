Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A575C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 18:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08DB72064A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 18:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNyw6YdB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbfGCSS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 14:18:26 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35416 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbfGCSS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 14:18:26 -0400
Received: by mail-qk1-f196.google.com with SMTP id r21so3295403qke.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 11:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=E5F0P1vDyJ3wUiYtSXmadNODkx8n9+HfVcL5UJ271aQ=;
        b=iNyw6YdBVsOUYRfGnZr41qxv/qJhiE8z6oAtCqxvVNOK0DkkLwaPWnKiWJAT86S9dM
         jWP+tAujM9G0lwlx2aKpvh45VtDijqbeTv8i4oFRETVIvHSpt2tFyG2LPiIgnV4RkPza
         5GaYvvloe2MyxumyoLFEGaOkVSzGcQh1/X+tQ0uhoAVaYuNSsuNagkYini4eOhB/W25Z
         tphvS3I3yN5I2fMyOfgNk92o/I9CWpD17+mR2yQb9ZLEgJnFq1orjK7hdtsOe3UCEENU
         zzpY3GqvIQLsRav6euL/+rqnqsA48JAdld5F5q/FOf9yuCSbv1wOYxo3m8lx2sXTXe/J
         QFSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E5F0P1vDyJ3wUiYtSXmadNODkx8n9+HfVcL5UJ271aQ=;
        b=hzoSN38tsANj+8mLzaujOyFc8988iRJ05kwt4nVc8qq/Zs/k4L24HVNszI5nuVQTtD
         s1YhxZ6B+wWg+ScvXzLTPPgkAQlAfoki7If4GbF6u+Lk515Ngf8wf4SuYjtet/s21wSt
         ibEa+91Mh5FWJqDWz1WcYoYfgOWWV5XQWccUA8WNgTGwtu7rkWfeFwyRYYWlbAlpH3rA
         WW1G3EnM1Qucm2v5juKSI4AGCLY+GESlvxqjfl95WTqZ3wJHqHmW7xuRABJU8R9MGGuk
         bRNjBKkpdyhtDS7+l+uHJc+8xmvSZ4MR3WPcBmkJ8BtGhQxZ4DcCppb+8ZJcDs8BuYSD
         z5AA==
X-Gm-Message-State: APjAAAUVodGJYB6ykfChNthfTh56rn7tFWnUXOZHu3d+QMkfK0FuOCV+
        S6CpzgUJahJppVM8DnB5Bvw=
X-Google-Smtp-Source: APXvYqzNKpecx14rn/OVfcxsVgRFDoVbgm67vbFk+gRFR6GltcqQP1ONCh/Rkfrp5LeezDqjXotp/A==
X-Received: by 2002:a05:620a:16c6:: with SMTP id a6mr31991741qkn.413.1562177904826;
        Wed, 03 Jul 2019 11:18:24 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([177.195.209.182])
        by smtp.gmail.com with ESMTPSA id b69sm1292412qkg.105.2019.07.03.11.18.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 11:18:23 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A69A741153; Wed,  3 Jul 2019 15:18:15 -0300 (-03)
Date:   Wed, 3 Jul 2019 15:18:15 -0300
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
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
Message-ID: <20190703181815.GB10740@kernel.org>
References: <20190702103420.27540-1-leo.yan@linaro.org>
 <20190702110743.GA12694@krava>
 <20190703014808.GC6852@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703014808.GC6852@leoy-ThinkPad-X240s>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jul 03, 2019 at 09:48:08AM +0800, Leo Yan escreveu:
> On Tue, Jul 02, 2019 at 01:07:43PM +0200, Jiri Olsa wrote:
> > On Tue, Jul 02, 2019 at 06:34:09PM +0800, Leo Yan wrote:
> > > When I used static checker Smatch for perf building, the main target is
> > > to check if there have any potential issues in Arm cs-etm code.  So
> > > finally I get many reporting for errors/warnings.
> > > 
> > > I used below command for using static checker with perf building:
> > > 
> > >   # make VF=1 CORESIGHT=1 -C tools/perf/ \
> > >     CHECK="/root/Work/smatch/smatch --full-path" \
> > >     CC=/root/Work/smatch/cgcc | tee smatch_reports.txt
> > > 
> > > I reviewed the errors one by one, if I understood some of these errors
> > > so changed the code as I can, this patch set is the working result; but
> > > still leave some errors due to I don't know what's the best way to fix
> > > it.  There also have many inconsistent indenting warnings.  So I firstly
> > > send out this patch set and let's see what's the feedback from public
> > > reviewing.
> > > 
> > > Leo Yan (11):
> > >   perf report: Smatch: Fix potential NULL pointer dereference
> > >   perf stat: Smatch: Fix use-after-freed pointer
> > >   perf top: Smatch: Fix potential NULL pointer dereference
> > >   perf annotate: Smatch: Fix dereferencing freed memory
> > >   perf trace: Smatch: Fix potential NULL pointer dereference
> > >   perf hists: Smatch: Fix potential NULL pointer dereference
> > >   perf map: Smatch: Fix potential NULL pointer dereference
> > >   perf session: Smatch: Fix potential NULL pointer dereference
> > >   perf intel-bts: Smatch: Fix potential NULL pointer dereference
> > >   perf intel-pt: Smatch: Fix potential NULL pointer dereference
> > >   perf cs-etm: Smatch: Fix potential NULL pointer dereference
> > 
> > from quick look it all looks good to me, nice tool ;-)
> > 
> > Acked-by: Jiri Olsa <jolsa@kernel.org>
> 
> Thanks for reviewing, Jiri.
> 
> @Arnaldo, Just want to check, will you firstly pick up 01~05, 07,
> 08/11 patches if you think they are okay?  Or you want to wait me to
> spin new patch set with all patches after I gather all comments?

I'm picking up the uncontrovertial, will push to my perf/core branch,
continue from there, please.

- Arnaldo
 
> Thanks,
> Leo Yan
> 
> > >  tools/perf/builtin-report.c    |  4 ++--
> > >  tools/perf/builtin-stat.c      |  2 +-
> > >  tools/perf/builtin-top.c       |  8 ++++++--
> > >  tools/perf/builtin-trace.c     |  5 +++--
> > >  tools/perf/ui/browsers/hists.c | 13 +++++++++----
> > >  tools/perf/util/annotate.c     |  6 ++----
> > >  tools/perf/util/cs-etm.c       |  2 +-
> > >  tools/perf/util/intel-bts.c    |  5 ++---
> > >  tools/perf/util/intel-pt.c     |  5 ++---
> > >  tools/perf/util/map.c          |  7 +++++--
> > >  tools/perf/util/session.c      |  3 +++
> > >  11 files changed, 36 insertions(+), 24 deletions(-)
> > > 
> > > -- 
> > > 2.17.1
> > > 

-- 

- Arnaldo
