Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED0FC282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D305206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nTGWDgw7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732499AbfDQO2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:28:07 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39698 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732352AbfDQO2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:28:06 -0400
Received: by mail-pf1-f195.google.com with SMTP id i17so12191153pfo.6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 07:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LCbUomO0PoXbW5LHWVPRzENV8iuXEXyVbNnsm5gnDh0=;
        b=nTGWDgw7XmWtU68qpayyH+Wn76Ka9r13BNuQCfmbb9x2e7nF64vdd6V83agMm7NbZm
         ShdUCyPub2l26vCXr8Kc8x0N3cdJqTbKDfzSXrCFnL/5GdhvUcEH5s9rq8WRla6iCe8m
         qUfb6jYLB2yrmZxr9zBiXpdKe9s+yF9/VFEHkaKSnsBrcVPnSaDwglsSfHB8jpBI6tyK
         KW5A9zun1xJQc8X/2HhSdo6fU9yFwNSL5swexTO0s6DFbRfuMM0l5ZpmYbF+UoI+BmkU
         0B9qA5KwSO+8z7UikaVTCA1JX4dU3CdlmlWmwszXtTsZ2BUSu9dZYcBYJUWrXwedZmZx
         P0xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LCbUomO0PoXbW5LHWVPRzENV8iuXEXyVbNnsm5gnDh0=;
        b=UXxjR/c4t1M9SpCd2uAglESh0/hM88XbYdIcrHGD8kBmYiLNl5nmPic4qM05Aq04HY
         A8FWgqS4E8bAu9qXhrT6i188wa9kOBJHHvef0A3FqPqkvZSyzLFQGXiuFFnG16/eF63r
         xpP3+VRAXaDZZ/4UwJOiuk6TNNKLHHJ9qR0ou9EfiM+DJE2Ec6vzUxlC4TKoV6H8irIc
         xZN8+w/3x9y/Os6yS48gjPseI8ChS3oASWAVScC6ZBTchVuOf4PGERJ64QRUPYGH+T0S
         rqzJs51Mjcmjz1gkw8TbBV7PjgiW5GukcDynsgYMqa26k5YUHMQVtynsI+gNoxKQTZ6f
         5Ehw==
X-Gm-Message-State: APjAAAVw9P67p+5ItuoRjX6P/MBYnc/++FG3oihXexZ31mwqdkuz10Me
        q7BD9hqtdzuRs86OSvVODk3vdw==
X-Google-Smtp-Source: APXvYqyyvfWLXi7fDY7Y4Vro9mh9sEL3NOhbr5Qd6GgweSoXspTjZ1QhyPZCuzh5ljzCz9yuBAvMFg==
X-Received: by 2002:a65:518d:: with SMTP id h13mr5324375pgq.259.1555511285318;
        Wed, 17 Apr 2019 07:28:05 -0700 (PDT)
Received: from localhost ([43.229.102.52])
        by smtp.gmail.com with ESMTPSA id l19sm37594803pfi.87.2019.04.17.07.28.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 07:28:03 -0700 (PDT)
Date:   Wed, 17 Apr 2019 19:57:43 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Yangtao Li <tiny.windzz@gmail.com>, vireshk@kernel.org, nm@ti.com,
        sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        wens@csie.org, rjw@rjwysocki.net, davem@davemloft.net,
        mchehab+samsung@kernel.org, gregkh@linuxfoundation.org,
        nicolas.ferre@microchip.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] cpufreq: Add sunxi nvmem based CPU scaling driver
Message-ID: <20190417142629.uckz42ufxywcbeez@vireshk-mac-ubuntu>
References: <20190416155209.24216-1-tiny.windzz@gmail.com>
 <20190417020830.f5empr3rr3ifbstl@vireshk-mac-ubuntu>
 <20190417083116.xgwglxogy2zqdghh@flea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417083116.xgwglxogy2zqdghh@flea>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-04-19, 10:31, Maxime Ripard wrote:
> On Wed, Apr 17, 2019 at 07:38:30AM +0530, Viresh Kumar wrote:
> > On 16-04-19, 11:52, Yangtao Li wrote:
> > > Add sunxi nvmem based CPU scaling driver, refers to qcom-cpufreq-kryo.
> > >
> > > Yangtao Li (2):
> > >   cpufreq: Add sunxi nvmem based CPU scaling driver
> > >   dt-bindings: cpufreq: Document allwinner,sun50i-h6-operating-points
> > >
> > >  .../bindings/opp/sun50i-nvmem-cpufreq.txt     | 167 +++++++++++++
> > >  MAINTAINERS                                   |   7 +
> > >  drivers/cpufreq/Kconfig.arm                   |  12 +
> > >  drivers/cpufreq/Makefile                      |   1 +
> > >  drivers/cpufreq/cpufreq-dt-platdev.c          |   2 +
> > >  drivers/cpufreq/sun50i-cpufreq-nvmem.c        | 226 ++++++++++++++++++
> > >  6 files changed, 415 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/opp/sun50i-nvmem-cpufreq.txt
> > >  create mode 100644 drivers/cpufreq/sun50i-cpufreq-nvmem.c
> > >
> > > ---
> > > v4:
> > > -I removed this sunxi_cpufreq_soc_data structure for now.
> >
> > Why this change ?
> 
> It's used on a single SoC for now, so it's impossible to know at this
> point what to put in that structure in the first place.
> 
> Of course, that would need to be brought back if we ever have two SoCs
> to support and that we know which differences there is.

Okay, I was surprised that you dropped that in v4, which was quite late :)

-- 
viresh
