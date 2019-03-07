Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A790C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 08:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F49D2146E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 08:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ozk7XYZh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbfCGIZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 03:25:32 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34886 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbfCGIZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 03:25:30 -0500
Received: by mail-wm1-f65.google.com with SMTP id y15so8357673wma.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 00:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=iByZZ0z3++dmogEJzqW9wd3kSy/x3E8tMax0I8dX9SU=;
        b=Ozk7XYZhfJM526uKrQcKHMap2YvaprhB4UeY56Ss/ZbtjHGIIIyk8vdSV17gtbU+M0
         HN0M1XIQvEeD0V+0uTcmCuToSSXhhrVueEWg7g9fC88K77b1KY/Fz1YdMNA3PwJPdDs4
         PTZuPyho75Ks0M1pHYB59mUFfWU+CXHh5WmyZWsTtx3xQyLl+PY1e7+r2SfFwoqoZb8T
         /N62PFDeuHYmTJlkWrWf8+uuid0Lm0tMxuBQ4obKFqG7cySaPW1sIv72YYN8jRt9O+yZ
         i7rzFA43M2Ybi26nhInNgwTaHj+brpm0kiu4DvSidUg6zX42RfoHFzT4Pg23aJN2uTAl
         hOpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=iByZZ0z3++dmogEJzqW9wd3kSy/x3E8tMax0I8dX9SU=;
        b=tXmgAq57Vf7DlFIV8Jfaj7LBn6d1ehzOSZg/6lxj5kOUXAW6aLMibvta9B7WNEHncn
         rXHcfP5j+tJR7gyFgAXM4L4crdijiN8fd1nRrf1gCY6ZedHenX5zj+dUBU68OcOSSJeI
         j8obH2ZYZxg8MSvoLVUnNCIZvhxCv3yhHn9s/L+fazSytC3iO1x9F+Viaj2yORpJ/QG2
         ESWdhgUPfvWnFgeSwDtrPiV8LFiH8XghHe7xEgc5CVt6AvgYivate+YxBQ8LZjIXNaa+
         BeVCJTLwO/VvJqTf9i+ZWix20L8lfj899fFTSw8syP0HJbuw6N1JhpQzyZRUhi4dBiyp
         Amrg==
X-Gm-Message-State: APjAAAVacx46bSKSFhu4WMD96jnKkug8mi/0oMWBng6UjJztnlWXMYDV
        dDG5wavjreCsD/5rEs/NN2fDpg==
X-Google-Smtp-Source: APXvYqwTxcnD+4anLx2oOQ1jLNLOzx9j46Xs76KBbdCSI6bk6e+VcSNXFmstFHBfP7EkCoU3YoC4Gw==
X-Received: by 2002:a1c:5f86:: with SMTP id t128mr4797036wmb.87.1551947127439;
        Thu, 07 Mar 2019 00:25:27 -0800 (PST)
Received: from dell ([2.27.35.194])
        by smtp.gmail.com with ESMTPSA id u14sm527016wrr.42.2019.03.07.00.25.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 00:25:26 -0800 (PST)
Date:   Thu, 7 Mar 2019 08:25:24 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
        Alessandro Rubini <rubini@gnudd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Cory Maccarrone <darkstar6262@gmail.com>,
        Davide Ciminaghi <ciminaghi@gnudd.com>,
        Dong Aisheng <dong.aisheng@linaro.org>,
        Graeme Gregory <gg@slimlogic.co.uk>,
        Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
        Haojian Zhuang <haojian.zhuang@marvell.com>,
        Jin Park <jinyoungp@nvidia.com>,
        Jorge Eduardo Candelaria <jedu@slimlogic.co.uk>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@opensource.wolfsonmicro.com>,
        Mattias Nilsson <mattias.i.nilsson@stericsson.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Tony Lindgren <tony@atomide.com>,
        Venu Byravarasu <vbyravarasu@nvidia.com>,
        linux-omap@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH v5 00/18] mfd: demodularization of non-modular drivers
Message-ID: <20190307082524.GB4634@dell>
References: <1547404609-14161-1-git-send-email-paul.gortmaker@windriver.com>
 <20190116132431.GE23399@dell>
 <20190306231003.GD7915@amd>
 <20190307041808.GK26690@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190307041808.GK26690@windriver.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Mar 2019, Paul Gortmaker wrote:

> [Re: [PATCH v5 00/18] mfd: demodularization of non-modular drivers] On 07/03/2019 (Thu 00:10) Pavel Machek wrote:
> 
> > On Wed 2019-01-16 13:24:31, Lee Jones wrote:
> > > [...]
> > > 
> > > > Paul Gortmaker (18):
> > > >   mfd: aat2870-core: Make it explicitly non-modular
> > > >   mfd: adp5520: Make it explicitly non-modular
> > > >   mfd: as3711: Make it explicitly non-modular
> > > >   mfd: db8500-prcmu: drop unused MODULE_ tags from non-modular code
> > > >   mfd: htc-i2cpld: Make it explicitly non-modular
> > > >   mfd: max8925-core: drop unused MODULE_ tags from non-modular code
> > > >   mfd: rc5t583: Make it explicitly non-modular
> > > >   mfd: sta2x11: drop unused MODULE_ tags from non-modular code
> > > >   mfd: syscon: Make it explicitly non-modular
> > > >   mfd: tps65090: Make it explicitly non-modular
> > > >   mfd: tps65910: Make it explicitly non-modular
> > > >   mfd: tps80031: Make it explicitly non-modular
> > > >   mfd: wm831x-spi: Make it explicitly non-modular
> > > >   mfd: wm831x-i2c: Make it explicitly non-modular
> > > >   mfd: wm831x-core: drop unused module infrastructure from non-modular code
> > > >   mfd: wm8350-i2c: Make it explicitly non-modular
> > > >   mfd: wm8350-core: drop unused module infrastructure from non-modular code
> > > >   mfd: wm8400-core: Make it explicitly non-modular
> > > > 
> > > >  drivers/mfd/aat2870-core.c      | 40 +++-------------------------------------
> > > >  drivers/mfd/adp5520.c           | 30 +++++++-----------------------
> > > >  drivers/mfd/as3711.c            | 14 --------------
> > > >  drivers/mfd/db8500-prcmu.c      | 10 ++++------
> > > >  drivers/mfd/htc-i2cpld.c        | 18 +-----------------
> > > >  20 files changed, 41 insertions(+), 332 deletions(-)
> > > 
> > > All applied!
> > 
> > Is it good idea?
> 
> Pavel, I think yes it is good, and I hope you will allow me the chance
> to convince you of the same.  It removes dead code, and removes the
> chance that people mistakenly believe any of these drivers were
> currently possible as modules, when they were really NOT at all modular.
> 
> > We want distro kernels on ARM, too, which means people will eventually
> > want these as a modules, no?
> 
> And at the risk of repeating something I've said a lot already, this
> is fine, and I 100% support people converting drivers to being modular,
> in the case where there is demand, and where people with the hardware
> who are willing to test that the modular use-case actually works.
> 
> If people want it to be modular, then this work actually helps.  You
> don't have drivers "hiding in the shadows" that pretend to be modules.
> Such drivers do not at all help with the "distro kernels" use case.
> 
> If a driver author responds and says they intended to make their driver
> a module, I 100% support them, and will drop the code removal patch and
> also have supported them in making their work tristate.  If the choice
> to convert to tristate happens a year or more from now, it is trivial to
> reclaim the unused-but-deleted code from git.
> 
> But, again as I have said many times -- I can't know every detail of
> each driver to know if module/tristate makes any sense, as a use-case or
> if even technically possible (such as in DMA/IOMMU or similar low level
> core systems).   So the right option is to remove the dead code and not
> impact the existing driver behaviour, and make it clear in the process
> to the authors and users, that the driver was never modular to begin
> with --  and in doing so, give them all a chance to comment and react.
> 
> Pavel, I hope this more extended explanation makes sense to you, and
> that you simply have not seen me write these same details in the past.

Blimey.  That's a really long winded way of saying:

  "Modular-ness is actually broken in these drivers; [Paul]'s patches
   make that point clear for all to see.  If people (authors/distros)
   wish them to be modular, they need to fix them properly."

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
