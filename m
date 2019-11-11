Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F37BCC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C87C821655
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l/M6bu5D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfKKSPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:15:33 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46420 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbfKKSPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:15:33 -0500
Received: by mail-oi1-f195.google.com with SMTP id n14so12274610oie.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 10:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wp8sNHHWKT8+0gi2mlOjdtdiQUngDsbO3HXqLtINp/4=;
        b=l/M6bu5DsPv1ggcaYLv0rj75Z+n1KYiYbFPcRtoYSAzEFuALAktcqMbOstn/rQ3Q7y
         A1HEZ+E2f1nw7BW1yJxy0Oez4a7h680j8FZR9SSZvyLaBlQA2t4R97S1gm7XI0zZHnWt
         fcDk1qLckOYvjrSvIm4z84U1Let85I67Aa+geIkkUjk99DM0BJ9JvlTAwg7sgKtxLrj/
         gvRekgJPtvxlI+J33aQgIyZPJAcxft6JZNmJNW0S/jwvCbGCkahYAUaMfQVqFwBkpnKC
         6ydhI1qYjviq0PvXA1N3hi8IdnVQMoFLrb09Oock6NqDBcRt9mPsQ4PVHNSmdyBhINvw
         ckrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wp8sNHHWKT8+0gi2mlOjdtdiQUngDsbO3HXqLtINp/4=;
        b=gKHyjqe12ufE4R3vdzs5RW0vbapfnGqC6B8GdRYRa1DXY2PglbdYoCr6ai4G8eeZmB
         woZ4NilYaO4WlzObQKvZGWUOkfqAg2I4GiP05aZUV9CewL+tfL2mbgTKNXfb61998moP
         X40OZNqt3OzMBjU5JSTTjfStk4C6HI7uSJy5uxFR+B6qR3uqjglInh6q7vakB1rdXEf9
         OSUiJztRlNbNGbprcghrAN13fBUyF1pFNW68i5QUj4bvMOZgEss6ZmraMAVW72vSGYeb
         kiDIPM8b/N++P/FIVuB7pZA01wg/98t2y1Fa236gH2xp1b95QKqjQmirTk0YOTl+Q+SF
         nFxg==
X-Gm-Message-State: APjAAAX9wBYtIcaX5U16/LkjHI2j+XPSbRsp0KF736wg6kH3wvFeSYEw
        Dk8XqGUqHT98TunaHs9c7p8XsthGSxLictGmGO1dBw==
X-Google-Smtp-Source: APXvYqyCKkeyiY3yL3VCysxF4ewu3NlESq+MKIQi1I+34jOM6EaAmQP2yu13y9xjdq8ILa2s5YuNCcaWS9QyH7dU/kw=
X-Received: by 2002:aca:f1c5:: with SMTP id p188mr230164oih.125.1573496131953;
 Mon, 11 Nov 2019 10:15:31 -0800 (PST)
MIME-Version: 1.0
References: <20190914000743.182739-1-yuzhao@google.com> <20191108193958.205102-1-yuzhao@google.com>
 <20191108193958.205102-2-yuzhao@google.com> <alpine.DEB.2.21.1911092024560.9034@www.lameter.com>
 <20191109230147.GA75074@google.com> <alpine.DEB.2.21.1911092313460.32415@www.lameter.com>
 <20191110184721.GA171640@google.com> <alpine.DEB.2.21.1911111543420.10669@www.lameter.com>
In-Reply-To: <alpine.DEB.2.21.1911111543420.10669@www.lameter.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 11 Nov 2019 10:15:20 -0800
Message-ID: <CALvZod7sdWpkERPbU9sram2q7PubS4yvkzVibRf+4bPKT1v4XQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] mm: avoid slub allocation while holding list_lock
To:     Christopher Lameter <cl@linux.com>, Roman Gushchin <guro@fb.com>
Cc:     Yu Zhao <yuzhao@google.com>, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Roman Gushchin

On Mon, Nov 11, 2019 at 7:47 AM Christopher Lameter <cl@linux.com> wrote:
>
> On Sun, 10 Nov 2019, Yu Zhao wrote:
>
> > On Sat, Nov 09, 2019 at 11:16:28PM +0000, Christopher Lameter wrote:
> > > On Sat, 9 Nov 2019, Yu Zhao wrote:
> > >
> > > > >         struct page *page, *h;
> > > > > +       unsigned long *map = bitmap_alloc(oo_objects(s->max), GFP_KERNEL);
> > > > > +
> > > > > +       if (!map)
> > > > > +               return;
> > > >
> > > > What would happen if we are trying to allocate from the slab that is
> > > > being shut down? And shouldn't the allocation be conditional (i.e.,
> > > > only when CONFIG_SLUB_DEBUG=y)?
> > >
> > > Kmalloc slabs are never shut down.
> >
> > Maybe I'm not thinking straight -- isn't it what caused the deadlock in
> > the first place?
>
> Well if kmalloc allocations become a problem then we have numerous
> issues all over the kernel to fix.
>
> > Kmalloc slabs can be shut down when memcg is on.
>
> Kmalloc needs to work even during shutdown of a memcg.
>
> Maybe we need to fix memcg to not allocate from the current memcg during
> shutdown?
>
>

Roman recently added reparenting of memcg kmem caches on memcg offline
and can comment in more detail but we don't shutdown a kmem cache
until all the in-fly memcg allocations are resolved. Also the
allocation here does not look like a __GFP_ACCOUNT allocation.
