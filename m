Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0161BC74A42
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 05:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C13D7206B8
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 05:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3IsQrcB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbfGKFC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 01:02:26 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:35887 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfGKFC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 01:02:26 -0400
Received: by mail-yw1-f68.google.com with SMTP id x67so372532ywd.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 22:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O7XDUYZ50C5Wivig3QmUbWDaMygc+9d5AOPjUhLcsBo=;
        b=l3IsQrcBVy6PrW8UVKVBL2FYEIdjoxNATom3yi4BY+Ol4ai4JZeEdsgjhfDCa+CEvV
         s1YYWCmvC8dn7ubda+c5nlfGCawIqNAxcLXewDUPpYBgD4uAg9ySqwVUS+9Dwaa999mw
         rbL1mTPDR4ql0lvYK5biWBL9Eg1dALDgCpg1yfhe4EmRSjE49Ef7O59VTgLFlSBMdd/X
         KbNqEYPiv9xLr1wiW0D2Ci7yYc4ZoXs54TYtV4J2SarwVIAT30jO48laMJ5+V42SBpZP
         rHDPhhClysG9EOE9ngvlmIaYb1Ud1GKVURXNUCkPF1m3bAb9ZcUmP06Zmu3XHmbuomSM
         d+LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O7XDUYZ50C5Wivig3QmUbWDaMygc+9d5AOPjUhLcsBo=;
        b=nttr+Ct+FZNVj/gCgvZzcKhJ/HPTE+5RzXUN6ibbrMImO0mySNNp0eG0F2qlGjTclS
         EYuYlFPrQG0inY2WCisRDsQzo0bm2TjH8kx7s8mIgppbLUXXFLIF+r12lsO9u6kkWIFP
         qAhD1sF9rznth+AnLOZbVyveUqUbZlu9UuRZp1CRJFL9pJ1ZgTFwoZO81LrLZOtK9UAu
         OB9zKLpO93QlrNS4d0EVR9kjYpDypZp89n7bk/pPlPqVreWTXaHmvjzNuJvt0tXzVOIA
         J5qo5kCNNNrq3Lhp4J0m3nu2K1XrKu68Y3J03CXPvrT2+heFyQKxveWVAoQUgFe8Bcfo
         R7yA==
X-Gm-Message-State: APjAAAXOc3aGi5bsv6FSMJWujXE/nDtmvAbqbFJCj5UxebCKstxs6bn3
        ERg0Z0SdnVLXKiaPmm1f8FDKwceM0TGPy/IHruI=
X-Google-Smtp-Source: APXvYqxk4dEK5tecSWqR9MAZ1C+G8y6zyrlLugpIDnqBoeyNKN/MtYliO+GrRsuY2M8HD7LogDKzqtghj2LfzHw0mnY=
X-Received: by 2002:ac8:359a:: with SMTP id k26mr1279205qtb.87.1562821345676;
 Wed, 10 Jul 2019 22:02:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190628091528.17059-1-duyuyang@gmail.com> <20190628091528.17059-18-duyuyang@gmail.com>
 <20190710051830.GB14490@tardis>
In-Reply-To: <20190710051830.GB14490@tardis>
From:   Yuyang Du <duyuyang@gmail.com>
Date:   Thu, 11 Jul 2019 13:02:14 +0800
Message-ID: <CAHttsrbedG9aJibhXBJZwKtt2ABX+TDU16dOWN+RP9yJ5OcbWA@mail.gmail.com>
Subject: Re: [PATCH v3 17/30] locking/lockdep: Add read-write type for a lock dependency
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>, ming.lei@redhat.com,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Waiman Long <longman@redhat.com>, paulmck@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for review.

On Wed, 10 Jul 2019 at 13:18, Boqun Feng <boqun.feng@gmail.com> wrote:
>
> On Fri, Jun 28, 2019 at 05:15:15PM +0800, Yuyang Du wrote:
> > Direct dependencies need to keep track of their read-write lock types.
> > Two bit fields, which share the distance field, are added to lock_list
> > struct so the types are stored there.
> >
> > With a dependecy lock1 -> lock2, lock_type1 has the type for lock1 and
> > lock_type2 has the type for lock2, where the values are one of the
> > lock_type enums.
> >
> > Signed-off-by: Yuyang Du <duyuyang@gmail.com>
> > ---
> >  include/linux/lockdep.h  | 15 ++++++++++++++-
> >  kernel/locking/lockdep.c | 25 +++++++++++++++++++++++--
> >  2 files changed, 37 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
> > index eb26e93..fd619ac 100644
> > --- a/include/linux/lockdep.h
> > +++ b/include/linux/lockdep.h
> > @@ -185,6 +185,8 @@ static inline void lockdep_copy_map(struct lockdep_map *to,
> >               to->class_cache[i] = NULL;
> >  }
> >
> > +#define LOCK_TYPE_BITS       2
> > +
> >  /*
> >   * Every lock has a list of other locks that were taken after or before
> >   * it as lock dependencies. These dependencies constitute a graph, which
> > @@ -207,7 +209,17 @@ struct lock_list {
> >       struct list_head                chains;
> >       struct lock_class               *class[2];
> >       struct lock_trace               trace;
> > -     int                             distance;
> > +
> > +     /*
> > +      * The lock_type fields keep track of the lock type of this
> > +      * dependency.
> > +      *
> > +      * With L1 -> L2, lock_type1 stores the lock type of L1, and
> > +      * lock_type2 stores that of L2.
> > +      */
> > +     unsigned int                    lock_type1 : LOCK_TYPE_BITS,
> > +                                     lock_type2 : LOCK_TYPE_BITS,
>
> Bad names ;-) Maybe fw_dep_type and bw_dep_type? Which seems to be
> aligned with the naming schema other functions.

I think the types are for L1 -> L2 respectively, hence the names in
question. Let me reconsider this anyway and maybe hear from others.

Thanks,
Yuyang
