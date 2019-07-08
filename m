Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D51C606AA
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 10:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E7FB20656
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 10:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KyZlzWPd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730042AbfGHKXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 06:23:22 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52528 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbfGHKXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 06:23:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=b5qXum5h7Vyhb39cf424pttg4JuuutBnFQzGHy3SShs=; b=KyZlzWPd7D/4gzRBgdm8VLXgU
        K+62TEoubYE1b1J6FkGbHpypbHekaei9FoyEi5oYZGtflDclFtFm8LyV9r4oXhxChHhwTveZLEsJY
        KT+tFKDc1ZjRZDdGVC+lBgSCQDTyMaqxYsCLxAV6HwWBGtlreeUTBynHYHfJRclIrgFFU9rOKrlwz
        lx/kWNxWpaHW4raCDJ+Q75F9liUEn9/a2CZRZBlFMKmcEeT9xAxVEEtx3tk55fKQdKzJpCLCLkiB7
        ym6SZ9zDVVKkvzGVxIrBDw9xuN7Pb8lHHqKe5ZCcoh0Mj0+pqZqNNtWnx8r4P3JD2gfcN1HmiBLE/
        fT1Dp5tTg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hkQnh-0006Kk-I2; Mon, 08 Jul 2019 10:23:13 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4BC7B20B28AD5; Mon,  8 Jul 2019 12:23:12 +0200 (CEST)
Date:   Mon, 8 Jul 2019 12:23:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Markus Elfring <Markus.Elfring@web.de>,
        kernel-janitors@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched/topology: One function call less in
 build_group_from_child_sched_domain()
Message-ID: <20190708102312.GF3402@hirez.programming.kicks-ass.net>
References: <ad2e7dfb-3323-b214-716e-a6cae41b8bcc@web.de>
 <20190706172223.GA12680@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190706172223.GA12680@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 06, 2019 at 10:52:23PM +0530, Srikar Dronamraju wrote:
> * Markus Elfring <Markus.Elfring@web.de> [2019-07-06 16:05:17]:
> 
> > From: Markus Elfring <elfring@users.sourceforge.net>
> > Date: Sat, 6 Jul 2019 16:00:13 +0200
> > 
> > Avoid an extra function call by using a ternary operator instead of
> > a conditional statement.
> > 
> > This issue was detected by using the Coccinelle software.
> > 
> > Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> > ---
> >  kernel/sched/topology.c | 6 +-----
> >  1 file changed, 1 insertion(+), 5 deletions(-)
> > 
> > diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> > index f751ce0b783e..6190eb52c30a 100644
> > --- a/kernel/sched/topology.c
> > +++ b/kernel/sched/topology.c
> > @@ -886,11 +886,7 @@ build_group_from_child_sched_domain(struct sched_domain *sd, int cpu)
> >  		return NULL;
> > 
> >  	sg_span = sched_group_span(sg);
> > -	if (sd->child)
> > -		cpumask_copy(sg_span, sched_domain_span(sd->child));
> > -	else
> > -		cpumask_copy(sg_span, sched_domain_span(sd));
> > -
> > +	cpumask_copy(sg_span, sched_domain_span(sd->child ? sd->child : sd));
> 
> At runtime, Are we avoiding a function call?
> However I think we are avoiding a branch instead of a conditional, which may
> be beneficial.

It all depends on what the compiler does; also this is super slow path
stuff and the patch makes code less readable (IMO).
