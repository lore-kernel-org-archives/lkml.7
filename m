Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC4BC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 18:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 480552173C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 18:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QlQaK2P+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729512AbfEVSSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 14:18:49 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38729 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727984AbfEVSSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 14:18:49 -0400
Received: by mail-io1-f68.google.com with SMTP id x24so2651532ion.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 11:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Oc3bQLWhGweMis4fWbACzNfmEcHdr/Fqo1ToP3CI3js=;
        b=QlQaK2P+0dNR9ypQ4OGuZYMLFCKkdci+YfCkVNBe6COsTQS2DPV11mNYcq7tRRrGLe
         BmranLCA7JuTHZhPDItrCR7un7Bf5dse8rPrKQiPxy5jQ6KSDbW1FZ4QYfXqBwQPLCaI
         aBXt+FVpPrQ/8RYXwLRRtk0LvP/mvejfYDbVke8SGGSkw6OTFK6pbs0cXrrOiEj8y+ec
         huaq+5IPo6T/XOU05pTr7EP42hMjv4Q5fKyjdW9r7kCruNo5gFOY/w2gyBFYVEf/b9bG
         gsiAXl93bu7o8el+3j8SkPdNGvtRZLp3MrswmlaPGFV48nfU7Qf2IndL9VZLA2pKlAz7
         NXJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Oc3bQLWhGweMis4fWbACzNfmEcHdr/Fqo1ToP3CI3js=;
        b=aFVSw8mQdoCNaxhgQt1tdINUZp3RZZbMk4NS/kez7pmHDAbHkwxBFaawsz3jFg5Gw0
         /+8ArALuOn924Xhe0jz98SflATmmLddwztfxpVp7DfTIEpoDhZG5OZtyegJJxXwf0SqB
         4cebPbDOIYDQvmGu4ySHjmP3yya5D3Zx6fFwNwgkWYV0tnl3lm1mlSOYvD+kwQ6+eEMB
         xIKdEGtfLeC7bizvYygJibv/dMH3qw0UTX5XTSvmp+Y9uLQM0piCu2+R1U8/FBcV0GVd
         mMKJuTDttItCQTQzS4KMTFTN+FPMMat4V8AuvysTxNeBLOq4uYFNitgHmg6E3YLTMutZ
         YUPQ==
X-Gm-Message-State: APjAAAUkb+FwfOh4z/m8gPRbq9oS7pIW3dOJGS6bw24KdOwfHpDPt0xX
        f5bB2ICoS6ZzVfdWeHguasCZlBtmD7Yr/ufPMQY=
X-Google-Smtp-Source: APXvYqzryR1p6C7aJHM3BCsQYpOhjrOy5oLO7EdNFedee6EaOmBlFfxoJBwTe7QkNoowKtV9thkMZTUBtYPqwqEtmW8=
X-Received: by 2002:a6b:7a49:: with SMTP id k9mr34067950iop.73.1558549128373;
 Wed, 22 May 2019 11:18:48 -0700 (PDT)
MIME-Version: 1.0
References: <155853600919.381.8172097084053782598.stgit@buzz>
 <20190522155220.GB4374@dhcp22.suse.cz> <177f56cd-6e10-4d2e-7a3e-23276222ba19@yandex-team.ru>
 <20190522170342.GA11077@tower.DHCP.thefacebook.com>
In-Reply-To: <20190522170342.GA11077@tower.DHCP.thefacebook.com>
From:   Konstantin Khlebnikov <koct9i@gmail.com>
Date:   Wed, 22 May 2019 21:18:36 +0300
Message-ID: <CALYGNiM9K6CTL+d5fUDgMFxQ_6xqtABOUhzFwbSm8zErmPZdZg@mail.gmail.com>
Subject: Re: [PATCH] proc/meminfo: add MemKernel counter
To:     Roman Gushchin <guro@fb.com>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Michal Hocko <mhocko@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 8:04 PM Roman Gushchin <guro@fb.com> wrote:
>
> On Wed, May 22, 2019 at 07:09:22PM +0300, Konstantin Khlebnikov wrote:
> > On 22.05.2019 18:52, Michal Hocko wrote:
> > > On Wed 22-05-19 17:40:09, Konstantin Khlebnikov wrote:
> > > > Some kinds of kernel allocations are not accounted or not show in meminfo.
> > > > For example vmalloc allocations are tracked but overall size is not shown
> > > > for performance reasons. There is no information about network buffers.
> > > >
> > > > In most cases detailed statistics is not required. At first place we need
> > > > information about overall kernel memory usage regardless of its structure.
> > > >
> > > > This patch estimates kernel memory usage by subtracting known sizes of
> > > > free, anonymous, hugetlb and caches from total memory size: MemKernel =
> > > > MemTotal - MemFree - Buffers - Cached - SwapCached - AnonPages - Hugetlb.
> > >
> > > Why do we need to export something that can be calculated in the
> > > userspace trivially? Also is this really something the number really
> > > meaningful? Say you have a driver that exports memory to the userspace
> > > via mmap but that memory is not accounted. Is this really a kernel
> > > memory?
> > >
> >
> > It may be trivial right now but not fixed.
> > Adding new kinds of memory may change this definition.
>
> Right, and it's what causes me to agree with Michal here, and leave it
> to the userspace calculation.
>
> The real meaning of the counter is the size of the "gray zone",
> basically the memory which we have no clue about.

Well, all kernel memory is a gray zone for normal programmers.
They have direct control only over anon and file-cache.

I want to invent simple metrics for 'system' memory usage.
It's about the same as separation cpu time to user and system.

> If we'll add accounting of some new type of memory, which now in this
> gray zone (say, xfs buffers), we probably should exclude it too.
> And this means that definition of this counter will change.

I'm not very familiar with xfs internals, never digged into it.
I've excluded buffers because this is simply file-cache for block devices.
Filesystems use it as cache for metadata. But userspace has direct access to it.

>
> So IMO the definition is way too implementation-defined to be a part
> of procfs API.
>

Ok. User/kernel memory separation could be redefined in more
abstract manner depending on the data access.
