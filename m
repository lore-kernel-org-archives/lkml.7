Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052EEC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 19:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D13E1270FC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 19:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wUFV0A+X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfFCTNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 15:13:07 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46923 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfFCTNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 15:13:07 -0400
Received: by mail-ot1-f68.google.com with SMTP id z23so2198429ote.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 12:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=mAoddn+++8qwVdvo0LP4Flz+Y0mAR71WsumbGA5/ntU=;
        b=wUFV0A+XrqyYbdkgHK2CxppQeWvJUI4OC2TQpYTXBHH0DILNt6bkaBhKCwhB5AMwIG
         0LOIAe+9QJKpYEjKS94senTDbXCrId9d/+f/ZBIfAfPM+uzNRYXp73FwgI8keJiQH6Wx
         cNe1QAI+DNUL/c6FAldEpXYakT33XUg0x5qP0g1jDJfet10XDHsrdMDInEk52n+QnmBA
         EzuhaWMFTEIxQS84WmV0CUdoSAaZUMhAm5V8jXOjbmWjyKqFHkZizOEpvqx/kZBlpS24
         DRbZGfmxdVyKJaGeuHg6Bj5VC642CNXwqO3WOByUzpW7WkyWju0chAM6nifBRzHX6/Mc
         2x0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=mAoddn+++8qwVdvo0LP4Flz+Y0mAR71WsumbGA5/ntU=;
        b=p16ORc/teOK5ee/gQ9kvDIQJRmA6ZJjrghKT7Nf1dlFKcb+UaAGAbY6iS6AT0SgHwR
         dVU20T4YQqrnctVY9l44tdQNSYHtlilhUbzShmYTbV/TeOuIaWzMkQeuxEUsDm75j1XP
         72LaGycs9r2tJCxl2aHghuKE4IPI494QZnU/CtpA6JteQeyPJJoW3YMQIMLgE4NWcVOj
         qa+NLjmFWgHmqMEyQAGs67Bp1etVG3Nm114hyaIiBWjsGMnNEtLeSlm0hfPSzzzRnB39
         G3gukMbk8xJfntR/80bPImSvPVqUSl3fllFs6FfpkHyfX8yOHeyWH8Ab0mxzX54Q5UGx
         r8iQ==
X-Gm-Message-State: APjAAAXYrjTodVi3gpi+b7rLqdfECnxjDf0keQ5U0D9AA/MyXMFlPcIN
        ytvMth6OpCXYXdJRWIY+HJieXZDn0i7M8eIrWJVE5g==
X-Google-Smtp-Source: APXvYqy+Lm1ofR4ZAQBNDXyeTt8ZtlyM1FjuSyKegJQbbObal6TMdDAAlb7/1ROuwQ5EjTzGHLN2r16ho6jaEfz21D8=
X-Received: by 2002:a05:6830:160c:: with SMTP id g12mr2427193otr.231.1559589186170;
 Mon, 03 Jun 2019 12:13:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190423132823.7915-1-georgi.djakov@linaro.org>
 <20190601021228.210574-1-saravanak@google.com> <20190603155634.GA10741@jcrouse1-lnx.qualcomm.com>
In-Reply-To: <20190603155634.GA10741@jcrouse1-lnx.qualcomm.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 3 Jun 2019 12:12:30 -0700
Message-ID: <CAGETcx8yV_D+=qLnJOx5s5Nvq2RxhcJvz+gejDBN1-qrBE=Msg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Introduce OPP bandwidth bindings
To:     Saravana Kannan <saravanak@google.com>, georgi.djakov@linaro.org,
        amit.kucheria@linaro.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        daidavid1@codeaurora.org, devicetree@vger.kernel.org,
        evgreen@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>, nm@ti.com,
        rjw@rjwysocki.net, Rob Herring <robh+dt@kernel.org>,
        sboyd@kernel.org, seansw@qti.qualcomm.com, sibis@codeaurora.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        vireshk@kernel.org, Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 3, 2019 at 8:56 AM Jordan Crouse <jcrouse@codeaurora.org> wrote:
>
> On Fri, May 31, 2019 at 07:12:28PM -0700, Saravana Kannan wrote:
> > I'll have to Nack this series because it's making a couple of wrong assumptions
> > about bandwidth voting.
> >
> > Firstly, it's mixing up OPP to bandwidth mapping (Eg: CPU freq to CPU<->DDR
> > bandwidth mapping) with the bandwidth levels that are actually supported by an
> > interconnect path (Eg: CPU<->DDR bandwidth levels). For example, CPU0 might
> > decide to vote for a max of 10 GB/s because it's a little CPU and never needs
> > anything higher than 10 GB/s even at CPU0's max frequency. But that has no
> > bearing on bandwidth level available between CPU<->DDR.
>
> I'm going to just quote this part of the email to avoid forcing people to
> scroll too much.
>
> I agree that there is an enormous universe of new and innovative things that can
> be done for bandwidth voting. I would love to have smart governors and expansive
> connections between different components that are all aware of each other. I
> don't think that anybody is discounting that these things are possible.
>
> But as it stands today, as a leaf driver developer my primary concern is that I
> need to vote something for the GPU->DDR path. Right now I'm voting the maximum
> because that is the bare minimum we need to get working GPU.
>
> Then the next incremental baby step is to allow us to select a minimum
> vote based on a GPU frequency level to allow for some sort of very coarse power
> savings. It isn't perfect, but better than cranking everything to 11.

I completely agree. I'm not saying you shouldn't do bandwidth voting
based on device frequency. In some cases, it's actually the right
thing to do too.

> This is
> why we need the OPP bandwidth bindings to allow us to make the association and
> tune down the vote.

Again, I'm perfectly fine with this too.

> I fully agree that this isn't the optimal solution but
> it is the only knob we have right now.
> And after that we should go nuts. I'll gladly put the OPP bindings in the
> rear-view mirror and turn over all bandwidth to a governor or two or three.

This is the problem part in the series. Once a property is exposed in
DT, we can't just take it back. A new kernel needs to continue
supporting old compiled DT binaries. So if we know we'll have to
change a DT property in the future to be "more correct", then we
should just do that one instead of "for now" bindings.

And I even proposed what the new bindings should look like and why we
should do it that way.

I'll try to get some patches out for that in the near future. But
doesn't have to be just from me. I'm just pointing out why the current
bindings aren't good/scalable.

> I'll be happy to have nothing to do with it again. But until then we need
> a solution for the leaf drivers that lets us provide some modicum of power
> control.

Agreed.

-Saravana
