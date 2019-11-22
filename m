Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C773C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 22:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CA282070E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 22:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="Rbsu0mdI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfKVWwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 17:52:38 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39263 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbfKVWwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 17:52:38 -0500
Received: by mail-ot1-f67.google.com with SMTP id w24so7625442otk.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 14:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tMJYperTaWW9B5cjv6OfL9Z7Y/zX/rl4iTRjBSXhv9Q=;
        b=Rbsu0mdINhGdn4Yen92e+l8i7scAEbACAdgfECz4skPbUUq3Z90+cX2Du/bjdaDjlS
         FcP39JriBOkr4cwXgl6dYentJve2gTxqlPkcKOjkZuVcXwBkounuwBgB1/OTAarCilb4
         Xi8Oh+elkGG11yU7q0emKSzs6JvjEkeucmiH5lxuKVt++ykW0ahEP+CwbPzoX51/VXNs
         MNpK8PYzdrxLOvJAH6bl35yvsuabsVwqZ0Bom4pS7we3llz8CHMELHpFLBx9qn5szPcM
         CI5v4zBIGmuLgqwmQdD+S0okwtzt0IBKV3ml+j8oKcmWU9kBQG2cK9XaaKEWVdF48hdy
         8QDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tMJYperTaWW9B5cjv6OfL9Z7Y/zX/rl4iTRjBSXhv9Q=;
        b=q5tCoHOOngTBMMEX1NQmPphK2DTeLrl7rnSjnCjDi5zWBjT6KUtdZpYlEMsrXFBqEw
         f+FidHTSVb24JR5n+kjmRYO/+1nM3187p4JaUsRX8qNNwOrdFS1538VFMDHFnKiLvRuY
         aSaLtLjBis8AB9SpRb90jjpHhjmmVhFTNKFAOOmoyWgJOSQRuUiOolzf8mbVGkbwv0vq
         TprPlrjNnOudVm+iw3B5HdC0/6fSZO5VgLMKc6+ef/wDwjFSmGHH2BxE9jOwaiamijXK
         2H+LM0qEuDkn3lN/l5oLCbU0E7tT7w2Y7ig7VEeNQDdfPC7D+LkkCd7fjzigXGX2IRqT
         TwhA==
X-Gm-Message-State: APjAAAUE7gYhuPZvv7JI6NnoAKARbcFVPaG1srmCNWoXJLcYvET7PXK7
        6q81BFnhzXTTGIAp8EXQwZbtJp/HCDqNpRHlHV4nNQ==
X-Google-Smtp-Source: APXvYqxY2V0mjivtMT3n0BRaoTh60B05oEUC9GsIKrplGnELg7aWD7Hi1UrurxG7LsF1J9tK4ilExHly03E7adsKzuE=
X-Received: by 2002:a9d:30c8:: with SMTP id r8mr12840505otg.363.1574463157247;
 Fri, 22 Nov 2019 14:52:37 -0800 (PST)
MIME-Version: 1.0
References: <20191120092831.6198-1-pagupta@redhat.com> <x49d0dmihmu.fsf@segfault.boston.devel.redhat.com>
 <CAPcyv4gCe8k1GdatAWn1991pm3QZq2WBFAGEFsZ2PXpyo2=wMw@mail.gmail.com>
 <CAPcyv4hJ6gHX=NYz-CoXFSrN93HUT+Xh+DP+QAjzqgGmmghmGA@mail.gmail.com>
 <1617854972.35808055.1574323227395.JavaMail.zimbra@redhat.com>
 <CAPcyv4haUOM92uzCBfVyrANxnNHKucivq053MFBmGOL3vqMgwQ@mail.gmail.com>
 <560894997.35969622.1574397521533.JavaMail.zimbra@redhat.com>
 <CAPcyv4gsQXY5C5URF2vrTaD-0Q_CJ+ib3GVb1VFZAO+1Gdau2w@mail.gmail.com> <838611538.35971353.1574401020319.JavaMail.zimbra@redhat.com>
In-Reply-To: <838611538.35971353.1574401020319.JavaMail.zimbra@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 22 Nov 2019 14:52:25 -0800
Message-ID: <CAPcyv4iZ5Ym3u9OiRFoPSxVa9p7ofzo8wf46JNsJnSjDx33RJg@mail.gmail.com>
Subject: Re: [PATCH] virtio pmem: fix async flush ordering
To:     Pankaj Gupta <pagupta@redhat.com>
Cc:     Jeff Moyer <jmoyer@redhat.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Vivek Goyal <vgoyal@redhat.com>,
        Keith Busch <keith.busch@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 9:37 PM Pankaj Gupta <pagupta@redhat.com> wrote:
>
>
> > > > > > >
> > > > > > > I added that and was about to push this out, but what about the
> > > > > > > fact
> > > > > > > that now the guest will synchronously wait for flushing to occur.
> > > > > > > The
> > > > > > > goal of the child bio was to allow that to be an I/O wait with
> > > > > > > overlapping I/O, or at least not blocking the submission thread.
> > > > > > > Does
> > > > > > > the block layer synchronously wait for PREFLUSH requests? If not I
> > > > > > > think a synchronous wait is going to be a significant performance
> > > > > > > regression. Are there any numbers to accompany this change?
> > > > > >
> > > > > > Why not just swap the parent child relationship in the PREFLUSH case?
> > > > >
> > > > > I we are already inside parent bio "make_request" function and we
> > > > > create
> > > > > child
> > > > > bio. How we exactly will swap the parent/child relationship for
> > > > > PREFLUSH
> > > > > case?
> > > > >
> > > > > Child bio is queued after parent bio completes.
> > > >
> > > > Sorry, I didn't quite mean with bio_split, but issuing another request
> > > > in front of the real bio. See md_flush_request() for inspiration.
> > >
> > > o.k. Thank you. Will try to post patch today to be considered for 5.4.
> > >
> >
> > I think it is too late for v5.4-final, but we can get it in the
> > -stable queue. Let's take the time to do it right and get some testing
> > on it.
>
> Sure.
>
> Just sharing probable patch for early feedback, if I am doing it correctly?
> I will test it thoroughly.
>
> Thanks,
> Pankaj
>
> ========
>
> diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.c
> index 10351d5b49fa..c683e0e2515c 100644
> --- a/drivers/nvdimm/nd_virtio.c
> +++ b/drivers/nvdimm/nd_virtio.c
> @@ -112,6 +112,12 @@ int async_pmem_flush(struct nd_region *nd_region, struct bio *bio)
>                 bio_copy_dev(child, bio);
>                 child->bi_opf = REQ_PREFLUSH;
>                 child->bi_iter.bi_sector = -1;
> +
> +               if (unlikely(bio->bi_opf & REQ_PREFLUSH)) {
> +                       struct request_queue *q = bio->bi_disk->queue;
> +                       q->make_request_fn(q, child);
> +                       return 0;
> +               }
>                 bio_chain(child, bio);
>                 submit_bio(child);

In the md case there is a lower level device to submit to. In this
case I expect you would

- create a flush workqueue
- queue the bio that workqueue and wait for any previous flush request
to complete (md_flush_request does this)
- run virtio_pmem_flush
- complete the original bio

Is there a way to make virtio_pmem_flush() get an interrupt when the
flush is complete rather than synchronously waiting. That way if you
get a storm of flush requests you can coalesce them like
md_flush_request() does.
