Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB5DC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA8A72075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TzHQPlIT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbfDDIWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:22:06 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38969 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbfDDIWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:22:05 -0400
Received: by mail-pl1-f196.google.com with SMTP id b65so785518plb.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 01:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=12hS8ZME4eY09I7P2b5Cz7kHzlqMseQJaYDWtbbZJ1M=;
        b=TzHQPlITAz/+I7HevKBz7wYkeIyyMCWsajTGK1IbPPDylknveFxv6/eW1g9qcaPeB5
         ruYawHxIrf4oMsJcsrM4cL8U/EGfwAnxDzJyEKd66005H5UANB4JLJPsecVXBaqadKY6
         VSjdJghh84+w6Wxulj/fnY8LQgvCJ1E0ixcs/uxOBQzl1APk8xuy6N7laPSb1XEIa8YV
         vm27R7HICPSpso1Kwnl+X97DeTVogyt8sBM93DMILswb88AOfL/0FSpsup4i3rBBLqEp
         Wri3BWbR0psqKn7l3WRGoD2WryJ7LC1kzcXGbVcLn/TmiaO9i3M9Jpog1j3BRolZpB/0
         klXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=12hS8ZME4eY09I7P2b5Cz7kHzlqMseQJaYDWtbbZJ1M=;
        b=gNOjiFuJ5tYQ+7tLkSNwAu/onn6+icvitmbJE/q2pixJrZ7cbvOow5ZAw1eMprcmh2
         z5Ktre4VWEHsWWKMYCnApEdNIaMc2grshetk484XYb/HZwKaXsVV+jux5ld25JeJj/yE
         uEp7aNuc2xqt+BFuLwgf4MMi5KEoV0HDpRGxFZKN77dbqHBoWvXKlYbWmlKJ8bINQcsZ
         r6Jns3EEno6MlIckMCSeWLEdWz5FJiNlnHBzYNSH9zOxesffjUPKBey1vTVg8fpczBly
         9G98YCcxSJz0Q2uCYx3FdlljJRyxY58SGbAuRdADYZWWFrorurhDjMKzIyOQdA2hVSVu
         tVXA==
X-Gm-Message-State: APjAAAU+ck7KXvU5W0xtOYSws4JSzwV9TLuDxqORHueHq3NFj+gs9+R8
        OyBLIiahsaRfQ8mIaROJmS7+5A==
X-Google-Smtp-Source: APXvYqxwGVk1RYdrXXKNJVzzm8nPDfdTw2mo2TcvjwoSSciWIrQbWqMIWcTHUDYtBAKQjDhAljKv1Q==
X-Received: by 2002:a17:902:526:: with SMTP id 35mr4976749plf.276.1554366124328;
        Thu, 04 Apr 2019 01:22:04 -0700 (PDT)
Received: from dell ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id h65sm48972719pfd.108.2019.04.04.01.21.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 01:22:03 -0700 (PDT)
Date:   Thu, 4 Apr 2019 09:21:53 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "sre@kernel.org" <sre@kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "Haikola, Heikki" <Heikki.Haikola@fi.rohmeurope.com>
Subject: Re: [PATCH v11 2/8] mfd: bd70528: Support ROHM bd70528 PMIC - core
Message-ID: <20190404082153.GP6830@dell>
References: <20190403093015.GJ11301@dell>
 <20190403101003.GC3493@localhost.localdomain>
 <20190403112559.GP11301@dell>
 <85b20828bb4fb51e6df1d5d9d1c1f667db3a7c48.camel@fi.rohmeurope.com>
 <20190404025234.GB6830@dell>
 <6775a75d1ee3ab96123d84b077881beedc358d12.camel@fi.rohmeurope.com>
 <20190404065452.GD6830@dell>
 <20190404072449.GE3493@localhost.localdomain>
 <20190404075640.GV22216@piout.net>
 <70a8a87a403eb2ab8f0aad2a26456de8a162f363.camel@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <70a8a87a403eb2ab8f0aad2a26456de8a162f363.camel@fi.rohmeurope.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Apr 2019, Vaittinen, Matti wrote:

> Hello Alexandre,
> 
> On Thu, 2019-04-04 at 09:56 +0200, Alexandre Belloni wrote:
> > On 04/04/2019 10:24:49+0300, Matti Vaittinen wrote:
> > > On Thu, Apr 04, 2019 at 07:54:52AM +0100, Lee Jones wrote:
> > > > On Thu, 04 Apr 2019, Vaittinen, Matti wrote:
> > > > 
> > > > > Actually, now that I thik of it the right way to do this would
> > > > > have
> > > > > been the function pointer in parent data as was done in
> > > > > original patch
> > > > > set. HW-colleagues tend to re-use HW blocks, and we like to re-
> > > > > use our
> > > > > drivers. If the next PMIC from ROHM uses same RTC block but
> > > > > does not
> > > > > provide watchdog - then it is cleanest solution to fall back to
> > > > > function pointer and leave it to NULL when there is no WDT or
> > > > > when WDT
> > > > > is unused. Another option is to export dummy function - which
> > > > > is not so
> > > > > nice.
> > > > 
> > > > I think the converse is true.
> > > > 
> > > > Pointers to functions outside of a subsystem API context are
> > > > generally
> > > > horrible.  It's much nicer to call a function which can be easily
> > > > stubbed out in a header file based on a Kconfig option.  It's how
> > > > most
> > > > kernel APIs work.
> > > 
> > > I hate to admit but I see your point. This nicely solves any issues
> > > in
> > > syncronizing the startup for driver providing function pointer and
> > > for
> > > driver using it.
> > > 
> > 
> > Wouldn't it be easier to register the watchdog driver as part of the
> > RTC
> > driver?
> > 
> > As I see it, the wdt is just a glorified RTC alarm.
> 
> Do you suggest me to put all the stuff now placed in
> drivers/watchdog/bd70528_wdt.c into rtc driver? It would be doable -
> but I'd rather kept the WDT independent module so that it can be left
> out of config if WDT needs not to be used. And same with RTC. Also, re-
> use of RTC driver in HW which does not include WDT is easier when WDT
> is a separate module. To me it looks much cleaner to have the WDT as
> own module than polluting the RTC driver with config ifdefs.

I haven't looked at the code, but I agree with this in principle.

I'm a firm believer of having functionality in the most appropriate
subsystem.  IMHO, if a device can be neatly split 9/10 it should be.

> But from HW perspective you are correct. The WDT in BD70528 seems to be
> kind of RTC alarm which shuts of the PMIC if triggered.
> 
> Br,
> 	Matti Vaittinen

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
