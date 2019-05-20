Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FBCEC04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 21:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4675821743
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 21:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hK2eyv+R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfETVkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 17:40:49 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37839 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbfETVks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 17:40:48 -0400
Received: by mail-qk1-f195.google.com with SMTP id d10so9813841qko.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 14:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IThQGlwZN4WtsbLkk3oukuwrzsnq23H8GMI8BgIL1f8=;
        b=hK2eyv+RmjhJBhO9xW7nmAOoLOTUPMU93WRuMaB8KV1/Ipcsc6fF4RwDKaRanXgiiQ
         1moFfP9ko3eAH7gEqqzVhMRmuadceiV7qXi2MurSlIpZ9Llv91z5GHWZ/1aX3y7jM18+
         IGN5yM1LK6mMLNa40n1/AIP0iJDcB2m08JUvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IThQGlwZN4WtsbLkk3oukuwrzsnq23H8GMI8BgIL1f8=;
        b=VVrrWS5qdcR9XWAmjkjHggiQE5zqC3/CuZY2zM+GI364cWIt6RexSBQFp5R4d6LX8+
         tJc57QANuo1VO2YP1mxdq3VsI7flW9dCNPRMj/SaVhAqiUXIabxL9uSTFlm0++Vyjfir
         nE1+JXvpjuANKPJGS2JI5lsX4k2LVrlGm7iphe+zLy183gDzvUMbRtckQ7P7QgH4itRc
         I83pFJ7/KmqyLpjcZzJ9N6peiviVmEvdtlIySCFQO9syvbO5DeW7eahFpwTH0kqUdLCy
         uc5LI74598CmPlepjklP/pNQwYELK9X0nqxfnlK6WbzQMMGtXPyDLpTV+czkVDF/ooUz
         h8Og==
X-Gm-Message-State: APjAAAVjAWIXTtuqVAfth0dqOlWQhctqiuATMhPe0JDvQ/PBhMZtRH1y
        AubrXeRhrxNjf6zdYIf9kGbkT9qQ4WALjW3d2VeDWw==
X-Google-Smtp-Source: APXvYqzfgYWlx9/QVid5RlxkAKFGC41IFGLXDgG2zUutdncRoErF8VDmxEvq4gwP/Ta+vr3S5rGzrv8w5nxXmGEg1dQ=
X-Received: by 2002:a37:4c04:: with SMTP id z4mr43466352qka.195.1558388447854;
 Mon, 20 May 2019 14:40:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190520044951.248096-1-drinkcat@chromium.org> <CAC5umygGsW3Nju-mA-qE8kNBd9SSXeO=YXMkgFsFaceCytoAww@mail.gmail.com>
In-Reply-To: <CAC5umygGsW3Nju-mA-qE8kNBd9SSXeO=YXMkgFsFaceCytoAww@mail.gmail.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Tue, 21 May 2019 05:40:36 +0800
Message-ID: <CANMq1KBUKfOdZWAf95nb2UQqLdLCMsLnVTZAZSgN0QfgK3Dbxw@mail.gmail.com>
Subject: Re: [PATCH] mm/failslab: By default, do not fail allocations with
 direct reclaim only
To:     Akinobu Mita <akinobu.mita@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Michal Hocko <mhocko@suse.com>, Joe Perches <joe@perches.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mm@kvack.org, Pekka Enberg <penberg@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 12:29 AM Akinobu Mita <akinobu.mita@gmail.com> wrot=
e:
>
> 2019=E5=B9=B45=E6=9C=8820=E6=97=A5(=E6=9C=88) 13:49 Nicolas Boichat <drin=
kcat@chromium.org>:
> >
> > When failslab was originally written, the intention of the
> > "ignore-gfp-wait" flag default value ("N") was to fail
> > GFP_ATOMIC allocations. Those were defined as (__GFP_HIGH),
> > and the code would test for __GFP_WAIT (0x10u).
> >
> > However, since then, __GFP_WAIT was replaced by __GFP_RECLAIM
> > (___GFP_DIRECT_RECLAIM|___GFP_KSWAPD_RECLAIM), and GFP_ATOMIC is
> > now defined as (__GFP_HIGH|__GFP_ATOMIC|__GFP_KSWAPD_RECLAIM).
> >
> > This means that when the flag is false, almost no allocation
> > ever fails (as even GFP_ATOMIC allocations contain
> > __GFP_KSWAPD_RECLAIM).
> >
> > Restore the original intent of the code, by ignoring calls
> > that directly reclaim only (___GFP_DIRECT_RECLAIM), and thus,
> > failing GFP_ATOMIC calls again by default.
> >
> > Fixes: 71baba4b92dc1fa1 ("mm, page_alloc: rename __GFP_WAIT to __GFP_RE=
CLAIM")
> > Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
>
> Good catch.
>
> Reviewed-by: Akinobu Mita <akinobu.mita@gmail.com>
>
> > ---
> >  mm/failslab.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/failslab.c b/mm/failslab.c
> > index ec5aad211c5be97..33efcb60e633c0a 100644
> > --- a/mm/failslab.c
> > +++ b/mm/failslab.c
> > @@ -23,7 +23,8 @@ bool __should_failslab(struct kmem_cache *s, gfp_t gf=
pflags)
> >         if (gfpflags & __GFP_NOFAIL)
> >                 return false;
> >
> > -       if (failslab.ignore_gfp_reclaim && (gfpflags & __GFP_RECLAIM))
> > +       if (failslab.ignore_gfp_reclaim &&
> > +                       (gfpflags & ___GFP_DIRECT_RECLAIM))
> >                 return false;
>
> Should we use __GFP_DIRECT_RECLAIM instead of ___GFP_DIRECT_RECLAIM?
> Because I found the following comment in gfp.h
>
> /* Plain integer GFP bitmasks. Do not use this directly. */

Oh, nice catch. I must say I had no idea I was using the 3-underscore
version, hard to tell them apart depending on the font.

I'll send a v2 with both your tags right away.

Thanks,
