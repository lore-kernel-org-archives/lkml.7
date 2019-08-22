Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671D7C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 09:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 368EB2339F
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 09:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TUbZ+XT6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733150AbfHVJTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 05:19:03 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41311 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727953AbfHVJTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 05:19:02 -0400
Received: by mail-wr1-f65.google.com with SMTP id j16so4678340wrr.8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 02:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=m9KKLrIqbY97G+YHTsqbk+m53nDW2UqwwOTGF21lRdM=;
        b=TUbZ+XT64zRH29bUvN0i/pkfTQ5oDoq3voysQLVKmlejq8f7t3N8QwT1Uti6bNMT2X
         aNtXyFjHsIv6Nt9FPjZ2mdrXl16cz5U+bkoXSS2aOS2EigmniSZRVAiIIqYfUaF5EEZI
         3XJ7wB6GWL5vslhkX96ikuN6ExYzq36yPaTkWSvErHrrfdXl2LEYueeWsYsvcBP2s75G
         xzcASZGDbE750EU1CXfDMw9+R1E9cpwqy3uo6TdWZ1cG2jpFuGu5uJZmkiN4FrUDjIYc
         y1cN+ZP3qBjDVlUtvbemet0/PoOXjo4WgHdszQcvq1OtjbnJpGdSsG+WLk9nB0iYyP+C
         A3Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m9KKLrIqbY97G+YHTsqbk+m53nDW2UqwwOTGF21lRdM=;
        b=VoAsm5BIVUv/BejVO3NhwHgGLzzSd+lA/feeksT4Leg30xHE9q2R+qwwClRdmbytxV
         MpubIZU7o/YSSrim/a9XOwo6PdPKOACHXE0bDn2K70E2uVbxjPfyrRZpVxz7IJ+wzoxp
         8GJjTXds67HDwu07ts7oUbSxtzNYPCGLlIjPWYvHn0lOoCnrAZBJp4cbRvOCcA/qvih9
         971JHtPTEXDdLgYVwuH9Kp5AH0M9nyaAGFgsv2zN9Isa4X6BSrPTr+GMt3WmvXpR/o2z
         5HPeyyqY1nORmCUDad+srOPQjQcdGnTXWDsT9ulNWjBOQy4CmWLVC/9MTTH6ux0xQlPP
         sAEg==
X-Gm-Message-State: APjAAAULRPEU15kk1phiYsaKMxS9i25IzUonNimFXyJ8gE/9iHqYi6Kf
        63YVPvpuy5DtAdW/BfJytvPNtQ==
X-Google-Smtp-Source: APXvYqzOVluoLA+MQFTvG9csQYBVPHzlnPIYJG5axOcRqEmbg07SceenPRU1Pq/+XLrKpoCD4FOEzA==
X-Received: by 2002:adf:c7cb:: with SMTP id y11mr39705758wrg.281.1566465541055;
        Thu, 22 Aug 2019 02:19:01 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id o8sm10141815wma.1.2019.08.22.02.18.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Aug 2019 02:18:59 -0700 (PDT)
Subject: Re: [PATCH] ALSA: pcm: add support for 352.8KHz and 384KHz sample
 rate
To:     Takashi Iwai <tiwai@suse.de>
Cc:     broonie@kernel.org, bgoswami@codeaurora.org, plai@codeaurora.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, Vidyakumar Athota <vathota@codeaurora.org>
References: <20190821102705.18382-1-srinivas.kandagatla@linaro.org>
 <s5h4l2a76qz.wl-tiwai@suse.de>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <cd375dcc-f2b8-4953-8099-485f72f426da@linaro.org>
Date:   Thu, 22 Aug 2019 10:18:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <s5h4l2a76qz.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for taking time to review,

On 21/08/2019 18:44, Takashi Iwai wrote:
> On Wed, 21 Aug 2019 12:27:05 +0200,
> Srinivas Kandagatla wrote:
>>
>> From: Vidyakumar Athota <vathota@codeaurora.org>
>>
>> Most of the modern codecs supports 352.8KHz and 384KHz sample rates.
>> Currently HW params fails to set 352.8Kz and 384KHz sample rate
>> as these are not in known rates list.
>> Add these new rates to known list to allow them.
>>
>> This patch also adds defines in pcm.h so that drivers can use it.
>>
>> Signed-off-by: Vidyakumar Athota <vathota@codeaurora.org>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> As I repeatedly write for this kind of request, please submit always
> with the user of the API, not only the API change itself.
> 
I totally agree with you.

I will respin the patchset with wcd9335 and QDSP6 patches.


thanks,
srini


> 
> thanks,
> 
> Takashi
> 
