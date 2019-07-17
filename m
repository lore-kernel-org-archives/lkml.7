Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D3EC76195
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 20:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78E8A21851
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 20:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="moNgVqVQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbfGQUf1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 16:35:27 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41370 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbfGQUf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 16:35:26 -0400
Received: by mail-ot1-f65.google.com with SMTP id o101so26506083ota.8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 13:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FXMPE8BPcH8HZFC59zfa+SPhPyvIIvJuCBoRrteYkho=;
        b=moNgVqVQhCBuJdG5uOFEyRfVcJzkfTBNTs1Z3BXgLCU/zNi1D4oLYm2x2ZWNlhu00o
         LT6iBaph3MXCWS/sJoRYUvIu8UNhz9wxYLRNawV9XKeiTlkcM6V4EJgr/o0s/l7F9H9n
         eaCRXJ8QSkb6IS+3uCDJJTElg4bu/QRKrv6kl7cRPXszOjrPpMBITdPZYbXHEjohwL+D
         5/kfaWdk788Em87avYwEI0HznRAtBgp6KwKJ6+O5YVGIUkjhdDxnZTLwziPCixlz6PTU
         1KCuifdDUYJNf8a0zKSnLcOplBhmSUW0TobyxmWOkuvaybNzsLmYg0kGob2RUtlutN3j
         qGdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FXMPE8BPcH8HZFC59zfa+SPhPyvIIvJuCBoRrteYkho=;
        b=s7dU1E8++E0xIfW26ukL7l0/A9RBZAQsxIVFDs98wgbgp3QNp5TppRKFNFVMposquy
         uUo01Bg9s1GVpoVvsqBYe+dTnaVgzwQJic4NM30eQUVn3GYjAyjSGVyKF80gdEmLbSXR
         d8ial5LtBeyqxVLNrc/FfgFp3oBqoHq7DWoNl4WQ9pneysj7kn8zZk1VvZkJwbIH3nl0
         l8tBJZpQDgT0H4+adxWVnlJNqFRsOj6F8zBHf9/PpmirHU0NmaM3xErCc0ejTAlbzwtB
         vzTPXogOInC2Dq6wYXT/E7CrB0HPYjynp2bKOFo+6eBicOF4bm420gRStJFezPlzvMIt
         NVZw==
X-Gm-Message-State: APjAAAXm8WvFy6aj74E/cfDaTi5rpYlma82ZmnS6G+PH3Y5YMY1nCCGN
        mrjzsJV/w7PH+iiW++YmXkjiw9JF1az34xLi4gDxYg==
X-Google-Smtp-Source: APXvYqwiUDUXNi3NqRWqHDw5Y5A6ix3QwgYxmpU6YxwqpVdAsmXY+1UW4eisFVhv1mqNUfAErWIwIX2XUNG2O5mIWr8=
X-Received: by 2002:a05:6830:160c:: with SMTP id g12mr32951615otr.231.1563395725759;
 Wed, 17 Jul 2019 13:35:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190703011020.151615-1-saravanak@google.com> <20190717103220.f7cys267hq23fbsb@vireshk-i7>
In-Reply-To: <20190717103220.f7cys267hq23fbsb@vireshk-i7>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 17 Jul 2019 13:34:49 -0700
Message-ID: <CAGETcx-tbjVzRKW8D-564zgNOhrA_z-NC1q5U70bhoUDBhp6VA@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Introduce Bandwidth OPPs for interconnect paths
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Sweeney, Sean" <seansw@qti.qualcomm.com>,
        daidavid1@codeaurora.org, Rajendra Nayak <rnayak@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
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

On Wed, Jul 17, 2019 at 3:32 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 02-07-19, 18:10, Saravana Kannan wrote:
> > Interconnects and interconnect paths quantify their performance levels in
> > terms of bandwidth and not in terms of frequency. So similar to how we have
> > frequency based OPP tables in DT and in the OPP framework, we need
> > bandwidth OPP table support in the OPP framework and in DT. Since there can
> > be more than one interconnect path used by a device, we also need a way to
> > assign a bandwidth OPP table to an interconnect path.
> >
> > This patch series:
> > - Adds opp-peak-KBps and opp-avg-KBps properties to OPP DT bindings
> > - Adds interconnect-opp-table property to interconnect DT bindings
> > - Adds OPP helper functions for bandwidth OPP tables
> > - Adds icc_get_opp_table() to get the OPP table for an interconnect path
> >
> > So with the DT bindings added in this patch series, the DT for a GPU
> > that does bandwidth voting from GPU to Cache and GPU to DDR would look
> > something like this:
> >
> > gpu_cache_opp_table: gpu_cache_opp_table {
> >       compatible = "operating-points-v2";
> >
> >       gpu_cache_3000: opp-3000 {
> >               opp-peak-KBps = <3000>;
> >               opp-avg-KBps = <1000>;
> >       };
> >       gpu_cache_6000: opp-6000 {
> >               opp-peak-KBps = <6000>;
> >               opp-avg-KBps = <2000>;
> >       };
> >       gpu_cache_9000: opp-9000 {
> >               opp-peak-KBps = <9000>;
> >               opp-avg-KBps = <9000>;
> >       };
> > };
> >
> > gpu_ddr_opp_table: gpu_ddr_opp_table {
> >       compatible = "operating-points-v2";
> >
> >       gpu_ddr_1525: opp-1525 {
> >               opp-peak-KBps = <1525>;
> >               opp-avg-KBps = <452>;
> >       };
> >       gpu_ddr_3051: opp-3051 {
> >               opp-peak-KBps = <3051>;
> >               opp-avg-KBps = <915>;
> >       };
> >       gpu_ddr_7500: opp-7500 {
> >               opp-peak-KBps = <7500>;
> >               opp-avg-KBps = <3000>;
> >       };
> > };
>
> Who is going to use the above tables and how ?

In this example the GPU driver would use these. It'll go through these
and then decide what peak and average bw to pick based on whatever
criteria.

> These are the maximum
> BW available over these paths, right ?

I wouldn't call them "maximum" because there can't be multiple
maximums :) But yes, these are the meaningful bandwidth from the GPU's
perspective to use over these paths.

>
> > gpu_opp_table: gpu_opp_table {
> >       compatible = "operating-points-v2";
> >       opp-shared;
> >
> >       opp-200000000 {
> >               opp-hz = /bits/ 64 <200000000>;
> >       };
> >       opp-400000000 {
> >               opp-hz = /bits/ 64 <400000000>;
> >       };
> > };
>
> Shouldn't this link back to the above tables via required-opp, etc ?
> How will we know how much BW is required by the GPU device for all the
> paths ?

If that's what the GPU driver wants to do, then yes. But the GPU
driver could also choose to scale the bandwidth for these paths based
on multiple other signals. Eg: bus port busy percentage, measure
bandwidth, etc.

Or they might even decide to pick the BW OPP that matches the index of
their GPU OPP. It's up to them how they actually do the heuristic.

-Saravana
