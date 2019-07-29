Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64350C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31D202067D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aLXoYLOL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730222AbfG2Vse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 17:48:34 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39178 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbfG2Vsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 17:48:33 -0400
Received: by mail-pl1-f194.google.com with SMTP id b7so28057338pls.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 14:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mHb7K/quzh/o9A0rhyew79DzGwVBiK/JKWkURFhBbPg=;
        b=aLXoYLOL9bhkDKwRtYhOygieMGKXSKL7OIukbB5IHhN9BIlS95bKQZUqFFb32huu4N
         noBkyP1aNp6N+UNxp0EvxGURLyduEawdLwt7dMSZ3fye87lVjcqTeBgcdWeTWO0nGRyp
         8AlwzN7d0PZSga4djNARnHts+njcY0DCqcd14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mHb7K/quzh/o9A0rhyew79DzGwVBiK/JKWkURFhBbPg=;
        b=W244l1NXnRms8YakX63gG8zCN/Ca1Zu0IbwNlcsYcTVIQKztKdUTa3sP+3te2O/AUY
         Ua2pqRiAEdqZrDBD8wYEYJW7SMrQ1/SS7N1oOB73dNL48+hYBPV+RT1IPKbxl9VnQQrj
         HF7fYM2Mif0pDGLBEcYt4mjmC5HnTW+Xlat97XA7rpwGatV+jC+Jq/EPBeW4+XuvefM8
         cajqmEHbFcv9dEH77X3wl/u18YWOOw/cSkbHXadgGVmzDFSaTfN3BQWZ0lHlLru6gZo2
         bV10PUIP6GUP4rV+U3rTo/zCg6UQA8GM5/ckHVJdEVlhOkdXFnjv98soa/8LUBp1x9TO
         POeg==
X-Gm-Message-State: APjAAAWhPyx36FJjyCs19Wf5XqPyAMBZyGKsdiYE+xslH8RLv9D+G6jf
        tMqD9+Ia9t+MGiDBJli4E6qSOVl/k3A=
X-Google-Smtp-Source: APXvYqyX4/6lzKkOPc8+bZ/Wr8naVik9Xqd0hoI58Yfve8v7GAHab9WzvrM4B0ZwL294T52ZxlWhnA==
X-Received: by 2002:a17:902:2ac7:: with SMTP id j65mr113085915plb.242.1564436913282;
        Mon, 29 Jul 2019 14:48:33 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a3sm65759270pfi.63.2019.07.29.14.48.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jul 2019 14:48:32 -0700 (PDT)
Date:   Mon, 29 Jul 2019 14:48:31 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2] sound: dmasound_atari: Mark expected switch
 fall-through
Message-ID: <201907291448.E375AA59F@keescook>
References: <20190729205454.GA5084@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729205454.GA5084@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 03:54:54PM -0500, Gustavo A. R. Silva wrote:
> Mark switch cases where we are expecting to fall through.
> 
> This patch fixes the following warning (Building: m68k):
> 
> sound/oss/dmasound/dmasound_atari.c: warning: this statement may fall
> through [-Wimplicit-fallthrough=]:  => 1449:24
> 
> Notice that, in this particular case, the code comment is
> modified in accordance with what GCC is expecting to find.
> 
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
> Changes in v2:
>  - Update code so switch and case statements are at the same indent.
> 
>  sound/oss/dmasound/dmasound_atari.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/sound/oss/dmasound/dmasound_atari.c b/sound/oss/dmasound/dmasound_atari.c
> index 83653683fd68..823ccfa089b2 100644
> --- a/sound/oss/dmasound/dmasound_atari.c
> +++ b/sound/oss/dmasound/dmasound_atari.c
> @@ -1432,25 +1432,25 @@ static int FalconMixerIoctl(u_int cmd, u_long arg)
>  {
>  	int data;
>  	switch (cmd) {
> -	    case SOUND_MIXER_READ_RECMASK:
> +	case SOUND_MIXER_READ_RECMASK:
>  		return IOCTL_OUT(arg, SOUND_MASK_MIC);
> -	    case SOUND_MIXER_READ_DEVMASK:
> +	case SOUND_MIXER_READ_DEVMASK:
>  		return IOCTL_OUT(arg, SOUND_MASK_VOLUME | SOUND_MASK_MIC | SOUND_MASK_SPEAKER);
> -	    case SOUND_MIXER_READ_STEREODEVS:
> +	case SOUND_MIXER_READ_STEREODEVS:
>  		return IOCTL_OUT(arg, SOUND_MASK_VOLUME | SOUND_MASK_MIC);
> -	    case SOUND_MIXER_READ_VOLUME:
> +	case SOUND_MIXER_READ_VOLUME:
>  		return IOCTL_OUT(arg,
>  			VOLUME_ATT_TO_VOXWARE(dmasound.volume_left) |
>  			VOLUME_ATT_TO_VOXWARE(dmasound.volume_right) << 8);
> -	    case SOUND_MIXER_READ_CAPS:
> +	case SOUND_MIXER_READ_CAPS:
>  		return IOCTL_OUT(arg, SOUND_CAP_EXCL_INPUT);
> -	    case SOUND_MIXER_WRITE_MIC:
> +	case SOUND_MIXER_WRITE_MIC:
>  		IOCTL_IN(arg, data);
>  		tt_dmasnd.input_gain =
>  			RECLEVEL_VOXWARE_TO_GAIN(data & 0xff) << 4 |
>  			RECLEVEL_VOXWARE_TO_GAIN(data >> 8 & 0xff);
> -		/* fall thru, return set value */
> -	    case SOUND_MIXER_READ_MIC:
> +		/* fall through - return set value */
> +	case SOUND_MIXER_READ_MIC:
>  		return IOCTL_OUT(arg,
>  			RECLEVEL_GAIN_TO_VOXWARE(tt_dmasnd.input_gain >> 4 & 0xf) |
>  			RECLEVEL_GAIN_TO_VOXWARE(tt_dmasnd.input_gain & 0xf) << 8);
> -- 
> 2.22.0
> 

-- 
Kees Cook
