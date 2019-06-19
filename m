Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9259C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 14:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFA042182B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 14:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GafIfaxS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731011AbfFSOUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 10:20:35 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39654 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730965AbfFSOUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 10:20:33 -0400
Received: by mail-pg1-f196.google.com with SMTP id 196so299110pgc.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 07:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y+NIKAFg+ExQLLbmXMnmJpgisbEnHgQ1vwgmPjZ4vak=;
        b=GafIfaxSxAdNcyKV/J2U7dFs/w0q/0HYZSgHEkjmdj6P31dIHZbgTXCE8vMbqpdzeg
         +Tj+Uwu5Wzkn3uc0nQ80Xr0Y5PN3yT4pc6jdkI5o7yML6ZcP6Q5YwQdkDRsD9Xc5cJwo
         JtgG2EP3dIYrQomtulBsMq2x/vRtF/0eb10KH0NuzwFSgLX6QFW8juz6f19M4LP0TazE
         AZWcFEZ0VdQaKq0IFvFykP4KANbr9mgW45KNr39kw9zE63JDfemJP3D/XTxLuiWSUmR4
         lI5nD5wuBg2K7unLwsmcFvVPrn3H+UayYGQvBbUlyTdJbYpbvHifxX9GpEhu/r1ds0oL
         GS/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y+NIKAFg+ExQLLbmXMnmJpgisbEnHgQ1vwgmPjZ4vak=;
        b=h2It4nuyr8YFEpobzaBJ/GeGb92ALjvmIvbG/4Xwdjhk2mFXSddnyAxsXoCpuFjl9L
         fezSH3VYPe0Od44ZcWOYAaR3c5yfCqacRGgWSX2hkHlcBY7wNUqbULm7lXMpsTn81HOM
         WfRjJZHaPMC0MTbQenR1opgNDPO7OA19sO7/M4HVCdIgfSsVybP/pESufaU4+tRxc54A
         Z0a4dpQfg4KFelTGnvWAd+rldXmRni0pEgYKOXbKO0slROMWY0gjpUGDur0MnGlrx3Wq
         mnqvCKOzqUxo2COl93cgu8cH0O9DKzqz3EWpv5+IIICljysrEIRv+vZ56BkwZ3fXdWa8
         kgyg==
X-Gm-Message-State: APjAAAWXoDkt29iuTqBtd3ThRwi+bl/It/qCCT5iL9ti9luP/WqjH125
        CuehaR7Fy+qTY9i/iPzo2D5bag==
X-Google-Smtp-Source: APXvYqyl8y+JzCbOosMZu0KXmqrF99YcF+Fc1Ogm7iBeymy2ykS/snJftN5OXCl+uVgfFRfxkeFlEw==
X-Received: by 2002:a17:90a:25e6:: with SMTP id k93mr11697397pje.100.1560954032124;
        Wed, 19 Jun 2019 07:20:32 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id d6sm17072039pgv.4.2019.06.19.07.20.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 07:20:31 -0700 (PDT)
Date:   Wed, 19 Jun 2019 19:50:29 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/6] cpufreq: Use has_target() instead of !setpolicy
Message-ID: <20190619142029.4nxlgywlayx4fzpa@vireshk-i7>
References: <cover.1560944014.git.viresh.kumar@linaro.org>
 <8c563c8f3515ceefd88875160302b6fd472c3dac.1560944014.git.viresh.kumar@linaro.org>
 <CAJZ5v0gmkAS-A2eT5VUyuBMD9+FfsM0HL-HPeUYUV24_oMTvVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gmkAS-A2eT5VUyuBMD9+FfsM0HL-HPeUYUV24_oMTvVw@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-06-19, 14:28, Rafael J. Wysocki wrote:
> On Wed, Jun 19, 2019 at 1:36 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > For code consistency, use has_target() instead of !setpolicy everywhere,
> > as it is already done at several places.
> 
> That's OK
> 
> > Maybe we should also use !has_target() for setpolicy case to use only one expression
> > for this differentiation.
> 
> But I'm not sure what you mean here?

At many places in code we are doing tests like:

if (cpufreq_driver->setpolicy) {
        xxx
}

Maybe we can write them as well like:

if (!has_target()) {
        xxx
}

-- 
viresh
