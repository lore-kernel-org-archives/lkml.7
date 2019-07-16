Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B184CC7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 19:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C5BC21848
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 19:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SHlT79ff"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388433AbfGPTSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 15:18:11 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35684 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728137AbfGPTSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 15:18:10 -0400
Received: by mail-oi1-f196.google.com with SMTP id a127so16497293oii.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 12:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=brIaX2RYp1IxrZ3yZn3EZu9yevRmYR9uZd9VeocVV/A=;
        b=SHlT79ff4TphKMM6dtCfppLLkhwTUMV8N9Y6kvPrJluOI+OpuDpeuE71+GhDruE72y
         K1Xss88yMBWRbpDwktKAEVld+i6x+CYIhsdrHZGXS6BBKncKvpVukj6mWATPqc+NpSvG
         iGUH/b3NtnBOMh5i46bI7HYW0f18yrFxgKf/11vfxkmsHar6NfYZDe1cnTD4wZrcP1CN
         q2phpoZVApjrC009ntjorLI8ISLM8C8kY2ploNosNMTqO11yMs8wkPjdTmuRHTfIS59+
         2iWvZhlF/FosUxleQdGVPiFmxQusOlEZ/O984BOYis8LW+Idn58vxr6VnU6KoBgd5Uns
         qAAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=brIaX2RYp1IxrZ3yZn3EZu9yevRmYR9uZd9VeocVV/A=;
        b=LHlUQmBvsWWmJTECG1ZFyuBnhHKYjjFeASoc6fSTg9LHeZKW5orKXZw8LiP4drmPx+
         XewBVUHhCMppbRKK4tnNiaGxKbAC6dXYyDKVI3BwTU0XiTdtosjWzoIXuWFL0xtYaEx2
         vhsgpB18Fji+qT244CXHNisLofBv5iqydFGtdtr7f1DB4jhPVyQLfhYaM5L0fEz4NzsP
         lHO3ADfBAxw8P6Xv3FVCMcyg/JU/bySnSg6pe1/jauZ2G1OOnMT18bJoAN5FulZ/2xI7
         Wj+QSqklxq22gP/ciAH3aWf1vgoox1dHIYMmBr7lhyaaOwdIAFQi5pOZjafpA9q0wa9A
         avcw==
X-Gm-Message-State: APjAAAVjx5eOEQcBLFR29MWWP3fsqYT6WP5kdQlG7XLEXZPJgTKBw4+k
        fBDhNKQc0OyWD9fgFklM6VKkhK7HVS5khEKNtosgIQ==
X-Google-Smtp-Source: APXvYqx3+GgqwYBseeHlcjkPEuUSEs2Hyz9M1TGUi71nRbjb0OErHX0xZGg8c96y1ng0XHyCcYM1UYkyK/KqdUMvVqw=
X-Received: by 2002:aca:6104:: with SMTP id v4mr17656619oib.172.1563304689299;
 Tue, 16 Jul 2019 12:18:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190614041733.120807-1-saravanak@google.com> <20190614041733.120807-12-saravanak@google.com>
 <5dc6c820-ead8-d0dc-44de-4d13f86df042@linaro.org> <CAGETcx-xU9i1FJB5JecUoyZEfWpD8f+o9bC3SQmb-=3fLVbmQw@mail.gmail.com>
 <9f2bf3fd-f7c5-40e8-6415-f334e3ef8d5d@codeaurora.org>
In-Reply-To: <9f2bf3fd-f7c5-40e8-6415-f334e3ef8d5d@codeaurora.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 16 Jul 2019 12:17:33 -0700
Message-ID: <CAGETcx8woxSpOcjosh3pasBJPw-bfzh+=4x4xkq6R-ZRV+dc4A@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] interconnect: Add devfreq support
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        amit.kucheria@linaro.org,
        "Sweeney, Sean" <seansw@qti.qualcomm.com>,
        daidavid1@codeaurora.org, Evan Green <evgreen@chromium.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        adharmap@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2019 at 11:13 AM Sibi Sankar <sibis@codeaurora.org> wrote:
>
> Hey Saravana,
>
> On 6/18/19 2:48 AM, Saravana Kannan wrote:
> > On Mon, Jun 17, 2019 at 8:44 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
> >>
> >> Hi Saravana,
> >>
> >> On 6/14/19 07:17, Saravana Kannan wrote:
> >>> Add a icc_create_devfreq() and icc_remove_devfreq() to create and remove
> >>> devfreq devices for interconnect paths. A driver can create/remove devfreq
> >>> devices for the interconnects needed for its device by calling these APIs.
> >>> This would allow various devfreq governors to work with interconnect paths
> >>> and the device driver itself doesn't have to actively manage the bandwidth
> >>> votes for the interconnects.
> >>
> >> Thanks for the patches, but creating devfreq devices for each interconnect path
> >> seems odd to me - at least for consumers that already use a governor.
> >
> > Each governor instance always handles one "frequency" (more like
> > performance) domain at a time. So if a consumer is already using a
> > governor to scale the hardware block, then using another governor to
> > scale the interconnect performance points is the right way to go about
> > it. In fact, that's exactly what devfreq passive governor's
> > documentation even says it's meant for. That's also what cpufreq does
> > for each cluster/CPU frequency domain too.
> >
> >> So for DDR
> >> scaling for example, are you suggesting that we add a devfreq device from the
> >> cpufreq driver in order to scale the interconnect between CPU<->DDR?
> >
> > Yes in general. Although, CPUs are a special case because CPUs don't
> > go through devfreq. So passive governor as it stands today won't work.
> > CPU<->DDR scaling might need a separate governor (unlikely) or some
> > changes to the passive governor that I'm happy to work on once we
> > settle this for general devices like GPU, etc. But the DT format for
> > CPUs will be identical to GPUs or any other device.
>
> using icc_create_devfreq from the cpufreq-hw driver on SDM845 SoC
> to scale CPU<->DDR would cause a circular dependency. (i.e) with
> the addition of cpufreq notifier to the passive governor as in
> https://patchwork.kernel.org/patch/11046147/ devm_devfreq_add_device
> would require the cpufreq transistion notifier register and cpu
> freq_cpu_get to go through. Please add your thought on addressing this.

This is an old series. So not going to dive into this much.

But to answer your question, I wrote the cpufreq_map governor a long
time ago. So not surprised if you are finding issues with it -- it
needs a rewrite anyway.

-Saravana

> >
> >> Also if the
> >> GPU is already using devfreq, should we add a devfreq per each interconnect
> >> path? What would be the benefit in this case - using different governors for
> >> bandwidth scaling maybe?
> >
> > When saying "separate/different governors" in this email, I mean both
> > different instance of the same governor logic with different tunables
> > AND actually different algorithms/governor logic entirely.
> >
> > The heuristics to use for each interconnect path might be (more like,
> > will be) different based on hardware characteristics (Eg: what voltage
> > domains the interconnect is sitting on) and what interconnect
> > information is available (Eg: Just busy time vs bandwidth count vs no
> > information etc) -- so having separate governors for each interconnect
> > path makes a lot of sense. It also allows userspace to control the
> > policy for scaling each of those paths based on product use cases.
> >
> > For example, when the GPU is just doing simple UI rendering, userspace
> > can use the max_freq sysfs file for the devfreq device to disallow high
> > bandwidth OPPs on the GPU<->DDR path, but those higher OPPs could be
> > allowed by userspace when the GPU is used for games. Having devfreq
> > device for each interconnect path also make it easy to debug
> > performance issues -- you can independently change the votes for each
> > path to figure out what is causing the bottleneck, etc.
> >
> > Adding a devfreq device for interconnect voting with a few lines gives
> > all these features "for free".
> >
> > This doesn't mean all users of interconnect framework NEED to use
> > devfreq for interconnect. They might do it simply based on
> > calculations based on the use case (Eg: display driver from display
> > resolution). But if they are trying to use any kind of
> > algorithm/heuristics, writing it as a devfreq governor should be
> > encouraged.
> >
> > Also want to point out that BW OPPs also work for drivers that don't
> > use devfreq at all. The interconnect-opp-table just lists the
> > meaningful OPP leveld for the path and the device driver can pick one
> > entry from the table based on the use case.
> >
> > Thanks,
> > Saravana
> >
> >
> >
>
> --
> Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc, is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
