Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 045BBC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 148ED20717
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tcH6Or/a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730906AbfDYV4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 17:56:30 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46487 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfDYV4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 17:56:30 -0400
Received: by mail-wr1-f67.google.com with SMTP id t17so1395047wrw.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 14:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GEgbleUXiftEFa1b6/nUBQ/7QI0Sg4jIX3OywJ4O6ss=;
        b=tcH6Or/aUj2gN2lZ+ilpm9QvEleYeL5nv+beBZyu5quvO7K0VU1A9U3qLFUEluKpEu
         Y1Ll+DSw/qgyJFUAUisuVrVxhkvCTOmW4gJeglXkWJggKF62oymkWwR+Ie5uRSFrjUF2
         k8Wmel3W9KzeQ5RuK/SWkRgsB3pQaIQzk5lLkiKt0yYu3MmIyMK0PuPN0InqZrsKnfzm
         RzMxVSdFj48PUqcTlJgGpZupP3AmqzhLHoMmwN9hoB6LUywsovrRZGD2R53ON8S7GRft
         V+t4nQpJNlvZBhAhgFWaA/9qneaTzyviepc/XTlKG3nrV0j15Rlr0hojFhKsS36Jwl1q
         Iq6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GEgbleUXiftEFa1b6/nUBQ/7QI0Sg4jIX3OywJ4O6ss=;
        b=rNQ2cPbGThdRlA5ZCtE5CDXtN4Lt0CB8z2JQl2CbMxRUzTiTWmlgRdoZTPSi+XeZyD
         eKoUFpiVNsWcdFqAp7kPA9VKIupsL5K9G1sUFWYoeLow/zbu+G7Hb75JM1GXOwJvgfVy
         QIwlom/kHpMXSSo7iEucWGguU+naBkKjwGb7pHb7Pq8W2948wikPJleFSbERQ++W3RRY
         xTLE7bqpA2y/tic4yyZwWxCEm0ViNI7q2esJs7a1O4CBevaM31OMSItEX8x9BidOSAjs
         xb19Sb9iVcWLa8jUO3Zgh54VTBhdUy8fgCiGIS00VFH+WDBTGI2EQ4fwF6yAPPWC3vI1
         lhZQ==
X-Gm-Message-State: APjAAAW5uibKvSq8tdium+uHY9azZCVLIoACb6EtlN0Y0qGSOV3NBrmT
        oVn899sYDXh9jJ9DpEbNPmroHqV8gWH4b+uEKd7RHA==
X-Google-Smtp-Source: APXvYqyMwEjv55C5T76qTTC8HI998zMaiRIQFxwC2X83mO0xhC+T72nf95L5ZLJIS/AdipIWQnRCB4DsPuraplN4L08=
X-Received: by 2002:adf:9144:: with SMTP id j62mr29511655wrj.320.1556229387867;
 Thu, 25 Apr 2019 14:56:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190411014353.113252-1-surenb@google.com> <20190411014353.113252-2-surenb@google.com>
 <c745df86-b95c-e82b-42ba-519da4f448ab@i-love.sakura.ne.jp>
In-Reply-To: <c745df86-b95c-e82b-42ba-519da4f448ab@i-love.sakura.ne.jp>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 25 Apr 2019 14:56:16 -0700
Message-ID: <CAJuCfpH-SnFQT=3qy3VANsgJsxK+vV6=G=WPkt11qG_2RpYAcQ@mail.gmail.com>
Subject: Re: [RFC 1/2] mm: oom: expose expedite_reclaim to use oom_reaper
 outside of oom_kill.c
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        yuzhoujian@didichuxing.com,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Shakeel Butt <shakeelb@google.com>,
        Christian Brauner <christian@brauner.io>,
        Minchan Kim <minchan@kernel.org>,
        Tim Murray <timmurray@google.com>,
        Daniel Colascione <dancol@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jann Horn <jannh@google.com>, linux-mm <linux-mm@kvack.org>,
        lsf-pc@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 2:13 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2019/04/11 10:43, Suren Baghdasaryan wrote:
> > diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> > index 3a2484884cfd..6449710c8a06 100644
> > --- a/mm/oom_kill.c
> > +++ b/mm/oom_kill.c
> > @@ -1102,6 +1102,21 @@ bool out_of_memory(struct oom_control *oc)
> >       return !!oc->chosen;
> >  }
> >
> > +bool expedite_reclaim(struct task_struct *task)
> > +{
> > +     bool res = false;
> > +
> > +     task_lock(task);
> > +     if (task_will_free_mem(task)) {
>
> mark_oom_victim() needs to be called under oom_lock mutex after
> checking that oom_killer_disabled == false. Since you are trying
> to trigger this function from signal handler, you might want to
> defer until e.g. WQ context.

Thanks for the tip! I'll take this into account in the new design.
Just thinking out loud... AFAIU oom_lock is there to protect against
multiple concurrent out_of_memory calls from different contexts and
prevent overly-aggressive process killing. For my purposes when
reaping memory of a killed process we don't have this concern (we did
not initiate the killing, SIGKILL was explicitly requested). I'll
probably need some synchronization there but not for purposes of
preventing multiple concurrent reapers. In any case, thank you for the
feedback!

>
> > +             mark_oom_victim(task);
> > +             wake_oom_reaper(task);
> > +             res = true;
> > +     }
> > +     task_unlock(task);
> > +
> > +     return res;
> > +}
> > +
> >  /*
> >   * The pagefault handler calls here because it is out of memory, so kill a
> >   * memory-hogging task. If oom_lock is held by somebody else, a parallel oom
> >
