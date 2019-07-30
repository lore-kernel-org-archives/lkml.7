Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80136C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 539932171F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jc/YC9le"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732744AbfG3DCE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 23:02:04 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39160 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732723AbfG3DCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 23:02:01 -0400
Received: by mail-pf1-f193.google.com with SMTP id f17so25038044pfn.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 20:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+E8omEH906TCMOUVaEXWKpNgn+JOLXcUorYQ/vWPPf0=;
        b=Jc/YC9lel3yNzxidJjL/B8/vFfeBsxFRicp39Oey3HLLBmzOKFl/TkdXqJsgaO1ojq
         U2JDseu5QkwHIr9DHg0Zy0zyY6F38DCkSBbHVg66ejwCQhUvk8ZNDHIfTgLKiL4wcxnX
         kp3K5zAmDoNjx9JdClWVxBf6JClsj1i/bpDJvJd/D2JYl0wPfjFznJl6Dx/c/a+kWsZy
         0JCiBkHDo1hgK5btmADMHNmvEiuAHyWZnndkFa5ojybqyyPu7YS0X5qky1c/fzbAFGkL
         k34hKPYhDnIFWjNHjar8YM+WjTadzFWy1D8/2FLDNSc7iZtKUFacgaiGgqk2bpFYZNGh
         XuVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+E8omEH906TCMOUVaEXWKpNgn+JOLXcUorYQ/vWPPf0=;
        b=HjgnrWxS/kZOc4JGWCqwXqFRxNlrGBGZgHorbQgXuShdO/2YBALJAZzz9YgrKRhwOp
         dBHip4iX5Tn7Pd9bUmikXxYHbzWV7+/aQrWHL6tG3QM+dz9wn/zc9xO/n+2KbzJG1po/
         TDLyS9DDATYChr3i4ZVBFVcn72LxLAaWqJNNN5zx7ouGVFAWk3j+R48I8mlVAd9ki2sH
         36A6aMdL5mZrZHqY1MGInn3O7znOnXHwkL2J8xgzTcWy1KV5BAlBNHPYCMk0lwM3bKPj
         J5qJ1ItHqnC4UHWLDzuMpzdo6Sxx4azy3nMLGPYnDcRNGo9ehXu6c4c5cnz/a0w0+bzV
         nyCQ==
X-Gm-Message-State: APjAAAXLTaXMuIG54n8Ie4Lkws1DoR6GZVBP/zbdXeVvS6kHwVDBGaoA
        lbt6lygCvK+GlAbg0+LaY5+OBQ==
X-Google-Smtp-Source: APXvYqzE6E6bwEiPVPhC8MPvNKfvs+L5X43/lx99CsVqkOn2lJdGMjp42IO+nI7wkwvsesO+oQP+bA==
X-Received: by 2002:a63:101b:: with SMTP id f27mr103042864pgl.291.1564455720224;
        Mon, 29 Jul 2019 20:02:00 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id i126sm75052149pfb.32.2019.07.29.20.01.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 20:01:59 -0700 (PDT)
Date:   Tue, 30 Jul 2019 08:31:57 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Saravana Kannan <saravanak@google.com>
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
Subject: Re: [PATCH v3 0/6] Introduce Bandwidth OPPs for interconnect paths
Message-ID: <20190730030157.aml7z6vfsiqgyief@vireshk-i7>
References: <20190703011020.151615-1-saravanak@google.com>
 <20190717103220.f7cys267hq23fbsb@vireshk-i7>
 <CAGETcx-tbjVzRKW8D-564zgNOhrA_z-NC1q5U70bhoUDBhp6VA@mail.gmail.com>
 <20190718053746.64drmonk72vwnt4s@vireshk-i7>
 <CAGETcx_-=b3An9YdxLUnZap=0iaeczvWTEnw65FMLU8BwA3HfQ@mail.gmail.com>
 <20190729092454.6lfqzmhkvrhpimsp@vireshk-i7>
 <CAGETcx_7fK20VZ6Zn07Z+Ran1_O7gSPohck_tg-aEr5oONQ5iA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx_7fK20VZ6Zn07Z+Ran1_O7gSPohck_tg-aEr5oONQ5iA@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-07-19, 13:12, Saravana Kannan wrote:
> On Mon, Jul 29, 2019 at 2:24 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 18-07-19, 21:12, Saravana Kannan wrote:
> > > On Wed, Jul 17, 2019 at 10:37 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > > I would like
> > > > to put this data in the GPU OPP table only. What about putting a
> > > > range in the GPU OPP table for the Bandwidth if it can change so much
> > > > for the same frequency.
> > >
> > > I don't think the range is going to work.
> >
> > Any specific reason for that ?
> 
> The next sentence was literally explaining this :) Fine to debate
> that, but ignoring that and asking this question is kinda funny.

Okay, but ...
 
> > > If a GPU is doing purely
> > > computational work, it's not unreasonable for it to vote for the
> > > lowest bandwidth for any GPU frequency.

... it wasn't clear to me even after reading this sentence again now
:)

I understand that you may have to vote for the lowest bandwidth but
that doesn't explain why a range can't work (sorry if it was just me
who doesn't understood it :)).

> > I think that is fine, but if the GPU is able to find how much
> > bandwidth it needs why can't it just pass that value without needing
> > to have another OPP table for the path ?
> 
> You were asking this question in the context of "can the GPU OPP just
> list all the range of bandwidth it might use per GPU frequency". My point
> is that the range would be useless because it would the entire
> available bandwidth range (because purely compute work might not need
> any bandwidth).

If it is useless to have entire range here, then why bother providing
one ? Why can't the GPU request what it needs in exact terms, based on
its calculations ? And then based on these requests, let the
interconnect find what's the best/stable values it really wants to
program the path for (and for that the interconnect can use its own
OPP table, which would be fine).

> Whereas, what the GPU's algorithm actually needs might be the list of
> "useful" bandwidth levels to use.

Hmm, I am not sure GPU's algorithm needs this table AFAIU based on all
the conversations we had until now. It is very capable of finding how
much bandwidth it needs, you just want the GPU driver to finally align
that with a stable bandwidth for the platform later on. And what I am
asking is that it is not required for the end driver to look for
stable values, it just requests what it wants and let the interconnect
core/driver decide the stable values.

Very much like the clock framework, most of the user drivers just ask
for a clk value to be programmed and it is the clock driver which
keeps a table of the stable values and then aligns the requested value
to one of those.

> Also, as we add more ICC request properties, this range idea will not scale.

I am not sure about what kind of properties there can be and where
should they land. My feedback is completely based on what you have
presented in this patchset.

-- 
viresh
