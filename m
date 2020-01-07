Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B353AC32771
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 01:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 836A32072E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 01:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mdt/L/fH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbgAGBpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 20:45:35 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40026 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727326AbgAGBpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 20:45:35 -0500
Received: by mail-qk1-f193.google.com with SMTP id c17so41330396qkg.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 17:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ft6xmRm0Xn4A+6zJu2AAPIsi5FGpNr4OiKyWPq8PF3E=;
        b=mdt/L/fHFt2uUCxneOT+wJBx1zeGq9fEF86Cyn+w5YQHYXVdG2UDKU90QAJJDbAT6E
         IZWrNX6Taxnc5BNAW8Yp3jFm3p+efXels7I1FhUsccQ4zciOFeCl6pRPzl9m7pO2PuDr
         KccNYENPlAXa8/HDVUEFXxyjyo87LkIjp98PX/W8bgzxDLiDmuBzWbE0awp041Lw231F
         +39mAOxKlUQKQGTmn1zMvdes8C2LY2Tfwuk7RCMGiBDabQHnqMP7NGNdvxL2BEaX+Sak
         z7fe9ZeK79KghIH6+sVVA3NzodbDqzqiLcC+fviJJ+agPmBXo3F4bTuXNJhJr2KcUTHw
         nV6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ft6xmRm0Xn4A+6zJu2AAPIsi5FGpNr4OiKyWPq8PF3E=;
        b=lKZTd7ialDiVYeQzv9hXnKqI0TirJnoM8LXemKbzPFldLH0BbBpYUQCn2bMS9VQank
         I+zZwtGq5COJr0fH3QmnquRHik6Cjrm+mf8bdcEuWYDZ4xuTABip7LCMXrMfaaC4xnFx
         oD4wwjCQyyk8drJonsIMzAqHJ6KwTIUs92PKtxJ8KFXg1H3QVzY/SxhOxT6t4b7IcPcS
         4wwLzOqbzvQWhvQDgtYc/MH1DGP3WeUfTFOHUqZ9+GCn5h/6GAM1PHHx3WDSqf11hPZv
         nxcTgdim459CZ0eamUFzR0U8hgNlhEpinsoXM/mL4EAdmm1NtymZ7vhm8JhCxtJH8WK3
         VivA==
X-Gm-Message-State: APjAAAWEkHPfLwZJepJ/20WHmG+KBtel594K267N5x53ci3aXxJrdOat
        47Zmphp4e2zIHTovpIaJ4MZ9Wncilb4wNtT58iE/6Q==
X-Google-Smtp-Source: APXvYqwhpelqz1BD3Zaxd7qhMERDtnjDXuXuK5sCqGFKA0nX5yXFO0Qqv4/D7HsevTyPJjTlnid1ORnGa9dP/VZvId4=
X-Received: by 2002:a37:ba03:: with SMTP id k3mr83504125qkf.127.1578361533830;
 Mon, 06 Jan 2020 17:45:33 -0800 (PST)
MIME-Version: 1.0
References: <20191210195333.648018-1-arnd@arndb.de> <d739240f-aaa6-c310-9c68-16c1a08ce759@nvidia.com>
In-Reply-To: <d739240f-aaa6-c310-9c68-16c1a08ce759@nvidia.com>
From:   Curtis Malainey <cujomalainey@google.com>
Date:   Mon, 6 Jan 2020 17:45:22 -0800
Message-ID: <CAOReqxh9wamuKQnjPqUsZS_=4xUbsy-Y3v+=OXGaWV5EuONPmA@mail.gmail.com>
Subject: Re: [PATCH] ASoC: rt5677: add SPI_MASTER dependency
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Ben Zhang <benzh@chromium.org>,
        Curtis Malainey <cujomalainey@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        KaiChieh Chuang <kaichieh.chuang@mediatek.com>,
        ALSA development <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 3:00 AM Jon Hunter <jonathanh@nvidia.com> wrote:
>
>
> On 10/12/2019 19:52, Arnd Bergmann wrote:
> > When CONFIG_SPI is disabled, the newly added code for the DSP
> > firmware loading fails to link:
> >
> > ERROR: "rt5677_spi_hotword_detected" [sound/soc/codecs/snd-soc-rt5677.ko] undefined!
> > ERROR: "rt5677_spi_write" [sound/soc/codecs/snd-soc-rt5677.ko] undefined!
>
> Would it be better if the above functions or the functions that call
> these are conditional on CONFIG_SND_SOC_RT5677_SPI?
>
> > Add a dependency to prevent this configuration.
> >
> > Note: the does not work with the DT probing, as there is no binding
>
> Are you missing 'SPI' or something here?
>
> > for the SPI half of the driver, but nothing seems to be using that
> > with the mainline kernel anyway.
>
> From a Tegra perspective, given that we don't use SPI in conjunction
> with the rt5677 codec, only I2C so far, I am not sure we should make the
> tegra_rt5677 driver dependent upon it. We should be able to operate
> without the SPI bits enabled.
>
There should be no changes needed for tegra, this should be isolated
to the bdw machine driver. The only things added to the machine driver
were some dai links.
> Cheers
> Jon
>
> --
> nvpublic
