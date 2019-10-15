Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B16ECE58C
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 20:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECE6F2083B
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 20:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732866AbfJOUUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 16:20:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:26588 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732525AbfJOUUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 16:20:54 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C871F61D25
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 20:20:53 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id m14so10658364wru.17
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 13:20:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=8GMAVQL2NP8TCu+G/gUvtl2ZtnzY76GnRz9u4ZClHjY=;
        b=kWuGN+ghfgNytcoEPBSSEHuOhwKBoDDNYVjDLnocYZvjRY4YVmNtcY2wqUuJ7mSsF1
         Y1eW9cXVWeBjn+xHiAEarMYl8TGQXAPIpzz08gCbFVFCcpiR9BqHj1rEBRDBiv8tAc2I
         pAo3A4FLz8BlBv294IxPpsHPCmb4+w5wgJwYIzXuoyzac85+vZfNDq9vH4OWkL0l0apw
         P9JvazmeyEandDxRyscY9AAmKb2I7ufYUATjbr7a1FrzYQ5Cx3bRjnyvYhfbyr32TeNB
         haSyqmgCBENAFMZHD1kTKTDM6CEJfDmH9KPqqt9tibanfI0kKfhWRr1q/mpVEvIQX2Lt
         9obw==
X-Gm-Message-State: APjAAAUaQ7+HdS2rSavRjCVN0goYxhH1weMGqsk0vSssYriTPr4eZ2Pc
        zjnpwEfgygIUR9hipBFybO1HXFRsRipyoA+BPST3gFEaeUDYGmW+6rHupZszBFaWvDQ0Xml01PH
        Uh9/8VaWzLbUQ+fXitS+yX+ds
X-Received: by 2002:a7b:cd89:: with SMTP id y9mr297821wmj.51.1571170851990;
        Tue, 15 Oct 2019 13:20:51 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzh9v01jF2Ba/auCgYS73sLQ6h1NSdbRfqN5RREozaF93h2gJUeFMSOjFP8XokdJfsFY9RWMA==
X-Received: by 2002:a7b:cd89:: with SMTP id y9mr297798wmj.51.1571170851664;
        Tue, 15 Oct 2019 13:20:51 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
        by smtp.gmail.com with ESMTPSA id h63sm547409wmf.15.2019.10.15.13.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 13:20:49 -0700 (PDT)
Date:   Tue, 15 Oct 2019 16:20:41 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH RFC v1 1/2] vhost: option to fetch descriptors through an
 independent struct
Message-ID: <20191014085806-mutt-send-email-mst@kernel.org>
References: <20191011134358.16912-1-mst@redhat.com>
 <20191011134358.16912-2-mst@redhat.com>
 <3b2a6309-9d21-7172-a581-9f0f1d5c1427@redhat.com>
 <20191012162445-mutt-send-email-mst@kernel.org>
 <fea337ec-7c09-508b-3efa-b75afd6fe33b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fea337ec-7c09-508b-3efa-b75afd6fe33b@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 09:43:25AM +0800, Jason Wang wrote:
> 
> On 2019/10/13 上午4:27, Michael S. Tsirkin wrote:
> > On Sat, Oct 12, 2019 at 03:28:49PM +0800, Jason Wang wrote:
> > > On 2019/10/11 下午9:45, Michael S. Tsirkin wrote:
> > > > The idea is to support multiple ring formats by converting
> > > > to a format-independent array of descriptors.
> > > > 
> > > > This costs extra cycles, but we gain in ability
> > > > to fetch a batch of descriptors in one go, which
> > > > is good for code cache locality.
> > > > 
> > > > To simplify benchmarking, I kept the old code
> > > > around so one can switch back and forth by
> > > > writing into a module parameter.
> > > > This will go away in the final submission.
> > > > 
> > > > This patch causes a minor performance degradation,
> > > > it's been kept as simple as possible for ease of review.
> > > > Next patch gets us back the performance by adding batching.
> > > > 
> > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > > ---
> > > >    drivers/vhost/test.c  |  17 ++-
> > > >    drivers/vhost/vhost.c | 299 +++++++++++++++++++++++++++++++++++++++++-
> > > >    drivers/vhost/vhost.h |  16 +++
> > > >    3 files changed, 327 insertions(+), 5 deletions(-)
> > > > 
> > > > diff --git a/drivers/vhost/test.c b/drivers/vhost/test.c
> > > > index 056308008288..39a018a7af2d 100644
> > > > --- a/drivers/vhost/test.c
> > > > +++ b/drivers/vhost/test.c
> > > > @@ -18,6 +18,9 @@
> > > >    #include "test.h"
> > > >    #include "vhost.h"
> > > > +static int newcode = 0;
> > > > +module_param(newcode, int, 0644);
> > > > +
> > > >    /* Max number of bytes transferred before requeueing the job.
> > > >     * Using this limit prevents one virtqueue from starving others. */
> > > >    #define VHOST_TEST_WEIGHT 0x80000
> > > > @@ -58,10 +61,16 @@ static void handle_vq(struct vhost_test *n)
> > > >    	vhost_disable_notify(&n->dev, vq);
> > > >    	for (;;) {
> > > > -		head = vhost_get_vq_desc(vq, vq->iov,
> > > > -					 ARRAY_SIZE(vq->iov),
> > > > -					 &out, &in,
> > > > -					 NULL, NULL);
> > > > +		if (newcode)
> > > > +			head = vhost_get_vq_desc_batch(vq, vq->iov,
> > > > +						       ARRAY_SIZE(vq->iov),
> > > > +						       &out, &in,
> > > > +						       NULL, NULL);
> > > > +		else
> > > > +			head = vhost_get_vq_desc(vq, vq->iov,
> > > > +						 ARRAY_SIZE(vq->iov),
> > > > +						 &out, &in,
> > > > +						 NULL, NULL);
> > > >    		/* On error, stop handling until the next kick. */
> > > >    		if (unlikely(head < 0))
> > > >    			break;
> > > > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > > > index 36ca2cf419bf..36661d6cb51f 100644
> > > > --- a/drivers/vhost/vhost.c
> > > > +++ b/drivers/vhost/vhost.c
> > > > @@ -301,6 +301,7 @@ static void vhost_vq_reset(struct vhost_dev *dev,
> > > >    			   struct vhost_virtqueue *vq)
> > > >    {
> > > >    	vq->num = 1;
> > > > +	vq->ndescs = 0;
> > > >    	vq->desc = NULL;
> > > >    	vq->avail = NULL;
> > > >    	vq->used = NULL;
> > > > @@ -369,6 +370,9 @@ static int vhost_worker(void *data)
> > > >    static void vhost_vq_free_iovecs(struct vhost_virtqueue *vq)
> > > >    {
> > > > +	kfree(vq->descs);
> > > > +	vq->descs = NULL;
> > > > +	vq->max_descs = 0;
> > > >    	kfree(vq->indirect);
> > > >    	vq->indirect = NULL;
> > > >    	kfree(vq->log);
> > > > @@ -385,6 +389,10 @@ static long vhost_dev_alloc_iovecs(struct vhost_dev *dev)
> > > >    	for (i = 0; i < dev->nvqs; ++i) {
> > > >    		vq = dev->vqs[i];
> > > > +		vq->max_descs = dev->iov_limit;
> > > > +		vq->descs = kmalloc_array(vq->max_descs,
> > > > +					  sizeof(*vq->descs),
> > > > +					  GFP_KERNEL);
> > > 
> > > Is iov_limit too much here? It can obviously increase the footprint. I guess
> > > the batching can only be done for descriptor without indirect or next set.
> > > Then we may batch 16 or 64.
> > > 
> > > Thanks
> > Yes, next patch only batches up to 64.  But we do need iov_limit because
> > guest can pass a long chain of scatter/gather.
> > We already have iovecs in a huge array so this does not look like
> > a big deal. If we ever teach the code to avoid the huge
> > iov arrays by handling huge s/g lists piece by piece,
> > we can make the desc array smaller at the same point.
> > 
> 
> Another possible issue, if we try to batch descriptor chain when we've
> already batched some descriptors, we may reach the limit then some of the
> descriptors might need re-read.
> 
> Or we may need circular index (head, tail) in this case?
> 
> Thanks

We never supported more than IOV_MAX descriptors.
And we don't batch more than iov_limit - IOV_MAX.

so buffer never overflows.

-- 
MST
