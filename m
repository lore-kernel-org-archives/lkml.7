Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10605C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 12:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCFC52089F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 12:30:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RNtV53yj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbfJKMaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 08:30:24 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37348 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727672AbfJKMaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 08:30:24 -0400
Received: by mail-wr1-f67.google.com with SMTP id p14so11724703wro.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 05:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eUAVKWO5tGOGok/vKm5I9Fla/1z4P3pvPIySfc1WbLY=;
        b=RNtV53yjZdIOhcHzhhnYIbDQbJJ7VLlvGAzwvvD7Iz76cQbWeEsAAgKU1UR+xBYFbD
         lTQhpVC6KvASGkVqJcSNfXZ/GTqhbSdUv8IG0CQGmGNDckpp6soaH5cLty0VtOsEsyfW
         bs5sbmKzARNsPY/zhYADlpWpebgW5RjvmCEwfBToNFd+nDMpLYY92kmn+8tnJTWP1HsO
         9BtBLlg5UjgSUmztX1EnqGaORzA7BZSjQYHtLB6/ec9ZaWSFwbAdmhjHwMFoc0acGGvq
         BmJqKwLrbeoLV3+S6GDB4j/73HchdsOTO6JU/1xHhUl5XUkjmyf0qOTNi8UQA/IDUEiv
         j2Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eUAVKWO5tGOGok/vKm5I9Fla/1z4P3pvPIySfc1WbLY=;
        b=A7Lah2nc7H92e9Dp8CoIj6JfwAki4PFPe6lyQAjdsn65DiDA7JPjy0dX6qG1893CUJ
         HHO4eKn/x4XizuBR5tzzwePaWcyMrpmV2qu/RURPjbJTTmBlEVlozm7tWsrwqikN4dQc
         VUVULF9PGesLVPqQ7SySGtgfjo3JMJQ310MKU9gd1jy5sW6yciJB2SLor0GvY83LN//Z
         ysdj2KTFe0B2In6rMfsO3CqQSU9iaMzVR1vrn85mfrgwgdSqnu1mlg/j29i57YTuJvdz
         tzNqt/xw64vWB22vB6KsHfFY/9cXhbz+qb6hciEwVc0/uM0RdBFsFX9cTJog8zzxLsDd
         mfKQ==
X-Gm-Message-State: APjAAAW0IkIDVKlTDR4HRf/Z1Dsqn/96Y6r/Z+0S7YtgBlKWxRwjnCit
        ufW8Rjx33iFcXcy4KicdnUDsqQ==
X-Google-Smtp-Source: APXvYqx1rdX0PmyUW4J4n+ZmiD+1KiVOhomZpcCLUgiE5LNwHT/pvqwwgRHD7MkrHSBvv4avhMCG2Q==
X-Received: by 2002:adf:f4c2:: with SMTP id h2mr13353630wrp.69.1570797021729;
        Fri, 11 Oct 2019 05:30:21 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id t123sm14523710wma.40.2019.10.11.05.30.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Oct 2019 05:30:20 -0700 (PDT)
Subject: Re: [alsa-devel] [PATCH v2 3/5] ASoC: core: add support to
 snd_soc_dai_get_sdw_stream()
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, linux-kernel@vger.kernel.org,
        plai@codeaurora.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>,
        spapothi@codeaurora.org
References: <20190813191827.GI5093@sirena.co.uk>
 <cc360858-571a-6a46-1789-1020bcbe4bca@linux.intel.com>
 <20190813195804.GL5093@sirena.co.uk>
 <20190814041142.GU12733@vkoul-mobl.Dlink>
 <99d35a9d-cbd8-f0da-4701-92ef650afe5a@linux.intel.com>
 <5e08f822-3507-6c69-5d83-4ce2a9f5c04f@linaro.org>
 <53bb3105-8e85-a972-fce8-a7911ae4d461@linux.intel.com>
 <95870089-25da-11ea-19fd-0504daa98994@linaro.org>
 <2326a155-332e-fda0-b7a2-b48f348e1911@linux.intel.com>
 <34e4cde8-f2e5-0943-115a-651d86f87c1a@linaro.org>
 <20191010120337.GB31391@ediswmail.ad.cirrus.com>
 <22eff3aa-dfd6-1ee5-8f22-2af492286053@linux.intel.com>
 <e671930b-645a-7ee3-6926-eea39626c0a3@linaro.org>
 <c9203f7f-f360-0ede-d351-cfdbec03299c@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <dbb25f4c-7198-ef28-ec6a-9ac5676122b6@linaro.org>
Date:   Fri, 11 Oct 2019 13:30:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <c9203f7f-f360-0ede-d351-cfdbec03299c@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/10/2019 16:49, Pierre-Louis Bossart wrote:
> 
> 
>> I still need to figure out prefixing multiple instances of this 
>> Amplifier controls with "Left" and "Right"
> 
> FWIW we use the "snd_codec_conf" stuff to add a prefix for each 
> amplifier, so that the controls are not mixed up between instances of 
> the same amp, see e.g.
> 
Thanks Pierre for the inputs.
Am using Documentation/devicetree/bindings/sound/name-prefix.txt for dt 
and it works!

I will send new set of patches by dropping this patch!

--srini
> 
> static struct snd_soc_codec_conf codec_conf[] = {
>      {
>          .dev_name = "sdw:0:25d:711:0:1",
>          .name_prefix = "rt711",
>      },
>      {
>          .dev_name = "sdw:1:25d:1308:0:0",
>          .name_prefix = "rt1308-1",
>      },
>      {
>          .dev_name = "sdw:2:25d:1308:0:2",
>          .name_prefix = "rt1308-2",
>      },
>      {
>          .dev_name = "sdw:3:25d:715:0:1",
>          .name_prefix = "rt715",
>      },
> };
> 
> 
> https://github.com/thesofproject/linux/pull/1142/commits/9ff9cf9d8994333df2250641c95431261bc66d69#diff-892560f80d603420baec7395e0b45d81R212 
> 
