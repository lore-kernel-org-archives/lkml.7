Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C885C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 13:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FF1E22CE3
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 13:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L6eKFF9y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404285AbfHWNDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 09:03:41 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38238 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404041AbfHWNDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 09:03:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=d/8OC8qK7AH729RYuk/u+nW1ro0Plfkg+QQGzVTANr8=; b=L6eKFF9ypk0LmLF7nc13NiAyN
        mVRGyMd+ZBjHbHJ4c7M9bpNUm5oNB/WN4clmoDYOV5w9NxfGmHN4Oc9nJLnKrqA2IqJupzfpaUCih
        i6TM+ZI/b+3wKv8eGVaiGjoPNwpEJgeRxtsn2oRbCYrEjl177tgUquVVTTGwqCxaa+Mk8vtpxAe+i
        LgpsrSIZ2p0NgK8v40CccfhA0F52zEj6Z7Dt5hUDQqZIxwzsfTVoThPb9CniCM6fo9hW1iFiqGELu
        lLMCC1/KQJDmngOsHyqlvYmu4JexwiqDedr62bPBsRiDVcIWHl+0Q3HzBGF7vxSKwi77m7yMieOpv
        GzIX+B6NA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i19Dy-0001bh-5e; Fri, 23 Aug 2019 13:03:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A027D307510;
        Fri, 23 Aug 2019 15:02:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 11044202245C4; Fri, 23 Aug 2019 15:03:23 +0200 (CEST)
Date:   Fri, 23 Aug 2019 15:03:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ganapatrao Kulkarni <gklkml16@gmail.com>
Cc:     Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Ganapatrao Kulkarni <gkulkarni@marvell.com>,
        Jayachandran Chandrasekharan Nair <jnair@marvell.com>
Subject: Re: [PATCH] perf cgroups: Don't rotate events for cgroups
 unnecessarily
Message-ID: <20190823130322.GO2349@hirez.programming.kicks-ass.net>
References: <20190601082722.44543-1-irogers@google.com>
 <20190621082422.GH3436@hirez.programming.kicks-ass.net>
 <CAP-5=fW7sMjQEHm+1e=cdAi+ZyP53UyU7xhAbnouMApuxYqrhw@mail.gmail.com>
 <20190624075520.GC3436@hirez.programming.kicks-ass.net>
 <CAP-5=fU=xbP39b6WZV4h92g6Ub_w4tH2JdApw5t6DTyZqxShUQ@mail.gmail.com>
 <CAKTKpr6m7YzqJ7U2icNHq7ZwoG0pw8ws_EHcLR+-T6ZeEfe15Q@mail.gmail.com>
 <20190823115946.GM2349@hirez.programming.kicks-ass.net>
 <CAKTKpr5N6thBR+SJ8rdRTCEjv+7GVsw3R9EY+cKTGexz-yr4sg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKTKpr5N6thBR+SJ8rdRTCEjv+7GVsw3R9EY+cKTGexz-yr4sg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 23, 2019 at 06:26:34PM +0530, Ganapatrao Kulkarni wrote:
> On Fri, Aug 23, 2019 at 5:29 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > On Fri, Aug 23, 2019 at 04:13:46PM +0530, Ganapatrao Kulkarni wrote:
> >
> > > We are seeing regression with our uncore perf driver(Marvell's
> > > ThunderX2, ARM64 server platform) on 5.3-Rc1.
> > > After bisecting, it turned out to be this patch causing the issue.
> >
> > Funnily enough; the email you replied to didn't contain a patch.
> 
> Hmm sorry, not sure why the patch is clipped-off, I see it in my inbox.

Your email is in a random spot of the discussion for me. At least it was
fairly easy to find the related patch.

> > > Test case:
> > > Load module and run perf for more than 4 events( we have 4 counters,
> > > event multiplexing takes place for more than 4 events), then unload
> > > module.
> > > With this sequence of testing, the system hangs(soft lockup) after 2
> > > or 3 iterations. Same test runs for hours on 5.2.
> > >
> > > while [ 1 ]
> > > do
> > >         rmmod thunderx2_pmu
> > >         modprobe thunderx2_pmu
> > >         perf stat -a -e \
> > >         uncore_dmc_0/cnt_cycles/,\
> > >         uncore_dmc_0/data_transfers/,\
> > >         uncore_dmc_0/read_txns/,\
> > >         uncore_dmc_0/config=0xE/,\
> > >         uncore_dmc_0/write_txns/ sleep 1
> > >         sleep 2
> > > done
> >
> > Can you reproduce without the module load+unload? I don't think people
> > routinely unload modules.
> 
> The issue wont happen, if module is not unloaded/reloaded.
> IMHO, this could be potential bug!

Does the softlockup give a useful stacktrace? I don't have a thunderx2
so I cannot reproduce.


