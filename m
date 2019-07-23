Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D91C76194
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 16:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D21C122543
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 16:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="wxSO1Z3h";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="Xep00Pci"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388097AbfGWQXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 12:23:40 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:40390 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725837AbfGWQXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 12:23:40 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id B72BC8EE147;
        Tue, 23 Jul 2019 09:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1563899019;
        bh=ilEyyPI3JwOqXzHLQnn/4QmNwfGx0u7qQ2C+MI4Q2TU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=wxSO1Z3hnG74Anjmmz7hOw3jJUe1i3fK7SQxjDWHOv3obqemaQXZiJdrt5JW7+Uww
         Fiv2MXEx1SHonCqebh9ssjuiRga4OFTEctM7GpPYOtY4sjhqfw4L05WGmnu48AxzRV
         GQPucFmOslJ444eTgWNeIKWjdrOOmfSvymtD108M=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id s9JAKFB6Xl78; Tue, 23 Jul 2019 09:23:38 -0700 (PDT)
Received: from jarvis.lan (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id EECE38EE0EF;
        Tue, 23 Jul 2019 09:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1563899017;
        bh=ilEyyPI3JwOqXzHLQnn/4QmNwfGx0u7qQ2C+MI4Q2TU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Xep00PcibUJ7xEEVM/4Ry+Kh+jqvZ6faUu6GnzKADnNcFkxTsHrLfm+6HoNuu3Sbr
         NaVKEnv2u+pqN6HEgapaGYPnsiO7KM4rrrcLqqRMM/VQlJm6S40wdLOx+ynWhM8M2H
         fJew4b6k5ypJKP0/RSYM9F2ju8/Kps6YA0Y2Nrkw=
Message-ID: <1563899014.3609.26.camel@HansenPartnership.com>
Subject: Re: Linux 5.3-rc1
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Steffen Maier <maier@linux.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        linux-scsi <linux-scsi@vger.kernel.org>
Date:   Tue, 23 Jul 2019 09:23:34 -0700
In-Reply-To: <20190723161918.GB9140@roeck-us.net>
References: <CAHk-=wiVjkTqzP6OppBuLQZ+t1mpRQC4T+Ho4Wg2sBAapKd--Q@mail.gmail.com>
         <20190722222126.GA27291@roeck-us.net>
         <1563839144.2504.5.camel@HansenPartnership.com>
         <4dc6ef77-afce-1c6d-add3-8df76332e672@roeck-us.net>
         <1563859682.2504.17.camel@HansenPartnership.com>
         <1e05670d-9e28-1b1d-249d-743c736e6d63@linux.ibm.com>
         <1563895995.3609.10.camel@HansenPartnership.com>
         <20190723161918.GB9140@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-07-23 at 09:19 -0700, Guenter Roeck wrote:
> On Tue, Jul 23, 2019 at 08:33:15AM -0700, James Bottomley wrote:
> [ ... ]
> > 
> > Yes, I think so.  Can someone try this, or something like it.
> > 
> > Thanks,
> > 
> > James
> > 
> > ---
> > 
> > diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> > index 9381171c2fc0..4715671a1537 100644
> > --- a/drivers/scsi/scsi_lib.c
> > +++ b/drivers/scsi/scsi_lib.c
> > @@ -1793,7 +1793,8 @@ void __scsi_init_queue(struct Scsi_Host
> > *shost, struct request_queue *q)
> >  	dma_set_seg_boundary(dev, shost->dma_boundary);
> >  
> >  	blk_queue_max_segment_size(q, shost->max_segment_size);
> > -	blk_queue_virt_boundary(q, shost->virt_boundary_mask);
> > +	if (shost->virt_boundary_mask)
> > +		blk_queue_virt_boundary(q, shost-
> > >virt_boundary_mask);
> >  	dma_set_max_seg_size(dev, queue_max_segment_size(q));
> >  
> >  	/*
> 
> This fixes the problem for me.

Great, thanks!

I'm thinking this is the more correct fix:

https://lore.kernel.org/linux-block/1563896932.3609.15.camel@HansenPartnership.com/

But we'll see what Jens says.

James

