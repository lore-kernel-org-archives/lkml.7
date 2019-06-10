Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35BB1C468BC
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 08:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EA1C2082E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 08:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dLWDNPrk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388807AbfFJI5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 04:57:09 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32828 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388570AbfFJI5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 04:57:08 -0400
Received: by mail-wr1-f66.google.com with SMTP id n9so8340244wru.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 01:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=GlDt1J1fvetPyCESKlMjIqNMRM316J8zlPWhx4LvhsY=;
        b=dLWDNPrkI87/+NMFnp/VUOiz1kzAkorqRcxWDj2CwmyrVaPmdZqEui/iYaPCvA3EBt
         YqPI7+TYFzoQSWEuLJ74QLiw7ke6fg0PByg9knMnNIJzN+tYd3RT0OFaQ1VaeWcl/XDV
         awBdJmYgsMK8KCOAC7Z2wtU68rJmTZvwuKiNyxNeML9bl9KJTutqOQmU8kuQI/TYfwbV
         AzJH+7TANCbH6cLFyWGUve2ETdV7hkG5L4N5L9qc6RVwJDemOGB1Si7ol9cFGmU175+g
         paimTa6NSc3J74RFiZVjkGCiiF/3P9cWgXEwoZ3uqJjfAI+kZ7CD2L4yRZPYmU+Mear2
         dvYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=GlDt1J1fvetPyCESKlMjIqNMRM316J8zlPWhx4LvhsY=;
        b=jt2Q0jJTR0fpJfDiEWpAjYo4gtA7agQra1jr7b9FSc+AEUFzV992SLKRXnrQVieU/m
         0DEM+3AA/hGxy4Z71NCQqb2bGTjrNQmCbesb/F0arc/SybJmr2OTD+NRxK2iK4hTNmsx
         IhXnOOVaB4502+LB4gNH0xOkNUPkJ+PygkW8Wi2V23fFsXxv51IURPfJ8IXWO3St5E5C
         dYspzdCEfZpRgH7NESeXY52rbkxjFDrllAHOOaKu60o8n1S+CMjQWX+vAbXMyUpBGVj1
         59IKTTPLhUogTD68H5KZoRa+dT+zB/Q826/hRtFY8aIb4M4yocdbRJjJ+bhYuwy7uk4n
         43ew==
X-Gm-Message-State: APjAAAWzjiQORgweBchM3f8qP/KEafk9+2vaVMfVwma1OqKN37+Q86wD
        mIJ4XHuu70YFpdIX1Pe4rdNrog==
X-Google-Smtp-Source: APXvYqwjc0a0DLhGA1q6cGuReETiH52r+c3VwON9VQ9q0tUiL5klLowpEXxkevN5zMVwdmaiDjiyJg==
X-Received: by 2002:adf:e691:: with SMTP id r17mr27661347wrm.67.1560157026515;
        Mon, 10 Jun 2019 01:57:06 -0700 (PDT)
Received: from dell ([2.31.167.229])
        by smtp.gmail.com with ESMTPSA id h1sm9097423wrt.20.2019.06.10.01.57.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Jun 2019 01:57:06 -0700 (PDT)
Date:   Mon, 10 Jun 2019 09:57:04 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        alsa-devel@alsa-project.org, linux-iio@vger.kernel.org,
        fabien.lahoudere@collabora.com, Takashi Iwai <tiwai@suse.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>
Subject: Re: [GIT PULL] Immutable branch between MFD and Cros due for the
 v5.3 merge window
Message-ID: <20190610085704.GM4797@dell>
References: <20190603183401.151408-1-gwendal@chromium.org>
 <20190604055908.GA4797@dell>
 <CAFqH_51gMu81f=VFQaF4u9-tAWDMocGAwM_fOPT3Cctv6KWniw@mail.gmail.com>
 <20190610082012.GK4797@dell>
 <CAFqH_50J1wqdhWw5nW+D=crfg=JjUrSh2it=JORx5Wn8LfNTQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFqH_50J1wqdhWw5nW+D=crfg=JjUrSh2it=JORx5Wn8LfNTQg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jun 2019, Enric Balletbo Serra wrote:

> Hi,
> 
> Thanks for the ib Lee.
> 
> Doing my Monday rebase I just noticed we will have a trivial conflict
> for the merge window.
> 
> Missatge de Lee Jones <lee.jones@linaro.org> del dia dl., 10 de juny
> 2019 a les 10:20:
> >
> > As requested.
> >
> > Enjoy!
> >
> > The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:
> >
> >   Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-cros-v5.3
> >
> > for you to fetch changes up to 3aa6be30da899619c44aa654313ba66eb44e7291:
> >
> >   mfd: cros_ec: Update I2S API (2019-06-10 09:15:08 +0100)
> >
> > ----------------------------------------------------------------
> > Immutable branch between MFD and Cros due for the v5.3 merge window
> >
> > ----------------------------------------------------------------
> > Gwendal Grignou (30):
> >       mfd: cros_ec: Update license term
> 
> That's the commit will have problems due
> 
> commit 9c92ab61914157664a2fbdf926df0eb937838e45
> Author: Thomas Gleixner <tglx@linutronix.de>
> Date:   Wed May 29 07:17:56 2019 -0700
> 
>     treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 282
> 
> That was introduced in v5.2-rc4

Thanks for the heads-up.  Hopefully -next will catch it.  If not,
hopefully Git will just 'do the right thing' (TM).

> >       mfd: cros_ec: Zero BUILD_ macro
> >       mfd: cros_ec: set comments properly
> >       mfd: cros_ec: add ec_align macros
> >       mfd: cros_ec: Define commands as 4-digit UPPER CASE hex values
> >       mfd: cros_ec: use BIT macro
> >       mfd: cros_ec: Update ACPI interface definition
> >       mfd: cros_ec: move HDMI CEC API definition
> >       mfd: cros_ec: Remove zero-size structs
> >       mfd: cros_ec: Add Flash V2 commands API
> >       mfd: cros_ec: Add PWM_SET_DUTY API
> >       mfd: cros_ec: Add lightbar v2 API
> >       mfd: cros_ec: Expand hash API
> >       mfd: cros_ec: Add EC transport protocol v4
> >       mfd: cros_ec: Complete MEMS sensor API
> >       mfd: cros_ec: Fix event processing API
> >       mfd: cros_ec: Add fingerprint API
> >       mfd: cros_ec: Fix temperature API
> >       mfd: cros_ec: Complete Power and USB PD API
> >       mfd: cros_ec: Add API for keyboard testing
> >       mfd: cros_ec: Add Hibernate API
> >       mfd: cros_ec: Add Smart Battery Firmware update API
> >       mfd: cros_ec: Add I2C passthru protection API
> >       mfd: cros_ec: Add API for EC-EC communication
> >       mfd: cros_ec: Add API for Touchpad support
> >       mfd: cros_ec: Add API for Fingerprint support
> >       mfd: cros_ec: Add API for rwsig
> >       mfd: cros_ec: Add SKU ID and Secure storage API
> >       mfd: cros_ec: Add Management API entry points
> >       mfd: cros_ec: Update I2S API
> >
> >  include/linux/mfd/cros_ec_commands.h | 3658 +++++++++++++++++++++++++++-------
> >  sound/soc/codecs/cros_ec_codec.c     |    8 +-
> >  2 files changed, 2915 insertions(+), 751 deletions(-)
> >

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
