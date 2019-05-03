Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D90C004C9
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 12:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2645A2063F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 12:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Q1s+yLF0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbfECM5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 08:57:22 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44196 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfECM5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 08:57:22 -0400
Received: by mail-ed1-f65.google.com with SMTP id b8so5867116edm.11
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 05:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VaxPQ6IeVmYMFGePLBrY6yLBQaxZgQlHXQuFLzQ/+d4=;
        b=Q1s+yLF06i2mWw5XUZDrN3OrhZkHA8MeRl3UBfwzVL1qD0zqGe2QutTZhtxhQAoE9D
         xvQ5wXPYNODkqxiQUF3mOTp7pZE9B7BCM+r90yRx6rXkZ45fnVut3oNIknNMHV9McNkz
         gnPbaALBFQupBUtkVTqzWtVenkPE2fscTIKqyRkAgsETnrM+I6zEsxcVGWz+wqVSLltU
         /EYGqnwmMsMHGuJW2fhPE0vGgNHR0K9Q8kz4UKmPnoynnLJRvhF0Cch3nRtebAg2LxL7
         sWpRPHoR6w4Xyl/FMtZRKVQr4qwfszDvBPp+SUx3ktr5jhhURApDYJ2I0IcQGnJaUENr
         hK5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VaxPQ6IeVmYMFGePLBrY6yLBQaxZgQlHXQuFLzQ/+d4=;
        b=uA0s9KXKhD4iALldOBPEJwjbZrF2zM4waOff+fP0PoOdTOZTLlnH/koSpd8b1P9+y4
         wPKJ/kAxdikQEkvDFFuNuOGZ7DC/IomLHbomvT38ySm/Hj5/tcU0lR9nNO+5UsKi8S7P
         ihWwZ0FHkWAgsszHgDjsr9fmzXJLtiA0kAp6uKD7iJR3PVK/fTuudsdFmzAfzyRabkBr
         qJgEdisxb3VSFKH2zZZ/ZCmQNgjJTAwqZjMNI6sNpW8/TSNXRvdJc+dSwLyGhfv3YjPZ
         QVTB4G9P9tUcWOplGkOfA3QxwRaYx+aUZT50kX+Rz8deFbvBS//Rpws3bOBFfAP2jYn5
         XGSQ==
X-Gm-Message-State: APjAAAWVoXrOi7qxO21n6MAEk73HV+qjF1Ute5B04UXqdLfhDa0THqF/
        swWCrt5ZUuOzAm5jJ08R2GD1Pi+Rkda13ZHh+Zp5aw==
X-Google-Smtp-Source: APXvYqxGpxdtpUzePQzoj8+ABR2xl3yPHLROkt/fFrbcMScpdOGg5GoJBHZkg6V088MaY7vMf4/rxnhdCFk/G/55mD8=
X-Received: by 2002:a50:b56a:: with SMTP id z39mr8130377edd.91.1556888240692;
 Fri, 03 May 2019 05:57:20 -0700 (PDT)
MIME-Version: 1.0
References: <155552633539.2015392.2477781120122237934.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155552634586.2015392.2662168839054356692.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CA+CK2bCkqLc82G2MW+rYrKTi4KafC+tLCASkaT8zRfVJCCe8HQ@mail.gmail.com>
 <CAPcyv4g+KNu=upejy7Xm=jWR0cdhygPAdSRbkfFGpJeHFGc4+w@mail.gmail.com> <bd76cb2f-7cdc-f11b-11ec-285862db66f3@arm.com>
In-Reply-To: <bd76cb2f-7cdc-f11b-11ec-285862db66f3@arm.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Fri, 3 May 2019 08:57:09 -0400
Message-ID: <CA+CK2bBS5Csz0O9sDVwt_NjtrBtLaMfkycjhaOmR7mXoKJ5XEg@mail.gmail.com>
Subject: Re: [PATCH v6 02/12] mm/sparsemem: Introduce common definitions for
 the size and mask of a section
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-mm <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 3, 2019 at 6:35 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 03/05/2019 01:41, Dan Williams wrote:
> > On Thu, May 2, 2019 at 7:53 AM Pavel Tatashin <pasha.tatashin@soleen.co=
m> wrote:
> >>
> >> On Wed, Apr 17, 2019 at 2:52 PM Dan Williams <dan.j.williams@intel.com=
> wrote:
> >>>
> >>> Up-level the local section size and mask from kernel/memremap.c to
> >>> global definitions.  These will be used by the new sub-section hotplu=
g
> >>> support.
> >>>
> >>> Cc: Michal Hocko <mhocko@suse.com>
> >>> Cc: Vlastimil Babka <vbabka@suse.cz>
> >>> Cc: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
> >>> Cc: Logan Gunthorpe <logang@deltatee.com>
> >>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> >>
> >> Should be dropped from this series as it has been replaced by a very
> >> similar patch in the mainline:
> >>
> >> 7c697d7fb5cb14ef60e2b687333ba3efb74f73da
> >>   mm/memremap: Rename and consolidate SECTION_SIZE
> >
> > I saw that patch fly by and acked it, but I have not seen it picked up
> > anywhere. I grabbed latest -linus and -next, but don't see that
> > commit.
> >
> > $ git show 7c697d7fb5cb14ef60e2b687333ba3efb74f73da
> > fatal: bad object 7c697d7fb5cb14ef60e2b687333ba3efb74f73da
>
> Yeah, I don't recognise that ID either, nor have I had any notifications
> that Andrew's picked up anything of mine yet :/

Sorry for the confusion. I thought I checked in a master branch, but
turns out I checked in a branch where I applied arm hotremove patches
and Robin's patch as well. These two patches are essentially the same,
so which one goes first the other should be dropped.

Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>

Thank you,
Pasha

>
> Robin.
