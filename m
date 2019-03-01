Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE45FC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 17:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7FC520818
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 17:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dSg0PDlA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388176AbfCAR3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 12:29:12 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39054 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbfCAR3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 12:29:11 -0500
Received: by mail-ot1-f67.google.com with SMTP id e15so12059463otk.6
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 09:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YNzUlcboXEK2HdayycemQ+DLo43k1a8lwu4tdJryPoU=;
        b=dSg0PDlA6P5MMQ+jekn5xwLDWY6ItKEvK1wPMYnY4EBnJyEMX/an5sY5bK/87i6CSx
         vfXBq7Nxb9CVPZhq386djlljxjvzghpGhYLYbOoWwQA680khCUK/uZ5ajOQKSTpvFK08
         4X3NazcxzKi6I0+NPp3fOK0Vf5DtL2dZqtVQ2UPb0xalDZmYcd4vBW+ml2nAjtud27mT
         A3OKGdxj4lbj9s4ABuAjA/1Uq/pYgXf3NwYpqkL7T9outbOXOZW/JPNMeIWqn5E1d9qn
         8SW1pHVYFtznPFXrPZb6UD5asm1+P0CaUQjB4JOSbUCdzuKfqS9wGw2nyMcF0jBPBLUi
         ry3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YNzUlcboXEK2HdayycemQ+DLo43k1a8lwu4tdJryPoU=;
        b=AkLMWuRPU6CE9odEederXyQu3ySD34IR1mCzZKiQ7AcqRrxzAnIwbgrysfnX5gpW9O
         kzyKYpE4yNXS48Jqbk8YMwGH/FTmKEUqOsqzIkKhvYj6VSyYdagtFdhJ9gD++PkDLOU+
         jaRXRbo2SFRFFp71orpXV0JUwYbePVrG7EzndsWr/mwt+lhESIseaN9iCMBKgwqfZavE
         CwXCAvmUps+1vUiEIP10FS8BZWXhcdbQf/OyELKlhrnC9I2kGs5C7UMCN+DcW+I6R80S
         W++MD1jt2r/oOiQQ9oJIi9uM2VGA/tNId7yKi0XcXihFFElMPeKX99THIFF/ZsLwbsry
         SaXA==
X-Gm-Message-State: APjAAAXOL9N4mkmWwBOO5XXZ61+2J2124P6gJlSA/xYIM5T0kQ3IpghN
        betMfTNfDThz9dekll/2fJmDUSpNCKDFs+LexIbxiQ==
X-Google-Smtp-Source: APXvYqz0paXgp3p81rVSzUtWTG/gfIuQ9YeFvx+xNiHRxtl8cLaGe6m6FYWJt6D5Nr8ZNuecmD8dUQthG/L9/1WVsq4=
X-Received: by 2002:a9d:644c:: with SMTP id m12mr4136883otl.59.1551461350137;
 Fri, 01 Mar 2019 09:29:10 -0800 (PST)
MIME-Version: 1.0
References: <bbc0d37a-5a08-9ce0-58b6-c89d28c558ce@nvidia.com>
In-Reply-To: <bbc0d37a-5a08-9ce0-58b6-c89d28c558ce@nvidia.com>
From:   Curtis Malainey <cujomalainey@google.com>
Date:   Fri, 1 Mar 2019 09:28:59 -0800
Message-ID: <CAOReqxhYUASVFdrHzKEr8F_NA0CNnJ1Hx51L4ganvcrK=dSCCA@mail.gmail.com>
Subject: Re: Regression: ASoC: soc-core: clear platform pointers on error
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Curtis Malainey <cujomalainey@chromium.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 1, 2019 at 4:07 AM Jon Hunter <jonathanh@nvidia.com> wrote:
>
> Hi Mark, Curtis,
>
> I am seeing a regression on -next where the soundcard on one of our
> Tegra boards fails to initialise following a probe deferral. The bisect
> points to the commit 78a24e10cd94420f1b4e2dc5923ae7109e2aaba1 ('ASoC:
> soc-core: clear platform pointers on error') and reverting this on top
> of -next fixes the problem.
>
> Looking at the bootlog from the failure I see ...
>
>  tegra-snd-wm8903 sound: ASoC: failed to init link WM8903
>
>  tegra-snd-wm8903 sound: snd_soc_register_card failed (-517)
>
>  tegra30-i2s 70080400.i2s: DMA channels sourced from device 70080000.ahub
>
>  tegra-snd-wm8903 sound: ASoC: Both platform name/of_node are set for WM8903
>
>  tegra-snd-wm8903 sound: ASoC: failed to init link WM8903
>
>  tegra-snd-wm8903 sound: snd_soc_register_card failed (-22)
>
>  tegra-snd-wm8903: probe of sound failed with error -22
>
>
> With the above change I see soc_cleanup_platform() is ever being called
> when the probe is deferred and hence leads to the failure. Note that the
> initial failure, "ASoC: failed to init link WM8903" occurs very early
> in snd_soc_register_card() when initialising the prelinks.
>
> The following fixes it, but I have not scrutinised the code to see if
> there are other exit points that we need to handle.
>
You are indeed correct. That should be there. I think I got confused
when I was doing my initial debugging on our local 4.19 kernel as the
cleanup code had changed when I was testing on -next and forgot to add
this to my upstream patch and it wasn't caught in my testing. Thanks
for catching this. I went back and looked and it appears that is the
only call to soc_init_dai_link that is outside soc_instantiate_card
and therefore not caught by the original patch's cleanup routine. Do
you want to submit a patch and I'll add my signoff?
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index 93d316d5bf8e..6f66beb0c3ae 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -2797,6 +2797,7 @@ int snd_soc_register_card(struct snd_soc_card *card)
>
>                 ret = soc_init_dai_link(card, link);
>                 if (ret) {
> +                       soc_cleanup_platform(card);
>                         dev_err(card->dev, "ASoC: failed to init link %s\n",
>                                 link->name);
>                         mutex_unlock(&client_mutex);
>
> Cheers
> Jon
>
> --
> nvpublic
