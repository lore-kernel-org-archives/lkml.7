Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE58DC76191
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A3DC22C7D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DLPjA6eb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390519AbfGYFRr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 01:17:47 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42793 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390368AbfGYFRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 01:17:47 -0400
Received: by mail-pg1-f196.google.com with SMTP id t132so22371714pgb.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 22:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/u83+hQ1QJSZQhZrXmEUjb2K6ijc3Xy3tbFtshDxhfA=;
        b=DLPjA6ebSqQMnWFq4JJNbgskYTCbvMXOTpeb8SzA8dD4lhEAgVdGspxIw+UuL7XB8h
         Gv4P7+W73rim2Ym3ir6uigy++MwBE7jbkrV+NBR0y87WvSD8U9kKhEZCh7kngp+1mzoj
         GZXUawj94hGsKbTlIbluVoxHyEigED8f5YqicUEqymMAO/V2uMTGGTDrLusi4YjnEb85
         8iGdPO6D9jhR9M5yCZ1AK5Lnw2YT6ti5IUvLqL7JwX7xlv/HWIEFJpuOqk1LNDlXq9w7
         BqJMbrNM5/+c+kNO7xfx9wIkPkoybKFjTYoCW7g2pIbEbA8JALpEZjFLLk486+T0gBb/
         wrYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/u83+hQ1QJSZQhZrXmEUjb2K6ijc3Xy3tbFtshDxhfA=;
        b=sWxrrgeFg3XROm2mnp74Rmq80FTnb7fxZzvthC60WVNGR8jjLvvkURp8deJxmdVVZ+
         Xe0ShbY8h00rsZQzXOtv2OWt0emaZb+5cUg8tvuD/BeCs6XETcG+gdL3W0jUuXluHf+M
         Qd+9zKt3u7Brq6cjk7fXggkCLQIzh4WlkV6khwNzExjUaJ8i5VWRrpJcmMhvuJOSpLlq
         bd3+RJf0N2OMyQZHxDiF+RfTvjGInTOsXxPNrEGu48uWOAxlCfS9fCQbT6WV7oEK04VF
         EF9cMSeF0oaUdoZIznIHEJRpD9ZkpgDDVMzTixIQ9nBI+mhhOrq0iZD74PUdkP2h0MP9
         0TFA==
X-Gm-Message-State: APjAAAVBsh1w5zek8GEnpOo7nfNJYWMS0GGfwrh6BjPTwkviOWwrX3Da
        mDK1K8FnSy8Oefy7CZylEOyJkg==
X-Google-Smtp-Source: APXvYqwRgHw22t1Ez3v6HGsA4DNuKmxxcEJSqzfywoFPkhctAPIvI9uRybfdTAWZi5/HEcfLafSq2g==
X-Received: by 2002:aa7:8b55:: with SMTP id i21mr14861350pfd.155.1564031866108;
        Wed, 24 Jul 2019 22:17:46 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id b37sm77297543pjc.15.2019.07.24.22.17.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 22:17:44 -0700 (PDT)
Date:   Thu, 25 Jul 2019 10:47:42 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sibi Sankar <sibis@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/5] OPP: Improve require-opps linking
Message-ID: <20190725051742.mn54pi722txkpddg@vireshk-i7>
References: <20190717222340.137578-1-saravanak@google.com>
 <20190717222340.137578-4-saravanak@google.com>
 <20190723102842.t2s45zzylsjuccm4@vireshk-i7>
 <CAGETcx-6M9Ts8tfMf6aA8GjMyzK5sOLr069ZCxTG7RHMFPLzHw@mail.gmail.com>
 <20190725030712.lx3cjogo5r7kc262@vireshk-i7>
 <CAGETcx8QTs2Dqqppb_gwiUa2fte92K_q+B+j_CreRgqU52L7EA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx8QTs2Dqqppb_gwiUa2fte92K_q+B+j_CreRgqU52L7EA@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-07-19, 21:09, Saravana Kannan wrote:
> On Wed, Jul 24, 2019 at 8:07 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > We should be doing this whenever a new OPP table is created, and see
> > if someone else was waiting for this OPP table to come alive.
> 
> Searching the global OPP table list seems a ton more wasteful than
> doing the lazy linking. I'd rather not do this.

We can see how best to optimize that, but it will be done only once
while a new OPP table is created and putting stress there is the right
thing to do IMO. And doing anything like that in a place like
opp-set-rate is the worst one. It will be a bad choice by design if
you ask me and so I am very much against that.

> > Also we
> > must make sure that we do this linking only if the new OPP table has
> > its own required-opps links fixed, otherwise delay further.
> 
> This can be done. Although even without doing that, this patch is
> making things better by not failing silently like it does today? Can I
> do this later as a separate patch set series?

I would like this to get fixed now in a proper way, there is no hurry
for a quick fix currently. No band-aids please.

> > Even then I don't want to add these checks to those places. For the
> > opp-set-rate routine, add another flag to the OPP table which
> > indicates if we are ready to do dvfs or not and mark it true only
> > after the required-opps are all set.
> 
> Honestly, this seems like extra memory and micro optimization without
> any data to back it.

Again, opp-set-rate isn't supposed to do something like this. It
shouldn't handle initializations of things, that is broken design.

> Show me data that checking all these table
> pointers is noticeably slower than what I'm doing. What's the max
> "required tables count" you've seen in upstream so far?

Running anything extra (specially some initialization stuff) in
opp-set-rate is wrong as per me and as a Maintainer of the OPP core it
is my responsibility to not allow such things to happen.

> I'd even argue that doing it the way I do might actually reduce the
> cache misses/warm the cache because those pointers are going to be
> searched/used right after anyway.

So you want to make the cache hot with data, by running some code at a
place where it is not required to be run really, and the fact that
most of the data cached may not get used anyway ? And that is an
improvement somehow ?

-- 
viresh
