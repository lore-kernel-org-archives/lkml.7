Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2AA6C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 02:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0B112184E
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 02:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AckAnRHG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbfHSC0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 22:26:44 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36944 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfHSC0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 22:26:44 -0400
Received: by mail-pg1-f193.google.com with SMTP id d1so246471pgp.4
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2019 19:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D27NEAPjmVHRvIAbVgVA3ytPoAPu40jjQqNHrVZHT48=;
        b=AckAnRHGnL7XPKz8rixraSIpon7+sYMNLcrCyi2mP8ep27X6iBjFlqkFteTxNrvx2R
         L1g+1jS0UaztK5DrINseql9Pvqigl6zzV1shhl7xPHt46y+GkHYwhYCFUdtjBBDXOzJP
         uWyperagHVSi2zRXotnqK0yBJs58FVG+MJ6jbcrSvS34xFvjlSNvM+MtR8zumEuPBVxu
         pasKEt9mauuWa1fs6PrvGIDqAgL6baAGpUbMk8PQ4N2RMCbBdZTrZFl2Fpeu2xDP3A6O
         wcbkgTlNPRhcwezb5WAD7iRIHMnJ5D3wsk93KLfamegdmELQJp4Z9CuU7d5l7KRuHmfp
         l8KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D27NEAPjmVHRvIAbVgVA3ytPoAPu40jjQqNHrVZHT48=;
        b=W4Jwa+mjpXlxURzYpYGTzXiKB7US+DAifXenJ9E0wR5ME2vXkvXSWlBP/Oj5yUakmf
         g8jqk5p/t6ZDXqJ0j4JBhz7FzQoJVLHHoJW2b/H5s7V5KEs/QqSYEpIBHlIp1SV3Ds0N
         hBf6MhIyg56lGJnMWnr8LRpQ/ELToV2jYgpAc7BALgsJI76GPw/I3JocCvwVTgbvZ9lp
         1RaR6S5bfBtuQEyAmheYQs3a3IAy9YVTMRRtDahByjB3T/OWwtJieCIPvc9JNmQuKC7p
         +MybBzMRXVohAYY58iRGWV2o7PA/w4Rw6Cak+TZcP0A9+naAbR8E93Z4jBWXh7vL02+X
         UmaQ==
X-Gm-Message-State: APjAAAXc0BCJDF7rZLNzg0ljPsKSQH9JWnP4VBD4+FpBqfAoSFwvCbwC
        sulFOCEgEkvGHIKqt6fgv2eO3g==
X-Google-Smtp-Source: APXvYqzFkamjOjLS7iubUYiLHgSZJ2tU+Ta59qmQd8iUSUBlL4HURQlT702anrPYAArTzDSw43dvTw==
X-Received: by 2002:a17:90a:374a:: with SMTP id u68mr18446548pjb.4.1566181603617;
        Sun, 18 Aug 2019 19:26:43 -0700 (PDT)
Received: from localhost ([122.172.76.219])
        by smtp.gmail.com with ESMTPSA id a3sm14170158pfc.70.2019.08.18.19.26.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Aug 2019 19:26:42 -0700 (PDT)
Date:   Mon, 19 Aug 2019 07:56:14 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 04/10] cpufreq: powerpc_cbe: Switch to QoS requests
 instead of cpufreq notifier
Message-ID: <20190819022614.oy5qdozde2afibwu@vireshk-i7>
References: <cover.1563862014.git.viresh.kumar@linaro.org>
 <524de8ace0596e68a24b57b3b4043c707db32ca7.1563862014.git.viresh.kumar@linaro.org>
 <20190809023445.xn3mlv5qxjgz6bpp@vireshk-i7>
 <CAJZ5v0gQ2RCZGo03=7DoUAxw86wSEaXdnJ2KtknU3uUtXCqmvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gQ2RCZGo03=7DoUAxw86wSEaXdnJ2KtknU3uUtXCqmvQ@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-08-19, 11:01, Rafael J. Wysocki wrote:
> On Fri, Aug 9, 2019 at 4:34 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 23-07-19, 11:44, Viresh Kumar wrote:
> > > The cpufreq core now takes the min/max frequency constraints via QoS
> > > requests and the CPUFREQ_ADJUST notifier shall get removed later on.
> > >
> > > Switch over to using the QoS request for maximum frequency constraint
> > > for ppc_cbe_cpufreq driver.
> > >
> > > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > ---
> > >  drivers/cpufreq/ppc_cbe_cpufreq.c     | 19 +++++-
> > >  drivers/cpufreq/ppc_cbe_cpufreq.h     |  8 +++
> > >  drivers/cpufreq/ppc_cbe_cpufreq_pmi.c | 96 +++++++++++++++++----------
> > >  3 files changed, 86 insertions(+), 37 deletions(-)
> >
> > -------------------------8<-------------------------
> 
> If you do it this way, Patchwork will not pick up the patch.
> 
> Please send afresh with "[Update]" or bumped up version number in the
> subject (or both).

Okay, will take care of this in future. Was away on holidays and so
the late reply. Thanks.

-- 
viresh
