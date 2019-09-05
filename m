Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B15C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 10:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8104206BB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 10:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZFF+gqbJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387903AbfIEKtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 06:49:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34052 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731889AbfIEKtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 06:49:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ndJ3xT/+P88NkCNSYWvx4UsoYyfPRvn/Wl55/0pFoeU=; b=ZFF+gqbJcAzlpHz9/j6LOxc3x
        DuIS1v0MwBsJN2mMrW4dmx6M8Vz/0k8AYhmDlaaiCORzQM38Cea6Jm5snrpBRrGTXsnrcn6oh+bmx
        We4nq0wZfz6IPh9CEb9DC0d3bYinvMTPj9VGU3Cz+7WMhaJTihPkGVtcVI+hGDmEE0QDR8Ls/hZFO
        9bcTmXGwEYe3VLHAa+CXfsTuk+MAMAiovmVwifbwvFD1iPA9j1aMGrARCpw9IQtR8fnLqcCbcMLj5
        chrZqanvGMA63DbugPxlBkqaDpT44fSmw8cT85gi7BwMSokknF0ZIvi8BuZGj5zq87A4DtCPilEQb
        vsxU51fpg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i5pJr-0004yf-O2; Thu, 05 Sep 2019 10:48:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DA7FC3011DF;
        Thu,  5 Sep 2019 12:48:12 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CF05D29E3BB8A; Thu,  5 Sep 2019 12:48:49 +0200 (CEST)
Date:   Thu, 5 Sep 2019 12:48:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     subhra mazumdar <subhra.mazumdar@oracle.com>,
        linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        steven.sistare@oracle.com, dhaval.giani@oracle.com,
        daniel.lezcano@linaro.org, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, tim.c.chen@linux.intel.com,
        mgorman@techsingularity.net, parth@linux.ibm.com
Subject: Re: [RFC PATCH 1/9] sched,cgroup: Add interface for latency-nice
Message-ID: <20190905104849.GE2332@hirez.programming.kicks-ass.net>
References: <20190830174944.21741-1-subhra.mazumdar@oracle.com>
 <20190830174944.21741-2-subhra.mazumdar@oracle.com>
 <87pnkf2h41.fsf@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pnkf2h41.fsf@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 11:05:18AM +0100, Patrick Bellasi wrote:
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index b52ed1a..365c928 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -143,6 +143,13 @@ static inline void cpu_load_update_active(struct rq *this_rq) { }
> >  #define NICE_0_LOAD		(1L << NICE_0_LOAD_SHIFT)
> >  
> >  /*
> > + * Latency-nice default value
> > + */
> > +#define	LATENCY_NICE_DEFAULT	5
> > +#define	LATENCY_NICE_MIN	1
> > +#define	LATENCY_NICE_MAX	100
> 
> Values 1 and 5 looks kind of arbitrary.

Yes, and like I just wrote, completely and utterly wrong.
