Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E789BC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 13:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8945122CEC
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 13:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="gyrMKzTu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405681AbfHWNnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 09:43:00 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43910 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731976AbfHWNnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 09:43:00 -0400
Received: by mail-oi1-f195.google.com with SMTP id y8so7004359oih.10
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 06:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jw7xTqZljvWDt+gH2lHnnIUkh+OWb2dqWCVggLcTb1s=;
        b=gyrMKzTuaWrnNIRBDm50i6quBqIz1bhUm1Gm6/8s2kaFviG+TeyKizbVwp8QsZDsg9
         cB0yBjxUh49n7gzOZcU+eGE8vbuKolbVIShRQc6ouMetE6nFGOVR3MppH+/tnYO3Zrlc
         UH0SHALg7tcmzdDG2FTfNdvvTV0I/BMmNjbSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jw7xTqZljvWDt+gH2lHnnIUkh+OWb2dqWCVggLcTb1s=;
        b=V6vSEG+3EbY9tl2IqrUJfWM+zs3L1C/YQu4WJ5ZvNnJL6jF1JlJY0nuiwno+KBTT2a
         NOemhk20jjgQA8MD2xNHs7cVGEPalkwEYZj/uWmeYn9H4HrljYcN0vhY7gnxwn1TZaSP
         xc8qWPyo+NhvX1skLP0I5stpyHmQlEygl0xa26maIainclpwKXdRCtePdezO8aiAznMn
         0rDQqcZ4l4E4zOMOUCtmW3zeh1MnHVU7xsIoqr6NBmibqV1753grAWEjHph7luofL2+a
         m49qguxRag+WLA8Ec5j/6jUgr74jv2frdWbalOOlct3lOPeYcVrQjo2Zx8FY/C8uPnB8
         zi5w==
X-Gm-Message-State: APjAAAWLH/fh+LXMebTR8gRmK/dh/dp6wH8igC6xEBwGAcntr0p1+0My
        YKbQ4Swnrfbn1PBfXd5oUK6VagOvO4FA9JsR9ZzMuw==
X-Google-Smtp-Source: APXvYqw+eNygtffssBOBe6S8vbVTEOL5pWoEIu5RbBvwqcrgjAiCt8BJn2VrxejfsbAbB+/zEvTuexyQmTMFvMUOjmE=
X-Received: by 2002:aca:da08:: with SMTP id r8mr3001623oig.101.1566567779012;
 Fri, 23 Aug 2019 06:42:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190820081902.24815-1-daniel.vetter@ffwll.ch>
 <20190820081902.24815-4-daniel.vetter@ffwll.ch> <20190820202440.GH11147@phenom.ffwll.local>
 <20190822161428.c9e4479207386d34745ea111@linux-foundation.org>
 <CAKMK7uGw_7uD=wH3bcR9xXSxAcAuYTLOZt3ue4TEvst1D0KzLQ@mail.gmail.com> <20190823121234.GB12968@ziepe.ca>
In-Reply-To: <20190823121234.GB12968@ziepe.ca>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Fri, 23 Aug 2019 15:42:47 +0200
Message-ID: <CAKMK7uHzSkd2j4MvSMoHhCaSE0BT0zMo9osF4FUBYwNZrVfYDA@mail.gmail.com>
Subject: Re: [PATCH 3/4] kernel.h: Add non_block_start/end()
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wei Wang <wvw@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jann Horn <jannh@google.com>, Feng Tang <feng.tang@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 23, 2019 at 2:12 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Fri, Aug 23, 2019 at 10:34:01AM +0200, Daniel Vetter wrote:
> > On Fri, Aug 23, 2019 at 1:14 AM Andrew Morton <akpm@linux-foundation.org> wrote:
> > >
> > > On Tue, 20 Aug 2019 22:24:40 +0200 Daniel Vetter <daniel@ffwll.ch> wrote:
> > >
> > > > Hi Peter,
> > > >
> > > > Iirc you've been involved at least somewhat in discussing this. -mm folks
> > > > are a bit undecided whether these new non_block semantics are a good idea.
> > > > Michal Hocko still is in support, but Andrew Morton and Jason Gunthorpe
> > > > are less enthusiastic. Jason said he's ok with merging the hmm side of
> > > > this if scheduler folks ack. If not, then I'll respin with the
> > > > preempt_disable/enable instead like in v1.
> > >
> > > I became mollified once Michel explained the rationale.  I think it's
> > > OK.  It's very specific to the oom reaper and hopefully won't be used
> > > more widely(?).
> >
> > Yeah, no plans for that from me. And I hope the comment above them now
> > explains why they exist, so people think twice before using it in
> > random places.
>
> I still haven't heard a satisfactory answer why a whole new scheme is
> needed and a simple:
>
>    if (IS_ENABLED(CONFIG_DEBUG_ATOMIC_SLEEP))
>         preempt_disable()
>
> isn't sufficient to catch the problematic cases during debugging??
> IMHO the fact preempt is changed by the above when debugging is not
> material here. I think that information should be included in the
> commit message at least.
>
> But if sched people are happy then lets go ahead. Can you send a v2
> with the check encompassing the invalidate_range_end?

Yes I will resend with this patch plus the next, amended as we
discussed, plus the might_sleep annotations. I'm assuming the lockdep
one will land, so not going to resend that.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
