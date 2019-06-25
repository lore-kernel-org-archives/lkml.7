Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 967DCC48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 17:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 623EC216C8
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 17:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ocl1bNLr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729637AbfFYRBE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 13:01:04 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43821 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728506AbfFYRBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 13:01:04 -0400
Received: by mail-io1-f67.google.com with SMTP id k20so10438ios.10;
        Tue, 25 Jun 2019 10:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4nh5j4XcTvP6By9QhoNnt2Wmf1hC1P4k60SdPp76T0k=;
        b=Ocl1bNLr8OYzeu9TD1azuErTT8IzFHOcI287iJQWs6IMZ/x2MG20iUj2WdhhmYvmAv
         Zk5lyLTO6h+MThMdU2/+IIXgapLAdfy2/NzsZHUjjaHkdyR8SzJzifePWoWbt2Wk3V+V
         nAbOwcLUJ9Hzk/CkONjV89hTvByIB7QPw8pEzrfdP7W/CK2CUge/r97cvhG3Gy4B7CI6
         YHfgMuJdDTDFbHKdRWU1tXveDuOZHRJ5jeZpZQvhhX3oU5ZlvAibv+TUloulaHhRuw39
         FkQ4i8MfMB6AuCUZwqXTORgKRnBx9uEKm2Qe6caTvo6JaiEm28MA9JxSpIIvZ8onjSa3
         FiUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4nh5j4XcTvP6By9QhoNnt2Wmf1hC1P4k60SdPp76T0k=;
        b=N2ueKvvlUI8K5pOgr7n5J8hn6Ae0KrX8jnK0lwtN/yZDa6PSoHwFluPJ7M/BUTjKOS
         oGLeOWKj6zB9lXkEa6sfX32lVrPCdrFGydELRLH4AgTdzcGoA/yPfmmIjZN0FAy+OdBM
         RFT95JgNN7DhVCJNT+vuDZmzPie+DGrTmn+ZsupcXvsHmGL0R/tzMzH7qPrHFJC9Msh1
         /IWZ84FvC7LKH+AyIir98j+kGHdpT5VKH89SIcviJqfkcL1mT0UB4UyhyLh0IiZY6JNl
         yChPjCaa9d/PHMxaRv3B2aGOWZFfLJ9kZ+0ehGu2pYKv3g3kE20VE6TCz80dipZjZpur
         d3Iw==
X-Gm-Message-State: APjAAAVnMXOUkBMJID0trQIVoBa6GX29ZW65kJx01r3duj4ckVsAPr3t
        Hl/Du2xpY/sdHvfcgM1CUbpE9iEYV4qh4lV2kfZmWJ5t
X-Google-Smtp-Source: APXvYqzlYWj2ApUnurVtHQQxOd0ZImZSLCuMNUPe0E/UsQDrF+TtQT0+vIgxTiOE1J5+2kko7cJoekjiCl+Pxhleo7k=
X-Received: by 2002:a6b:5106:: with SMTP id f6mr17350556iob.15.1561482063168;
 Tue, 25 Jun 2019 10:01:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190619222922.1231.27432.stgit@localhost.localdomain>
 <ff133df4-6291-bece-3d8d-dc3f12f398cf@redhat.com> <8fea71ba-2464-ead8-3802-2241805283cc@intel.com>
In-Reply-To: <8fea71ba-2464-ead8-3802-2241805283cc@intel.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Tue, 25 Jun 2019 10:00:51 -0700
Message-ID: <CAKgT0UdAj4Kq8qHKkaiB3z08gCQh-jovNpos45VcGHa_v5aFGg@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] mm / virtio: Provide support for paravirtual waste
 page treatment
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Zhang <yang.zhang.wz@gmail.com>, pagupta@redhat.com,
        Rik van Riel <riel@surriel.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        lcapitulino@redhat.com, wei.w.wang@intel.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, dan.j.williams@intel.com,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 7:10 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 6/25/19 12:42 AM, David Hildenbrand wrote:
> > On 20.06.19 00:32, Alexander Duyck wrote:
> > I still *detest* the terminology, sorry. Can't you come up with a
> > simpler terminology that makes more sense in the context of operating
> > systems and pages we want to hint to the hypervisor? (that is the only
> > use case you are using it for so far)
>
> It's a wee bit too cute for my taste as well.  I could probably live
> with it in the data structures, but having it show up out in places like
> Kconfig and filenames goes too far.
>
> For instance, someone seeing memory_aeration.c will have no concept
> what's in the file.  Could we call it something like memory_paravirt.c?
>  Or even mm/paravirt.c.

Well I couldn't come up with a better explanation of what this was
doing, also I wanted to avoid mentioning hinting specifically because
there have already been a few series that have been committed upstream
that reference this for slightly different purposes such as the one by
Wei Wang that was doing free memory tracking for migration purposes,
https://lkml.org/lkml/2018/7/10/211.

Basically what we are doing is inflating the memory size we can report
by inserting voids into the free memory areas. In my mind that matches
up very well with what "aeration" is. It is similar to balloon in
functionality, however instead of inflating the balloon we are
inflating the free_list for higher order free areas by creating voids
where the madvised pages were.

> Could you talk for a minute about why the straightforward naming like
> "hinted/unhinted" wasn't used?  Is there something else we could ever
> use this infrastructure for that is not related to paravirtualized free
> page hinting?

I was hoping there might be something in the future that could use the
infrastructure if it needed to go through and sort out used versus
unused memory. The way things are designed right now for instance
there is only really a define that is limiting the lowest order pages
that are processed. So if we wanted to use this for another purpose we
could replace the AERATOR_MIN_ORDER define with something that is
specific to that use case.
