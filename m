Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE649C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 22:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73CBE20675
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 22:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ChqqDy9O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbfEHWFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 18:05:44 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46551 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbfEHWFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 18:05:43 -0400
Received: by mail-lj1-f194.google.com with SMTP id h21so209392ljk.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 15:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mJDqU9Be18vct3RelT0fkz+NNup0uRkQXwCH0J/0ayA=;
        b=ChqqDy9OtTLco9IUq0EovfxGWkylmU9D9HUEpFYYW+YRmXm0hippWdq2pKZankIEGt
         Xf2jdjQWWmAdtZPM+9/wLEklwq++GFufTFUCOTqAq2A6cLLxT6l3ymO2l+h0yQElcUIS
         oZ2pIuEdr4g1L8oDs6yyOQmrqt/DoKU53ONMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mJDqU9Be18vct3RelT0fkz+NNup0uRkQXwCH0J/0ayA=;
        b=L7vojqGNfTSUHUFwWsJ17oCD25qZsn3Lp5FZ7aIaS4D2vz/lrJTnIFiqLmB5/bF0uq
         uJqC2HfFsj8l1b4OAnC0b+TcWWoMSmiAmRzzkXapukI2j3wFnpSvHmIRNbejLLqKxHsL
         +VTG+63zkUMsVhw1qMPaPEEI3IlFWi8XFgbuDmLkkI5OPdSQx7kE9/T8OwwiQK+y8Fk5
         nqjvDo96Ob7BGnvXf7dCYB8EdWTZlhFNQ5OqajWaedtZjtcSSZLQH1FMLSWJZ6KRTJ0J
         Y7UdiOOsZoxUYL/BYbQlsfi7JopZMAzE0KSVBt7lFU+tZsoARHC1wMVigCEPxwmifAej
         GavQ==
X-Gm-Message-State: APjAAAVOA/wOmuG9iozfwJECzyU4c1uua5GGtGGdUBr8vGyYQOLIRrR3
        Uw13mC6a7MR3+D3hOXjxeOzsqsW/Hoo=
X-Google-Smtp-Source: APXvYqygUDBeYpRaGsjr9vW1NGeTSWZ7no5AWtwzfYAczLzD3/RN7kAPbUPv97A5g8TpCaLQAM0nIQ==
X-Received: by 2002:a2e:5d49:: with SMTP id r70mr123175ljb.102.1557353142026;
        Wed, 08 May 2019 15:05:42 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id s6sm8014ljh.65.2019.05.08.15.05.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 15:05:41 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id n134so30410lfn.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 15:05:41 -0700 (PDT)
X-Received: by 2002:a19:2d1a:: with SMTP id k26mr255997lfj.104.1557352684116;
 Wed, 08 May 2019 14:58:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190507215359.113378-1-evgreen@chromium.org> <20190507215359.113378-3-evgreen@chromium.org>
 <866afac2-e457-375b-d745-88952b11d75e@linux.intel.com> <CAE=gft4sDo1cLeU8Cm1CRZu2PzVG0iu-b7UaWxWVrsUeZ=SYhQ@mail.gmail.com>
 <6fd9ca2b-dcf6-801f-209e-11eba59203fe@linux.intel.com>
In-Reply-To: <6fd9ca2b-dcf6-801f-209e-11eba59203fe@linux.intel.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 8 May 2019 14:57:27 -0700
X-Gmail-Original-Message-ID: <CAE=gft7JgbDo2xPwdRmY9-oiA_Wchg+mCz1foH267pob-223YA@mail.gmail.com>
Message-ID: <CAE=gft7JgbDo2xPwdRmY9-oiA_Wchg+mCz1foH267pob-223YA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ASoC: Intel: Skylake: Add Cometlake PCI IDs
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, Naveen M <naveen.m@intel.com>,
        Sathya Prakash <sathya.prakash.m.r@intel.com>,
        Ben Zhang <benzh@chromium.org>,
        Rajat Jain <rajatja@chromium.org>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        Rakesh Ughreja <rakesh.a.ughreja@intel.com>,
        Guenter Roeck <groeck@chromium.org>,
        Yu Zhao <yuzhao@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>, Jenny TC <jenny.tc@intel.com>,
        Jie Yang <yang.jie@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 8, 2019 at 10:04 AM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
>
>
> On 5/8/19 11:51 AM, Evan Green wrote:
> > On Tue, May 7, 2019 at 3:31 PM Pierre-Louis Bossart
> > <pierre-louis.bossart@linux.intel.com> wrote:
> >>
> >> On 5/7/19 4:53 PM, Evan Green wrote:
> >>> Add PCI IDs for Intel CometLake platforms, which from a software
> >>> point of view are extremely similar to Cannonlake platforms.
> >>
> >> Humm, I have mixed feelings here.
> >>
> >> Yes the hardware is nearly identical, with the exception of one detail
> >> that's not visible to the kernel, but there is no support for DMICs with
> >> the Skylake driver w/ HDaudio, and Chrome platforms are only going with
> >> SOF, so is it wise to add these two CometLake platforms to the default
> >> SND_SOC_INTEL_SKYLAKE selector, which is used by a number of distributions?
> >>
> >> I don't mind if we add those PCI IDs and people use this driver if they
> >> wish to, but it may be time for an explicit opt-in? The
> >> SND_SOC_INTEL_SKYLAKE definition should even be pruned to mean SKL, APL,
> >> KBL and GLK, and we can add DMI-based quirks for e.g. the Up2 board and
> >> GLK Chromebooks which work with SOF.
> >
> > I don't have the context here, so feel free to ignore me. But it seems
> > like such a tiny amount of extra bits to add to make Cometlake work,
> > and then there's no hassle for the distributions when Cometlake
> > devices start showing up in the wild. So while things are more or less
> > the same, why not continue piggypacking off the default?
> > Or are you saying that the lack of DMIC support means the default
> > should be to use a different driver?
>
> Yes, it's the latter case, SOF will be the only driver supporting DMICs
> on CometLake, so it'd be better to avoid creating a conflict with SOF or
> enabling a configuration by default which is known to have restrictions.
> It's fine to add the CML IDs, but better avoid adding CML under the
> SKYLAKE all-you-can-eat selector.

Ok, I'll plan to remove the new selects from under SND_SOC_INTEL_SKYLAKE.
