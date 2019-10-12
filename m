Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A583DC4CECE
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 20:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F5B720700
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 20:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729634AbfJLU1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 16:27:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37476 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729494AbfJLU1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 16:27:50 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0670FC010925
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2019 20:27:49 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id n3so5452806wmf.3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2019 13:27:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=EqTOWjC4L/Kz6sFQs9jCsgXd8dSNgdgkSYjDXmXjolo=;
        b=CyAAMNaLucvqhQxAg6GywlXTsPt/BtbFiweWtobtDUf/JXdyLPNFlu3BkpsbAzFe1a
         AECmsjFAagczIoINMR0sec+rcsKJzOOEo7x0+J8Yf0/M729+Vsbp/EhwqVGmNwWjsBRG
         0vkt5oCY45nQwc04fLbYAW+zCZZ0obsOCAeuD9RIGqkJJ6QF9BBQi6IunS8Fm7q1iW1Y
         Rwjb0/D1hqPQHTnRuzexn9KNE35Jb5XpluPVSNnYzo3YjRBOSUU0IYWpZudK9K/NcrLj
         fKkbYtyoof2ew7RivEIqD5qc67ICEdp2mbfihpgjD2+jNlme4IJdA608c1+OHAwyB2p0
         VidA==
X-Gm-Message-State: APjAAAVFrv+ckqYwPVnMGpjJIZEGWV4TfDBQ8hV+BPnxDZVNhhNihtRQ
        wa4sCrw7ufIFDF5PaNusmaPfCnpTBK9O7cvq54/4ltNh/EnS0xM70lBuPIYYckjh+JAk/eVFgPK
        fGRaCDulik1ASgvtz6TyJswXX
X-Received: by 2002:a05:600c:21c8:: with SMTP id x8mr7778917wmj.123.1570912067637;
        Sat, 12 Oct 2019 13:27:47 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwQzyMBrFDfWTdK5lUQ3sY5hHb4OoDfa1GaxOr1ruBpGf2toaNre0YJeRWwm2tOu4hgB0VNpQ==
X-Received: by 2002:a05:600c:21c8:: with SMTP id x8mr7778905wmj.123.1570912067370;
        Sat, 12 Oct 2019 13:27:47 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
        by smtp.gmail.com with ESMTPSA id s9sm14550556wme.36.2019.10.12.13.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2019 13:27:46 -0700 (PDT)
Date:   Sat, 12 Oct 2019 16:27:43 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH RFC v1 1/2] vhost: option to fetch descriptors through an
 independent struct
Message-ID: <20191012162445-mutt-send-email-mst@kernel.org>
References: <20191011134358.16912-1-mst@redhat.com>
 <20191011134358.16912-2-mst@redhat.com>
 <3b2a6309-9d21-7172-a581-9f0f1d5c1427@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3b2a6309-9d21-7172-a581-9f0f1d5c1427@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 12, 2019 at 03:28:49PM +0800, Jason Wang wrote:
> 
> On 2019/10/11 下午9:45, Michael S. Tsirkin wrote:
> > The idea is to support multiple ring formats by converting
> > to a format-independent array of descriptors.
> > 
> > This costs extra cycles, but we gain in ability
> > to fetch a batch of descriptors in one go, which
> > is good for code cache locality.
> > 
> > To simplify benchmarking, I kept the old code
> > around so one can switch back and forth by
> > writing into a module parameter.
> > This will go away in the final submission.
> > 
> > This patch causes a minor performance degradation,
> > it's been kept as simple as possible for ease of review.
> > Next patch gets us back the performance by adding batching.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >   drivers/vhost/test.c  |  17 ++-
> >   drivers/vhost/vhost.c | 299 +++++++++++++++++++++++++++++++++++++++++-
> >   drivers/vhost/vhost.h |  16 +++
> >   3 files changed, 327 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/vhost/test.c b/drivers/vhost/test.c
> > index 056308008288..39a018a7af2d 100644
> > --- a/drivers/vhost/test.c
> > +++ b/drivers/vhost/test.c
> > @@ -18,6 +18,9 @@
> >   #include "test.h"
> >   #include "vhost.h"
> > +static int newcode = 0;
> > +module_param(newcode, int, 0644);
> > +
> >   /* Max number of bytes transferred before requeueing the job.
> >    * Using this limit prevents one virtqueue from starving others. */
> >   #define VHOST_TEST_WEIGHT 0x80000
> > @@ -58,10 +61,16 @@ static void handle_vq(struct vhost_test *n)
> >   	vhost_disable_notify(&n->dev, vq);
> >   	for (;;) {
> > -		head = vhost_get_vq_desc(vq, vq->iov,
> > -					 ARRAY_SIZE(vq->iov),
> > -					 &out, &in,
> > -					 NULL, NULL);
> > +		if (newcode)
> > +			head = vhost_get_vq_desc_batch(vq, vq->iov,
> > +						       ARRAY_SIZE(vq->iov),
> > +						       &out, &in,
> > +						       NULL, NULL);
> > +		else
> > +			head = vhost_get_vq_desc(vq, vq->iov,
> > +						 ARRAY_SIZE(vq->iov),
> > +						 &out, &in,
> > +						 NULL, NULL);
> >   		/* On error, stop handling until the next kick. */
> >   		if (unlikely(head < 0))
> >   			break;
> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > index 36ca2cf419bf..36661d6cb51f 100644
> > --- a/drivers/vhost/vhost.c
> > +++ b/drivers/vhost/vhost.c
> > @@ -301,6 +301,7 @@ static void vhost_vq_reset(struct vhost_dev *dev,
> >   			   struct vhost_virtqueue *vq)
> >   {
> >   	vq->num = 1;
> > +	vq->ndescs = 0;
> >   	vq->desc = NULL;
> >   	vq->avail = NULL;
> >   	vq->used = NULL;
> > @@ -369,6 +370,9 @@ static int vhost_worker(void *data)
> >   static void vhost_vq_free_iovecs(struct vhost_virtqueue *vq)
> >   {
> > +	kfree(vq->descs);
> > +	vq->descs = NULL;
> > +	vq->max_descs = 0;
> >   	kfree(vq->indirect);
> >   	vq->indirect = NULL;
> >   	kfree(vq->log);
> > @@ -385,6 +389,10 @@ static long vhost_dev_alloc_iovecs(struct vhost_dev *dev)
> >   	for (i = 0; i < dev->nvqs; ++i) {
> >   		vq = dev->vqs[i];
> > +		vq->max_descs = dev->iov_limit;
> > +		vq->descs = kmalloc_array(vq->max_descs,
> > +					  sizeof(*vq->descs),
> > +					  GFP_KERNEL);
> 
> 
> Is iov_limit too much here? It can obviously increase the footprint. I guess
> the batching can only be done for descriptor without indirect or next set.
> Then we may batch 16 or 64.
> 
> Thanks

Yes, next patch only batches up to 64.  But we do need iov_limit because
guest can pass a long chain of scatter/gather.
We already have iovecs in a huge array so this does not look like
a big deal. If we ever teach the code to avoid the huge
iov arrays by handling huge s/g lists piece by piece,
we can make the desc array smaller at the same point.


