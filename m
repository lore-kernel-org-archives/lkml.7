Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4DE8C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 731A420840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7OgvY7L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfCGPWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 10:22:11 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41181 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfCGPWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 10:22:10 -0500
Received: by mail-ed1-f67.google.com with SMTP id x7so13775058eds.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 07:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OH1+4LcBj06RcAtfzMYBSlC6+Qd57B9iZTps1DUx5dk=;
        b=h7OgvY7LGEGkdi1fIqi/P4NXg1BEcWBfJUqKdsk2bE0M3I1O8IA0HEGc/Y9r76hqwe
         yvec4osySaNU45RxKBoC4Wc3aMwGbs3p4jAVaSKN9K0y0nJ93tMgANltCalA95jVEbHg
         VnQkA9rAiyAxAlVn8zJ/eorhhFF3nJn25TlPJ3Tnb1EZEjUb9uvsL5UkEwHsoXivGaov
         F8+Y+1fGbatEajATiHT3regHkad/tbD1H/0g5yRKKDoWipdoBWZ2uNM1987EeOgvomRi
         mxWHsq9gtBId74z6x+OehNuA79LbusKHeMBosIbLwq1lgvDlmQHq0vDjkxftGsAn+AMi
         Dmww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OH1+4LcBj06RcAtfzMYBSlC6+Qd57B9iZTps1DUx5dk=;
        b=nQo+iflTrrwrTCVlulHJUxgrSzSv88lebcXte52/fhpMu7w3zEfQsdFzLRTjv/FVAt
         VManjInnSp11MPZb8sSNSOmu5b0/OezGcnNt1nH0pW/ho+5EfBX2mSVsCcC+WYL/s8BW
         9424cVmIWQsvl8biegXr+XWpE/LGH/MbKYwYI/GUQ/RSkDjECahIVk0eQNpo6COCcxG7
         9Vh++p3MDxSsTJA/rI6qo07r70qOiCX343cp8JCqp4rDdI36LJGq2uHkuj7Uza5mnbX8
         D7j3Uj3U3yT0lq19YGu7D9sI28ejCRyaoVaTQakdDR+FQB8MrPHhsH3FkTaclEl14xI+
         zgig==
X-Gm-Message-State: APjAAAX8ATWYETXnjVar0q7SfQrSEJfCUiA13sYTkUP5Zb2viGtlLpkX
        z6WgatTO5IZl2Fd2MFOxO+Y=
X-Google-Smtp-Source: APXvYqxVyKM56NQU41LGrKs5wKe2GXv8jmoo58rV+ezEwFmSNGo/tYiyLfGoYHptXEkp1RSnbQoLHw==
X-Received: by 2002:a50:82c7:: with SMTP id 65mr28946906edg.7.1551972128585;
        Thu, 07 Mar 2019 07:22:08 -0800 (PST)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id p44sm1403031edc.1.2019.03.07.07.22.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 07 Mar 2019 07:22:08 -0800 (PST)
Date:   Thu, 7 Mar 2019 08:22:06 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Tony Lindgren <tony@atomide.com>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: ams-delta: remove duplicate 'const'
Message-ID: <20190307152206.GF20201@archlinux-ryzen>
References: <20190307101101.613881-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307101101.613881-1-arnd@arndb.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 11:10:49AM +0100, Arnd Bergmann wrote:
> clang points out that SOC_ENUM_SINGLE_EXT_DECL() contains a 'const'
> modifier already, so adding another one does not make it more const:
> 
> sound/soc/ti/ams-delta.c:203:14: error: duplicate 'const' declaration specifier [-Werror,-Wduplicate-decl-specifier]
> static const SOC_ENUM_SINGLE_EXT_DECL(ams_delta_audio_enum,
>              ^
> include/sound/soc.h:351:2: note: expanded from macro 'SOC_ENUM_SINGLE_EXT_DECL'
>         const struct soc_enum name = SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(xtexts), xtexts)
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
>  sound/soc/ti/ams-delta.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/ti/ams-delta.c b/sound/soc/ti/ams-delta.c
> index 4dce494dfbd3..b9611db14c86 100644
> --- a/sound/soc/ti/ams-delta.c
> +++ b/sound/soc/ti/ams-delta.c
> @@ -200,7 +200,7 @@ static int ams_delta_get_audio_mode(struct snd_kcontrol *kcontrol,
>  	return 0;
>  }
>  
> -static const SOC_ENUM_SINGLE_EXT_DECL(ams_delta_audio_enum,
> +static SOC_ENUM_SINGLE_EXT_DECL(ams_delta_audio_enum,
>  				      ams_delta_audio_mode);
>  
>  static const struct snd_kcontrol_new ams_delta_audio_controls[] = {
> -- 
> 2.20.0
> 
