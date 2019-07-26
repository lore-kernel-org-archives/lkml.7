Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B67E6C76190
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 01:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75C212238C
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 01:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QSMLORbC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbfGZBwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 21:52:50 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38568 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfGZBwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 21:52:50 -0400
Received: by mail-ot1-f66.google.com with SMTP id d17so53809348oth.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 18:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TiousANIM8Ym1d99fpbOzWaRdwbbqZlUg00mIz18Zzs=;
        b=QSMLORbC76eYIkEJoBLupfx/zQ8ufC6hcV0EJNWlC9L1gDKgU9axM65c6GyR4Zk2sL
         qenZTXiQk/OnWyleJmxfTnm2MiSNYQDKqgTEi7ooH7Cf1lTdIBG+L2MM+iu2wiQewP4P
         oiqxtP0wmi3DTCWlx6JKh/Pv+4DP2yyWN4iLjywmEvSmhyHuyUQBR3KaYTP+eEcgI1Bs
         zMERjZiMuH2snJ8G/wnF2K/7lk3MmZr/FjeF8RKBTJYDeddu49izpxJcqmhVhUxX4tnp
         8KrG6fCpd4x0P8PCcXC7fWzWIdOLSS1DQG4QMUdXOZN6Njt2jsgiXXFwVnpWIdJHNOja
         V4aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TiousANIM8Ym1d99fpbOzWaRdwbbqZlUg00mIz18Zzs=;
        b=mwL2qzmU4XIOnl72rroAtiTfSP8b38ocd/f7+3cpGdUTTdjlA648aGF40KO7sIhatG
         uW2iCBuZOIPYiZuxpjEhEdSGNiG6dS7HWATfPNAYEZxEjlx/GlpN1p1T26uMdWIrJxAg
         MvQUMq8rZEIXkBe8QiaeDzcFWn/26Meckxar0J0zgMaNycma9xsxD1ARmBoK7cjcq8jz
         evbVTWar0CvYeLn0dyOjk++2OEza+fRm2UTPhc1phVgzshTNVou927y2J58p9PLcwqH/
         9lakW9Rgm8gaveXTh+uhBvWfFz5GrRtKbmYwtfOlo7BGhuqzlV519diE3xZ9rNYwv3jv
         AW2w==
X-Gm-Message-State: APjAAAWMIDk8IbhFBWRl7RVf7SZnUzxQTNVBGpsIL/JXhHw5wKbxbu03
        AUVS36/CISt59lTiyrmwA6LEaVXW+0l5/8brsW0ttQ==
X-Google-Smtp-Source: APXvYqxcYuMUWiDwRwA2OJ6MD9+ZDILLOWvrJDjR6OvjPD3hun3BBu9PeDPdULURc2DNhKHtgkiBXezSPtLjUKh7A7E=
X-Received: by 2002:a05:6830:160c:: with SMTP id g12mr12061343otr.231.1564105969661;
 Thu, 25 Jul 2019 18:52:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190717222340.137578-1-saravanak@google.com> <20190717222340.137578-4-saravanak@google.com>
 <20190723102842.t2s45zzylsjuccm4@vireshk-i7> <CAGETcx-6M9Ts8tfMf6aA8GjMyzK5sOLr069ZCxTG7RHMFPLzHw@mail.gmail.com>
 <20190725030712.lx3cjogo5r7kc262@vireshk-i7> <CAGETcx8QTs2Dqqppb_gwiUa2fte92K_q+B+j_CreRgqU52L7EA@mail.gmail.com>
 <20190725051742.mn54pi722txkpddg@vireshk-i7>
In-Reply-To: <20190725051742.mn54pi722txkpddg@vireshk-i7>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 25 Jul 2019 18:52:13 -0700
Message-ID: <CAGETcx9yO7HCz-rvqRMQf6srN_9-O_wc1bb7HadL+4QxvuqyWA@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] OPP: Improve require-opps linking
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sibi Sankar <sibis@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 10:17 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 24-07-19, 21:09, Saravana Kannan wrote:
> > On Wed, Jul 24, 2019 at 8:07 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > We should be doing this whenever a new OPP table is created, and see
> > > if someone else was waiting for this OPP table to come alive.
> >
> > Searching the global OPP table list seems a ton more wasteful than
> > doing the lazy linking. I'd rather not do this.
>
> We can see how best to optimize that, but it will be done only once
> while a new OPP table is created and putting stress there is the right
> thing to do IMO. And doing anything like that in a place like
> opp-set-rate is the worst one. It will be a bad choice by design if
> you ask me and so I am very much against that.
>
> > > Also we
> > > must make sure that we do this linking only if the new OPP table has
> > > its own required-opps links fixed, otherwise delay further.
> >
> > This can be done. Although even without doing that, this patch is
> > making things better by not failing silently like it does today? Can I
> > do this later as a separate patch set series?
>
> I would like this to get fixed now in a proper way, there is no hurry
> for a quick fix currently. No band-aids please.
>
> > > Even then I don't want to add these checks to those places. For the
> > > opp-set-rate routine, add another flag to the OPP table which
> > > indicates if we are ready to do dvfs or not and mark it true only
> > > after the required-opps are all set.
> >
> > Honestly, this seems like extra memory and micro optimization without
> > any data to back it.
>
> Again, opp-set-rate isn't supposed to do something like this. It
> shouldn't handle initializations of things, that is broken design.
>
> > Show me data that checking all these table
> > pointers is noticeably slower than what I'm doing. What's the max
> > "required tables count" you've seen in upstream so far?
>
> Running anything extra (specially some initialization stuff) in
> opp-set-rate is wrong as per me and as a Maintainer of the OPP core it
> is my responsibility to not allow such things to happen.

Doing operations lazily right before they are needed isn't something
new in the kernel. It's done all over the place (VFP save/restore?).
It's not worth arguing though -- so I'll agree to disagree but follow
the Maintainer's preference.

> > I'd even argue that doing it the way I do might actually reduce the
> > cache misses/warm the cache because those pointers are going to be
> > searched/used right after anyway.
>
> So you want to make the cache hot with data, by running some code at a
> place where it is not required to be run really, and the fact that
> most of the data cached may not get used anyway ? And that is an
> improvement somehow ?

My point is that both of us are hypothesizing and for some
micro-optimization like this, data is needed.

-Saravana
