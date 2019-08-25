Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29115C3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 17:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06F2820578
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 17:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbfHYRiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 13:38:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52996 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727077AbfHYRiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 13:38:19 -0400
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 200954E924
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2019 17:38:19 +0000 (UTC)
Received: by mail-ed1-f71.google.com with SMTP id f11so8255723edn.9
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2019 10:38:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CK1a23hD4lHdM/UHCYL3dWOeCp7ea2G2doEW1IlG12o=;
        b=rMAdH955d1QEcX86lJM6r748SXqzk3WXOBVjTQ0OwyVggcuCbbrv5iN5fhBRHqTA91
         tKM2NWwKAR2oUb9mU9cx/KWEeoEj/WYNtU71HX+7ukboJw5s6O/4OmW7mswvDiKPS7Hm
         0b0JykbptQV3RaIIreLTfXmD3KovSF1US2QtZ7pwcT9Egw0RMKIEJW9K78mRHLS7BFZJ
         pBrkWp943BsliBpgjWzS0wm5rRsijXCoblCexyUl1a6g9mC9wJS32YwZLgxLrlGMvdLP
         dgMP9iRLRd15IzbBJnXl7wIaJOzXtgZ1gCISG6RZSoso9pWU6Tez1pSalqYuBLmwhqiz
         fNZA==
X-Gm-Message-State: APjAAAU+GO8uWJtnnYmzldzFI9ljOccZbT94hsq3hvRF6tbXNFdK0k+M
        5wL/RQ0mgyp1+j2eEQfyCssfkKl5wJRbjg72NBTFMSxK7FKHzhFD+6HpEV0aSG2PuT3N7y5CaaN
        G34erBVbxGHU8PngyQjWySHXE
X-Received: by 2002:a50:f05a:: with SMTP id u26mr14914556edl.116.1566754697636;
        Sun, 25 Aug 2019 10:38:17 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy//Oidu64o3SogMsT7m8oHy4BJyX16GMS3wuS3JJc9u+iiQQPgmxOGqTa6iW0EjR/CbX4hXQ==
X-Received: by 2002:a50:f05a:: with SMTP id u26mr14914547edl.116.1566754697496;
        Sun, 25 Aug 2019 10:38:17 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id c15sm2459120ejs.17.2019.08.25.10.38.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Aug 2019 10:38:16 -0700 (PDT)
Subject: Re: [PATCH] ASoC: es8316: limit headphone mixer volume
To:     Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        Mark Brown <broonie@kernel.org>,
        David Yang <yangxiaohua@everest-semi.com>,
        Daniel Drake <drake@endlessm.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20190824210426.16218-1-katsuhiro@katsuster.net>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <943932bf-2042-2a69-c705-b8e090e96377@redhat.com>
Date:   Sun, 25 Aug 2019 19:38:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190824210426.16218-1-katsuhiro@katsuster.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 24-08-19 23:04, Katsuhiro Suzuki wrote:
> This patch limits Headphone mixer volume to 4 from 7.
> Because output sound suddenly becomes very loudly with many noise if
> set volume over 4.
> 
> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>

Higher then 4 not working matches my experience, see this comment from
the UCM file: alsa-lib/src/conf/ucm/codecs/es8316/EnableSeq.conf :

# Set HP mixer vol to -6 dB (4/7) louder does not work
cset "name='Headphone Mixer Volume' 4"

Limiting this to the actual working range at the kernel level seems
sensible:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>   sound/soc/codecs/es8316.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/es8316.c b/sound/soc/codecs/es8316.c
> index 8dfb5dbeebbf..bc4141e1eb7f 100644
> --- a/sound/soc/codecs/es8316.c
> +++ b/sound/soc/codecs/es8316.c
> @@ -91,7 +91,7 @@ static const struct snd_kcontrol_new es8316_snd_controls[] = {
>   	SOC_DOUBLE_TLV("Headphone Playback Volume", ES8316_CPHP_ICAL_VOL,
>   		       4, 0, 3, 1, hpout_vol_tlv),
>   	SOC_DOUBLE_TLV("Headphone Mixer Volume", ES8316_HPMIX_VOL,
> -		       0, 4, 7, 0, hpmixer_gain_tlv),
> +		       0, 4, 4, 0, hpmixer_gain_tlv),
>   
>   	SOC_ENUM("Playback Polarity", dacpol),
>   	SOC_DOUBLE_R_TLV("DAC Playback Volume", ES8316_DAC_VOLL,
> 
