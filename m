Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E3AC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAA2520851
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LKUR2QG8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfCHNYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 08:24:05 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:34047 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbfCHNYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 08:24:04 -0500
Received: by mail-vk1-f193.google.com with SMTP id k64so4564792vke.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 05:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E/Y97PauZvlWC5LaIqRv37Me09Wz3zb9niWsov8aWzU=;
        b=LKUR2QG8UOUMNBv5PC4HP7otAsH3lQ4V95b1qTz8Ru7tlszPcY9mXzwo/dk5XL1qf4
         w8Iab+njZbYLXL0oTGAcjC9v8dTeqYkdrJVUYYHUzsws3lPk+bmI+VKsbbDhwR0ghi/S
         0zwB/ZXXu4OmA1RsYLos0aXVJkEo2R7V6Ta8nzZ/G7FxSMP6NohzA8Wkz5B+AamCu5Ly
         QPabB8ecf3FaRSnbtqoFMhF/46CR5obf3dar8wLbbyDnTujvyHiwpbj5YcFwHnKK3HNg
         OxiY2XGIQS1J7+03k6zSbs1irlYcbqTqD4qSGr29A3wrHrJOOqoyls6biH62zE5heKZ6
         whOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E/Y97PauZvlWC5LaIqRv37Me09Wz3zb9niWsov8aWzU=;
        b=AUk4n0Fyy2iG1fh2anNMa96k2SKTlgbNFLNFT+1ENAt+oHtA+Y4rKK2TZyOLeCA4zF
         pvtQL4C/KRe+cvPdxP5XI7sCSw1S+/vjqyGuIg1JKMKd7Z0bz8Kk+4UrlzqX6VFRLlz1
         jTh5wA8RFuE7uEAyk5/VJj/WX4ZK+t6SK6yfRAHSJ4Osa8i+Muusfx6jNkVXo+diHsGh
         zjuUy4YqjYJ3rW/fUQOwGQ9tcaovktGL0NC6MRqystGzfx1PqQETR6uqLEU1d2rTy1cO
         W90vqSuD84aUkli4ia4URsPTJU2zqwRD+/LcbRC7DLHpReOT3YFvFDMOkytmMxm0M4l/
         YPKQ==
X-Gm-Message-State: APjAAAWew+xB2/a4zESsFCCmsmgVL0CXzVLATpFLU0HUyVJoSn7vw/eJ
        b3EQ+L6URs6GmxkIfPmQ541Zzxv2L2HDFN3EfLhSgQ==
X-Google-Smtp-Source: APXvYqzDw7U6tZWCw1q5Hz7XaSBZW3K9ct6gjv8fBdUMOuFAR11PCJTBmKOXqs0igXBAnDlzZp1pJvIFtks6/6WKWSY=
X-Received: by 2002:a1f:37cd:: with SMTP id e196mr3545031vka.36.1552051442345;
 Fri, 08 Mar 2019 05:24:02 -0800 (PST)
MIME-Version: 1.0
References: <20190228135919.3747-1-ulf.hansson@linaro.org> <20190228135919.3747-6-ulf.hansson@linaro.org>
 <20190301172810.GR15517@lakrids.cambridge.arm.com> <CAPDyKFrqp6_NkTBVXZTa3j+-6y+m7aX2y6t=nH=Tjdo4BgMDtQ@mail.gmail.com>
 <20190306181519.GA3355@e107981-ln.cambridge.arm.com> <CAPDyKFrbu4rFyohv+YJkG7O03_r3+3gn1vib_FJUW0t-4REgTw@mail.gmail.com>
 <20190308114943.GA27731@e107981-ln.cambridge.arm.com> <CAPDyKFry_ZQXA-bj6gA8npdqkMmg8AUOZ+Kr4mnOaS8=xZ+MwA@mail.gmail.com>
 <20190308131723.GA30600@e107981-ln.cambridge.arm.com>
In-Reply-To: <20190308131723.GA30600@e107981-ln.cambridge.arm.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 8 Mar 2019 14:23:26 +0100
Message-ID: <CAPDyKFpf_SHO46x-7tYU3ouWbjQ9+r_wr6qx9q3ofZoDAtEqfA@mail.gmail.com>
Subject: Re: [PATCH 5/7] drivers: firmware: psci: Simplify state node parsing
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Mar 2019 at 14:17, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Fri, Mar 08, 2019 at 02:07:51PM +0100, Ulf Hansson wrote:
> > On Fri, 8 Mar 2019 at 12:49, Lorenzo Pieralisi
> > <lorenzo.pieralisi@arm.com> wrote:
> > >
> > > On Fri, Mar 08, 2019 at 11:36:49AM +0100, Ulf Hansson wrote:
> > >
> > > [...]
> > >
> > > > Instead, my suggestion is according to what I propose in patch 4 and
> > > > $subject patch, which means minor adjustments to be able to pass the
> > > > struct cpuidle_driver * to the init functions. This, I need it for
> > > > next steps, but already at this point it improves things as it avoids
> > > > some of the OF parsing, and that's good, isn't it?
> > >
> > > I will take the patches Mark ACKed and send them for v5.2 as
> > > early as it gets in v5.1-rc* cycle.
> >
> > Actually, may I suggest we funnel these through Rafael's tree, unless
> > you are expecting other PSCI changes for v.5.2, which could cause
> > conflicts?
> >
> > The reason is, other PM core changes, to genpd for example, needs to
> > go via Rafael's tree. Those would then potentially block us for
> > applying any other changes to your tree (arm-soc?) for PSCI (as there
> > is dependency) until v5.3.
> >
> > How about if you provides your explicit acks for those PSCI changes
> > your are happy with, then Rafael can pick them?
>
> It is fine we can do that, I would have not sent the patches Mark
> has ACKed to arm-soc till -{rc2/rc3} anyway.

Great!

May I suggest you just reply to the cover-letter and provide the acks
to the relevant patches, then I can then collect the received acks
tags and re-post them to Rafael once rc1 is out.

Kind regards
Uffe

>
> Thanks,
> Lorenzo
>
> > > For this one maybe you can post the changes on top and see what's
> > > the best way forward ?
> > >
> > > I agree that duplicating idle state parsing code across back-ends
> > > is silly - we just want to keep PSCI and kernel data structure
> > > decoupled.
> >
> > Right. Let's continue this discussion later on and move forward here.
> > Make sense.
> >
> > >
> > > Post the code on top and we will find a way forward, OK ?
> >
> > Sure, let me do that.
> >
> > Thanks and kind regards
> > Uffe
