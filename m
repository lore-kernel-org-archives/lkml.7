Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48A8C433FF
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 07:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B10B42073D
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 07:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OlVaIPUj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbfHCHhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 03:37:18 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39053 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727490AbfHCHhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 03:37:18 -0400
Received: by mail-oi1-f194.google.com with SMTP id m202so58557359oig.6
        for <linux-kernel@vger.kernel.org>; Sat, 03 Aug 2019 00:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jl2PKbgaPXEPQzEE98RM60PJ/+V9ykW4sMy1QGCFlLk=;
        b=OlVaIPUj62eZx4uWCbHnHB1iSwPqh8Y2mLuoNLR6+S6GRrUWNP3bdlQkUy849eo+ab
         G838OZf97qjSbOeIJLYksqOEhxHdRrtOvBVMdV4RVOvD+soPy37AbGuQ0AwKm4E1mzCT
         npMug1f0DTXf3x8uf6g39mXGGRi2JdKs4bKtwnCvgsumGd6xmDVzR8wGW3E7WqIfD5B6
         zWgG4dzfheNPCrmjaXXma7VR47UwqJEOc0b1lgaCpMDhZjFDt/2c9YIZKasqINgeCNWy
         leZqGyk9FDRZNBfoZOClr6onHzuUL9INAe2Z8iM0nublxEnYDXBCdfKsu4Ft92TxlNOb
         d1/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jl2PKbgaPXEPQzEE98RM60PJ/+V9ykW4sMy1QGCFlLk=;
        b=scvayEDFFS45936/e0YSSgn7HLFTA5EfCyDHxkzesa//ocVpgDsP1Q5+Lh9za3lAEF
         dos2wouC2QQJIejUNW/gKkfnJCif4pPEQ6xM8aRXJreKBx3fISBTeoKJRB0k2RemG4f9
         KhjnJHOhbsmpYeccVgDpsuhbXPBEYacY04yXVKXhWnikShWen+X70odTuLPuDB2kn6K6
         X+4+yEUiDB2QLeycWNprUVnswhjMvOwbHh/SWmQBkjkTgCOD5atRy24GFdP8ooPd+m1v
         6ZzIA3zAuqkKLkP4qST/fMkHH7S4X0MrjllwJuQ6LxrPty9UU1lbIGkuYH8NA7yT4NrR
         dTTw==
X-Gm-Message-State: APjAAAVuJftG0fSw/h80zlg9iqkBx6mu+DOT3GNap1gQsJrroejlBgQd
        k+AZJhlI3H79x7DwoDyRyiwUFzQOpbmyak9FbflEhw==
X-Google-Smtp-Source: APXvYqywFrColoSzAWofIYKmzyGLJaj5Q12+4btLGnobJEhu8w0ZJt9DH6NLtyf5bDaagasCNCuKOUv/7818dqbHS/g=
X-Received: by 2002:aca:1803:: with SMTP id h3mr5055432oih.24.1564817836378;
 Sat, 03 Aug 2019 00:37:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190703011020.151615-1-saravanak@google.com> <20190717103220.f7cys267hq23fbsb@vireshk-i7>
 <CAGETcx-tbjVzRKW8D-564zgNOhrA_z-NC1q5U70bhoUDBhp6VA@mail.gmail.com>
 <20190718053746.64drmonk72vwnt4s@vireshk-i7> <CAGETcx_-=b3An9YdxLUnZap=0iaeczvWTEnw65FMLU8BwA3HfQ@mail.gmail.com>
 <20190729092454.6lfqzmhkvrhpimsp@vireshk-i7> <CAGETcx_7fK20VZ6Zn07Z+Ran1_O7gSPohck_tg-aEr5oONQ5iA@mail.gmail.com>
 <20190730030157.aml7z6vfsiqgyief@vireshk-i7>
In-Reply-To: <20190730030157.aml7z6vfsiqgyief@vireshk-i7>
From:   Saravana Kannan <saravanak@google.com>
Date:   Sat, 3 Aug 2019 00:36:40 -0700
Message-ID: <CAGETcx-Hp0CVH8SUyW=HtYPbvfqk-SetHecK8Gg4=n2rFGLOAw@mail.gmail.com>
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
        David Dai <daidavid1@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
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

Resending due to HTML.

On Mon, Jul 29, 2019 at 8:02 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 29-07-19, 13:12, Saravana Kannan wrote:
> > On Mon, Jul 29, 2019 at 2:24 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > On 18-07-19, 21:12, Saravana Kannan wrote:
> > > > On Wed, Jul 17, 2019 at 10:37 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > > > I would like
> > > > > to put this data in the GPU OPP table only. What about putting a
> > > > > range in the GPU OPP table for the Bandwidth if it can change so much
> > > > > for the same frequency.
> > > >
> > > > I don't think the range is going to work.
> > >
> > > Any specific reason for that ?
> >
> > The next sentence was literally explaining this :) Fine to debate
> > that, but ignoring that and asking this question is kinda funny.
>
> Okay, but ...
>
> > > > If a GPU is doing purely
> > > > computational work, it's not unreasonable for it to vote for the
> > > > lowest bandwidth for any GPU frequency.
>
> ... it wasn't clear to me even after reading this sentence again now
> :)
>
> I understand that you may have to vote for the lowest bandwidth but
> that doesn't explain why a range can't work (sorry if it was just me
> who doesn't understood it :)).

Well, doesn't work as in, it doesn't give any additional info. I can
just vote for 0 or UINT_MAX if I want to stay at the lowest or high
bandwidth. Having the actual values of the lowest or highest point
doesn't help for cases where you need to skip intermediate bandwidth
levels when going from low to high (as the need increases).

>
> > > I think that is fine, but if the GPU is able to find how much
> > > bandwidth it needs why can't it just pass that value without needing
> > > to have another OPP table for the path ?
> >
> > You were asking this question in the context of "can the GPU OPP just
> > list all the range of bandwidth it might use per GPU frequency". My point
> > is that the range would be useless because it would the entire
> > available bandwidth range (because purely compute work might not need
> > any bandwidth).
>
> If it is useless to have entire range here, then why bother providing
> one ? Why can't the GPU request what it needs in exact terms, based on
> its calculations ? And then based on these requests, let the
> interconnect find what's the best/stable values it really wants to
> program the path for (and for that the interconnect can use its own
> OPP table, which would be fine).

Let's say there actual path can support 1, 2, 3, 4, 5, 6, 7, 8, 9 and 10 GB/s.

Let's say 2, 3, and 4 need the same voltage level as 5 for this path.
So, for GPU's needs using 2, 3 and 4 GB/s might not be good because
the power savings from the frequency difference is not worth the
performance and power (if you run the interconnect slow, the GPU would
run faster to achieve the same performance) impact compared to running
the interconnect at 5 GB/s. Similarly it might skip 6 GB/s. So even if
the GPU can somehow calculate the exact bandwidth required (or say
measure it), it'll need to know to skip 2, 3 and 4 because they aren't
power/perf efficient levels to use.

But all these bandwidth levels might be useable for a smaller HW IP
whose power cost isn't high. So power savings running the interconnect
at 3 GB/s might be worth it -- because even if the small HW IP ran
faster to achieve the performance, the power increase in the HW IP
won't be higher than the power savings from running the interconnect
slower.

> > Whereas, what the GPU's algorithm actually needs might be the list of
> > "useful" bandwidth levels to use.
>
> Hmm, I am not sure GPU's algorithm needs this table AFAIU based on all
> the conversations we had until now. It is very capable of finding how
> much bandwidth it needs,

Not really. If you have a monitor that can actually measure the
bandwidth, yes. Most often that's not the case. If you just have a
monitor that can give you the bus port busy% then it'll have to use
this table to pick the useful ones. As in, in the example above, if
the bus is still too busy at 1 GB/s it would directly ask for 5 GB/s
instead of going through 2, 3 and 4.

> you just want the GPU driver to finally align
> that with a stable bandwidth for the platform later on. And what I am
> asking is that it is not required for the end driver to look for
> stable values, it just requests what it wants and let the interconnect
> core/driver decide the stable values.

I think you've misunderstood my prior statements then.

The interconnect driver would then still have to aggregate the
requests and pick the final frequency for the interconnect. That's
where it comes in -- executing/implementing the requests of all the
clients.

> Very much like the clock framework, most of the user drivers just ask
> for a clk value to be programmed and it is the clock driver which
> keeps a table of the stable values and then aligns the requested value
> to one of those.

This of this similar to the clock API and the OPP tables for CPUs. The
clock API could run the CPU at multiple different frequencies. But the
CPU driver uses the CPU OPP table to pick a certain set of frequencies
that are "useful". If your CPU clock is shared with another block, say
L3 and there's an L3 driver that's requesting a different frequency
range (using clk_set_rate_range(x, UINT_MAX)), that's where the clock
driver aggregates their request and set's the final clock frequency.

Similarly, the GPU driver wants to pick useful interconnect path
bandwidth levels using BW OPP tables. And the interconnect framework
aggregates the requests across multiple drivers requesting different
bandwidths.

Does that make sense?

-Saravana
