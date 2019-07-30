Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59BFC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 05:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A53B520679
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 05:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N17K/Md9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729800AbfG3Fxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 01:53:50 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45614 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbfG3Fxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 01:53:49 -0400
Received: by mail-ot1-f65.google.com with SMTP id x21so26620161otq.12
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 22:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z9yhVZrCo2Ym96O9jSbeb4ViFfqeymdVjMGrDKz2FPM=;
        b=N17K/Md9kf9zsF+8d2jNQ4qeEMqeDzuH2Fn+lKJIzHgbcXXOjdXqxhe19pt/7H+kfK
         XIK9MUmRSzEkvOdZxeQ6792Oxc44al7rEb96Qa4TRYkiZNU+2QBvoxA5HSBjy2Qbr6W8
         karZdmF31kOYyjULxZJDgpCSFY/y12xphn+Ku0jhWDm02Ic0UcY97gI3Q798ydEBPQYd
         +ddBmLBRhnl5/3zOGgNhGxyitb7DltzQm7fjlDExtim+zNKXNt1MRCHizz3F+SBjicNQ
         nOI9ItTaH6hxoO9MeQTvvhUsb+gY3mSY/yxaPeWHKRA3MkxO3883J0ao/X5SwFU2hK48
         Cu/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z9yhVZrCo2Ym96O9jSbeb4ViFfqeymdVjMGrDKz2FPM=;
        b=TzAheF3hKyAcQyll1vLPy0zm4+9eCEmOm+sO4N2kmHe7qYgPpBcoZaRyspuzvuw0hy
         ICj/LNAdAPYlERxsntapyaIJZwuDQSjCon2wjFiSfFkXNJtBxgSWG6bl/TtC4NmEJ96B
         r9MPaz5GtpE1MuERuSfEYaK86b0MDzIasK4AQPR7n8j1+wDLCsr/d8OdXM6yxOH3VdoH
         X/RCZ2tfuZn12YXwTf3aJm/4dYbWLx92T/iT1HJZZ9yqRQVUo3bA3rFE2lytwdQxs9M7
         vKnXNaB5CL0RAVNduLHAQzv1MyXK5PC0ZAVbsL6ZstVHsHuocDMKz9tUO7D2exbESGrJ
         xDSA==
X-Gm-Message-State: APjAAAUrbW8FR+XRZEvP6mt2iiMvPrsYOIXFu7KVrbx3viDB3fWMAPZT
        4fy9bhOLdFhA6doYUMptXcJ+SWEifzdn4P2k2EuTMw==
X-Google-Smtp-Source: APXvYqw7aEwNPWqA3eNN9XZ6LCef/h3vqbjo/cS8W1eUnYiAmCC4A8v/J5cB8Qphwz409QxSDP0CwBJE6rzqfg/0x8I=
X-Received: by 2002:a9d:6201:: with SMTP id g1mr86267586otj.195.1564466028394;
 Mon, 29 Jul 2019 22:53:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190726231558.175130-1-saravanak@google.com> <20190729093545.kvnqxjkyx4nogddk@vireshk-i7>
 <CAGETcx8OBFGgP1-hj717Sk-_N95-kacVsz0yb288n3pej12n1Q@mail.gmail.com>
 <20190730024640.xk27jgdfl2j6ucx7@vireshk-i7> <361effba-4433-24d9-243c-201af39214cc@codeaurora.org>
In-Reply-To: <361effba-4433-24d9-243c-201af39214cc@codeaurora.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 29 Jul 2019 22:53:12 -0700
Message-ID: <CAGETcx_BpJswxA4AGARogZ1xRJPqm=_zTOZq1xJ2vgx+DUYsqQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] Introduce Bandwidth OPPs for interconnects
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Sweeney, Sean" <seansw@qti.qualcomm.com>,
        David Dai <daidavid1@codeaurora.org>, adharmap@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 10:28 PM Sibi Sankar <sibis@codeaurora.org> wrote:
>
> Hey Viresh,
>
> On 7/30/19 8:16 AM, Viresh Kumar wrote:
> > On 29-07-19, 13:16, Saravana Kannan wrote:
> >> Sibi might be working on doing that for the SDM845 CPUfreq driver.
> >> Georgi could also change his GPU driver use case to use this BW OPP
> >> table and required-opps.
> >>
> >> The problem is that people don't want to start using this until we
> >> decide on the DT representation. So it's like a chicken and egg
> >> situation.
> >
> > Yeah, I agree to that.
> >
> > @Georgi and @Sibi: This is your chance to speak up about the proposal
> > from Saravana and if you find anything wrong with them. And specially
> > that it is mostly about interconnects here, I would like to have an
> > explicit Ack from Georgi on this.
> >
> > And if you guys are all okay about this then please at least commit
> > that you will convert your stuff based on this in coming days.
>
> I've been using both Saravana's and Georgi's series for a while
> now to scale DDR and L3 on SDM845. There is currently no consensus
> as to where the votes are to be actuated from, hence couldn't post
> anything out.
>
> DCVS based on Saravana's series + passive governor:
> https://github.com/QuinAsura/linux/tree/lnext-072619-SK-series

Thanks Sibi! You might want to convert your patches so that until the
passive governor is ready, you just look up the required opps and vote
for BW directly from the cpufreq driver. Once devfreq governor is
ready, you can switch to it.

-Saravana

>
> DCVS based on Georgi's series: (I had already posted this out)
> https://github.com/QuinAsura/linux/tree/lnext-072619-GJ-series
>
> --
> Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc, is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
