Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1529FC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 19:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD442206BB
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 19:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jbDvBSQK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbfFFTwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 15:52:09 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33547 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbfFFTwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 15:52:08 -0400
Received: by mail-io1-f67.google.com with SMTP id u13so1208756iop.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 12:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KHvZ08UQ6F9DrHSAJkdM4lRvAaL9fp+PzcKQDvAi3QA=;
        b=jbDvBSQKpvmcMfisYPWINLkIs3i3NZs3RpdPSdnRUOHZnK1IOgnssVmxivPMMSoK4e
         nv/niDA3x/sHbTqqGxpF7OBCH1o4MvD1RBWwK2KQoN7/h2miH0lAtmdrkm47ZBrYI13w
         zt7vPo7wvgZLRvh1Gbnb6uHqUNOp1C1yUqwme7OSii8ttZ7QiWEESYK8uRtN5RF5QTrU
         BN693xbH+tersd1T+gYqV8Tvly0puO4lUKcMojAn4ieh8PAhmYlk01sk9Pgx3tzF/Pg/
         zmisvsJvs5pc9GzSL93Q4yWuXqYhyOkJmKKu74bQDnGI01kFwj9PQ7nwZ6XjK7Z6nb2Q
         +0wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KHvZ08UQ6F9DrHSAJkdM4lRvAaL9fp+PzcKQDvAi3QA=;
        b=oW8LhAirENvnZdApuCEaawnBZYrxd6O7EPcNjjqBzg8Ep1HhSStBCLvt70CskShc0I
         bmsEzH52/U7S7VUdCZGMkGQqFZ4Id0zjs9k/peIV8zbrsHAayK93uEC2W1Or0GUCQozI
         tfwJqXUXTFPxZt7BvKJ6mJWIjPJeJLNcTsaahWdTk6dNwnAkwj0OUHXUSqgfUHW9+gze
         bfoHjk6IIdJrHL6Gp1M+7AzS4sktN1VJcAueopi3y3YgYKEO1BJDjYbiR+4Xqs0l2dsE
         9w/jqMMD+LGB72Lr/CmU3/AQjcO53x+d++Xle4+SoQpQyF65g1p8lXHeRE+LHsvrcemN
         wqNw==
X-Gm-Message-State: APjAAAV4yC5PjQymLlxy8NAcAIs1xG4C6p+6NxYXdpbTBC03VKO+bIE4
        RhBZEQBAsfRtqr0FGK4wtKLDUlFSoVAB+mJu5Fk=
X-Google-Smtp-Source: APXvYqymvS7JveFRHGX2qEIRdNfDHD4Cnki5S0RB9Xg/IBxcdtjj13BXWkPSvtVcEsD98/qeQ1BPGZK9lP9LOmRePc8=
X-Received: by 2002:a6b:f607:: with SMTP id n7mr7342606ioh.263.1559850727465;
 Thu, 06 Jun 2019 12:52:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190605070507.11417-1-andrew.smirnov@gmail.com>
 <CGME20190605070532epcas2p2154c96c417cca1c1fc3c149c66447560@epcas2p2.samsung.com>
 <20190605070507.11417-6-andrew.smirnov@gmail.com> <9f847830-7bc6-c377-5cd7-b3cff783cbb3@samsung.com>
In-Reply-To: <9f847830-7bc6-c377-5cd7-b3cff783cbb3@samsung.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Thu, 6 Jun 2019 12:51:56 -0700
Message-ID: <CAHQ1cqGuDj2wVbKRMxBsFWk6cK4HO54ivajqSNfXate_NzF+Yg@mail.gmail.com>
Subject: Re: [PATCH v3 05/15] drm/bridge: tc358767: Drop custom
 tc_write()/tc_read() accessors
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     dri-devel@lists.freedesktop.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andrey Gusakov <andrey.gusakov@cogentembedded.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cory Tusar <cory.tusar@zii.aero>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 6, 2019 at 3:34 AM Andrzej Hajda <a.hajda@samsung.com> wrote:
>
> On 05.06.2019 09:04, Andrey Smirnov wrote:
> > A very unfortunate aspect of tc_write()/tc_read() macro helpers is
> > that they capture quite a bit of context around them and thus require
> > the caller to have magic variables 'ret' and 'tc' as well as label
> > 'err'. That makes a number of code paths rather counterintuitive and
> > somewhat clunky, for example tc_stream_clock_calc() ends up being like
> > this:
> >
> >       int ret;
> >
> >       tc_write(DP0_VIDMNGEN1, 32768);
> >
> >       return 0;
> > err:
> >       return ret;
> >
> > which is rather surprising when you read the code for the first
> > time. Since those helpers arguably aren't really saving that much code
> > and there's no way of fixing them without making them too verbose to
> > be worth it change the driver code to not use them at all.
>
>
> On the other side, error checking after every registry access is very
> annoying and significantly augments the code, makes it redundant and
> less readable. To avoid it one can cache error state, and do not perform
> real work until the error is clear. For example with following accessor:
>
> void tc_write(struct tc_data *tc, u32 reg, u32 val){
>
>     int ret;
>
>     if (tc->error) //This check is IMPORTANT
>
>         return;
>
>     ret =regmap_write(...);
>
>     if (ret >= 0)
>
>         return;
>
>     tc->error = ret;
>
>     dev_err(tc->dev, "Error writing register %#x\n", reg);
>
> }
>
> You can safely write code like:
>
>     tc_write(tc, DP_PHY_CTRL, BGREN | PWR_SW_EN | PHY_A0_EN);
>
>     tc_write(tc, DP0_PLLCTRL, PLLUPDATE | PLLEN);
>
>     tc_write(tc, DP1_PLLCTRL, PLLUPDATE | PLLEN);
>
>     if (tc->error) {
>
>         tc->error = 0;
>
>         goto err;
>
>     }
>
> This is of course loose suggestion.
>

I am going to have to disagree with you on this one, unfortunately.
Using regmap API explicitly definitely makes code more verbose, less
readable or more annoying though? Not really from my perspective. With
regmap code I know what the code is doing the moment I look at it,
with the example above, not so much. I also find it annoying that I
now have to remember the tricks that tc_write is pulling internally as
well as be mindful of a global-ish error state object. My problem with
original code was that a) it traded explicitness for conciseness in a
an unfavorable way, which I still think is true for code above b) it
didn't provide a comprehensive abstraction completely removing regmap
API and still relied on things like regmap_update_bits() explicitly,
making the code even more confusing (true for above example as well).
I think this driver isn't big enough to have a dedicated person always
working on it and it will mostly see occasional commits from somewhat
random folks who are coming to the codebase fresh, so creating as
little "institutional knowledge", so to speak, in a form of a custom
exception-like mechanism and opting for explicit but verbose code
seems like a preferable choice.

Anyway, I get it that's it is a loose suggestion :-), just wanted to
provide a detailed explanation why I'd rather not go that way.

Thanks,
Andrey Smirnov
