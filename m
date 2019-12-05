Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875EFC2D0BF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 09:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 564C324654
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 09:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="apWsFOaY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbfLEJSP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 04:18:15 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36546 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728892AbfLEJSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 04:18:14 -0500
Received: by mail-wr1-f66.google.com with SMTP id z3so2582619wru.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 01:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7eqArs22c9d5V0kudwDe/vJo1J0LOw5HZJLmQ+GRMlY=;
        b=apWsFOaYx2/LRv6H1kjakHWNqgZnBqe0eRo+BvInhlLVplGHmn8e4I2JkeVelsFthJ
         3pIz0Jr9VZ91ebSm0/7+FUUIqGE1UGMHxKlRMd1nJEx8U9Kt4nNQFX2V0ly+e7n0ce+h
         SZPwY1cf8t+10GB0ydsoUxDkQwwpFFwIaLeee40Z87ARYrcLyJFDV4WOhhV+UJmepU5A
         uzmB3E9/puNEEhRritoGxiAb06wgEgZQPrffPcIeBeSGOt3MZgAXxOy4gSt4L/dgHRmZ
         1ZpiGiu+TxrXSv23qoCYlEY7ALPVOQUCfXe9MKdEob63CjeuIC+crELEZ3JYDEbYmNcX
         pskA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7eqArs22c9d5V0kudwDe/vJo1J0LOw5HZJLmQ+GRMlY=;
        b=rCKv1NesJWUXl6sKj+O2PXkL8tIEjx59/mJPaZQGaQfuN6+pPughUc2IsqHNEOaXHO
         jOVzz3U/ySAFbfYTXl0zPAc7FhoZraC5dE3E1mrUow2sFj1xe4TH1aHFUEVtcZocNEq1
         QlxRkYckaUdSMEdLgp7Lk+fQ6Zk+U9B393bAHXqS4J2BuEd4PjO+lF8NPNHr1bZywtWU
         Bbjatde80PD/THSPVYdSAjT1VV4eYIrLKKHf9FBJcA2A0uPzyzi+2oTKcbktQzRNvwb+
         hIstGtAcg/+xawiwS8gvdH8N2fp0ykO/T2A+BDBOZb+0fJpR/iA9E5NtTYv0QI8ws3Lt
         ARMA==
X-Gm-Message-State: APjAAAWxu6WypJeWiX+j5v7R9LKnlN2vSQ2PXlVaoCIZVS7BuVKmUXtS
        TIqLTL1KoigTs/gxux80nt0vG6zGrE1xpMnsUYo=
X-Google-Smtp-Source: APXvYqxIsng5JiXRsisnkQljkSc7ex9Uew97ul2dSVYXh/pFNfuJ80yJq0We9UFX3FZ2awdxjGnvDlqsi99Yo0rGgx0=
X-Received: by 2002:a5d:4b4e:: with SMTP id w14mr8662439wrs.187.1575537492732;
 Thu, 05 Dec 2019 01:18:12 -0800 (PST)
MIME-Version: 1.0
References: <20191204151333.26625-1-daniel.baluta@nxp.com> <CAFQqKeXG3ihj67L+KgKZW=Cp6ipJC18wUVci3hGTMutBv4boZw@mail.gmail.com>
 <82095ea8-fa9a-5c67-e0e6-1a886dfc4b0e@linux.intel.com>
In-Reply-To: <82095ea8-fa9a-5c67-e0e6-1a886dfc4b0e@linux.intel.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Thu, 5 Dec 2019 11:18:01 +0200
Message-ID: <CAEnQRZCL-VPNbLozd2PnySmfNXYdJYWC-wx6PaznHqjO0OUZ0A@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: soc-core: Set dpcm_playback / dpcm_capture
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     "Sridharan, Ranjani" <ranjani.sridharan@intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Pierre-louis Bossart <pierre-louis.bossart@intel.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 5, 2019 at 6:11 AM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
>
>
> On 12/4/19 5:29 PM, Sridharan, Ranjani wrote:
> > On Wed, Dec 4, 2019 at 7:16 AM Daniel Baluta <daniel.baluta@nxp.com> wrote:
> >
> >> When converting a normal link to a DPCM link we need
> >> to set dpcm_playback / dpcm_capture otherwise playback/capture
> >> streams will not be created resulting in errors like this:
> >>
> >> [   36.039111]  sai1-wm8960-hifi: ASoC: no backend playback stream
> >>
> >> Fixes: a655de808cbde ("ASoC: core: Allow topology to override machine
> >> driver FE DAI link config")
> >> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> >> ---
> >>   sound/soc/soc-core.c | 2 ++
> >>   1 file changed, 2 insertions(+)
> >>
> >> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> >> index 977a7bfad519..f89cf9d0860c 100644
> >> --- a/sound/soc/soc-core.c
> >> +++ b/sound/soc/soc-core.c
> >> @@ -1872,6 +1872,8 @@ static void soc_check_tplg_fes(struct snd_soc_card
> >> *card)
> >>
> >>                          /* convert non BE into BE */
> >>                          dai_link->no_pcm = 1;
> >> +                       dai_link->dpcm_playback = 1;
> >> +                       dai_link->dpcm_capture = 1;
> >>
> > Hi Daniel,
> >
> > Typically, for Intel platforms, this information comes from the machine
> > driver and there are some DAI links that have either playback or capture
> > set. But this change would set both for all DAI links.
> > Not sure if this is the right thing to do.
>
> I am with Ranjani, I don't get why we'd set the full-duplex mode by
> default. but to be honest I never quite understood what this code is
> supposed to do...

Indeed I need to figure out when exactly to enable playback/capture. I
was hoping
Liam will chime in, as this was in the original patch he sent months ago.
