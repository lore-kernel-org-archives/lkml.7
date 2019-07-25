Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE6FC76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 04:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF51422ADA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 04:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bqG/SvOc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbfGYEJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 00:09:42 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36339 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbfGYEJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 00:09:41 -0400
Received: by mail-ot1-f65.google.com with SMTP id r6so50225369oti.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 21:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bvjfb2LhI+/zuz8KHMCw9FpZvOIrarX3w7sAGkpylfQ=;
        b=bqG/SvOcv8Mwj5FFO+DrPMKgzVt8YVxd83tsBeTDx8qr7h/3xeBPE6QHnJ0j+vgUSF
         D1s9NFSpBTA6MHBCz9oMCJvY1gRrKM6xDr8BX+lZ/jbVuqlAypmKNnz+a61C4MBP+v4Y
         RWZItLoV6itbASo+u1lY1k94/2JQ/JGfv2h4NOs+XvCKFeZoMU0ZOwyjHywbxEM0lvSX
         g4a6g6tsMJwU8q78cHHaHw+K20eCPD5g0ZpcOmscX5XbUvkgLouh9L3BYcNnewm1z3hR
         Yixp9kHaKsqmfspUPq6kKp8JqddKAbzgVGkOI7Wq+9FcCW+1wNdA2ELQBS9dtFi6kr6u
         coUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bvjfb2LhI+/zuz8KHMCw9FpZvOIrarX3w7sAGkpylfQ=;
        b=AVmGLNGDFem5HZC0FriTQQNYOfAYJaz9n5R3zncIXsjLrhwNSAvgBK+7M+ZG9eeAEm
         4pLpf/np6TwlI9gXsBZfX9PrtOD7qKd+vl20TG7tZKPTiPShrEUTTV3Q/NuyBdptUiDU
         mDNKu9n29U6AaZttDmM2Fp4sQBlH/nPNMoObYdTa8vDmo6ysbkd5rTraTIoJZLnVTm+E
         zuVe6BURz0dShvzE//q/qEorxAmJjK7kfOHuT8Higs/w3DEzWsQ32Uj4psYWaysy0/Tg
         4XjxJbInlngQInShK2W0zX6WJqVTYsah6JNBHxaLJFiyWqva2gIuyMQa33ZVJ293Wn+q
         LYuQ==
X-Gm-Message-State: APjAAAUjuTQeTduApGSZodXR/gHtNE+1GVynqbiTIAHoWsirmxVTMZjW
        o5HNseQcOPq5yEK2MUBY1+myo/Y1HVws1pu+tzV/DQ==
X-Google-Smtp-Source: APXvYqzaPo5V9rstqlfAw5FF4231hqbxdKu50LHhUr0IKGgskie8ih1DVomew4/4MuweYr4O7m8vQFvERcjsAaZo3Ic=
X-Received: by 2002:a05:6830:12d6:: with SMTP id a22mr34587694otq.236.1564027780397;
 Wed, 24 Jul 2019 21:09:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190717222340.137578-1-saravanak@google.com> <20190717222340.137578-4-saravanak@google.com>
 <20190723102842.t2s45zzylsjuccm4@vireshk-i7> <CAGETcx-6M9Ts8tfMf6aA8GjMyzK5sOLr069ZCxTG7RHMFPLzHw@mail.gmail.com>
 <20190725030712.lx3cjogo5r7kc262@vireshk-i7>
In-Reply-To: <20190725030712.lx3cjogo5r7kc262@vireshk-i7>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 24 Jul 2019 21:09:04 -0700
Message-ID: <CAGETcx8QTs2Dqqppb_gwiUa2fte92K_q+B+j_CreRgqU52L7EA@mail.gmail.com>
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

On Wed, Jul 24, 2019 at 8:07 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 23-07-19, 07:47, Saravana Kannan wrote:
> > On Tue, Jul 23, 2019, 3:28 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > > $subject doesn't have correct property name.
> > >
> > > On 17-07-19, 15:23, Saravana Kannan wrote:
> > > > Currently, the linking of required-opps fails silently if the
> > > > destination OPP table hasn't been added before the source OPP table is
> > > > added. This puts an unnecessary requirement that the destination table
> > > > be added before the source table is added.
> > > >
> > > > In reality, the destination table is needed only when we try to
> > > > translate from source OPP to destination OPP. So, instead of
> > > > completely failing, retry linking the tables when the translation is
> > > > attempted.
> > > >
> > > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > > ---
> > > >  drivers/opp/core.c | 32 +++++++++++-----
> > > >  drivers/opp/of.c   | 91 ++++++++++++++++++++++------------------------
> > > >  drivers/opp/opp.h  |  5 +++
> > > >  3 files changed, 71 insertions(+), 57 deletions(-)
> > >
> > > Here is the general feedback and requirements I have:
> > >
> > > - We shouldn't do it from _set_required_opps() but way earlier, it
> > >   shouldn't affect the fast path (where we change the frequency).
> > >
> >
> > I don't think there's any other intermediate OPP call where we can try to
> > link the tables. Also if there tables are already fully linked, this is
> > just checking for not NULL for a few elements in the array.
>
> We should be doing this whenever a new OPP table is created, and see
> if someone else was waiting for this OPP table to come alive.

Searching the global OPP table list seems a ton more wasteful than
doing the lazy linking. I'd rather not do this.

> Also we
> must make sure that we do this linking only if the new OPP table has
> its own required-opps links fixed, otherwise delay further.

This can be done. Although even without doing that, this patch is
making things better by not failing silently like it does today? Can I
do this later as a separate patch set series?

> > I don't think
> > this is really going to allow down the fast path in anyway.
>
> > If you have other ideas, I'm willing to look at it. But as it is right now
> > seems the best to me.
> >
> Even then I don't want to add these checks to those places. For the
> opp-set-rate routine, add another flag to the OPP table which
> indicates if we are ready to do dvfs or not and mark it true only
> after the required-opps are all set.

Honestly, this seems like extra memory and micro optimization without
any data to back it. Show me data that checking all these table
pointers is noticeably slower than what I'm doing. What's the max
"required tables count" you've seen in upstream so far?

I'd even argue that doing it the way I do might actually reduce the
cache misses/warm the cache because those pointers are going to be
searched/used right after anyway.

-Saravana
