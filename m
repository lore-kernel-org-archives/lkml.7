Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D071C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 16:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F99B206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 16:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kx0HfBYD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbfHLQJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 12:09:50 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:47085 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbfHLQJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 12:09:49 -0400
Received: by mail-ot1-f65.google.com with SMTP id z17so42350231otk.13;
        Mon, 12 Aug 2019 09:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QDjWy6zxgGdSDhJob+297Umxwr1TMxaLNkT4pYebqjI=;
        b=Kx0HfBYDrxN4e4uoSy1GSgWI+WokAnRWf3yS1svPrjsV8mHWlsmkRjzF3ANg5aSf6W
         ygJ33vA/pZC4kxseu9nRIlcpcIqW2wnn+3zborGy5gH+85Slm6/QOh10uhv29y70Mrko
         hnt+L7d/l104Bwmn8r992nsTM3uS1VICFBJDmh+eZnP1EuGDcIhsBgM8hX8q8Rnp6rRH
         Tu1sqknWU7+cm5j8m2cPdtcxQtwuyICiZ0X7p2uUVVQALBtMX9DzDxYOnQ+AaAwvySNi
         qDi20vU3RZzmgy3Xveef91D+ogyh+PJaC6Nr87pB3OPxtqjdQpa9ldvm/Kz4e6jLYG3U
         tDmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QDjWy6zxgGdSDhJob+297Umxwr1TMxaLNkT4pYebqjI=;
        b=g0c1URa4szUEQ526294yzymovWdKHZSmdwMsneq59ismoumchpx7KA3TsmMRxLATlH
         deEfQjKYq6OjtR8WkbG+aS/1uL893WnReUGXPgsFr/4VL//3K3xb9qocazyTDxumdLrT
         NQVW8LshWHZNVp3jP2Hv0Ec6Y6Uck5QsgV2ibHysnUlZ/ABDtMOqOL+eits/bgreFTPG
         oY+nbOmq6ndV8M4ubfevZqsc2+K2XiJjPiHSxeScLuBprd08SK6BK3Ho+Zuhjo4rq1fV
         /byZmgcMHew5lJ46oBZKt81V+mPmXGc35Jvq5ZH/Ai+0XVtvDyRY1oIJVuS1gXwTX8VJ
         9ODA==
X-Gm-Message-State: APjAAAXFAX1DK0xR/YYQ8AW9s2cEZ3DWkde1yA7Q005vmfUXncz+rE0H
        woYKpulKdvNOuD82tvYdbIAK2EzK4tSVnzp4Cbs=
X-Google-Smtp-Source: APXvYqwjCFQtckcxTzRGTeLLfqB5wY7X1qdlmFTvbdZpoH+ulXS1sqQPzBG21vx5nUc0Uvx1m3t9PDe8OKOcRfULw3E=
X-Received: by 2002:a6b:b549:: with SMTP id e70mr27581914iof.95.1565626187859;
 Mon, 12 Aug 2019 09:09:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190807224037.6891.53512.stgit@localhost.localdomain>
 <20190807224219.6891.25387.stgit@localhost.localdomain> <20190812055054-mutt-send-email-mst@kernel.org>
 <CAKgT0Ucr7GKWsP5sxSbDTtW_7puSqwXDM7y_ZD8i2zNrKNScEw@mail.gmail.com> <ddb2c4a9-c515-617f-770a-90625c08c829@redhat.com>
In-Reply-To: <ddb2c4a9-c515-617f-770a-90625c08c829@redhat.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Mon, 12 Aug 2019 09:09:36 -0700
Message-ID: <CAKgT0UekkEDPxDQ6J5uQZb92UDMq_fgHHo+tzGVP-jLWNAOp9w@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] virtio-balloon: Add support for providing unused
 page reports to host
To:     David Hildenbrand <david@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Zhang <yang.zhang.wz@gmail.com>, pagupta@redhat.com,
        Rik van Riel <riel@surriel.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, lcapitulino@redhat.com,
        wei.w.wang@intel.com, Andrea Arcangeli <aarcange@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, dan.j.williams@intel.com,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 8:50 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 12.08.19 17:20, Alexander Duyck wrote:
> > On Mon, Aug 12, 2019 at 2:53 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >>
> >> On Wed, Aug 07, 2019 at 03:42:19PM -0700, Alexander Duyck wrote:
> >>> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> >
> > <snip>
> >
> >>> --- a/include/uapi/linux/virtio_balloon.h
> >>> +++ b/include/uapi/linux/virtio_balloon.h
> >>> @@ -36,6 +36,7 @@
> >>>  #define VIRTIO_BALLOON_F_DEFLATE_ON_OOM      2 /* Deflate balloon on OOM */
> >>>  #define VIRTIO_BALLOON_F_FREE_PAGE_HINT      3 /* VQ to report free pages */
> >>>  #define VIRTIO_BALLOON_F_PAGE_POISON 4 /* Guest is using page poisoning */
> >>> +#define VIRTIO_BALLOON_F_REPORTING   5 /* Page reporting virtqueue */
> >>>
> >>>  /* Size of a PFN in the balloon interface. */
> >>>  #define VIRTIO_BALLOON_PFN_SHIFT 12
> >>
> >> Just a small comment: same as any feature bit,
> >> or indeed any host/guest interface changes, please
> >> CC virtio-dev on any changes to this UAPI file.
> >> We must maintain these in the central place in the spec,
> >> otherwise we run a risk of conflicts.
> >>
> >
> > Okay, other than that if I resubmit with the virtio-dev list added to
> > you thing this patch set is ready to be acked and pulled into either
> > the virtio or mm tree assuming there is no other significant feedback
> > that comes in?
> >
>
> I want to take a detailed look at the mm bits (might take a bit but I
> don't see a need to rush). I am fine with the page flag we are using.
> Hope some other mm people (cc'ing Michal and Oscar) can have a look.

Agreed. I just wanted to make sure we had the virtio bits locked in as
my concern was that some of the other MM maintainers might be waiting
on that.

I'll see about submitting a v5, hopefully before the end of today with
Michal, Oscar, and the virtio-dev mailing list also included.

Thanks.

- Alex
