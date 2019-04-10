Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D2D2C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 14:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C19F20850
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 14:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RzqOWIHn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732784AbfDJObd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 10:31:33 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34752 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732287AbfDJObc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 10:31:32 -0400
Received: by mail-wr1-f66.google.com with SMTP id p10so3271752wrq.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 07:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=inqH56thPQns2gYU55Pfm2TdtYzRz36XkF9DqtyRfNk=;
        b=RzqOWIHn4FItHDLOeE/3u3Jiyb0HP4J7ZYX+MDVE+HrjVJDZT26oQ+ctOMnOG0eu3w
         iZ3GqWOpbjnG5qpoULJH6fWYLWHDrZ1Xi159YsFQORilZn+ynDj17S+TwHyc9ZHZ2uX5
         JyPisD3aXTdo/NRz4fF/4gBXBc3/UIJCj78sOxzSiXLZafoAd3XteKKmLNkGXtzzpFUn
         tksCk7GsK2rWrGFP88OBIjZCWuIBM4r9cY2I6R3FHdO3lnpFHnDNrkadctaw2+lKi5o+
         2W6fsgNbI3lMJJLDk+FmjZbJoG0uUMcfDThv5bT0em0c1B7C2qwiRboPTmKognRCLzoM
         kfKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=inqH56thPQns2gYU55Pfm2TdtYzRz36XkF9DqtyRfNk=;
        b=oB7tGyk5eAUT0IBXeql/OS5kzRcCH3gh1mplrzDwekSrXPqLZRYhbn8RXwlzlprfYz
         bdT2eyCHRNRrAtRTZea9sQRvPG3T8nB1wnEl7XC7w/tLCEcv33MbYBJT3k/m8Hegn4HK
         UBJbSlULxc1/Y5dMs0cfBZKM2TaJKprmC1mMC+Sc/ZHYy/SsBTYMwZR8CjdsCDz4/JiR
         SRBRG86gSIh7f5fS56BrAYLcoafmgdg0Wog5Ee+3NUjzvTx4EC6/1U7Kogkav8FxX3f7
         pp+mNu4xKA5LqumQSBjM2DlZS8enY4YqR7zdCrXxju3XZ2MLmUP5l7LgKtkxlgGcKefa
         WbYw==
X-Gm-Message-State: APjAAAUAnUsszOR5zoYs8aQgCnZpnNM3Zp7Cg9S/25hvYH+8+LpHJ8Y2
        DexgEdcMnnX8uFa5l3e0+0/bjQ==
X-Google-Smtp-Source: APXvYqxrRtjmt4VBBnPBCLoqfR6JV5cyO5Q4M3OB90bwjpYuJKNTwS+WvcwyJwqJHyHAv6g9RVMSoQ==
X-Received: by 2002:a05:6000:14a:: with SMTP id r10mr7790708wrx.107.1554906690806;
        Wed, 10 Apr 2019 07:31:30 -0700 (PDT)
Received: from [192.168.86.29] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id y1sm103533433wrd.34.2019.04.10.07.31.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 07:31:29 -0700 (PDT)
Subject: Re: [PATCH] ASoC: wcd9335: Fix missing regmap requirement
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org,
        Arnd Bergmann <arnd@arndb.de>
References: <8c0b22e2-2c67-8d45-a57d-dfc54043fbc9@free.fr>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <da5f1653-c668-f587-8fcf-69965f082ea7@linaro.org>
Date:   Wed, 10 Apr 2019 15:31:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <8c0b22e2-2c67-8d45-a57d-dfc54043fbc9@free.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/04/2019 15:23, Marc Gonzalez wrote:
> wcd9335.c: undefined reference to 'devm_regmap_add_irq_chip'
> 
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> ---

Thanks for Fix,

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

>   sound/soc/codecs/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
> index 419142111b6d..33778dc99108 100644
> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -1162,6 +1162,7 @@ config SND_SOC_WCD9335
>   	tristate "WCD9335 Codec"
>   	depends on SLIMBUS
>   	select REGMAP_SLIMBUS
> +	select REGMAP_IRQ
>   	help
>   	  The WCD9335 is a standalone Hi-Fi audio CODEC IC, supports
>   	  Qualcomm Technologies, Inc. (QTI) multimedia solutions,
> 
