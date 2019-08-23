Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C433C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 11:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D08D22CE3
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 11:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FZCOxMDJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389035AbfHWL7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 07:59:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49014 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727894AbfHWL7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 07:59:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MCKmImQ0R7fs/6XAgJnWu6vihJ6Hr3Y99gy4SyfNOlA=; b=FZCOxMDJPgj2WE7xMMDZy9X0M
        RjCB/eg/giF5WfYFquy5CueJrkQeb1QLlbtio8nLhsZZQHINVSzGS0Cda9me4z/AQGu6c0AqYlFOD
        XrB/mbK1i9kKYE94F8rveai4Dx4y30knXWq8z10Yx1f4SP10blnZiw+2GMWzVInqLjoe/hHSyPYxj
        qdLLts3sw9WYPxjTmnz9JXC2JQT09It8LSA4bfE7B2vGZzmm/u5ER621WzilDr1KIsmTKnnezNnBn
        y7Rkg2zAPJ9AmnmU3cwODZDlqAIFeWjufdiwtSUav/HvhEZcz+sVKvBAAxAivIYd4vECRHKYuK8vO
        I/pDM7VVQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i18EP-0003Wt-Mm; Fri, 23 Aug 2019 11:59:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8E5DE305F65;
        Fri, 23 Aug 2019 13:59:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4C530201E04D9; Fri, 23 Aug 2019 13:59:46 +0200 (CEST)
Date:   Fri, 23 Aug 2019 13:59:46 +0200
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
Message-ID: <20190823115946.GM2349@hirez.programming.kicks-ass.net>
References: <20190601082722.44543-1-irogers@google.com>
 <20190621082422.GH3436@hirez.programming.kicks-ass.net>
 <CAP-5=fW7sMjQEHm+1e=cdAi+ZyP53UyU7xhAbnouMApuxYqrhw@mail.gmail.com>
 <20190624075520.GC3436@hirez.programming.kicks-ass.net>
 <CAP-5=fU=xbP39b6WZV4h92g6Ub_w4tH2JdApw5t6DTyZqxShUQ@mail.gmail.com>
 <CAKTKpr6m7YzqJ7U2icNHq7ZwoG0pw8ws_EHcLR+-T6ZeEfe15Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKTKpr6m7YzqJ7U2icNHq7ZwoG0pw8ws_EHcLR+-T6ZeEfe15Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

On Fri, Aug 23, 2019 at 04:13:46PM +0530, Ganapatrao Kulkarni wrote:

> We are seeing regression with our uncore perf driver(Marvell's
> ThunderX2, ARM64 server platform) on 5.3-Rc1.
> After bisecting, it turned out to be this patch causing the issue.

Funnily enough; the email you replied to didn't contain a patch.

> Test case:
> Load module and run perf for more than 4 events( we have 4 counters,
> event multiplexing takes place for more than 4 events), then unload
> module.
> With this sequence of testing, the system hangs(soft lockup) after 2
> or 3 iterations. Same test runs for hours on 5.2.
> 
> while [ 1 ]
> do
>         rmmod thunderx2_pmu
>         modprobe thunderx2_pmu
>         perf stat -a -e \
>         uncore_dmc_0/cnt_cycles/,\
>         uncore_dmc_0/data_transfers/,\
>         uncore_dmc_0/read_txns/,\
>         uncore_dmc_0/config=0xE/,\
>         uncore_dmc_0/write_txns/ sleep 1
>         sleep 2
> done

Can you reproduce without the module load+unload? I don't think people
routinely unload modules.


