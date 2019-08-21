Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19819C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 05:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E252A22CF7
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 05:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FUz7pN44"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbfHUFYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 01:24:21 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43992 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727793AbfHUFYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 01:24:20 -0400
Received: by mail-pf1-f194.google.com with SMTP id v12so626722pfn.10
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 22:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WVZuNtomVVNJU6oxBSPSh7G1rqbdcZx30YER/VTqJy0=;
        b=FUz7pN44X6Tv4OeVuIV52guGzHMnmYin+wu9ELjFCcSR+0aws/OWfCadkkuqfVdCLK
         mNGaUIjPJikw+d22fQPAE5PlaRRwxBqtQCNgdjrOUKqL9EfbQ1ymZLXKWp+ZFONNvI14
         x1VgB8USTvIJaFXzt8Hz4wYclyoDS/928mCrxNzBO+0HQlj3T5Hx0qoSQhket12hKZeI
         s16MRBgF1ca01Adh+FAA3GF9KpeEZmlXGoI/XQeC3HdXX9Cdp8CyR87ufMKOltSiMDZG
         ua5tdZPmMtv/brEPvUX9c837I/Tc59DwbMtYUcNjcOe17AS1TP/D/TqIjIOX+aT8YGgb
         AepQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WVZuNtomVVNJU6oxBSPSh7G1rqbdcZx30YER/VTqJy0=;
        b=exJKkhHdrLKj7+EDeb2RY7SyTUXALcStD8HSa43QQePNDoMuu4vhTSTTd6wW7U8n9D
         jQZuURqmj8wf8ZuCZlFiNRt92VLdLUxwcgbBJoqsy2vg6twzIER4YbKbGK7Y3GeMnm9Z
         gTCKrHreD4ZLdHZdFE2Fu3fxyVf1bI2UvBxnR8/+kKTqiWdMx0HiDGDTMkdfLXciWHlz
         SqeAKBTjtuNzN/fWLuq2bKCtvGAlUQr+Q9eFjqyGeqD3bnXeg0PZy+FhgMMFj8oZj3Gr
         E/vj1de4taaJEDTM+FoCxGTKxrecxwQJH5PM7RE+8BBVtwDhOc2nYqiZyL/x4veLJf2b
         Znbg==
X-Gm-Message-State: APjAAAV6BJHoccj+uizdaGlEKuYKNYKgrljNAxyZmpfaGOnttssHcbmu
        fEVNNfsos6rVhMFxupyOihC0bw==
X-Google-Smtp-Source: APXvYqz5Xtr2EJgM6D6fSLIQb46x2LJP6fotbNZ4KkYGPV/au8MPrF7OtOBzkPcoKZLYmwj4ZF66QA==
X-Received: by 2002:a17:90a:2325:: with SMTP id f34mr3758425pje.128.1566365059850;
        Tue, 20 Aug 2019 22:24:19 -0700 (PDT)
Received: from localhost ([122.172.76.219])
        by smtp.gmail.com with ESMTPSA id e7sm22939634pfn.72.2019.08.20.22.24.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2019 22:24:19 -0700 (PDT)
Date:   Wed, 21 Aug 2019 10:54:17 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Sweeney, Sean" <seansw@qti.qualcomm.com>,
        David Dai <daidavid1@codeaurora.org>, adharmap@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 2/3] OPP: Add support for bandwidth OPP tables
Message-ID: <20190821052417.gby4borlnxv2xacr@vireshk-i7>
References: <20190807223111.230846-1-saravanak@google.com>
 <20190807223111.230846-3-saravanak@google.com>
 <20190820061300.wa2dirylb7fztsem@vireshk-i7>
 <CAGETcx9BV9qj17LY30vgAaLtz+3rXt_CPpu4wB_AQCC5M7qOdA@mail.gmail.com>
 <CAGETcx-xQika2MgTgA3Gft3u2_uXgvoYThXwEpW_G03QTEh-yQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx-xQika2MgTgA3Gft3u2_uXgvoYThXwEpW_G03QTEh-yQ@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-08-19, 15:36, Saravana Kannan wrote:
> On Tue, Aug 20, 2019 at 3:27 PM Saravana Kannan <saravanak@google.com> wrote:
> >
> > On Mon, Aug 19, 2019 at 11:13 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > On 07-08-19, 15:31, Saravana Kannan wrote:
> 
> > > > +     ret = of_property_read_u32(np, "opp-peak-kBps", &bw);
> > > > +     if (ret)
> > > > +             return ret;
> > > > +     new_opp->rate = (unsigned long) bw;
> > > > +
> > > > +     ret = of_property_read_u32(np, "opp-avg-kBps", &bw);
> > > > +     if (!ret)
> > > > +             new_opp->avg_bw = (unsigned long) bw;
> > >
> > > If none of opp-hz/level/peak-kBps are available, print error message here
> > > itself..
> >
> > But you don't print any error for opp-level today. Seems like it's optional?
> >
> > >
> > > > +
> > > > +     return 0;
> > >
> > > You are returning 0 on failure as well here.
> >
> > Thanks.
> 
> Wait, no. This is not actually a failure. opp-avg-kBps is optional. So
> returning 0 is the right thing to do. If the mandatory properties
> aren't present an error is returned before you get to th end.

You are right :)

-- 
viresh
