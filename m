Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9325EC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 17:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 679EC20693
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 17:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="gqL0EETY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730951AbfIMRTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 13:19:38 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43764 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728720AbfIMRTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 13:19:38 -0400
Received: by mail-oi1-f194.google.com with SMTP id t84so3252265oih.10
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 10:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OKzQ7wwphOjxmY/K1EtxnOsTdv2PWzuGJ4C8ws0Egy0=;
        b=gqL0EETYmHL8v3NKExxXcCfswUCCiPVZzxeoC79eVpYprEt+jozMPa6wAWDltcNb3x
         VmYaF6bcrZLJnKz9xIIEwoEwF8/jbmki9ju1dVDY7Krqll1tKgk871TOS2FTkEv5VjJL
         RRtibs3gERfUlHMwswxQ0mabI7O5m4cz9vovI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OKzQ7wwphOjxmY/K1EtxnOsTdv2PWzuGJ4C8ws0Egy0=;
        b=Y97qVVN9XQq4gTbe3nHDdS3L/LnNHzYS/KQpFeYPtj2+HK2eAufzfJ1SX+Jb6cIypi
         t7+bpyRzjSbKD4tMTr32ix75pC3msdsvZYuk+m3BNdW2izXrHNo4TB5uodyofbviGgF5
         AFAvZ46EJaymXl55RBFl+JkQNGoueI5EIquSgruk9kvWr40PHRC9bOyHIGYIu7UOhux4
         qrbSLsm6mzIUWGw/7CTtBr8olqNz/D6EW8djs50b3UC76y5sysgB/0jnkZvODONTOQ4k
         DripajHecWRMJ+/nibev0pW2BmRHNPp1XGBHJKhsRIm15BpideA9Mc7lyRKgSvlHrm7C
         sfZA==
X-Gm-Message-State: APjAAAWxGWsNcsSGt2cuvoKPxX5ODUCMniVXqoD2RS9UC4xM+CPlT2ty
        SLzfqTpKOtNpInZKs5nRcmDr4UKQJhXufBKtTobfVA==
X-Google-Smtp-Source: APXvYqwuw9ZYZrUqJW3S1meWYkCAvipklH3NTP77DVgNvFseKQvu1WlDTpRX3RPGZCmD4dIwv3Hxd1PSyIy8xnCxSnk=
X-Received: by 2002:aca:5697:: with SMTP id k145mr4124856oib.101.1568395175833;
 Fri, 13 Sep 2019 10:19:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190907090534.GB1712@pc-sasha.localdomain> <CAKMK7uHYdXwruQxxBM12Q5MVeH9fjFpZvxZz06BSo7YrCQbM2w@mail.gmail.com>
 <20190908141307.GA7115@pc-sasha.localdomain> <20190909201159.778590a0@canb.auug.org.au>
 <20190909202128.0c420ddd@canb.auug.org.au> <CAJ1xhMXKNRfOm1Xj3B_cgLByBfDP03P+DBEbRpWc+tU6kdxtBw@mail.gmail.com>
In-Reply-To: <CAJ1xhMXKNRfOm1Xj3B_cgLByBfDP03P+DBEbRpWc+tU6kdxtBw@mail.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Fri, 13 Sep 2019 19:19:24 +0200
Message-ID: <CAKMK7uEnECWMC-EhEhNYiMH4+om6vLTmNw3jTwx0MY5m-Ksc8A@mail.gmail.com>
Subject: Re: Kernel panic during drm/nouveau init 5.3.0-rc7-next-20190903
To:     Alexander Kapshuk <alexander.kapshuk@gmail.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-Next <linux-next@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, Dave Airlie <airlied@linux.ie>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 9, 2019 at 12:25 PM Alexander Kapshuk
<alexander.kapshuk@gmail.com> wrote:
>
> On Mon, Sep 9, 2019 at 1:21 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Hi,
> >
> > On Mon, 9 Sep 2019 20:11:59 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > >
> > > If you are bisecting linux-next, I will suggest bisecting between the
> > > stable branch on linux-next (which is just Linus' tree when I started
> > > that day) and the top of the first linux-next that fails.  (Assuming
> > > that the stable branch is good).
> >
> > Actually (since you won't be bisecting the latest linux-next), you
> > probably want to use
> >
> > git merge-base stable next-20190903
> >         (or whatever linux-next you are bisecting)
> >
> > as your first good commit (assuming it id good :-)).
> >
> > --
> > Cheers,
> > Stephen Rothwell
>
> Hi Stephen,
>
> Thanks very much for the tips.
> I'll go ahead and give those a try.

Yeah this should help, but in general, due to our non-linear history,
git bisect can jump around quite a bit. Especially if you only look at
dates. Also due to our non-linear history, it sometimes needs to test
you a merge-base, to figure out which part of the history it needs to
chase for the bad commit. So all normal, but the hint above should
help.

Also, you don't need to restart git bisect, you can just tell it about
any good/bad commit you tested with

$ git bisect good|bad $sha1

The more git knows, the quicker it should find the bad commit.

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
