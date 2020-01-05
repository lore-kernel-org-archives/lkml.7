Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 942CFC33C99
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 00:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6366224655
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 00:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXiya4/B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgAEAm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 19:42:56 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39937 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgAEAm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 19:42:56 -0500
Received: by mail-lf1-f67.google.com with SMTP id i23so34177064lfo.7;
        Sat, 04 Jan 2020 16:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MqPoqLvy4YfZM6m1dYTriP2Qs0sSNBcj+svV3TvqrKI=;
        b=OXiya4/BQtMJtWatXec0gyqa8/lEccNU2JJqqB39VTLiISx2vDb9pAb4W+K/bCBIbp
         pbdIxhqOmkY0Wsx4ZI7aTdCtLe6lxvx4EOpJNyIbzkFLOMaGxrEniZJ+fs4hgluZROS5
         w53mTy/SN5B2GsMgxl/V9DyO9s1c/Pedryy34EoG2SRo0sp02Ma0wkvytgwgXYjtqykd
         WiMrcaNc7iQAWhKCPDtCEebEgayCH8A6NbYFqqMNPs2z2Fo9AjvPzDOgE9Q9IUF3RBvi
         FHZW67EKNWYtPmHguJu7I2KWHEi5I2G0r6NSHhT1vlp9p7h/5ReIOcMjYCWallMzi+tp
         OvMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MqPoqLvy4YfZM6m1dYTriP2Qs0sSNBcj+svV3TvqrKI=;
        b=UshK1SR8bUtBDQH3o3kzGha2ATGUn/bt9fszutlTA9O7TWrB8/RyICYtK4ky5QBpHl
         aU4AC1MvLUc0w+WBxpYbzRiZ+Aaufx04Xv5pGuztnRtoep7cCC2f9DnePWtEg8CdSTLq
         4mKmTGwW+o5wD1Lg3jsME/Yls1o9hs7E0JaUk3u9i/q/7sQM1NorpviEEawaxrdl+um8
         SyYc7oFtJa9HQKW+4p2I95halEYOm9yXhDCadtwHX0on8HTqZUANfxe2yDIIAKm/tyH6
         u67bPGruzf6DOpOFqB4NHgbTy4hQ4pZBaRH2QCRZxhgHpCG9RkxpgHauAfnKdr3GmJ6n
         k1qA==
X-Gm-Message-State: APjAAAVFm4x2VdNMCGyhXbzM1hLPvva9Dk3jgE4trnytf1CVS65WZh26
        A/Qo44l4semTBfKdqOG7+M0xCO5Y
X-Google-Smtp-Source: APXvYqxh4wXgUfN47yty3ECPBUkXEEBpg1+syHhA1/z5jqKJCD5X7BXB9bJmje9rwPQ80ZtVwGBXtQ==
X-Received: by 2002:ac2:420e:: with SMTP id y14mr54216068lfh.145.1578184972471;
        Sat, 04 Jan 2020 16:42:52 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id r21sm26975655ljn.64.2020.01.04.16.42.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Jan 2020 16:42:51 -0800 (PST)
Subject: Re: [PATCH v2 10/10] usb: chipidea: tegra: Add USB_TEGRA_PHY module
 to driver's dependencies
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Peter Chen <peter.chen@nxp.com>, Rob Herring <robh+dt@kernel.org>,
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
 <51ecc509-e277-591d-3db5-fc9d46eee326@gmail.com>
 <20200104110138.GA7849@qmqm.qmqm.pl>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <27363204-6a18-213e-f0bf-2fc02bd5f74c@gmail.com>
Date:   Sun, 5 Jan 2020 03:42:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200104110138.GA7849@qmqm.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

04.01.2020 14:01, Michał Mirosław пишет:
> On Sat, Jan 04, 2020 at 02:19:01AM +0300, Dmitry Osipenko wrote:
>> 03.01.2020 10:25, Michał Mirosław пишет:
>>> On Thu, Jan 02, 2020 at 06:17:47PM +0300, Dmitry Osipenko wrote:
>>>> 31.12.2019 00:02, Michał Mirosław пишет:
>>>>> On Tue, Dec 24, 2019 at 07:21:05AM +0300, Dmitry Osipenko wrote:
>>>>>> 24.12.2019 00:32, Michał Mirosław пишет:
>>>>>>> On Fri, Dec 20, 2019 at 07:31:08AM +0300, Dmitry Osipenko wrote:
>>>>>>>> 20.12.2019 06:56, Peter Chen пишет:
>>>>>>>>> On 19-12-20 04:52:38, Dmitry Osipenko wrote:
>>>>>>> [...]
>>>>>>>>>> --- a/drivers/usb/chipidea/ci_hdrc_tegra.c
>>>>>>>>>> +++ b/drivers/usb/chipidea/ci_hdrc_tegra.c
>>>>>>>>>> @@ -53,6 +53,12 @@ static int tegra_udc_probe(struct platform_device *pdev)
>>>>>>>>>>  	struct tegra_udc *udc;
>>>>>>>>>>  	int err;
>>>>>>>>>>  
>>>>>>>>>> +	if (IS_MODULE(CONFIG_USB_TEGRA_PHY)) {
>>>>>>>>>> +		err = request_module("phy_tegra_usb");
>>>>>>>>>> +		if (err)
>>>>>>>>>> +			return err;
>>>>>>>>>> +	}
>>>>>>>>>> +
>>>>>>>>>
>>>>>>>>> Why you do this dependency, if this controller driver can't
>>>>>>>>> get USB PHY, it should return error. What's the return value
>>>>>>>>> after calling below:
>>>>>>>>>
>>>>>>>>> 	udc->phy = devm_usb_get_phy_by_phandle(&pdev->dev, "nvidia,phy", 0);
>>>>>>>>
>>>>>>>> It returns -EPROBE_DEFER when phy_tegra_usb isn't loaded.
>>>>>>>
>>>>>>> How are other driver modules autoloaded? Isn't there an appropriate
>>>>>>> MODALIAS or MODULE_DEVICE_TABLE in there?
>>>>>>
>>>>>> Hello Michał,
>>>>>>
>>>>>> The phy_tegra_usb module is fine by itself, it's getting autoloaded.
>>>>>>
>>>>>> The problem is that ci_hdrc_tegra module depends on the phy_tegra_usb
>>>>>> module and thus the PHY module should be loaded before the CI module,
>>>>>> otherwise CI driver fails with the EPROBE_DEFER.
>>>>>
>>>>> Why, then, is CI driver not being probed again after PHY driver loads?
>>>>> EPROBE_DEFER is what should cause driver core to re-probe a device after
>>>>> other devices appear (PHY in this case).
>>>>
>>>> CI driver is getting re-probed just fine if PHY's driver module is
>>>> loaded manually after loading the CI's module. This patch removes this
>>>> necessity to manually load PHY's module.
>>>>
>>>> This is just a minor convenience change that brings the CI's driver
>>>> loading behaviour on par with the behaviour of loading Tegra's EHCI
>>>> driver module.
>>>
>>> I fully understand the goal, but what I'm missing is that why this
>>> doesn't work out of the box? If the PHY module is autoloaded, and so is
>>> CI driver, and (as I understand) the driver's probe() correctly returns
>>> EPROBE_DEFER when PHY is not probed yet, then I guess that means bug
>>> somewhere else and the patch just covers it up.
>>
>> It works out of the box, but it also could work a bit better in a case
>> of manually reloading modules. Perhaps it should be possible to derive
>> module dependencies from the Kconfig dependencies, apparently kernel
>> doesn't support it yet or maybe there is some reason why it can't be done.
> 
> Kconfig change I'm ok with as it simplifies kernel configuration.
> The request_module() is something I would advise against, because if I
> do manual module loading, I usually don't want modules loaded
> automatically.

Okay, I'll drop the request_module since it raises a bit too many
questions and since it's an optional change that won't be needed once
Tegra EHCI driver will be squashed into CI.
