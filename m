Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6115C2D0D2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 04:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 606CE20706
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 04:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r+CFwFbX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfLXEVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 23:21:10 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43734 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbfLXEVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 23:21:10 -0500
Received: by mail-lj1-f194.google.com with SMTP id a13so19694397ljm.10;
        Mon, 23 Dec 2019 20:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=udOFYCS91CTeMpnFfc0r7ZXKWlf7+Pdzv8DizzBwQek=;
        b=r+CFwFbX1PuDSE2cPYpK7g+P2hVFikYAjyOc9kXu2VjkEQRewx/88UbGvSGJ5ChalS
         6XbmT+KWo4h+Ef6OQ2/hegnERMASdmcORVHBRY+/Qn/5UbNdmW3fRSuV6/23qTbg2Zhs
         mrpMEZGzRrZeHjknwO9WV6ZTq7MD07YllYCUeS4DaAlHC7StqsC4yF+uV9fQkU/oS+P2
         f6Nc3FVR9mfijRzIE9gsF+xdly9pxRLWw5/S4BDQeOKoNQ9jeunPxH/dECPD16AKjetM
         YB91YlSZDXX0UQCSP9T+4vfU47H67rjFQHGKDQbIDJiLMETA796JzQdZ0ImSO46FQUDT
         CCXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=udOFYCS91CTeMpnFfc0r7ZXKWlf7+Pdzv8DizzBwQek=;
        b=T6PMeGRBWunBI3UgKojjlRA3+v4g/p9AYnGlwD7NBzykZaSUWTUU/kYPWgU1AFi8fn
         KMnY54hA2jql7oVYoMx+cI/3GQdzcwsquHb2Ce5mXosdKD7Wr7FhnvaSWaFU24k9UsWV
         MOU2hqi8yxDzcZxxX9neihvWfu3GrEFUew7GYa06CV1ukgXRVBu/sebbs6DnUMauRpkA
         On539loF1hZyIzX7pXKCVWm6ogCmX/26+pq55ubvZxfm0vofAoa+S5cBAJk2iCDJe0Yg
         rVFoFGuqfFf5kR+S0Vdl3DLkKc5C6iDytI+iIhgOPDYc2h1O7ayRGc40ZrROjnM4tT2E
         F9QQ==
X-Gm-Message-State: APjAAAUXbF/PYJ+mBzMTI3/mF0+L0dvVqC3SUXIH0q5FK8/g1vXvBRoq
        a3cLVH857jL52iPCma/alKS2v4O3
X-Google-Smtp-Source: APXvYqw4whaGwmVR32tWRsk9kzKbCPts2siqG6dKgpyGbfx1Vpw7SM9pAEvNTS1ui/TM7Wl2y8yaEQ==
X-Received: by 2002:a2e:b60d:: with SMTP id r13mr19567553ljn.40.1577161267488;
        Mon, 23 Dec 2019 20:21:07 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id q13sm4320327ljm.68.2019.12.23.20.21.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Dec 2019 20:21:06 -0800 (PST)
Subject: Re: [PATCH v2 10/10] usb: chipidea: tegra: Add USB_TEGRA_PHY module
 to driver's dependencies
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Peter Chen <peter.chen@nxp.com>, Rob Herring <robh-dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Felipe Balbi <balbi@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20191220015238.9228-1-digetx@gmail.com>
 <20191220015238.9228-11-digetx@gmail.com>
 <20191220035650.GC19921@b29397-desktop>
 <fb7dee6e-e645-fe45-126c-c5f1e280bc26@gmail.com>
 <20191223213234.GA28786@qmqm.qmqm.pl>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <7174833f-8325-7fb4-d190-78ba4bed0cbb@gmail.com>
Date:   Tue, 24 Dec 2019 07:21:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191223213234.GA28786@qmqm.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

24.12.2019 00:32, Michał Mirosław пишет:
> On Fri, Dec 20, 2019 at 07:31:08AM +0300, Dmitry Osipenko wrote:
>> 20.12.2019 06:56, Peter Chen пишет:
>>> On 19-12-20 04:52:38, Dmitry Osipenko wrote:
> [...]
>>>> --- a/drivers/usb/chipidea/ci_hdrc_tegra.c
>>>> +++ b/drivers/usb/chipidea/ci_hdrc_tegra.c
>>>> @@ -53,6 +53,12 @@ static int tegra_udc_probe(struct platform_device *pdev)
>>>>  	struct tegra_udc *udc;
>>>>  	int err;
>>>>  
>>>> +	if (IS_MODULE(CONFIG_USB_TEGRA_PHY)) {
>>>> +		err = request_module("phy_tegra_usb");
>>>> +		if (err)
>>>> +			return err;
>>>> +	}
>>>> +
>>>
>>> Why you do this dependency, if this controller driver can't
>>> get USB PHY, it should return error. What's the return value
>>> after calling below:
>>>
>>> 	udc->phy = devm_usb_get_phy_by_phandle(&pdev->dev, "nvidia,phy", 0);
>>
>> It returns -EPROBE_DEFER when phy_tegra_usb isn't loaded.
> 
> How are other driver modules autoloaded? Isn't there an appropriate
> MODALIAS or MODULE_DEVICE_TABLE in there?

Hello Michał,

The phy_tegra_usb module is fine by itself, it's getting autoloaded.

The problem is that ci_hdrc_tegra module depends on the phy_tegra_usb
module and thus the PHY module should be loaded before the CI module,
otherwise CI driver fails with the EPROBE_DEFER.
