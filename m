Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3550BC10F05
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F09EC20855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbfDDHY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 03:24:57 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38274 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfDDHYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 03:24:55 -0400
Received: by mail-lf1-f67.google.com with SMTP id a6so998221lfl.5;
        Thu, 04 Apr 2019 00:24:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lNOA7R5yLFsuZRe3mPqByyFkVafCuBm5cFyQF7wmFmU=;
        b=JTAMtZq81lU2ewoBJ+iBvpkmIRdptvVZNg1AQHzRveRqEoxmiv858IQnKv1xpKCZpS
         2H43gqNk7LQWIUgesnwRhNxK/QPAGl0kz5ZEZdV7/MUzgcptVMGPmTXorwm83khYFytW
         2cNkw8RyJxBEJwHj30kie1oEUM4G6MLj70X7R7CeBOjCI0SJJ+Tnx2eJqSzsNSNjdwfc
         sTU+jlBQAY7CNuwkmbBNpSRHcCZ0cgrP+aM0fJFjp+C0Lpt1Kw6puXO0+aDPAGRUZhDM
         PRCrm0xAW6gnsUKSHoGh4X+MaGGIVoFtmzDaO7LUXqFtIIHg41CA8+YtM9e20JyHphOB
         XJdg==
X-Gm-Message-State: APjAAAVhsfFlopCgqJY6BozeGdUYS35qF/y9Ujrhm7Jg70V8YIEWWtk5
        Tpya3b5FQowX/tE3X/yVFuo=
X-Google-Smtp-Source: APXvYqzKjVgLaOKWF0u/e/MUBLH8qTtq1abb44fRhd7Wn3BL7u8baMpK/5ctoRkGU57WCRUzh5HWDA==
X-Received: by 2002:ac2:5082:: with SMTP id f2mr2384497lfm.71.1554362692700;
        Thu, 04 Apr 2019 00:24:52 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id f25sm2922156lfk.69.2019.04.04.00.24.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 00:24:52 -0700 (PDT)
Date:   Thu, 4 Apr 2019 10:24:49 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "sre@kernel.org" <sre@kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "Haikola, Heikki" <Heikki.Haikola@fi.rohmeurope.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v11 2/8] mfd: bd70528: Support ROHM bd70528 PMIC - core
Message-ID: <20190404072449.GE3493@localhost.localdomain>
References: <39efebe0396dd42de30d37c6f3c1ef2926c90210.1553515333.git.matti.vaittinen@fi.rohmeurope.com>
 <20190403073152.GM4187@dell>
 <20190403084732.GA3493@localhost.localdomain>
 <20190403093015.GJ11301@dell>
 <20190403101003.GC3493@localhost.localdomain>
 <20190403112559.GP11301@dell>
 <85b20828bb4fb51e6df1d5d9d1c1f667db3a7c48.camel@fi.rohmeurope.com>
 <20190404025234.GB6830@dell>
 <6775a75d1ee3ab96123d84b077881beedc358d12.camel@fi.rohmeurope.com>
 <20190404065452.GD6830@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404065452.GD6830@dell>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 07:54:52AM +0100, Lee Jones wrote:
> On Thu, 04 Apr 2019, Vaittinen, Matti wrote:
> 
> > Actually, now that I thik of it the right way to do this would have
> > been the function pointer in parent data as was done in original patch
> > set. HW-colleagues tend to re-use HW blocks, and we like to re-use our
> > drivers. If the next PMIC from ROHM uses same RTC block but does not
> > provide watchdog - then it is cleanest solution to fall back to
> > function pointer and leave it to NULL when there is no WDT or when WDT
> > is unused. Another option is to export dummy function - which is not so
> > nice.
> 
> I think the converse is true.
> 
> Pointers to functions outside of a subsystem API context are generally
> horrible.  It's much nicer to call a function which can be easily
> stubbed out in a header file based on a Kconfig option.  It's how most
> kernel APIs work.

I hate to admit but I see your point. This nicely solves any issues in
syncronizing the startup for driver providing function pointer and for
driver using it.

> > Additional benefit from function pointer would have been that the
> > function pointer can be only used by drivers which have acces to it.
> > This exported function is globally visible. The WDT disable/enable is
> > very specific procedure and it actually would be nicer design to not
> > have it visible globally. It is not intended to be used by anything
> > else besides the WDT and RTC here.
> 
> Why would anything else try to use it?
> 
> There are 1000's of exported functions in the kernel.  If it's
> properly namespaced a consumer would have to purposely call it, which
> if they really wanted to, they could do anyway.  I don't really see
> your point.

I could still argue on this. It _is_ less obvous that an exported function
is not meant to be publicly used than it is for function pointers. But
as you say, this is not a strong enough point to see the trouble in
synchronizing the WDT/RTC startup.

> > But I can't say there will be PMIC with same RTC and no WDT coming from
> > ROHM. Also, I am not terribly excited about the option of changing this
> > back to function-pointer as I already removed the pointer from parent
> > data and this changed parent data is already adapted to all sub drivers
> > - so this is all just babbling. Maybe it is just my huge ego shouting
> > there - 'I was right, I must have the final say'.
> 
> No, a call-back function would be a back-step.

You are probably right.

> Ego or no ego, you're wrong. =:-D

I'd rephrase that as "It's not that I am wrong, but you are right." =)

> > As a side note, I already did submit v12 with other styling fixes but
> > which left the WDT function in MFD. If you still see the WDT functions
> > should be exported from WDT - then please ignore the v12. I'll do v13
> > at the afternoon (my time, which is only a bit after noon your time I
> > guess) which will export these functions from WDT. (Well, I had to try
> > once more :D)
> 
> Please keep the WDT code in the WDT driver.  Create a little stub for
> the cases where the WDT driver is not enabled - job done.

Yes Sir.

Br,
	Matti Vaittinen

-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
