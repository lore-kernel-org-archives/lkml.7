Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11260CA9ECF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 08:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9913218BA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 08:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CURR3Lfs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727974AbfKDIka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 03:40:30 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56662 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfKDIka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 03:40:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pHINdxeRrniqD93Z7XY51rAt/Snx+07p0RIhPThEcG4=; b=CURR3LfsSdDaQIKfySpmU+W4E
        PfYsBIWAwk5+63EqxsMJEo7bqLk/SWV1cafXHaBAIopZ67DILlcTrceULlM8HRbwkg7sSUrGiNwcH
        if/l9JZ+UY7YbnkQJgjIPb8SlvUhWAHAehQzPe7ITWpsoMpxnsxj+utqzGy5XgRpJbCIc919xZzY4
        iupd1Fi5M8xCVeFTq66RnS1hMQaM56ASHaCeohl0wpHk8KuclPaHT5uIRRr1jsLJfeut6N8PQjC93
        u6GKoZ0TM6bds7hvNy8lNQ8IEdpVq185Az01OSGgNtEgcpSOWizGfayNgn+8zWJokpst5Pm64VRb0
        TFQ+a5JEw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iRXuU-0000SR-Uu; Mon, 04 Nov 2019 08:40:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2715B305FC2;
        Mon,  4 Nov 2019 09:39:20 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 240B123CEFE81; Mon,  4 Nov 2019 09:40:24 +0100 (CET)
Date:   Mon, 4 Nov 2019 09:40:24 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        jolsa@redhat.com, adrian.hunter@intel.com,
        mathieu.poirier@linaro.org, mark.rutland@arm.com
Subject: Re: [PATCH v3 1/3] perf: Allow using AUX data in perf samples
Message-ID: <20191104084024.GZ4131@hirez.programming.kicks-ass.net>
References: <20191025140835.53665-1-alexander.shishkin@linux.intel.com>
 <20191025140835.53665-2-alexander.shishkin@linux.intel.com>
 <20191028162712.GH4097@hirez.programming.kicks-ass.net>
 <87tv7sg5ml.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tv7sg5ml.fsf@ashishki-desk.ger.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 07:08:18PM +0200, Alexander Shishkin wrote:

> > @@ -6318,11 +6318,12 @@ static void perf_aux_sample_output(struc
> >  
> >  	/*
> >  	 * Guard against NMI hits inside the critical section;
> > -	 * see also perf_aux_sample_size().
> > +	 * see also perf_prepare_sample_aux().
> >  	 */
> >  	WRITE_ONCE(rb->aux_in_sampling, 1);
> > +	barrier();
> 
> Isn't WRITE_ONCE() barrier enough on its own? My thinking was that we
> only need a compiler barrier here, hence the WRITE_ONCE.

WRITE_ONCE() is a volatile store and (IIRC) the compiler ensures order
against other volatile things, but not in general.

barrier() OTOH clobbers all of memory and thereby ensures nothing can
get hoised over it.

Now, the only thing we do inside this region is an indirect call, which
on its own already implies a sync point for as long as the compiler
cannot inline it, so it might be a bit paranoid on my end (I don't think
even LTO can reduce this indirection and cause inlining).
