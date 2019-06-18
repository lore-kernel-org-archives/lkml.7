Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63329C31E5E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 08:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C8A8213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 08:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fVFXPhPq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbfFRINC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 04:13:02 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35539 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfFRINC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 04:13:02 -0400
Received: by mail-wm1-f68.google.com with SMTP id c6so2143950wml.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 01:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A1EQqhov8GIAHcRALyrTo95BX/wMNvkrcX1BAH+gcHU=;
        b=fVFXPhPqKIKjaT2O6gcVuMT+Bp6qsx0D3k8Zab+TsU468kSMjEi7t1AsBPaFFPoVGz
         YFt/t7e/lBHvir+0dDviw50OaKw8BoS1n8ag7dkiF8QctNTnM1PtVwTt2klkB1GC/GPi
         3uhFkk5SmeidcOT84y94qnWZY2C1t+NVDsRq2nj8hNuTpsnkgvubcHK/ibV6f7gWWDiS
         nE4AEYUnk6DAPts40QJ2RSBxr0lSGkNGeR/Aw79iXvFYWUeKgls21JHuI6X3sT+2du3/
         kHUsei92oxxLKcb+ZgCYHddMVQZMUiuHD7uUFiICCl0LydhP4PX9hRpuY/+6F64V2C88
         qC6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A1EQqhov8GIAHcRALyrTo95BX/wMNvkrcX1BAH+gcHU=;
        b=mWcDTGYlEfVlncmrubAntqjV7NRFzkNh9Ae0pHy1l6ns7zhjobD6YWIy9GGDOxuHIq
         ixEcyASfJTo6wV5wa6nHvRGSir49Qc+d1QICUBvcXDQFTFT7q3eb4phtxaI9ZPNPSjLl
         3ZzSoQNpmvc+4QDv6M6j1ewlokrvmJ/ULecIkR20dV7BwVzK4V3xUybBhXBV+71HJcwF
         fAWwj/Mna4ovNOARfE+4/TUwdqsfecfeNaRHW0OChKZmTU5gQABwSCxgbEgkCxPMj/lN
         7U+0Z8cUuninudgyhdcsRCiVKFHSr3y1szQ7LbjEdtqvk88j7/Grgp00AYY3ZiwzoWYD
         sGMA==
X-Gm-Message-State: APjAAAWOlOKKMsnbv4KTjSq/IaczpYgfNS7qK7w1LD+m5RDV907P7KyU
        veAvztDIeRX9U4k7Afq53S0nDg==
X-Google-Smtp-Source: APXvYqzIrn8u/txhtI7DRk2qYrbC/FWvYlvylHwE4xyIyB3aOYH2N7Zh2XTDr4RKjkCNwWcHIIYflw==
X-Received: by 2002:a1c:dc45:: with SMTP id t66mr2360140wmg.63.1560845579797;
        Tue, 18 Jun 2019 01:12:59 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id 32sm30733908wra.35.2019.06.18.01.12.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 01:12:59 -0700 (PDT)
Subject: Re: [PATCH] ASoC: qcom: common: Fix NULL pointer in of parser
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Patrick Lai <plai@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20190618052813.32523-1-bjorn.andersson@linaro.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <ad8ef1b1-a69c-df2f-cec4-d69278b570dc@linaro.org>
Date:   Tue, 18 Jun 2019 09:12:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190618052813.32523-1-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Bjorn for this patch.

On 18/06/2019 06:28, Bjorn Andersson wrote:
> A snd_soc_dai_link_component is allocated and associated with the first
> link, so when the code tries to assign the of_node of the second link's
> "cpu" member it dereferences a NULL pointer.
> 
> Fix this by moving the allocation and assignement of
> snd_soc_dai_link_components into the loop, giving us one pair per link.
> 
> Fixes: 1e36ea360ab9 ("ASoC: qcom: common: use modern dai_link style")
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

I think the original patch did not realize that there are multiple links!

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
