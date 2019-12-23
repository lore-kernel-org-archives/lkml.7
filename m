Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 775BCC2D0D2
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 17:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4869F20715
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 17:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZggbavCY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbfLWRXq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 12:23:46 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38564 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbfLWRXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 12:23:46 -0500
Received: by mail-lj1-f196.google.com with SMTP id k8so18419001ljh.5;
        Mon, 23 Dec 2019 09:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=u+GgTQ7ybWZ7C8xjZYQV6OBNXZmHXRlNnZIqFKfsmh0=;
        b=ZggbavCYF9R03LN/GA6A8IAjFSb2I19CLDSBWQ1cQjNoQHj5a7Cb5dLLQ0uuvjh4dt
         2c/EYAH0FjqszqiRQsgRk0oaOz9p0XWQiqmebWcRycVX92AGQU280HM2wSK0mOrtV3ZW
         THBmUoPVoBx5qVJnVpEhwQr99eL+zZW6R4SFlEPUZpaylRjFkKApK9YUkxmmFxE6QQ3e
         L0Mu04D0CmHyaG7ULHT42Eci7sdBnJ5Oteai40TGYjG/4ARyoKCDDwBUrPk4fwqcJkRH
         2/ZZ5M6bS3m/fGY4SwcMs2wSgVDalGauOVsWZQ3K6oeYAOdHXdsEYYWIbCgCCQMBMZcW
         /zhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u+GgTQ7ybWZ7C8xjZYQV6OBNXZmHXRlNnZIqFKfsmh0=;
        b=F9uH5IY9EhncLZHOfQvFGMisPHsW6cyBm324yUiNSf3DRNSdqENwX5OBsAz4RjYCiN
         trFr6RvgwJrN2HJ60IFNmuFxMLiKx2GXSo35i38XAkfvRP/3ky5eJ1miPDF2KV9CNoY0
         MjnxqtFppOGSXKXFLp0mj3k8F6PV2jbAgBmHZoglHmrjmeq/ICWJEqKF65A4mm/bdkjX
         FEVEh50K2KJLJDzrLxuacdOYRpniNl8h/sFe+yOwUlGjerUH7oQJrMyihxlms2EVFjcp
         C6w0UtQONCKWWsCqLsOHRQWd2O5v0IUCPPvYxaXbxAXefJTCTgQKxDlcoUO3dPGEeQPC
         /ymg==
X-Gm-Message-State: APjAAAUEKoycboNfGYgRMaSuxOonx2e9AiMg3etsNBb6unttNFmtPbRZ
        v1G75MclpNC+YqtDNQdTqMw=
X-Google-Smtp-Source: APXvYqznVHMwk4z0zRQUa244lrNFQoo8AGsEqJjn52aZ+3QFYFwDs9N4TOHu5uO+eUBLwMuv73DHlw==
X-Received: by 2002:a05:651c:282:: with SMTP id b2mr18236642ljo.41.1577121823402;
        Mon, 23 Dec 2019 09:23:43 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id q26sm8568568lfc.52.2019.12.23.09.23.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Dec 2019 09:23:42 -0800 (PST)
Subject: Re: [PATCH v2 10/10] usb: chipidea: tegra: Add USB_TEGRA_PHY module
 to driver's dependencies
To:     Peter Chen <peter.chen@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Felipe Balbi <balbi@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peter Geis <pgwipeout@gmail.com>
References: <20191220015238.9228-1-digetx@gmail.com>
 <20191220015238.9228-11-digetx@gmail.com>
 <20191220035650.GC19921@b29397-desktop>
 <fb7dee6e-e645-fe45-126c-c5f1e280bc26@gmail.com>
 <20191223063958.GD19921@b29397-desktop>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <1d2e3ea0-a7ff-3e83-57d1-05ffddb0da07@gmail.com>
Date:   Mon, 23 Dec 2019 20:23:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191223063958.GD19921@b29397-desktop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

23.12.2019 09:40, Peter Chen пишет:
> On 19-12-20 07:31:08, Dmitry Osipenko wrote:
>> 20.12.2019 06:56, Peter Chen пишет:
>>> On 19-12-20 04:52:38, Dmitry Osipenko wrote:
>>>> Now, when ci_hdrc_tegra kernel module is loaded, the phy_tegra_usb module
>>>> is loaded too regardless of kernel's configuration. Previously this
>>>> problem was masked because Tegra's EHCI driver is usually enabled in
>>>> kernel's config and thus PHY driver was getting loaded because of it, but
>>>> now I was making some more thorough testing and noticed that PHY's module
>>>> isn't getting auto-loaded without the host driver.
>>>>
>>>> Note that ChipIdea's driver doesn't use any of the exported functions of
>>>> phy_tegra_usb module and thus the module needs to be requested explicitly.
>>>>
>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>> ---
>>>>  drivers/usb/chipidea/Kconfig         | 1 +
>>>>  drivers/usb/chipidea/ci_hdrc_tegra.c | 6 ++++++
>>>>  2 files changed, 7 insertions(+)
>>>>
>>>> diff --git a/drivers/usb/chipidea/Kconfig b/drivers/usb/chipidea/Kconfig
>>>> index ae850b3fddf2..d53db520e209 100644
>>>> --- a/drivers/usb/chipidea/Kconfig
>>>> +++ b/drivers/usb/chipidea/Kconfig
>>>> @@ -7,6 +7,7 @@ config USB_CHIPIDEA
>>>>  	select RESET_CONTROLLER
>>>>  	select USB_ULPI_BUS
>>>>  	select USB_ROLE_SWITCH
>>>> +	select USB_TEGRA_PHY if ARCH_TEGRA
>>>>  	help
>>>>  	  Say Y here if your system has a dual role high speed USB
>>>>  	  controller based on ChipIdea silicon IP. It supports:
>>>> diff --git a/drivers/usb/chipidea/ci_hdrc_tegra.c b/drivers/usb/chipidea/ci_hdrc_tegra.c
>>>> index 7455df0ede49..8bc11100245d 100644
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
>>
>> So if you'll do:
>>
>> # rmmod ci_hdrc_tegra; rmmod ci_hdrc; rmmod phy_tegra_usb;
>> # modprobe ci_hdrc_tegra
>> # lsmod
>> Module                  Size  Used by
>> ci_hdrc_tegra          16384  0
>> ci_hdrc                45056  1 ci_hdrc_tegra
>>
>> After this patch:
>>
>> # rmmod ci_hdrc_tegra; rmmod ci_hdrc; rmmod phy_tegra_usb;
>> # modprobe ci_hdrc_tegra
>> # lsmod
>> Module                  Size  Used by
>> Module                  Size  Used by
>> phy_tegra_usb          20480  1
>> ci_hdrc_tegra          16384  0
>> ci_hdrc                45056  1 ci_hdrc_tegra
> 
> I wonder why the driver needs such dependency? If there are two phy
> drivers could work with this controller driver, you may request two
> modules.

Well, if somebody wants to use some PHY driver other than the upstream's
standard one, then that person could simply load the custom driver
module first, such that it will bind to the PHY's device first.

It is also possible to manually unbind the standard driver from PHY's
device and then bind whatever driver you want.

> Doesn't such dependency should be done by the board
> level script?

This patch only improves the default behaviour that is common for all
NVIDIA Tegra boards, it doesn't prevent from doing any special
customizations.

Perhaps the Kconfig change could be dropped from this patch in order to
provide a bit more flexibility in regards to kernel's configuration, but
I'm very doubtful that realistically anyone would want to replace the
default driver with anything else on Tegra. The Kconfig change also puts
ChipIdea's UDC driver in line with the Tegra's EHCI driver that selects
USB_TEGRA_PHY, please see drivers/usb/host/Kconfig.

> Do you know are there any other drivers do such things?

I don't think that any of the USB host drivers are currently doing such
things, but in general there are quite a lot of drivers in kernel that
are using request_module [1].

[1] https://elixir.bootlin.com/linux/latest/ident/request_module

Please note that drivers/usb/host/ehci-tegra.c uses exported symbols
from usb/phy/phy-tegra-usb.c and that is why the EHCI driver doesn't
need to explicitly load the phy_tegra_usb module, the load happens
automatically because of the missing symbols.

Also, please note that it is possible to squash the Tegra EHCI driver
into ci_hdrc_tegra.c and then the explicit dependency on the
phy_tegra_usb won't be needed anymore since it will be replaced with an
implicit dependency. We (me and Peter Geis) already had some
experimental patches that do the successful squashing of the drivers,
but looks like Peter got sidetracked for a more important things for
now, we'll probably return to that work later on.
