Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E27C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 08:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11028208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 08:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfHNI66 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 04:58:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51512 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725265AbfHNI66 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 04:58:58 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 475864E926;
        Wed, 14 Aug 2019 08:58:58 +0000 (UTC)
Received: from ming.t460p (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AE7A710016F3;
        Wed, 14 Aug 2019 08:58:51 +0000 (UTC)
Date:   Wed, 14 Aug 2019 16:58:46 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "Derrick, Jonathan" <jonathan.derrick@intel.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3 1/3] genirq/affinity: Enhance warning check
Message-ID: <20190814085845.GA21802@ming.t460p>
References: <20190813081447.1396-1-ming.lei@redhat.com>
 <20190813081447.1396-2-ming.lei@redhat.com>
 <ac920ba3996d0feedc924045b54724ba5482e427.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac920ba3996d0feedc924045b54724ba5482e427.camel@intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 14 Aug 2019 08:58:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 07:31:39PM +0000, Derrick, Jonathan wrote:
> Hi Ming,
> 
> On Tue, 2019-08-13 at 16:14 +0800, Ming Lei wrote:
> > The two-stage spread is done on same irq vectors, and we just need that
> > either one stage covers all vector, not two stage work together to cover
> > all vectors.
> > 
> > So enhance the warning check to make sure all vectors are spread.
> > 
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Keith Busch <kbusch@kernel.org>
> > Cc: linux-nvme@lists.infradead.org,
> > Cc: Jon Derrick <jonathan.derrick@intel.com>
> > Cc: Jens Axboe <axboe@kernel.dk>
> > Fixes: 6da4b3ab9a6 ("genirq/affinity: Add support for allocating interrupt sets")
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  kernel/irq/affinity.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
> > index 6fef48033f96..265b3076f16b 100644
> > --- a/kernel/irq/affinity.c
> > +++ b/kernel/irq/affinity.c
> > @@ -215,8 +215,7 @@ static int irq_build_affinity_masks(unsigned int startvec, unsigned int numvecs,
> >  					       npresmsk, nmsk, masks);
> >  	put_online_cpus();
> >  
> > -	if (nr_present < numvecs)
> > -		WARN_ON(nr_present + nr_others < numvecs);
> > +	WARN_ON(max(nr_present, nr_others) < numvecs);
> 
> I think the patch description assumes the first condition
> "The two-stage spread is done on same irq vectors"
> 
>     /*
>      * Spread on non present CPUs starting from the next vector to be
>      * handled. If the spreading of present CPUs already exhausted the
>      * vector space, assign the non present CPUs to the already spread
>      * out vectors.
>      */
>     if (nr_present >= numvecs)
>             curvec = firstvec;
> 
> But doesn't following condition imply nr_others spread is potentionally
> different vector set?
> 
>     else
>             curvec = firstvec + nr_present;
> 

Most times, __irq_build_affinity_masks() returns numvecs.

However, each stage may expose less CPU number than num_vecs, then less
vectors than 'numvecs' can be spread.

So this patch is actually wrong.


Thank,
Ming
