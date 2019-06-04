Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A90C28CC3
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 14:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 728D3212F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 14:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghWNYbIh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbfFDOl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 10:41:58 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40785 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727182AbfFDOl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 10:41:58 -0400
Received: by mail-lj1-f196.google.com with SMTP id a21so4733772ljh.7;
        Tue, 04 Jun 2019 07:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=N8b0nbgILUFGl4UhABnT90OSTFViNxt/Voe8ebDAUhw=;
        b=ghWNYbIhPC6NlWyE+BZpNLhuHwETwE7B0fWdhCiAG4IA4jsTtN61T517kBBgAtOLNG
         z2jlVHxg2ZfIshZkWLpMfffA2xszE3IxepJXAjK9koyhen3nqCcLnHlRCDwGeZsiMIMA
         PBdvovgf0UX1ZfP7I4dJcmTaXlf6TSEIQ0j5lSSAnTjk8BKCA0MYl6uzsT+B1m3V0NyT
         RQEknCuvA0eAwG80q1OVcQ5HXrOVO3MliWV4rVUaJaki7j1XVdFbyIK5L7qKnQ4/ARps
         rJ7PslclJDPTRvlaBFRkvZ4HHAXTK0uGlji+k5qrgEII4qOHVrP39z6v4X34yP7shTyD
         meKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N8b0nbgILUFGl4UhABnT90OSTFViNxt/Voe8ebDAUhw=;
        b=j02gs/p7/kJArAkfgfjscPBldvQODmufDpKmlLQRHkKM/Bqq5V5/ukZ9aVVn6yQO8M
         ukZGdQHAyQ8oELZJTgDo27hr3sPWM8M7xlD3ftelmur/XB37bY1lVpjPXlkqEUMwI6mF
         sv4ERVRjxA0aEHGS5gAdQytVKwvIO4yBQIU4iD3In1HNb5/a2KHsIVIdOb39+5NIPoQP
         +vtWiw+AWexoM9P8AGHwCdUZqs/ou4hWksbLxdPMZMl2kAVO+cktOfzrSeJ5G4gWxwOH
         DdZ+Z1WnujcHvoaus2yYFk7kFzQa5/N8S+nxUsMjqWVPipSaHUCLmSFKQgJ0to9ORcZy
         d6/w==
X-Gm-Message-State: APjAAAU2LdrKoMYhEh2bkcRenH7htSwp5HcbhlJ+3Net+qbrMgaJsAHh
        can5aeS9twQY8MyRisAyFKGstxKq
X-Google-Smtp-Source: APXvYqy5vx2cwnCGez25xql+Ko8Oo9C3uT3MAcpdxH78GRK8I9rCzO2unYJGvdz7BOGi+xvrS34pHA==
X-Received: by 2002:a2e:9a96:: with SMTP id p22mr86177lji.57.1559659315586;
        Tue, 04 Jun 2019 07:41:55 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.35.141])
        by smtp.googlemail.com with ESMTPSA id h10sm3223813lfj.10.2019.06.04.07.41.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 07:41:54 -0700 (PDT)
Subject: Re: [PATCH v4 14/16] PM / devfreq: tegra: Enable COMPILE_TEST for the
 driver
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190501233815.32643-1-digetx@gmail.com>
 <20190501233815.32643-15-digetx@gmail.com> <20190604112026.GN16519@ulmo>
 <ed2c502f-8f49-d89b-32c6-4b5415e1fa47@gmail.com> <20190604141031.GB397@ulmo>
 <20190604141824.GC397@ulmo>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <02a6651f-17f3-2e79-7780-57657596ba23@gmail.com>
Date:   Tue, 4 Jun 2019 17:41:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190604141824.GC397@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

04.06.2019 17:18, Thierry Reding пишет:
> On Tue, Jun 04, 2019 at 04:10:31PM +0200, Thierry Reding wrote:
>> On Tue, Jun 04, 2019 at 04:53:17PM +0300, Dmitry Osipenko wrote:
>>> 04.06.2019 14:20, Thierry Reding пишет:
>>>> On Thu, May 02, 2019 at 02:38:13AM +0300, Dmitry Osipenko wrote:
>>>>> The driver's compilation doesn't have any specific dependencies, hence
>>>>> the COMPILE_TEST option can be supported in Kconfig.
>>>>>
>>>>> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>>> ---
>>>>>  drivers/devfreq/Kconfig | 2 +-
>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
>>>>> index 56db9dc05edb..a6bba6e1e7d9 100644
>>>>> --- a/drivers/devfreq/Kconfig
>>>>> +++ b/drivers/devfreq/Kconfig
>>>>> @@ -93,7 +93,7 @@ config ARM_EXYNOS_BUS_DEVFREQ
>>>>>  
>>>>>  config ARM_TEGRA_DEVFREQ
>>>>>  	tristate "NVIDIA Tegra30/114/124/210 DEVFREQ Driver"
>>>>> -	depends on ARCH_TEGRA
>>>>> +	depends on ARCH_TEGRA || COMPILE_TEST
>>>>>  	select PM_OPP
>>>>>  	help
>>>>>  	  This adds the DEVFREQ driver for the Tegra family of SoCs.
>>>>
>>>> You need to be careful with these. You're using I/O register accessors,
>>>> which are not supported on the UM architecture, for example.
>>>>
>>>> This may end up getting flagged during build testing.
>>>
>>> We have similar cases in other drivers and it doesn't cause any known
>>> problems because (I think) build-bots are aware of this detail. Hence
>>
>> I don't understand how the build-bots would be aware of this detail.
>> Unless you explicitly state what the dependencies are, how would the
>> build-bots know? Perhaps there's some logic built-in somewhere that I
>> don't know about?
> 
> So looks like COMPILE_TEST has a !UML dependency, so this might just
> work.
> 
> Acked-by: Thierry Reding <treding@nvidia.com>
> 

Thank you very much for the clarification! Certainly that would caused
problems already since there are such cases all over the kernel,
including Tegra drivers.
