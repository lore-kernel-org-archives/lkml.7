Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E08C76188
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 12:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A44E820880
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 12:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KmyZb7on"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728726AbfGPMeZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 08:34:25 -0400
Received: from merlin.infradead.org ([205.233.59.134]:57572 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbfGPMeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 08:34:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ukkgoKS/Ipjg1tt9wgdm0MDAYloHyeh53UXnSxDig0Q=; b=KmyZb7onIweWOf3RyIzEVil/Q
        myYCflBVTCrdtavRkHGCbqzzuiuglnTlG3l81jjtMmfsUvTc48HVcSF9jj8qSMHMFvHVV/I+I3Krw
        kwA8C080ZHokTqUM/TlczT38BZ4sh+alI9CEH8dNZqGDRX4VC2y7JWsuHfU/n7isE0GZbu5tj0+oU
        8V+rZA5G3QKv/dDCEsQCH0P0EbCiennQhWRmJza5vLZDwjtopkA1oJgafap5FS1vbRWRjJ2DbVM6g
        Xd5MzU4dwU6t2py2z07ftXdZolhk/yPFYujDzk4Wbo6aB9NoL1+V/dVbFPljG4RJjlYcRtr1iPQhO
        Q/YqMlhQQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hnMer-0008Ln-A3; Tue, 16 Jul 2019 12:34:13 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 39A332013A7FB; Tue, 16 Jul 2019 14:34:11 +0200 (CEST)
Date:   Tue, 16 Jul 2019 14:34:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Numfor Mbiziwo-Tiapo <nums@google.com>, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, songliubraving@fb.com, mbd@fb.com,
        linux-kernel@vger.kernel.org, irogers@google.com,
        eranian@google.com
Subject: Re: [PATCH] Fix perf test data race for tsan build
Message-ID: <20190716123411.GY3402@hirez.programming.kicks-ass.net>
References: <20190710221620.211059-1-nums@google.com>
 <20190716091039.GE22317@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716091039.GE22317@krava>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2019 at 11:10:39AM +0200, Jiri Olsa wrote:
> On Wed, Jul 10, 2019 at 03:16:20PM -0700, Numfor Mbiziwo-Tiapo wrote:
> > The tsan build of perf gives a data race warning in
> 
> hi,
> what's 'tsan build of perf' ?

Thread Sanitizer, from the group that brought us KASAN and UBSAN.

I'd much rather see the below use READ_ONCE() and WRITE_ONCE(). Using
atomic_t without RmW ops is confusing.

> > mmap-thread-lookup.c when perf test is run on our local machines.
> > This is because there is no lock around the "go_away" variable in
> > "mmap-thread-lookup.c".
> > 
> > The warning is difficult to reproduce from the tip branch and we
> > suspect it has something to do with tsan working differently
> > depending on the clang version.
> > 
> > The warning can be silenced by adding locks around the variable
> > but it is better practice to make the variable atomic and use
> > the atomic_set and atomic_read functions. This does not actually
> > silence the warning because tsan doesn't recognize the atomic
> > functions as thread safe, but in actuality it should prevent a
> > data race.
> > 
> > Signed-off-by: Numfor Mbiziwo-Tiapo <nums@google.com>
> > ---
> >  tools/perf/tests/mmap-thread-lookup.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/tools/perf/tests/mmap-thread-lookup.c b/tools/perf/tests/mmap-thread-lookup.c
> > index 5ede9b561d32..f4cbb3d92a46 100644
> > --- a/tools/perf/tests/mmap-thread-lookup.c
> > +++ b/tools/perf/tests/mmap-thread-lookup.c
> > @@ -17,7 +17,7 @@
> >  
> >  #define THREADS 4
> >  
> > -static int go_away;
> > +static atomic_t go_away;
> >  
> >  struct thread_data {
> >  	pthread_t	pt;
> > @@ -64,7 +64,7 @@ static void *thread_fn(void *arg)
> >  		return NULL;
> >  	}
> >  
> > -	while (!go_away) {
> > +	while (!atomic_read(&go_away)) {
> >  		/* Waiting for main thread to kill us. */
> >  		usleep(100);
> >  	}
> > @@ -98,7 +98,7 @@ static int threads_create(void)
> >  	struct thread_data *td0 = &threads[0];
> >  	int i, err = 0;
> >  
> > -	go_away = 0;
> > +	atomic_set(&go_away, 0);
> >  
> >  	/* 0 is main thread */
> >  	if (thread_init(td0))
> > @@ -118,7 +118,7 @@ static int threads_destroy(void)
> >  	/* cleanup the main thread */
> >  	munmap(td0->map, page_size);
> >  
> > -	go_away = 1;
> > +	atomic_set(&go_away, 1);
> >  
> >  	for (i = 1; !err && i < THREADS; i++)
> >  		err = pthread_join(threads[i].pt, NULL);
> > -- 
> > 2.22.0.410.gd8fdbe21b5-goog
> > 
