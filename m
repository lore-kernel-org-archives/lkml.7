Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF4FEC35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 12:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F82621A4C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 12:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sM6qtA+y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbfJBMiE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 08:38:04 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35727 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfJBMiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 08:38:04 -0400
Received: by mail-wr1-f67.google.com with SMTP id v8so19504577wrt.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 05:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=uGk0NsnReW3v26x69JoF4U/XFHQmuXUFuiRSC/I83Fg=;
        b=sM6qtA+y6e7x1nTHaofxM9BD/VTOgP5onwXKS6WOPTvz/Fn+5Bc1DTKW/8qf11Dqyi
         fCWGOI0yGP+HVLyfkD9tqXvA+95gLwYxx3+dsBe780mV9990tfSkH63E6BX1jB+ZApZg
         m48sydXZOM/FlfZwrgQFIQedpUwJem5Gzb8IMJWlAAoJimdgFJ7MzVtExlu2tFEsZG82
         tYQceUIze60tVwcsIc27yjS61uLF0CFPSZ+gm4SCJLH6k4RZi8kVftQFDALOxUj2eQBB
         bSt0hqyl4yoChI9MoQeU4yktEtLk5HjfPB8EVjpzN3Zzm7NeH6xCH87LzIvb5uJUJQ7M
         ZYSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=uGk0NsnReW3v26x69JoF4U/XFHQmuXUFuiRSC/I83Fg=;
        b=nFFOGC64EUpkkBRDALVQFMbPDxQ1RSOu/UlXsWYFMzRj8ZqoRU7wPe2nZIafA6dbO2
         VfwuBLzT6gKlxpiDvBwdkfq0QrAUR7BujOQGu7XfkX51iBvEjnt3yCIDd3oq565BOPMF
         zIf4PC0HprqXDtHRGyfQrTaT83op+ER4T1TQ+oYHuTXuL6swgT8k5I8/8qXgkwSo3SS9
         trLBiZ1CZ6Egyp/hPoArfJb3/8nodXWHqBP4S89Zyu6p1Jv7Z33OvKxHhFD8fEvQc9tS
         d6fiENqtsY3kAZn/c5AkE/2dvAivH+2FDr2aMa1al5iMZhGw61EmXCnAhVUZ9iWYTsMX
         e/9A==
X-Gm-Message-State: APjAAAVSbTvvRCCgu0+2dd5pAQWhThxERvuRa2jN+/sZ+M1s87Uv8aek
        KMzXAqC63+vKHa1AlPfJs6nxMNIGDDA=
X-Google-Smtp-Source: APXvYqzIexH/mIsTsFrTBb+7hbdKoVIDGAMfo2sUtHTukDZhvnGLGnjD6phrChjA1fuXqRhVNjIBRQ==
X-Received: by 2002:adf:cf02:: with SMTP id o2mr2797118wrj.380.1570019881834;
        Wed, 02 Oct 2019 05:38:01 -0700 (PDT)
Received: from dell ([2.27.167.122])
        by smtp.gmail.com with ESMTPSA id u83sm7097505wme.0.2019.10.02.05.38.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Oct 2019 05:38:01 -0700 (PDT)
Date:   Wed, 2 Oct 2019 13:37:59 +0100
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
Message-ID: <20191002123759.GD11769@dell>
References: <1569891524-18875-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
 <1569891524-18875-2-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
 <20191001064539.GB11769@dell>
 <2ff13a61-a346-4d49-ab3a-da5d2126727c@amd.com>
 <20191001120020.GC11769@dell>
 <BN6PR12MB180930BD7D03FD7DEB14D7C1F79D0@BN6PR12MB1809.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BN6PR12MB180930BD7D03FD7DEB14D7C1F79D0@BN6PR12MB1809.namprd12.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 Oct 2019, Deucher, Alexander wrote:

> > -----Original Message-----
> > From: Lee Jones <lee.jones@linaro.org>
> > Sent: Tuesday, October 1, 2019 8:00 AM
> > To: RAVULAPATI, VISHNU VARDHAN RAO
> > <Vishnuvardhanrao.Ravulapati@amd.com>
> > Cc: RAVULAPATI, VISHNU VARDHAN RAO
> > <Vishnuvardhanrao.Ravulapati@amd.com>; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; Liam Girdwood <lgirdwood@gmail.com>;
> > Mark Brown <broonie@kernel.org>; Jaroslav Kysela <perex@perex.cz>;
> > Takashi Iwai <tiwai@suse.com>; Mukunda, Vijendar
> > <Vijendar.Mukunda@amd.com>; Maruthi Srinivas Bayyavarapu
> > <Maruthi.Bayyavarapu@amd.com>; Mehta, Sanju
> > <Sanju.Mehta@amd.com>; Colin Ian King <colin.king@canonical.com>; Dan
> > Carpenter <dan.carpenter@oracle.com>; moderated list:SOUND - SOC LAYER
> > / DYNAMIC AUDIO POWER MANAGEM... <alsa-devel@alsa-project.org>;
> > open list <linux-kernel@vger.kernel.org>
> > Subject: Re: [PATCH 2/7] ASoC: amd: Registering device endpoints using MFD
> > framework
> > 
> > On Tue, 01 Oct 2019, vishnu wrote:
> > 
> > > Hi Jones,
> > >
> > > I am very Thankful to your review comments.
> > >
> > > Actually The driver is not totally based on MFD. It just uses
> > > mfd_add_hotplug_devices() and mfd_remove_devices() for adding the
> > > devices automatically.
> > >
> > > Remaining code has nothing to do with MFD framework.
> > >
> > > So I thought It would not break the coding style and moved ahead by
> > > using the MFD API by adding its header file.
> > >
> > > If it is any violation of coding standard then I can move it to
> > > drivers/mfd.
> > >
> > > This patch could be a show stopper for us.Please suggest us how can we
> > > move ahead ASAP.
> > 
> > Either move the MFD parts to drivers/mfd, or stop using the MFD API.
> 
> There are more drivers outside of drivers/mfd using this API than
> drivers in drivers/mfd.

People do wrong things all the time.  It doesn't make them right.

> In a lot of cases it doesn't make sense to move the driver to drivers/mfd.

In those cases, the platform_device_*() API should be used.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
