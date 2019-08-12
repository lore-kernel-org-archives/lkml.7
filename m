Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9855EC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 15:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6893C20665
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 15:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W1JJqGlN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbfHLPUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 11:20:55 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33452 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbfHLPUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 11:20:54 -0400
Received: by mail-ot1-f65.google.com with SMTP id q20so7232826otl.0;
        Mon, 12 Aug 2019 08:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y942T0sqUtRFxvyP+0sjKx+0c1PT5SZ2qa8t2fKDAFs=;
        b=W1JJqGlN7ks0BxXMoB5/KNFf0nROJKOybkqJ3cMs4ab0iL75KVUafriWVN/E2cXEcY
         O3K1ggu/sQaRj/xiNZ9O7MVWaLBiZMFdO/1MnRO6Vk7ME3/5peR5kdpkxJuB5oyachfk
         8A1p9DZAF9gn9rQq4QW/RoiO9zf46h9rMAh9Ngv1G3Mxc8W8iKJU1rZhENWpQoBn1MkR
         q/rd7cfqkWyzM2uJ71cL67Hm2hPCH/+QkjFnruZEGUER+hIwreqxsfn5TzbhXzuO8BZc
         qd8my03dztvuYLIviS608mRiHqNoxRJ2sL4KscopZRh1NZJKF6FXfZ2kl0V6Z2nAkT5k
         67PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y942T0sqUtRFxvyP+0sjKx+0c1PT5SZ2qa8t2fKDAFs=;
        b=mUMFvU94jsjcE3Wj2/5yJ0pUM7CfkybzsWzM2/fCnlokfFwJHMcp+o7zhH498hA/4p
         vQNf3BZ14S305mu/PngAKJ6qjw/icBUTGDThWcPiOXoI/T+kd8UVN7RxxP7rwuYfhoGz
         +SX7oJTCX/3ad2ptKW30E/qG5wDW5J/7pIq4e4QakW0YVFoy2Msny52vtbzuLaAijtxs
         j/E8cGTyWSw0fafCYKQPWFTDWZ+t9isQgiQeV2uubV315Jnc0iL+0PAPlA3aimugermR
         SuaKfpeFArU0DML3DvpvoZ2+fnqXlfLbxl+zvYNi8z/AxQELXCEplQGAsTjiysdFoArJ
         NECg==
X-Gm-Message-State: APjAAAWdCGrzNuzgGPaHwLrOHdVj8bRt7sHqdZQRxx0h/6xWA5hCwonc
        eu2GUUAMGdiipARW/CecK6WmIiR34Ko8FOy24H0=
X-Google-Smtp-Source: APXvYqy9RJAJ67fbKLDTn0LncfVL9ev90bkQOYTqrem2KxlTH8J/PW8bomoaqWAAmMVPPE6mcs7yIw7PbWL3Dvd97d4=
X-Received: by 2002:a5e:8c11:: with SMTP id n17mr33490391ioj.64.1565623253892;
 Mon, 12 Aug 2019 08:20:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190807224037.6891.53512.stgit@localhost.localdomain>
 <20190807224219.6891.25387.stgit@localhost.localdomain> <20190812055054-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190812055054-mutt-send-email-mst@kernel.org>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Mon, 12 Aug 2019 08:20:43 -0700
Message-ID: <CAKgT0Ucr7GKWsP5sxSbDTtW_7puSqwXDM7y_ZD8i2zNrKNScEw@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] virtio-balloon: Add support for providing unused
 page reports to host
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Nitesh Narayan Lal <nitesh@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
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
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 2:53 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Aug 07, 2019 at 03:42:19PM -0700, Alexander Duyck wrote:
> > From: Alexander Duyck <alexander.h.duyck@linux.intel.com>

<snip>

> > --- a/include/uapi/linux/virtio_balloon.h
> > +++ b/include/uapi/linux/virtio_balloon.h
> > @@ -36,6 +36,7 @@
> >  #define VIRTIO_BALLOON_F_DEFLATE_ON_OOM      2 /* Deflate balloon on OOM */
> >  #define VIRTIO_BALLOON_F_FREE_PAGE_HINT      3 /* VQ to report free pages */
> >  #define VIRTIO_BALLOON_F_PAGE_POISON 4 /* Guest is using page poisoning */
> > +#define VIRTIO_BALLOON_F_REPORTING   5 /* Page reporting virtqueue */
> >
> >  /* Size of a PFN in the balloon interface. */
> >  #define VIRTIO_BALLOON_PFN_SHIFT 12
>
> Just a small comment: same as any feature bit,
> or indeed any host/guest interface changes, please
> CC virtio-dev on any changes to this UAPI file.
> We must maintain these in the central place in the spec,
> otherwise we run a risk of conflicts.
>

Okay, other than that if I resubmit with the virtio-dev list added to
you thing this patch set is ready to be acked and pulled into either
the virtio or mm tree assuming there is no other significant feedback
that comes in?

Thanks.

- Alex
