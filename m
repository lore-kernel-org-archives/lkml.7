Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2E1C35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 13:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E9B921D80
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 13:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CEwJVEoE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbfJBNf7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 09:35:59 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38049 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727854AbfJBNf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 09:35:58 -0400
Received: by mail-wr1-f68.google.com with SMTP id w12so19711548wro.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 06:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=SKsMv8qnMo+5vAVsJhy/p0hqFSrqBGNR2va/5wYlCuM=;
        b=CEwJVEoE0/j9CZxiEx8eaD9UtVNmxSeBk+wSYk0Ie4EqY8VXts8uiIcXkz+nV50KXu
         yKdlBWYBdjU2d2dEgqeyVK70H6nm/GN2aoIrvE3GxkvaqFYa6pmrVa9iV51u9/J25UoW
         cvRIh4cpLWJ6r2tXFe5dU4Eja4scW/+Jf/dVf9blzrjUhqBBVi6fdkfWDAlT2m4VYw9j
         RS1aUXbe1apSFbPzvdFUBTrZsiNYDvViq6YCDRMYebDVzvsORWFdvB4S4q3Mf+YPQyl9
         5lxeJL8TFr+Zx1zQbjeKLVPl0sAR3PWqHeCBpK8ZwtJMiuLws18C+B1rzUO8JsTTB2XM
         z+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=SKsMv8qnMo+5vAVsJhy/p0hqFSrqBGNR2va/5wYlCuM=;
        b=YYjW18Ure8mpg9VkWiToQZFXJ0Y4Mr5Ds8l8QoLk4O7CEfJtM8Rxg+OgTP6bB+rIcs
         wZ3+7cYokp/Wn1D4wDPx1tHEABAnOc/eAz6VjixNyW990IkbYStxnbJ2aN83//KzMykL
         4ZgirYUd+VtLZKGqeNwE+ShYWDAIE7otnWhXLJZHcgxoDMmRRWdWPwDeWswTZJ7EIqOf
         Gk0Hp1FFPMu+QMHEjK9FQUpyTKRVKJpXAJDjvmVGJRxyDoH9+81YeXe8DNh4VzU6IICh
         bvSeiL5m626yXpsYvT/9o9Yh6msBadJ275gt2KPpO1zjR1QGIDG57FcKsyIQ67caQOwW
         Jarw==
X-Gm-Message-State: APjAAAVLrANqCVGEoo2cFU8IHXFa/0738jpg14lNNA8FRbWhNLwaHWjH
        YtTYr3vYnoH2LMHxC7fiBavflw==
X-Google-Smtp-Source: APXvYqwmQEJTRFI2E4QtGacDdNY5KlrW5j4hYCbn4S/SB7PHxXD8maaacFuWFSKfjW3MsMrj5O0Gxw==
X-Received: by 2002:a5d:43d0:: with SMTP id v16mr2822249wrr.390.1570023355697;
        Wed, 02 Oct 2019 06:35:55 -0700 (PDT)
Received: from dell ([2.27.167.122])
        by smtp.gmail.com with ESMTPSA id m18sm23191103wrg.97.2019.10.02.06.35.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Oct 2019 06:35:55 -0700 (PDT)
Date:   Wed, 2 Oct 2019 14:35:53 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc:     "RAVULAPATI, VISHNU VARDHAN RAO" 
        <Vishnuvardhanrao.Ravulapati@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>,
        "Mehta, Sanju" <Sanju.Mehta@amd.com>,
        Colin Ian King <colin.king@canonical.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/7] ASoC: amd: Registering device endpoints using MFD
 framework
Message-ID: <20191002133553.GA21172@dell>
References: <1569891524-18875-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
 <1569891524-18875-2-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
 <20191001064539.GB11769@dell>
 <2ff13a61-a346-4d49-ab3a-da5d2126727c@amd.com>
 <20191001120020.GC11769@dell>
 <BN6PR12MB180930BD7D03FD7DEB14D7C1F79D0@BN6PR12MB1809.namprd12.prod.outlook.com>
 <20191002123759.GD11769@dell>
 <BN6PR12MB1809451A3152488F3D8D1371F79C0@BN6PR12MB1809.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BN6PR12MB1809451A3152488F3D8D1371F79C0@BN6PR12MB1809.namprd12.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Oct 2019, Deucher, Alexander wrote:

> > -----Original Message-----
> > From: Lee Jones <lee.jones@linaro.org>
> > Sent: Wednesday, October 2, 2019 8:38 AM
> > To: Deucher, Alexander <Alexander.Deucher@amd.com>
> > Cc: RAVULAPATI, VISHNU VARDHAN RAO
> > <Vishnuvardhanrao.Ravulapati@amd.com>; Liam Girdwood
> > <lgirdwood@gmail.com>; Mark Brown <broonie@kernel.org>; Jaroslav
> > Kysela <perex@perex.cz>; Takashi Iwai <tiwai@suse.com>; Mukunda,
> > Vijendar <Vijendar.Mukunda@amd.com>; Maruthi Srinivas Bayyavarapu
> > <Maruthi.Bayyavarapu@amd.com>; Mehta, Sanju
> > <Sanju.Mehta@amd.com>; Colin Ian King <colin.king@canonical.com>; Dan
> > Carpenter <dan.carpenter@oracle.com>; moderated list:SOUND - SOC LAYER
> > / DYNAMIC AUDIO POWER MANAGEM... <alsa-devel@alsa-project.org>;
> > open list <linux-kernel@vger.kernel.org>
> > Subject: Re: [PATCH 2/7] ASoC: amd: Registering device endpoints using MFD
> > framework
> > 
> > On Tue, 01 Oct 2019, Deucher, Alexander wrote:
> > 
> > > > -----Original Message-----
> > > > From: Lee Jones <lee.jones@linaro.org>
> > > > Sent: Tuesday, October 1, 2019 8:00 AM
> > > > To: RAVULAPATI, VISHNU VARDHAN RAO
> > > > <Vishnuvardhanrao.Ravulapati@amd.com>
> > > > Cc: RAVULAPATI, VISHNU VARDHAN RAO
> > > > <Vishnuvardhanrao.Ravulapati@amd.com>; Deucher, Alexander
> > > > <Alexander.Deucher@amd.com>; Liam Girdwood
> > <lgirdwood@gmail.com>;
> > > > Mark Brown <broonie@kernel.org>; Jaroslav Kysela <perex@perex.cz>;
> > > > Takashi Iwai <tiwai@suse.com>; Mukunda, Vijendar
> > > > <Vijendar.Mukunda@amd.com>; Maruthi Srinivas Bayyavarapu
> > > > <Maruthi.Bayyavarapu@amd.com>; Mehta, Sanju
> > <Sanju.Mehta@amd.com>;
> > > > Colin Ian King <colin.king@canonical.com>; Dan Carpenter
> > > > <dan.carpenter@oracle.com>; moderated list:SOUND - SOC LAYER /
> > > > DYNAMIC AUDIO POWER MANAGEM... <alsa-devel@alsa-project.org>;
> > open
> > > > list <linux-kernel@vger.kernel.org>
> > > > Subject: Re: [PATCH 2/7] ASoC: amd: Registering device endpoints
> > > > using MFD framework
> > > >
> > > > On Tue, 01 Oct 2019, vishnu wrote:
> > > >
> > > > > Hi Jones,
> > > > >
> > > > > I am very Thankful to your review comments.
> > > > >
> > > > > Actually The driver is not totally based on MFD. It just uses
> > > > > mfd_add_hotplug_devices() and mfd_remove_devices() for adding
> > the
> > > > > devices automatically.
> > > > >
> > > > > Remaining code has nothing to do with MFD framework.
> > > > >
> > > > > So I thought It would not break the coding style and moved ahead
> > > > > by using the MFD API by adding its header file.
> > > > >
> > > > > If it is any violation of coding standard then I can move it to
> > > > > drivers/mfd.
> > > > >
> > > > > This patch could be a show stopper for us.Please suggest us how
> > > > > can we move ahead ASAP.
> > > >
> > > > Either move the MFD parts to drivers/mfd, or stop using the MFD API.
> > >
> > > There are more drivers outside of drivers/mfd using this API than
> > > drivers in drivers/mfd.
> > 
> > People do wrong things all the time.  It doesn't make them right.
> > 
> > > In a lot of cases it doesn't make sense to move the driver to drivers/mfd.
> > 
> > In those cases, the platform_device_*() API should be used.
> 
> Why do we have both?  It's not clear to me on when we should use one

The platform_device_*() API is the de facto API to use for registering
devices.  mfd_*() is a framework built on-top of that for devices
which register sub-devices that do not reasonably reside elsewhere.

The mfd_*() helper functions should only be used by MFD devices.

> vs the other.  These are not platforms per se, they are PCI devices
> that happen to have other devices on them.  On previous projects, I
> was told to use mfd and no objections were raised at that time.

Who told you to use MFD API outside of drivers/mfd?  That's a hack.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
