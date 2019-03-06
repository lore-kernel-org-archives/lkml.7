Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25FB3C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD5E120661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729359AbfCFKi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 05:38:29 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44220 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727367AbfCFKi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 05:38:29 -0500
Received: by mail-lj1-f196.google.com with SMTP id q128so10392790ljb.11;
        Wed, 06 Mar 2019 02:38:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pkbGJnzrNQWp1Q//kyZcWCjFglxOFBhl6nZ3Kk0wE3I=;
        b=s34ODNwagVp0VTyp0Vs2Rnuq552D+19dWobMZe7NNYeWxEoitSbXKDCaMxlxsO1bNz
         ouT38fJtiWBhI8jKmiK5rQpjWFKfFWZtDzlwi/GqllID+gtOHq7/jkDuhVjiToOaKiMH
         d6kgSJ/Y6USAkc7a12havjabBUHjOhBel81c0aNAsK4upsXQ7X65R7QNQPv0BG5EHLOn
         SdYMNujDHx2f1fQcxhbXBYmhyzGgct6nnWQnkDUBM6wGts0iUjeiEffPn6QyaC7nuPSy
         6/8BlNbwF5Ih3usZEnl5o7g048IHQYj/yTcXBqYKUc/unD2I5GnN7J0faZCOm2D6xvjK
         6UDg==
X-Gm-Message-State: APjAAAX/Vev4X726cZ8ktZMXh+1Z7tBkhlMhDHjb0e67YEO/KPrGJ/sa
        QI6umalJLcRHKi0dKGjy2FY=
X-Google-Smtp-Source: APXvYqwSZpXNqawZCxqpf81sWMEG0ADqPGL3hCmeo+GD8l0NCKMHdZx32634V7xuAqXy+DDZ8gZo6w==
X-Received: by 2002:a2e:97ce:: with SMTP id m14mr2022026ljj.162.1551868705751;
        Wed, 06 Mar 2019 02:38:25 -0800 (PST)
Received: from localhost.localdomain (dyvyhqw8krmdp3vv9p36y-4.rev.dnainternet.fi. [2001:14bb:440:66cb:8872:86cb:c63d:65f4])
        by smtp.gmail.com with ESMTPSA id b64sm259421ljf.82.2019.03.06.02.38.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Mar 2019 02:38:24 -0800 (PST)
Date:   Wed, 6 Mar 2019 12:38:16 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     mazziesaccount@gmail.com, Guenter Roeck <linux@roeck-us.net>,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com,
        lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        sre@kernel.org, lgirdwood@gmail.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, wim@linux-watchdog.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-watchdog@vger.kernel.org, bogdan-petru.chircu-mare@nxp.com
Subject: Re: [PATCH v10 0/9] support ROHM BD70528 PMIC
Message-ID: <20190306103816.GA23959@localhost.localdomain>
References: <cover.1550148989.git.matti.vaittinen@fi.rohmeurope.com>
 <20190228070450.GB3773@localhost.localdomain>
 <20190228114026.GA6802@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228114026.GA6802@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 11:40:26AM +0000, Mark Brown wrote:
> On Thu, Feb 28, 2019 at 09:04:50AM +0200, Matti Vaittinen wrote:
> > On Thu, Feb 14, 2019 at 03:02:37PM +0200, Matti Vaittinen wrote:
> 
> >> Patch series introducing support for ROHM BD70528 PMIC
> > 
> > I was wondering if there is anything that could be done to allow the MFD
> > part of this series to end up in upstream without having to wait the
> > regmap-irq changes
> > (https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git/commit/?h=topic/irq)
> >  to be merged from Linus' tree to MFD tree? If I see it correctly, the
> > regmap-irq (main-irq-reg support) changes are not targeted to linux 5.1.
> > To me it looks like getting them to MFD via Linus' tree will take a while.
> 
> They're targeted for v5.1 and I sent a pull request to Lee for that
> branch IIRC.
Thanks Mark. I think I have misunderstood how you deliver changes to 5.1
- or then I have done some other mistake. I thought these changes were
  not going to 5.1 as I did not see them in your for-5.1 branch. But I
probably did some error there. Thanks for explaining this :)

Br,
	Matti Vaittinen



-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
