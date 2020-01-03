Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B6BC3276E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 00:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E436222C3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 00:21:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KzOw1b7W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbgACAVG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 19:21:06 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54172 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgACAVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 19:21:06 -0500
Received: by mail-wm1-f68.google.com with SMTP id m24so7057087wmc.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 16:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PRPBkou+uS1zWNSOaxrecr/7LWg1sY/IJLNmSa72PP0=;
        b=KzOw1b7W+dgKGAThSM9EsvLpjbfAF32G6nByR78jmSLIj8CsDCnVA+3qESaq9lo/Mz
         tlp9GPLePItxsfN3nNTGPHtReAGQMwMxGwKDT8ZOpX1rOSgrWQte8t5TFTPm7CjZRVld
         MghGWqE/AP95QTb63M2Vc9Uh0tOBGjV4KG2So=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PRPBkou+uS1zWNSOaxrecr/7LWg1sY/IJLNmSa72PP0=;
        b=svhVi7kRJ6njD7MfIGjQeYzj/SUBpHi6e+E+tF+ZpiFEX0eY/k7bW8lSCxlUZiPNQr
         wZ4wd7Lo8fc07ozreOqNaPabXPbE5CfiAHR52A0EpEY6pKkS5Yc6pofYS2HUOE1Q9tsh
         E8qXf+uzjVPK1yYwwEK4nrZlRjhaPQXShNPpJ5Vo8EHxNBKRS81biiL/nNav5qxhWdQJ
         8NP8g7mOUCdRDgAKWTfbPfna+TtDF0QQ3dJPL2x8+gF2GUzJf89Q9LE68PDUnb3MZ0f/
         B4L+yaF/b20vucU8UkYNUv7hr3/ZvoH3zP9QtLpZtyR9HRkwDiXsW2vTZpENX96mk3Qx
         7xDg==
X-Gm-Message-State: APjAAAU4NJkUlI0mIl0u6vrrcRn2MUopNzLTCLpIYtnGIsAvpMYy+HQV
        o0sPxfS9hvB/dMmuBceesFEweppintvQck/gqTap8A==
X-Google-Smtp-Source: APXvYqx/ci/jx8coSHWX+oaIRR3IFz+Cjzk8IQk58kJAwAjteJC9NLM2626yzxODf7N/9szk6OapKxvCqzDrMEwxIGc=
X-Received: by 2002:a1c:7715:: with SMTP id t21mr15944147wmi.149.1578010864658;
 Thu, 02 Jan 2020 16:21:04 -0800 (PST)
MIME-Version: 1.0
References: <20200102112558.1.Ib87c4a7fbb3fc818ea12198e291b87dc2d5bc8c2@changeid>
 <a7ab606a-1e35-29aa-ea60-7c31374eb7b4@linux.intel.com>
In-Reply-To: <a7ab606a-1e35-29aa-ea60-7c31374eb7b4@linux.intel.com>
From:   Sam McNally <sammc@chromium.org>
Date:   Fri, 3 Jan 2020 11:20:27 +1100
Message-ID: <CAJqEsoDxuKs7EufU-FwZzkipgw7dXpP1=7nSDqOy2oNB4hq6fg@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: Intel: sof_rt5682: Ignore the speaker
 amp when there isn't one.
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        alsa-devel@alsa-project.org,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sathya Prakash M R <sathya.prakash.m.r@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jairaj Arava <jairaj.arava@intel.com>,
        Xun Zhang <xun2.zhang@intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Jan 2020 at 08:18, Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
>
>
> On 1/1/20 6:28 PM, Sam McNally wrote:
> > Some members of the Google_Hatch family include a rt5682, but not a
> > speaker amp. When a speaker amp is also present, it matches MX98357A
> > as well, resulting in the quirk_data field in the snd_soc_acpi_mach
> > being non-null. When only the rt5682 is present, quirk_data is left
> > null.
>
> Sorry, I don't get this last sentence.
>
> There is a single entry for 10EC5682 in sound-acpi-intel-glk-match.c and
> quirk_data is assigned - thus can never be NULL.
>
> I wonder if your Chrome kernel has an extra entry in
> snd_soc_acpi_intel_glk_machines[] ? What I am missing?
>

I was referring to the duplicate 10EC5682 entries in
snd_soc_acpi_intel_cml_machines[]. Sorry for the confusion. I'll send
a new version with those details in the description.

> >
> > The sof_rt5682 driver's DMI data matching identifies that a speaker amp
> > is present for all Google_Hatch family devices. Detect cases where there
> > is no speaker amp by checking for a null quirk_data in the
> > snd_soc_acpi_mach and remove the speaker amp bit in that case.
> >
> > Signed-off-by: Sam McNally <sammc@chromium.org>
> > ---
> >
> >   sound/soc/intel/boards/sof_rt5682.c | 9 ++++++++-
> >   1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
> > index ad8a2b4bc709..8a13231dee15 100644
> > --- a/sound/soc/intel/boards/sof_rt5682.c
> > +++ b/sound/soc/intel/boards/sof_rt5682.c
> > @@ -603,6 +603,14 @@ static int sof_audio_probe(struct platform_device *pdev)
> >
> >       dmi_check_system(sof_rt5682_quirk_table);
> >
> > +     mach = (&pdev->dev)->platform_data;
> > +
> > +     /* A speaker amp might not be present when the quirk claims one is.
> > +      * Detect this via whether the machine driver match includes quirk_data.
> > +      */
> > +     if ((sof_rt5682_quirk & SOF_SPEAKER_AMP_PRESENT) && !mach->quirk_data)
> > +             sof_rt5682_quirk &= ~SOF_SPEAKER_AMP_PRESENT;
> > +
> >       if (soc_intel_is_byt() || soc_intel_is_cht()) {
> >               is_legacy_cpu = 1;
> >               dmic_be_num = 0;
> > @@ -663,7 +671,6 @@ static int sof_audio_probe(struct platform_device *pdev)
> >       INIT_LIST_HEAD(&ctx->hdmi_pcm_list);
> >
> >       sof_audio_card_rt5682.dev = &pdev->dev;
> > -     mach = (&pdev->dev)->platform_data;
> >
> >       /* set platform name for each dailink */
> >       ret = snd_soc_fixup_dai_links_platform_name(&sof_audio_card_rt5682,
> >
