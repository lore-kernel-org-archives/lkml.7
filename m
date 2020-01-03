Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57D3C32767
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 23:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA36D24649
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 23:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rs43lxKN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgACXTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 18:19:06 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38112 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbgACXTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 18:19:06 -0500
Received: by mail-lf1-f66.google.com with SMTP id r14so32875535lfm.5;
        Fri, 03 Jan 2020 15:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=plPVBn5B05KxG9Buj5t41WutJV0n3H/IAkieAwZIPiw=;
        b=Rs43lxKNvkJWQWSxOMFj5HImDnbdW7tn96edGbjhtRbuIiqiMdOoKci2Ue3mtExYm2
         h8aw4WmdaQOUZdvV0OML3IKvoUM8vz0vhLvQcDV8olxP1ZZptdXNcFG5ofa0leTksW29
         uxF641QofPpFOcyLoJ0fcjG2ANyqpCEKSFZGafqo+UvSyTW8MqOod+7Uxu9QdKYKq34e
         e0blXEHs57SWhSkA/RFier4IIEv1SemZE2SpHIEncShEZkFOG+RCQ9sfxp4RssmVfkAB
         +XXBCTVW6KFrsilyEN8lj7hPDzcYXs+wRB+PxNCsPXkxDAvwBNLngE2fWgzgkBMCLH1C
         Zz5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=plPVBn5B05KxG9Buj5t41WutJV0n3H/IAkieAwZIPiw=;
        b=MmuHxtLBCci3TfLn+gnlvXkS/W2npWk1oeHsuHjYLlveW0+I9sxyAQM+uozW1JuP1p
         TIOXKrpS+IODfhhH2RsndbKgs5IlIUjdEOvM/XjYjcDlEIZfP0E4MY7d2dDNJKbQYg+u
         +MLwCY7SOQARzAwlWHimbLwP3nY3TWltsnRr9LWIR9IBa6UWAJ0ohIxx7hKY0c6QacUl
         y9Q+kLatGd6ixfbaAh5QHwLcxZEDkUqw4PmBCkRaqFJLsmHox3ofNsEGw4EKezc/YEAn
         rA9EMX/iqGfPkm3YjE+vm6ELejGP9QiWLcXHEnPqRuzFvgLQhzkn/GOeQ/KxBubn5ttz
         ruEw==
X-Gm-Message-State: APjAAAVFP2QjaX0zDSzr/5/f3Kygvq6yC0IohrNKgYxsIVIbJESwmYzv
        2Ac/Y8VnUGjIwwyxGqKYViv14f0T
X-Google-Smtp-Source: APXvYqyHpJll+Sl4MRgtwD+Fd2ygwv3MNH63zAjKk+0jlLGSGSkAAJxRGfgGeahH+vVWr/AsqzF5sA==
X-Received: by 2002:a19:ae04:: with SMTP id f4mr51629831lfc.64.1578093543753;
        Fri, 03 Jan 2020 15:19:03 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id i5sm25432335ljj.29.2020.01.03.15.19.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jan 2020 15:19:03 -0800 (PST)
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
 <b34972e3-569e-d74a-4d30-d52c89032a08@gmail.com>
 <20200103072536.GA14228@qmqm.qmqm.pl>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <51ecc509-e277-591d-3db5-fc9d46eee326@gmail.com>
Date:   Sat, 4 Jan 2020 02:19:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200103072536.GA14228@qmqm.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

03.01.2020 10:25, Michał Mirosław пишет:
> On Thu, Jan 02, 2020 at 06:17:47PM +0300, Dmitry Osipenko wrote:
>> 31.12.2019 00:02, Michał Mirosław пишет:
>>> On Tue, Dec 24, 2019 at 07:21:05AM +0300, Dmitry Osipenko wrote:
>>>> 24.12.2019 00:32, Michał Mirosław пишет:
>>>>> On Fri, Dec 20, 2019 at 07:31:08AM +0300, Dmitry Osipenko wrote:
>>>>>> 20.12.2019 06:56, Peter Chen пишет:
>>>>>>> On 19-12-20 04:52:38, Dmitry Osipenko wrote:
>>>>> [...]
>>>>>>>> --- a/drivers/usb/chipidea/ci_hdrc_tegra.c
>>>>>>>> +++ b/drivers/usb/chipidea/ci_hdrc_tegra.c
>>>>>>>> @@ -53,6 +53,12 @@ static int tegra_udc_probe(struct platform_device *pdev)
>>>>>>>>  	struct tegra_udc *udc;
>>>>>>>>  	int err;
>>>>>>>>  
>>>>>>>> +	if (IS_MODULE(CONFIG_USB_TEGRA_PHY)) {
>>>>>>>> +		err = request_module("phy_tegra_usb");
>>>>>>>> +		if (err)
>>>>>>>> +			return err;
>>>>>>>> +	}
>>>>>>>> +
>>>>>>>
>>>>>>> Why you do this dependency, if this controller driver can't
>>>>>>> get USB PHY, it should return error. What's the return value
>>>>>>> after calling below:
>>>>>>>
>>>>>>> 	udc->phy = devm_usb_get_phy_by_phandle(&pdev->dev, "nvidia,phy", 0);
>>>>>>
>>>>>> It returns -EPROBE_DEFER when phy_tegra_usb isn't loaded.
>>>>>
>>>>> How are other driver modules autoloaded? Isn't there an appropriate
>>>>> MODALIAS or MODULE_DEVICE_TABLE in there?
>>>>
>>>> Hello Michał,
>>>>
>>>> The phy_tegra_usb module is fine by itself, it's getting autoloaded.
>>>>
>>>> The problem is that ci_hdrc_tegra module depends on the phy_tegra_usb
>>>> module and thus the PHY module should be loaded before the CI module,
>>>> otherwise CI driver fails with the EPROBE_DEFER.
>>>
>>> Why, then, is CI driver not being probed again after PHY driver loads?
>>> EPROBE_DEFER is what should cause driver core to re-probe a device after
>>> other devices appear (PHY in this case).
>>
>> CI driver is getting re-probed just fine if PHY's driver module is
>> loaded manually after loading the CI's module. This patch removes this
>> necessity to manually load PHY's module.
>>
>> This is just a minor convenience change that brings the CI's driver
>> loading behaviour on par with the behaviour of loading Tegra's EHCI
>> driver module.
> 
> I fully understand the goal, but what I'm missing is that why this
> doesn't work out of the box? If the PHY module is autoloaded, and so is
> CI driver, and (as I understand) the driver's probe() correctly returns
> EPROBE_DEFER when PHY is not probed yet, then I guess that means bug
> somewhere else and the patch just covers it up.

It works out of the box, but it also could work a bit better in a case
of manually reloading modules. Perhaps it should be possible to derive
module dependencies from the Kconfig dependencies, apparently kernel
doesn't support it yet or maybe there is some reason why it can't be done.
