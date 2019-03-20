Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2084C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 06:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0A5620857
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 06:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gU1537TU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfCTGMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 02:12:03 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39518 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbfCTGMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 02:12:02 -0400
Received: by mail-ed1-f66.google.com with SMTP id p27so921790edc.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 23:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4pdlG2bv9u4nYOvNAww82/yTZQGVLCVPxU/0vGtTzfY=;
        b=gU1537TUVu0o6jkweFiV2wl7WckWWr8pX4dWC1xPJY7esUNmzZgZzdQLVjY6C0Ym1X
         PsRi1lQqwkloaITQdnENmfgt9GmqfKRFDczzaeeI8iMXodJ4NTcIngHasnMpa1VBHnQU
         VDwYSCkbIiut4IzAUnQrwa0XwQtI/krkYb65uYcTJRIlQHrc8WBlG7zeThAa1JpZ2Y5X
         ao2DT3HSfD+ExBw9gEPZldC1ZRqwjVAaOQYNQY2UlrYu1D+mhBtuN/WAgg5kV+NZHHYD
         WPRko/Z0qSdPtqzLu0h2P903DRuwoTCBxuxRA8yNagv8B7jzhZGR1veI2GZGW80AMSme
         Np3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4pdlG2bv9u4nYOvNAww82/yTZQGVLCVPxU/0vGtTzfY=;
        b=Pr+setbZeAhE2Q+i13waNAu41tUR+TQ3Utd7mG6W2itWZZvKhTlbzAuSnOuowZb4pX
         0n0IXnessPS6v3VUKF35SCDlUHGuyAS9Eua8pmVDcvNldy/ATFlYJJNJRH4NPXveg33M
         K0vU9sWF3LoE7pOsu3QjT1yKjCm8MT8JZ7hh8JklQIWDMyL7h2vHV5lsemqG+pK8RSJk
         TFVAMwcUGlE60U6b7wydbuQgPpbMLfGpl1vZ0aBAPiiVaJXLbsfowUiKyfS5PBKs4GrZ
         02UTGNoaABRBfXRF4XrI4yOOgMow35DahQ/y2nTIsoeZHWYX8Zj7FpG3CXdIhYF8jOgT
         8diA==
X-Gm-Message-State: APjAAAX+AFiq72tdGsHswzo+OLra91sd8AK4fDNBVTEnfUOIEh7OFbGo
        G1qIu3s4PczpQuEUiGSjKguGDEg1VSP4Q2FoQRs=
X-Google-Smtp-Source: APXvYqz4ubpGAUQW5X716FmcRb3LnIsD2xYaEgIzH6WD93F84jZXHe35n3xS1tcNjCPAMDJ7M8Qv3X2wcVNl8mLjy68=
X-Received: by 2002:a17:906:60d7:: with SMTP id f23mr15946849ejk.177.1553062320583;
 Tue, 19 Mar 2019 23:12:00 -0700 (PDT)
MIME-Version: 1.0
References: <1552561599-23662-1-git-send-email-huangzhaoyang@gmail.com> <alpine.DEB.2.21.1903191809420.18028@chino.kir.corp.google.com>
In-Reply-To: <alpine.DEB.2.21.1903191809420.18028@chino.kir.corp.google.com>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Wed, 20 Mar 2019 14:11:49 +0800
Message-ID: <CAGWkznH3Be5MSJi7_=Eoauf1=yZHaCTR4HL-gQH7_TORNEtzeQ@mail.gmail.com>
Subject: Re: [PATCH] driver : staging : ion: optimization for decreasing
 memory fragmentaion
To:     David Rientjes <rientjes@google.com>
Cc:     Chintan Pandya <cpandya@codeaurora.org>,
        Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 9:10 AM David Rientjes <rientjes@google.com> wrote:
>
> On Thu, 14 Mar 2019, Zhaoyang Huang wrote:
>
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > Two action for this patch:
> > 1. set a batch size for system heap's shrinker, which can have it buffer
> > reasonable page blocks in pool for future allocation.
> > 2. reverse the order sequence when free page blocks, the purpose is also
> > to have system heap keep as more big blocks as it can.
> >
> > By testing on an android system with 2G RAM, the changes with setting
> > batch = 48MB can help reduce the fragmentation obviously and improve
> > big block allocation speed for 15%.
> >
> > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > ---
> >  drivers/staging/android/ion/ion_heap.c        | 12 +++++++++++-
> >  drivers/staging/android/ion/ion_system_heap.c |  2 +-
> >  2 files changed, 12 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/staging/android/ion/ion_heap.c b/drivers/staging/android/ion/ion_heap.c
> > index 31db510..9e9caf2 100644
> > --- a/drivers/staging/android/ion/ion_heap.c
> > +++ b/drivers/staging/android/ion/ion_heap.c
> > @@ -16,6 +16,8 @@
> >  #include <linux/vmalloc.h>
> >  #include "ion.h"
> >
> > +unsigned long ion_heap_batch = 0;
>
> static?
ok
>
> > +
> >  void *ion_heap_map_kernel(struct ion_heap *heap,
> >                         struct ion_buffer *buffer)
> >  {
> > @@ -303,7 +305,15 @@ int ion_heap_init_shrinker(struct ion_heap *heap)
> >       heap->shrinker.count_objects = ion_heap_shrink_count;
> >       heap->shrinker.scan_objects = ion_heap_shrink_scan;
> >       heap->shrinker.seeks = DEFAULT_SEEKS;
> > -     heap->shrinker.batch = 0;
> > +     heap->shrinker.batch = ion_heap_batch;
> >
> >       return register_shrinker(&heap->shrinker);
> >  }
> > +
> > +static int __init ion_system_heap_batch_init(char *arg)
> > +{
> > +      ion_heap_batch = memparse(arg, NULL);
> > +
>
> No bounds checking?  What are the legitimate upper and lower bounds here?
Actruly, ion_heap_batch will work during shrink_slab, which shown bellow.
We can find that it is hard that to set batch_size as a constant value
as total ram size is different to each system. Furthermore, it is also
no need to set a percentage thing, "total_scan >= freeable" will work
as another threshold of slab size.
...
while (total_scan >= batch_size ||
       total_scan >= freeable) {
    unsigned long nr_to_scan = min(batch_size, total_scan);
    ret = shrinker->scan_objects(shrinker, shrinkctl);
...
shrinkctl->nr_to_scan = nr_to_scan;
shrinkctl->nr_scanned = nr_to_scan;
ret = shrinker->scan_objects(shrinker, shrinkctl);
>
> > +     return 0;
> > +}
> > +early_param("ion_batch", ion_system_heap_batch_init);
> > diff --git a/drivers/staging/android/ion/ion_system_heap.c b/drivers/staging/android/ion/ion_system_heap.c
> > index 701eb9f..d249f8d 100644
> > --- a/drivers/staging/android/ion/ion_system_heap.c
> > +++ b/drivers/staging/android/ion/ion_system_heap.c
> > @@ -182,7 +182,7 @@ static int ion_system_heap_shrink(struct ion_heap *heap, gfp_t gfp_mask,
> >       if (!nr_to_scan)
> >               only_scan = 1;
> >
> > -     for (i = 0; i < NUM_ORDERS; i++) {
> > +     for (i = NUM_ORDERS - 1; i >= 0; i--) {
> >               pool = sys_heap->pools[i];
> >
> >               if (only_scan) {
>
> Can we get a Documentation update on how we can use ion_batch and what the
> appropriate settings are (and in what circumstances)?
ok, I will explain it here firstly.
ion_heap_batch will work as the batch_size during shink_slab, which
help the heap buffer some of the page blocks for further allocation.
My test is based on a android system with 2G RAM. We find that
multimedia related cases is the chief consumer of the ion system heap
and cause memory fragmentation after a period of running. By
configuring ion_heap_batch as 48M(3 x camera peak consuming value) and
revert the shrink order, we can almost eliminate such scenario during
the test and improve the allocating speed up to 15%.
For common policy, the batch size should depend on the practical
scenario. The peak value can be got via sysfs or kernel log.
