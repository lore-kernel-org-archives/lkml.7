Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33E7C2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 15:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B71CF206E6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 15:17:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rm6d9E+d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbgABPRw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 10:17:52 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42414 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728561AbgABPRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 10:17:51 -0500
Received: by mail-lj1-f194.google.com with SMTP id y4so26679199ljj.9;
        Thu, 02 Jan 2020 07:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BQek1hpGtAcuz3Vy94GFTxcBosOLuEGkc1EsxVOl7K0=;
        b=rm6d9E+dTNWcbvvwgWbOuPY6szM3rkWylgsiKib7v/V9yznlEsOsFwX+N2GwxKm9U/
         qWscJQCbsvRA5ARFjYODsuNr2mt8t0SjPKbFIkshsLU+B9PtUQVyieZ6wNEJCSZ6sohO
         27i470vK8+FYTG4xMLLSr4GPKbk1cr4cg2CuUg8YdNrhaFOJoKzI6j/GRxnYq5rgDbcm
         vUYKLKvwT1mRsooiqTSbboIB9xwD8NetwGWEp+sfnw6rvNm3hkxjiD80wZ7tMJ6r1QFz
         O/4kShUi1C5bBOfNwHhevjBt45lkHKgqD6n2NoMawUeJDZDdSqm4KV4R6X2U2mmNryXO
         4rKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BQek1hpGtAcuz3Vy94GFTxcBosOLuEGkc1EsxVOl7K0=;
        b=ASVNTFb06OPMzozrwX9iDdOUWqBWV26aqWP9DeiSTxgtY8OudLWE8LDeu2tjsOCK/l
         U+kpSjjJzQyWdTO2UULNGzzCmrLSLz2U1VL3cm1o+au8IJa9trJfrcTTFkAw2jeLiQSV
         4ZvWfeTJYfXr01A81YkyfqK1b4uyZmRI39tR2RcxV77bIYOP/CbTIKLJw5M89QfZtzon
         I9n2wwRkXpnpinRpaxhxTbZOlXOjCqgXxFGzR9EfoyqkTcO5nJI9dewnZU/CgAQ+DO8n
         17A8tILf7ifhOEercnbI6gwOD2Rot/k/ZA3qi/niz2iQIG0UggZ7A2F8u61PotrKOodN
         9W1g==
X-Gm-Message-State: APjAAAW9JRPDrrYsJTJw6pzWVE7fvo7teUAJveskMlnSruAsDf9bYjap
        aSj9XjgkdetlG/nsmmApeMaUVLoi
X-Google-Smtp-Source: APXvYqxvkVFnhiPOxFv+7ZRxTUIFTDSny58aAUFqXUPm0qk5W3c5Kf0KO4HWqsPuKxknmCVge1rAdQ==
X-Received: by 2002:a2e:943:: with SMTP id 64mr37257269ljj.17.1577978269110;
        Thu, 02 Jan 2020 07:17:49 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id g27sm23515861lfj.49.2020.01.02.07.17.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jan 2020 07:17:48 -0800 (PST)
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
 <7174833f-8325-7fb4-d190-78ba4bed0cbb@gmail.com>
 <20191230210259.GD24135@qmqm.qmqm.pl>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <b34972e3-569e-d74a-4d30-d52c89032a08@gmail.com>
Date:   Thu, 2 Jan 2020 18:17:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191230210259.GD24135@qmqm.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

31.12.2019 00:02, Michał Mirosław пишет:
> On Tue, Dec 24, 2019 at 07:21:05AM +0300, Dmitry Osipenko wrote:
>> 24.12.2019 00:32, Michał Mirosław пишет:
>>> On Fri, Dec 20, 2019 at 07:31:08AM +0300, Dmitry Osipenko wrote:
>>>> 20.12.2019 06:56, Peter Chen пишет:
>>>>> On 19-12-20 04:52:38, Dmitry Osipenko wrote:
>>> [...]
>>>>>> --- a/drivers/usb/chipidea/ci_hdrc_tegra.c
>>>>>> +++ b/drivers/usb/chipidea/ci_hdrc_tegra.c
>>>>>> @@ -53,6 +53,12 @@ static int tegra_udc_probe(struct platform_device *pdev)
>>>>>>  	struct tegra_udc *udc;
>>>>>>  	int err;
>>>>>>  
>>>>>> +	if (IS_MODULE(CONFIG_USB_TEGRA_PHY)) {
>>>>>> +		err = request_module("phy_tegra_usb");
>>>>>> +		if (err)
>>>>>> +			return err;
>>>>>> +	}
>>>>>> +
>>>>>
>>>>> Why you do this dependency, if this controller driver can't
>>>>> get USB PHY, it should return error. What's the return value
>>>>> after calling below:
>>>>>
>>>>> 	udc->phy = devm_usb_get_phy_by_phandle(&pdev->dev, "nvidia,phy", 0);
>>>>
>>>> It returns -EPROBE_DEFER when phy_tegra_usb isn't loaded.
>>>
>>> How are other driver modules autoloaded? Isn't there an appropriate
>>> MODALIAS or MODULE_DEVICE_TABLE in there?
>>
>> Hello Michał,
>>
>> The phy_tegra_usb module is fine by itself, it's getting autoloaded.
>>
>> The problem is that ci_hdrc_tegra module depends on the phy_tegra_usb
>> module and thus the PHY module should be loaded before the CI module,
>> otherwise CI driver fails with the EPROBE_DEFER.
> 
> Why, then, is CI driver not being probed again after PHY driver loads?
> EPROBE_DEFER is what should cause driver core to re-probe a device after
> other devices appear (PHY in this case).

CI driver is getting re-probed just fine if PHY's driver module is
loaded manually after loading the CI's module. This patch removes this
necessity to manually load PHY's module.

This is just a minor convenience change that brings the CI's driver
loading behaviour on par with the behaviour of loading Tegra's EHCI
driver module.
