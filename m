Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A74C3A59B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 16:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C0C12184C
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 16:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="B5UOJokG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbfHQQKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Aug 2019 12:10:07 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43261 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbfHQQKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 12:10:06 -0400
Received: by mail-ot1-f65.google.com with SMTP id e12so12284614otp.10
        for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2019 09:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/dLbDP+XbKcJMYntrsaFKnZVTIgZ0VHyMdGQlHN9qFU=;
        b=B5UOJokGjOlBPz4rMQ3Si/DpHraMyEYjQZnsGkf6QDVaPp5z9cpjK1+gkfiq/zazff
         NL4cuOvDdj2IcVJLJ9P5XOOuwMQ+B+/YrCGP3oe4dPerl/SOJztR2seJqY/t5jIW2guZ
         0vUMVsA5mwUX/XZfEdCbwGtfe9HGRKda6wKfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/dLbDP+XbKcJMYntrsaFKnZVTIgZ0VHyMdGQlHN9qFU=;
        b=TqltgKmmGlRvTi4F2Y2Nmqi+FYXP36NzPOQLv/ql+d6aJTblyBhfdykyVCPAYGGFDf
         c26iVtRH1j+JwlDK15QhOVfnbV3gEnS/UDAndrOAXFhQcjdlaYaJyhGTdHNLT4zOZO83
         OYPZ71O10CWLgbEJBAfsiFldKruz4oBUdG53r6DpvkryYq1grfpYCLUexsWH5RWlFE0L
         Vcpr+qla80/bPcCUPc1R7mmrltbwOW5DiUAwD8vQEZhmUT+D/xcB8AfTLue3RUpKFfcg
         gHWeQ5CYveQZuj0qsrF9HPoM7sKojqs2ykhCSMMJ6bLZNET3I5FeffRBc1fqP7QHnnp+
         VsVA==
X-Gm-Message-State: APjAAAWxAIebhni2Kh3LPdigObfdFo9/bReKj25soJ2Q/N0O8/EXnflz
        eJgyxzrkEoDtj9ps2SRBl8B3K4SZYCC9Gh2ex3Wqcg==
X-Google-Smtp-Source: APXvYqzydMn1g2ReqTDUP6q5J7E16naHWiuE7+1VXp+Gur58sjaLDTfR2sEFLUfZsgF+0Z+C8/UELi+pyIE63v/mZBI=
X-Received: by 2002:a9d:590d:: with SMTP id t13mr660910oth.281.1566058205676;
 Sat, 17 Aug 2019 09:10:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190814202027.18735-1-daniel.vetter@ffwll.ch>
 <20190814202027.18735-4-daniel.vetter@ffwll.ch> <20190815000029.GC11200@ziepe.ca>
 <20190815070249.GB7444@phenom.ffwll.local> <20190815123556.GB21596@ziepe.ca>
In-Reply-To: <20190815123556.GB21596@ziepe.ca>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Sat, 17 Aug 2019 18:09:54 +0200
Message-ID: <CAKMK7uFz1ZiUUK5+tGpf-9Gksu5uN72sFW_KpJ53BuSfKY8PVg@mail.gmail.com>
Subject: Re: [PATCH 3/5] mm, notifier: Catch sleeping/blocking for !blockable
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

On Sat, Aug 17, 2019 at 5:26 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Thu, Aug 15, 2019 at 09:02:49AM +0200, Daniel Vetter wrote:
> > On Wed, Aug 14, 2019 at 09:00:29PM -0300, Jason Gunthorpe wrote:
> > > On Wed, Aug 14, 2019 at 10:20:25PM +0200, Daniel Vetter wrote:
> > > > We need to make sure implementations don't cheat and don't have a
> > > > possible schedule/blocking point deeply burried where review can't
> > > > catch it.
> > > >
> > > > I'm not sure whether this is the best way to make sure all the
> > > > might_sleep() callsites trigger, and it's a bit ugly in the code flow.
> > > > But it gets the job done.
> > > >
> > > > Inspired by an i915 patch series which did exactly that, because the
> > > > rules haven't been entirely clear to us.
> > >
> > > I thought lockdep already was able to detect:
> > >
> > >  spin_lock()
> > >  might_sleep();
> > >  spin_unlock()
> > >
> > > Am I mistaken? If yes, couldn't this patch just inject a dummy lockdep
> > > spinlock?
> >
> > Hm ... assuming I didn't get lost in the maze I think might_sleep (well
> > ___might_sleep) doesn't do any lockdep checking at all. And we want
> > might_sleep, since that catches a lot more than lockdep.
>
> Don't know how it works, but it sure looks like it does:
>
> This:
>         spin_lock(&file->uobjects_lock);
>         down_read(&file->hw_destroy_rwsem);
>         up_read(&file->hw_destroy_rwsem);
>         spin_unlock(&file->uobjects_lock);
>
> Causes:
>
> [   33.324729] BUG: sleeping function called from invalid context at kernel/locking/rwsem.c:1444
> [   33.325599] in_atomic(): 1, irqs_disabled(): 0, pid: 247, name: ibv_devinfo
> [   33.326115] 3 locks held by ibv_devinfo/247:
> [   33.326556]  #0: 000000009edf8379 (&uverbs_dev->disassociate_srcu){....}, at: ib_uverbs_open+0xff/0x5f0 [ib_uverbs]
> [   33.327657]  #1: 000000005e0eddf1 (&uverbs_dev->lists_mutex){+.+.}, at: ib_uverbs_open+0x16c/0x5f0 [ib_uverbs]
> [   33.328682]  #2: 00000000505f509e (&(&file->uobjects_lock)->rlock){+.+.}, at: ib_uverbs_open+0x31a/0x5f0 [ib_uverbs]
>
> And this:
>
>         spin_lock(&file->uobjects_lock);
>         might_sleep();
>         spin_unlock(&file->uobjects_lock);
>
> Causes:
>
> [   16.867211] BUG: sleeping function called from invalid context at drivers/infiniband/core/uverbs_main.c:1095
> [   16.867776] in_atomic(): 1, irqs_disabled(): 0, pid: 245, name: ibv_devinfo
> [   16.868098] 3 locks held by ibv_devinfo/245:
> [   16.868383]  #0: 000000004c5954ff (&uverbs_dev->disassociate_srcu){....}, at: ib_uverbs_open+0xf8/0x600 [ib_uverbs]
> [   16.868938]  #1: 0000000020a6fae2 (&uverbs_dev->lists_mutex){+.+.}, at: ib_uverbs_open+0x16c/0x600 [ib_uverbs]
> [   16.869568]  #2: 00000000036e6a97 (&(&file->uobjects_lock)->rlock){+.+.}, at: ib_uverbs_open+0x317/0x600 [ib_uverbs]
>
> I think this is done in some very expensive way, so it probably only
> works when lockdep is enabled..

This is the might_sleep debug infrastructure (both of them), not
lockdep. Disable CONFIG_PROVE_LOCKING and you should still get these.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
