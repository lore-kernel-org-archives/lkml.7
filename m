Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3DD7C76191
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B23B217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbfGXUqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 16:46:12 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38714 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbfGXUqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 16:46:12 -0400
Received: by mail-qt1-f195.google.com with SMTP id n11so46897635qtl.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 13:46:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kEmnRIh7eb5SZPPwt0SSGdzpr7hhPeFdagIv+/tAxBM=;
        b=Gw0xGDVCfpuSMyl2fm340k+ukP7D53VeKuytSeB5yHAV6OK6i49TVgGh/eM28rKMFL
         nmM7OPaUP2HO4fhhNWuiPzrneBwdSut96RSLLfTY8Y9fd+3Q/5kYVjPXLNh4Ab8epNj/
         E6fEBRpc0LG5fRvspCa2+MOPR8rEEb1ehRoQiQqEi9LlBAereURlty/k4Nvgx0jjkYsW
         GLE9cQqRuOhItZPspd7Se8J6Bm/aVFP6VbsCDORD0HLiXGoRqq5jSghEK97T49yoy0Tw
         awPmHqxTCi4M617ckBSNefki4L4HES3hHk3WHSalNWomEcCPTsBQZJUEwlKOSd1xOfdZ
         jLVQ==
X-Gm-Message-State: APjAAAWzDTbDL7VEC0LkUCFRQasfrEsFYm8UpiQcN9wevoxY3yxaK8/W
        zUVKElayPRTUYa/n+/RXxqDCKQ==
X-Google-Smtp-Source: APXvYqwbpIKZ55eh/98dX0EXGRSXf9HthV7sKQoo76sbcztNZu/6XKn9qDAYGtrzpMy5Z2naK3MXlQ==
X-Received: by 2002:ac8:5141:: with SMTP id h1mr59926940qtn.15.1564001170693;
        Wed, 24 Jul 2019 13:46:10 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
        by smtp.gmail.com with ESMTPSA id c5sm29604425qta.5.2019.07.24.13.46.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 13:46:09 -0700 (PDT)
Date:   Wed, 24 Jul 2019 16:46:03 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc:     Alexander Duyck <alexander.duyck@gmail.com>, nitesh@redhat.com,
        kvm@vger.kernel.org, david@redhat.com, dave.hansen@intel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, yang.zhang.wz@gmail.com,
        pagupta@redhat.com, riel@surriel.com, konrad.wilk@oracle.com,
        lcapitulino@redhat.com, wei.w.wang@intel.com, aarcange@redhat.com,
        pbonzini@redhat.com, dan.j.williams@intel.com
Subject: Re: [PATCH v2 QEMU] virtio-balloon: Provide a interface for "bubble
 hinting"
Message-ID: <20190724164433-mutt-send-email-mst@kernel.org>
References: <20190724165158.6685.87228.stgit@localhost.localdomain>
 <20190724171050.7888.62199.stgit@localhost.localdomain>
 <20190724150224-mutt-send-email-mst@kernel.org>
 <6218af96d7d55935f2cf607d47680edc9b90816e.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6218af96d7d55935f2cf607d47680edc9b90816e.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 01:18:00PM -0700, Alexander Duyck wrote:
> On Wed, 2019-07-24 at 15:02 -0400, Michael S. Tsirkin wrote:
> > On Wed, Jul 24, 2019 at 10:12:10AM -0700, Alexander Duyck wrote:
> > > From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > > 
> > > Add support for what I am referring to as "bubble hinting". Basically the
> > > idea is to function very similar to how the balloon works in that we
> > > basically end up madvising the page as not being used. However we don't
> > > really need to bother with any deflate type logic since the page will be
> > > faulted back into the guest when it is read or written to.
> > > 
> > > This is meant to be a simplification of the existing balloon interface
> > > to use for providing hints to what memory needs to be freed. I am assuming
> > > this is safe to do as the deflate logic does not actually appear to do very
> > > much other than tracking what subpages have been released and which ones
> > > haven't.
> > > 
> > > Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > > ---
> > >  hw/virtio/virtio-balloon.c                      |   40 +++++++++++++++++++++++
> > >  include/hw/virtio/virtio-balloon.h              |    2 +
> > >  include/standard-headers/linux/virtio_balloon.h |    1 +
> > >  3 files changed, 42 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> > > index 2112874055fb..70c0004c0f88 100644
> > > --- a/hw/virtio/virtio-balloon.c
> > > +++ b/hw/virtio/virtio-balloon.c
> > > @@ -328,6 +328,39 @@ static void balloon_stats_set_poll_interval(Object *obj, Visitor *v,
> > >      balloon_stats_change_timer(s, 0);
> > >  }
> > >  
> > > +static void virtio_bubble_handle_output(VirtIODevice *vdev, VirtQueue *vq)
> > > +{
> > > +    VirtQueueElement *elem;
> > > +
> > > +    while ((elem = virtqueue_pop(vq, sizeof(VirtQueueElement)))) {
> > > +    	unsigned int i;
> > > +
> > > +        for (i = 0; i < elem->in_num; i++) {
> > > +            void *addr = elem->in_sg[i].iov_base;
> > > +            size_t size = elem->in_sg[i].iov_len;
> > > +            ram_addr_t ram_offset;
> > > +            size_t rb_page_size;
> > > +            RAMBlock *rb;
> > > +
> > > +            if (qemu_balloon_is_inhibited())
> > > +                continue;
> > > +
> > > +            rb = qemu_ram_block_from_host(addr, false, &ram_offset);
> > > +            rb_page_size = qemu_ram_pagesize(rb);
> > > +
> > > +            /* For now we will simply ignore unaligned memory regions */
> > > +            if ((ram_offset | size) & (rb_page_size - 1))
> > > +                continue;
> > > +
> > > +            ram_block_discard_range(rb, ram_offset, size);
> > 
> > I suspect this needs to do like the migration type of
> > hinting and get disabled if page poisoning is in effect.
> > Right?
> 
> Shouldn't something like that end up getting handled via
> qemu_balloon_is_inhibited, or did I miss something there? I assumed cases
> like that would end up setting qemu_balloon_is_inhibited to true, if that
> isn't the case then I could add some additional conditions. I would do it
> in about the same spot as the qemu_balloon_is_inhibited check.

Well qemu_balloon_is_inhibited is for the regular ballooning,
mostly a work-around for limitations is host linux iommu
APIs when it's used with VFIO.

-- 
MST
