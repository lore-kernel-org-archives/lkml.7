Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E4EC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 09:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E15122D6D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 09:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="RWdDCknA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbfHUJeT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 05:34:19 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41393 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbfHUJeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 05:34:19 -0400
Received: by mail-oi1-f194.google.com with SMTP id g7so1085290oia.8
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 02:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jrMnd9Dw4BIbl105NPubLNKMx+vt1yB2bVw1jRY/PoI=;
        b=RWdDCknAmMlPEQ9u6yUMbaKojAWU9G+zSGrTlsA+5Fkb6D5PPhV3wXAdyHPQHxX3o2
         vq6qCQtWx7WMlW8Wcwk/fdYFN48LUhyp1O9fbzd3V40UTaKzdmNXguxv3DgFH0nqPlyM
         j37eomYfP4oBSb5y02UJPiGrztvAL9IJTDwk4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jrMnd9Dw4BIbl105NPubLNKMx+vt1yB2bVw1jRY/PoI=;
        b=F8JC6JCUJii1/1AHV438y3COkjhbqhYPXjGhSZOOGC8UyzyItV0NMebcKE4UHs4dHH
         +TGgo0VTH+ySWM1/E6PkMIj97snDDSV67FKXzxopBvwmyjro1oqwT1ifDR64bCb1ozyI
         mEQaa2K/vn7aYkVQ5uH6aUAzhFjupFSpw2Xi+Qu/DInRyoVpYFpze1hKUeI2AmPibktx
         tIr5k8Hsy5W9h9qCzYWpiSFqF6uP16b/FVE/ayDKDHpJejHpq4YXs8votXCrBYwuTIRr
         j28XCPGs4HYasBR7KGOLnE8USH0QUS6PLDic+Iza212b5t/tSIGI5dIumw+FoIJvJH+V
         Jycw==
X-Gm-Message-State: APjAAAVG9Fl8koXd2okhFURv7tuu0jXY486g4G8Za+qYMFL68cJ2/x95
        z9iQTN6boDlIj15WD8RYbfO4F5Isgm7wQ5HM+mzlbA==
X-Google-Smtp-Source: APXvYqz6Xkt/CCbaeKtV6kQUpHjgnS2QNd5FOt7p4vifuidxlIYHRXgS2fDGVa3/892Mj7QMqJOfxhRNKJMmZoX5PgE=
X-Received: by 2002:aca:da08:: with SMTP id r8mr2776211oig.101.1566380058381;
 Wed, 21 Aug 2019 02:34:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190820081902.24815-1-daniel.vetter@ffwll.ch>
 <20190820081902.24815-5-daniel.vetter@ffwll.ch> <20190820133418.GG29246@ziepe.ca>
 <20190820151810.GG11147@phenom.ffwll.local> <20190820152712.GH29246@ziepe.ca>
In-Reply-To: <20190820152712.GH29246@ziepe.ca>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 21 Aug 2019 11:34:06 +0200
Message-ID: <CAKMK7uGuH_Lvzf+M3Vast-RFS6Dr70F+Q4U_aSHuR1TpJg02SQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] mm, notifier: Catch sleeping/blocking for !blockable
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 9:33 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Tue, Aug 20, 2019 at 05:18:10PM +0200, Daniel Vetter wrote:
> > > > diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
> > > > index 538d3bb87f9b..856636d06ee0 100644
> > > > +++ b/mm/mmu_notifier.c
> > > > @@ -181,7 +181,13 @@ int __mmu_notifier_invalidate_range_start(struct mmu_notifier_range *range)
> > > >   id = srcu_read_lock(&srcu);
> > > >   hlist_for_each_entry_rcu(mn, &range->mm->mmu_notifier_mm->list, hlist) {
> > > >           if (mn->ops->invalidate_range_start) {
> > > > -                 int _ret = mn->ops->invalidate_range_start(mn, range);
> > > > +                 int _ret;
> > > > +
> > > > +                 if (!mmu_notifier_range_blockable(range))
> > > > +                         non_block_start();
> > > > +                 _ret = mn->ops->invalidate_range_start(mn, range);
> > > > +                 if (!mmu_notifier_range_blockable(range))
> > > > +                         non_block_end();
> > >
> > > If someone Acks all the sched changes then I can pick this for
> > > hmm.git, but I still think the existing pre-emption debugging is fine
> > > for this use case.
> >
> > Ok, I'll ping Peter Z. for an ack, iirc he was involved.
> >
> > > Also, same comment as for the lockdep map, this needs to apply to the
> > > non-blocking range_end also.
> >
> > Hm, I thought the page table locks we're holding there already prevent any
> > sleeping, so would be redundant?
>
> AFAIK no. All callers of invalidate_range_start/end pairs do so a few
> lines apart and don't change their locking in between - thus since
> start can block so can end.
>
> Would love to know if that is not true??

Yeah I reviewed them, I think I mixed up a discussion I had a while
ago with Jerome. It's a bit tricky to follow in the code since in some
places ->invalidate_range and ->invalidate_range_end seem to be called
from the same place, in others not at all.

> Similarly I've also been idly wondering if we should add a
> 'might_sleep()' to invalidate_rangestart/end() to make this constraint
> clear & tested to the mm side?

Hm, sounds like a useful idea. Since in general you wont test with mmu
notifiers, but they could happen, and then they will block for at
least some mutex usually. I'll throw that as an idea on top for the
next round.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
