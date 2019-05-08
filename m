Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4129CC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 16:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02943216F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 16:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EkeSxg5L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbfEHQv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 12:51:59 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35188 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728044AbfEHQv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 12:51:58 -0400
Received: by mail-lf1-f68.google.com with SMTP id j20so15070592lfh.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 09:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZQsJ0MMOXpj6zufGwF5+gpNcluH7GYea+FBpZiqmq4o=;
        b=EkeSxg5LiTGZ7oRiG88NnE3UOX78w4Hzdbbmt4L7rf01nC1vh+RrHjFojzc53VWTjN
         7uodjbP6QNH07K52PKfZzlfgmEITpiGPRtG5JFrR6zgYG+8oGLzI7DU4xFQIS8TmxRVA
         89lb4ZjnCK56fQ8t+nAq2Z9CaBeX+iseZyJeY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZQsJ0MMOXpj6zufGwF5+gpNcluH7GYea+FBpZiqmq4o=;
        b=bWyO2MJ9mLPeFsmszPd02J0Hry8He9XZf3hc8EPxEWrPjNOV4Va+kjvnotiNFOrrC5
         i8fKsSfZtEp03dUvRtgDEYuPavoYnRqqkJGhGXOYBEXORjdNXHi7nP6aAYaXHn5kc3Dw
         lt1dH13N5oOpeJWYFvFOpIOURA9oqV8vuE1TvnWMPctQ3NLUA4HDUbFJ6pbDVRZRMDSU
         qv661MQrumWDuIRTEl8xl60Vw3RnYCP6BVetfkETxqm4UWY6OoDEOgXm9CEDEotqLjYR
         +pF0h2ZLAsCbXHkT8IaBJw1Ay2nFgdeWeaL8kkUAKqv/P7fAkaA34kcCfVK67HxZ4NG7
         Wweg==
X-Gm-Message-State: APjAAAUyJx87bevxwTeOho1K9dJGqpuVMWl1JmZJYV3ZMT2DYzytPv14
        2qyBddBxywSfw3+0ceWRK1zYydmZ394=
X-Google-Smtp-Source: APXvYqxGjSK9R7yMzqP5V+l4hvx8tgLBHyHreO6i+70tFY39FfsoJ/PVd+BU4yu1DYqEnsx0vNiwzw==
X-Received: by 2002:ac2:4a86:: with SMTP id l6mr20458335lfp.51.1557334316947;
        Wed, 08 May 2019 09:51:56 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id a11sm591508ljb.31.2019.05.08.09.51.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 09:51:55 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id h126so3888799lfh.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 09:51:55 -0700 (PDT)
X-Received: by 2002:ac2:5621:: with SMTP id b1mr11089034lff.27.1557334314697;
 Wed, 08 May 2019 09:51:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190507215359.113378-1-evgreen@chromium.org> <20190507215359.113378-3-evgreen@chromium.org>
 <866afac2-e457-375b-d745-88952b11d75e@linux.intel.com>
In-Reply-To: <866afac2-e457-375b-d745-88952b11d75e@linux.intel.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 8 May 2019 09:51:18 -0700
X-Gmail-Original-Message-ID: <CAE=gft4sDo1cLeU8Cm1CRZu2PzVG0iu-b7UaWxWVrsUeZ=SYhQ@mail.gmail.com>
Message-ID: <CAE=gft4sDo1cLeU8Cm1CRZu2PzVG0iu-b7UaWxWVrsUeZ=SYhQ@mail.gmail.com>
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

On Tue, May 7, 2019 at 3:31 PM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
> On 5/7/19 4:53 PM, Evan Green wrote:
> > Add PCI IDs for Intel CometLake platforms, which from a software
> > point of view are extremely similar to Cannonlake platforms.
>
> Humm, I have mixed feelings here.
>
> Yes the hardware is nearly identical, with the exception of one detail
> that's not visible to the kernel, but there is no support for DMICs with
> the Skylake driver w/ HDaudio, and Chrome platforms are only going with
> SOF, so is it wise to add these two CometLake platforms to the default
> SND_SOC_INTEL_SKYLAKE selector, which is used by a number of distributions?
>
> I don't mind if we add those PCI IDs and people use this driver if they
> wish to, but it may be time for an explicit opt-in? The
> SND_SOC_INTEL_SKYLAKE definition should even be pruned to mean SKL, APL,
> KBL and GLK, and we can add DMI-based quirks for e.g. the Up2 board and
> GLK Chromebooks which work with SOF.

I don't have the context here, so feel free to ignore me. But it seems
like such a tiny amount of extra bits to add to make Cometlake work,
and then there's no hassle for the distributions when Cometlake
devices start showing up in the wild. So while things are more or less
the same, why not continue piggypacking off the default?
Or are you saying that the lack of DMIC support means the default
should be to use a different driver?
-Evan
