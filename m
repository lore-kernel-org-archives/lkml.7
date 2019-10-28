Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C478BCA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 15:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97DB021783
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 15:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tIkh9/Y/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730564AbfJ1PaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 11:30:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49498 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728132AbfJ1PaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 11:30:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4pIXgnGSTrmIbsx8nnVY6ovi+72F6jpCFbdaHl//REs=; b=tIkh9/Y/aP8LhxwfZd84/jXh4
        VzMHVzwzECB2W98TFAXxxHVc+YaD4STUhWtzLJTRCYFCfZXI9/DLi7JYLN3tuUDUpgLgDAfH6HkKQ
        PddU60/a6jki5q7zjJqzrUnWKQDfx2TO6deWOX+1bUDpAAFGOpMJt2v3M00pScYmcZNjRBE81c61n
        t0HmjyJl3irJwduVEOoheWC+CvMPMF45ThW6jKx1a4cT0SX0Iutrq7vRS9YW763jwAurTTlCGMULD
        3qowP0yukoovCR0tK5gz+PmL0rYK+syqu2S0e2mkO4TYRFKQr7gIsbWD1vkZpP8sS3ErgUpbhB6zr
        4eK5nxv5w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iP6yC-00085p-OS; Mon, 28 Oct 2019 15:30:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 40694306098;
        Mon, 28 Oct 2019 16:29:10 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 866502B4468CB; Mon, 28 Oct 2019 16:30:10 +0100 (CET)
Date:   Mon, 28 Oct 2019 16:30:10 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Thara Gopinath <thara.gopinath@linaro.org>, mingo@redhat.com,
        ionela.voinescu@arm.com, vincent.guittot@linaro.org,
        rui.zhang@intel.com, edubezval@gmail.com, qperret@google.com,
        linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, daniel.lezcano@linaro.org
Subject: Re: [Patch v4 4/6] sched/fair: update cpu_capcity to reflect thermal
 pressure
Message-ID: <20191028153010.GE4097@hirez.programming.kicks-ass.net>
References: <1571776465-29763-1-git-send-email-thara.gopinath@linaro.org>
 <1571776465-29763-5-git-send-email-thara.gopinath@linaro.org>
 <20191023122252.dz7obopab6iizy4s@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023122252.dz7obopab6iizy4s@e107158-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 01:28:40PM +0100, Qais Yousef wrote:
> On 10/22/19 16:34, Thara Gopinath wrote:
> > cpu_capacity relflects the maximum available capacity of a cpu. Thermal
> > pressure on a cpu means this maximum available capacity is reduced. This
> > patch reduces the average thermal pressure for a cpu from its maximum
> > available capacity so that cpu_capacity reflects the actual
> > available capacity.
> > 
> > Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> > ---
> >  kernel/sched/fair.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 4f9c2cb..be3e802 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -7727,6 +7727,7 @@ static unsigned long scale_rt_capacity(struct sched_domain *sd, int cpu)
> >  
> >  	used = READ_ONCE(rq->avg_rt.util_avg);
> >  	used += READ_ONCE(rq->avg_dl.util_avg);
> > +	used += READ_ONCE(rq->avg_thermal.load_avg);
> 
> Maybe a naive question - but can we add util_avg with load_avg without
> a conversion? I thought the 2 signals have different properties.

Changelog of patch #1 explains, it's in that dense blob of text.

But yes, you're quite right that that wants a comment here.
