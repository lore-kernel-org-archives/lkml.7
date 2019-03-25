Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B05C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 15:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A34AB20896
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 15:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729427AbfCYPmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 11:42:07 -0400
Received: from mail1.perex.cz ([77.48.224.245]:33362 "EHLO mail1.perex.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbfCYPmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 11:42:06 -0400
X-Greylist: delayed 397 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Mar 2019 11:42:05 EDT
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 1C7AEA0040;
        Mon, 25 Mar 2019 16:35:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 1C7AEA0040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1553528127; bh=ArdR1bWGLqLRpQ1UHn68TtXN7V2LypRqM23CXi3SprU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=vsI3ReodvI9uyFojLoDuRYKlUD6ahw11QrpyTQN8XeoU7Yhkt56L/2kRO21fncyKr
         dKsfLiQE83GRy+gTleZf/joELPIwBSw06NJsdyFMkepK75chNd4OGVSdURDTJYuFqk
         4cvrcm6NlFdq8rEvvrcb4KlQHy6pdVmdGeC5yf9k=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Mon, 25 Mar 2019 16:35:21 +0100 (CET)
Subject: Re: [PATCH] ALSA: aloop: Support S24 sample formats
To:     twischer@de.adit-jv.com, patch@alsa-project.org,
        broonie@kernel.org, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <1553526854-16921-1-git-send-email-twischer@de.adit-jv.com>
From:   Jaroslav Kysela <perex@perex.cz>
Message-ID: <5e015489-8705-0aa4-dfde-78854a49f6be@perex.cz>
Date:   Mon, 25 Mar 2019 16:35:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <1553526854-16921-1-git-send-email-twischer@de.adit-jv.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne 25. 03. 19 v 16:14 twischer@de.adit-jv.com napsal(a):
> From: Timo Wischer <twischer@de.adit-jv.com>
> 
> Currently snd_aloop supports only S16 and S32 audio sample formats. With
> this patch the S24 formats are also supported.

Reviewed-by: Jaroslav Kysela <perex@perex.cz>

> 
> Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>
> ---
>  sound/drivers/aloop.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
> index 8c3fbe1..c14e57b 100644
> --- a/sound/drivers/aloop.c
> +++ b/sound/drivers/aloop.c
> @@ -337,7 +337,7 @@ static int loopback_prepare(struct snd_pcm_substream *substream)
>  
>  	loopback_timer_stop_sync(dpcm);
>  
> -	salign = (snd_pcm_format_width(runtime->format) *
> +	salign = (snd_pcm_format_physical_width(runtime->format) *
>  						runtime->channels) / 8;
>  	bps = salign * runtime->rate;
>  	if (bps <= 0 || salign <= 0)
> @@ -562,6 +562,8 @@ static const struct snd_pcm_hardware loopback_pcm_hardware =
>  			 SNDRV_PCM_INFO_MMAP_VALID | SNDRV_PCM_INFO_PAUSE |
>  			 SNDRV_PCM_INFO_RESUME),
>  	.formats =	(SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S16_BE |
> +			 SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S24_BE |
> +			 SNDRV_PCM_FMTBIT_S24_3LE | SNDRV_PCM_FMTBIT_S24_3BE |
>  			 SNDRV_PCM_FMTBIT_S32_LE | SNDRV_PCM_FMTBIT_S32_BE |
>  			 SNDRV_PCM_FMTBIT_FLOAT_LE | SNDRV_PCM_FMTBIT_FLOAT_BE),
>  	.rates =	SNDRV_PCM_RATE_CONTINUOUS | SNDRV_PCM_RATE_8000_192000,
> 


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
