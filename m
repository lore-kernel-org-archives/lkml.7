Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248B5C28D1D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 12:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F272F20657
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 12:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xlVPpLHF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbfFFMRs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 08:17:48 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39148 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbfFFMRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 08:17:47 -0400
Received: by mail-wm1-f67.google.com with SMTP id z23so2194490wma.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 05:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=azkuI4+MWwGW5E0d5xwZ4dlYelhXqH8PmCOhVxLXrWY=;
        b=xlVPpLHFONV8DhQiGCaJ3qmDH1rm9bj0FTTQwPZSr274qwc7bZzfMkx/ha5oe0YSNY
         ylk4PNuYpQKWzgR6XcFPrGgtpbU3C/lFS7voccxf5zTI4oCcKWKF52nxgAEZ6yg/g+wd
         pJa9SQQlHY/uiC/oMm7HP9Ikkr7nn7lxD1giEOK6h0xVKxf+D/lC5JGfMAtl1OUXFVnz
         gV4xiEdBG66sTU2W/Pgat5pHBTllcGNLANuF6CsKCsPTQ6A4KWcfIm8FjXr53VGTsoac
         SS5c84fRfiAKlDk3KB2P12u/73eumWsEE2p3TDsDbQL00yRcz75mOLXtg4FFPFAhskD8
         K+HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=azkuI4+MWwGW5E0d5xwZ4dlYelhXqH8PmCOhVxLXrWY=;
        b=qiNaEpl2cF8Cu0S3li2GVXHpn8i7NlRWbdBhqxMRMTMS7Staf/yfUkhwj8w6zirDz8
         Shewmieziih/gAMxPd7z4OVNIHR4PT6gG3hirTE6uSIHXZG46EJ+kaZ4HvJxURc2eV5a
         ce0VUEy07VM2ZehfbCl/u6d8hy0pncNTeB/rglfAoHiFE4uT4dr7f8ef3Y2a7PggpUOS
         VXyFXHqtDbu/Oim4Z34SWyRdvFPn4kG9HgBagUN9DGMF3IVZArT+d2WXlJz+wBx+Gyc3
         Q0N3neoEkimyDh4pYjztyx+8m8vFrJZ0bsA+LK+ZA21Yq54RPqc21dtmxGYewC8P6RQ2
         QSnA==
X-Gm-Message-State: APjAAAVL+22CrUI7sFwxQPgXe6Xmbyl/OI3BttruedG3RSWGrc1RD1OT
        s1qhznzvxckCCTao+Qci/Lng4ARdLrpV+A==
X-Google-Smtp-Source: APXvYqwH/jszr4uALTkdlP+mnNr+rdHckw2wtCQBCkO2GqlxRaBueq8W+FcZFLpUVxdLNwrsnFC18Q==
X-Received: by 2002:a1c:99c9:: with SMTP id b192mr15555072wme.142.1559823465220;
        Thu, 06 Jun 2019 05:17:45 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id h17sm1502740wrq.79.2019.06.06.05.17.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 05:17:44 -0700 (PDT)
Subject: Re: [PATCH] ASoC: msm8916-wcd-digital: Add sidetone support
To:     Mark Brown <broonie@kernel.org>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20190606114002.17251-1-srinivas.kandagatla@linaro.org>
 <20190606115441.GB2456@sirena.org.uk>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <db763118-b3d6-cddc-c8ea-965d67f8a798@linaro.org>
Date:   Thu, 6 Jun 2019 13:17:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190606115441.GB2456@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review,

On 06/06/2019 12:54, Mark Brown wrote:
> On Thu, Jun 06, 2019 at 12:40:02PM +0100, Srinivas Kandagatla wrote:
> 
>> +	default:
>> +		pr_err("%s: event = %d not expected\n", __func__, event);
>> +	}
> 
> dev_err() please (and a break; as well, it isn't strictly needed but
> stops people having to check that it isn't needed).
> 
Sure I will add break.
I think the message itself is not required here as we would never come 
to this path.
>> +	SOC_SINGLE_EXT("IIR1 Enable Band1", IIR1, BAND1, 1, 0,
>> +	msm8x16_wcd_get_iir_enable_audio_mixer,
>> +	msm8x16_wcd_put_iir_enable_audio_mixer),
> 
> The indentation here is *really* messed up.  What are these controls,
> with names like "Enable" they sound like on/off controls in which case
> they should be standard Switch controls.
Yes, Switch controls should work, I will try that.

--srini
> 
