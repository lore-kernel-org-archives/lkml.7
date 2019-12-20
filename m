Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 926E3C2D0D2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 04:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CD3E21D7D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 04:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N34TX41K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbfLTEbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 23:31:13 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43652 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbfLTEbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 23:31:13 -0500
Received: by mail-lj1-f193.google.com with SMTP id a13so8579229ljm.10;
        Thu, 19 Dec 2019 20:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fVajutgU4AewzvJs6rRQbIrAoLOoOEBhPs/ZIUmI/WI=;
        b=N34TX41KkQ2aIKXv0ieUAt1On2i09BoudreHVP5xBn3DYfcijrJKR3tF1kwIC+w59P
         iGdTCAUy4ePy741kZvD/fIl5Wc9MZZLeOdTo+auOdALGWm4FvMco0vieil2J03adNMhs
         Y5Jua19qrP0P3Ywi+RYmI168KGk+NcVIHaNrjWAeVel/QP07OBkNfGWCdGG9Fp1BDTrB
         KWTK38LLM8G3eEIZAkGFkP5LHHECrsf67uFN2a/MHtt4ILq0pgw93DuvM03CKkj7ZyDA
         s5fsJEF3Q2BP2BL409xCcR/vXsnfGCDnx5geVDPmVp0JySKfEsF/CyS59DU8Vn0K0cfZ
         hApg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fVajutgU4AewzvJs6rRQbIrAoLOoOEBhPs/ZIUmI/WI=;
        b=stsLll9pZ3bVj4kykKFlnYPvLtJcA8VNBcSJPy+IZNSaJl2rGEfnEeIi4reU5xYbHz
         jCABoCMH5KiS6cwZp9jV6OQ/MHy4WILUlqpEi2dF5tUh+Vzz0EhjH8RRFBKUvUac6xED
         RcZbBF8IEKbQRveYMytWUid/xJbtCPClN0RJGKjhIErKHqk2cf7QZ88upKe25sxGa8kQ
         9ErgEfa5aH1swMElz2GLKpn63jFxnv9zKnu8+epJt98a9eitNGcDfUSxrowpm5dbaAsV
         o9LcCNnFLfHafNklEE62luQQn1V9b6JwS55+GEYRtohqN3AYweIhvtJkfN6v9LXAkmuF
         cXzw==
X-Gm-Message-State: APjAAAVbTXTTmuKrKzY9yEHE4sZIo965c+aUrr1YeGLK3z6ytbnATbyT
        b75+1AilQtWWpcIu6/WvdQhUTQ5s
X-Google-Smtp-Source: APXvYqwvoC56XGHrrnK9Of2G6/T/tDdXAkvpzoJVH6+G6hYRKOW19PKn373vR4bt92ZUAWqXOPDb7g==
X-Received: by 2002:a2e:824a:: with SMTP id j10mr8488846ljh.209.1576816270045;
        Thu, 19 Dec 2019 20:31:10 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id d9sm3623012lja.73.2019.12.19.20.31.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2019 20:31:09 -0800 (PST)
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20191220015238.9228-1-digetx@gmail.com>
 <20191220015238.9228-11-digetx@gmail.com>
 <20191220035650.GC19921@b29397-desktop>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <fb7dee6e-e645-fe45-126c-c5f1e280bc26@gmail.com>
Date:   Fri, 20 Dec 2019 07:31:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191220035650.GC19921@b29397-desktop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

20.12.2019 06:56, Peter Chen пишет:
> On 19-12-20 04:52:38, Dmitry Osipenko wrote:
>> Now, when ci_hdrc_tegra kernel module is loaded, the phy_tegra_usb module
>> is loaded too regardless of kernel's configuration. Previously this
>> problem was masked because Tegra's EHCI driver is usually enabled in
>> kernel's config and thus PHY driver was getting loaded because of it, but
>> now I was making some more thorough testing and noticed that PHY's module
>> isn't getting auto-loaded without the host driver.
>>
>> Note that ChipIdea's driver doesn't use any of the exported functions of
>> phy_tegra_usb module and thus the module needs to be requested explicitly.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/usb/chipidea/Kconfig         | 1 +
>>  drivers/usb/chipidea/ci_hdrc_tegra.c | 6 ++++++
>>  2 files changed, 7 insertions(+)
>>
>> diff --git a/drivers/usb/chipidea/Kconfig b/drivers/usb/chipidea/Kconfig
>> index ae850b3fddf2..d53db520e209 100644
>> --- a/drivers/usb/chipidea/Kconfig
>> +++ b/drivers/usb/chipidea/Kconfig
>> @@ -7,6 +7,7 @@ config USB_CHIPIDEA
>>  	select RESET_CONTROLLER
>>  	select USB_ULPI_BUS
>>  	select USB_ROLE_SWITCH
>> +	select USB_TEGRA_PHY if ARCH_TEGRA
>>  	help
>>  	  Say Y here if your system has a dual role high speed USB
>>  	  controller based on ChipIdea silicon IP. It supports:
>> diff --git a/drivers/usb/chipidea/ci_hdrc_tegra.c b/drivers/usb/chipidea/ci_hdrc_tegra.c
>> index 7455df0ede49..8bc11100245d 100644
>> --- a/drivers/usb/chipidea/ci_hdrc_tegra.c
>> +++ b/drivers/usb/chipidea/ci_hdrc_tegra.c
>> @@ -53,6 +53,12 @@ static int tegra_udc_probe(struct platform_device *pdev)
>>  	struct tegra_udc *udc;
>>  	int err;
>>  
>> +	if (IS_MODULE(CONFIG_USB_TEGRA_PHY)) {
>> +		err = request_module("phy_tegra_usb");
>> +		if (err)
>> +			return err;
>> +	}
>> +
> 
> Why you do this dependency, if this controller driver can't
> get USB PHY, it should return error. What's the return value
> after calling below:
> 
> 	udc->phy = devm_usb_get_phy_by_phandle(&pdev->dev, "nvidia,phy", 0);

It returns -EPROBE_DEFER when phy_tegra_usb isn't loaded.

So if you'll do:

# rmmod ci_hdrc_tegra; rmmod ci_hdrc; rmmod phy_tegra_usb;
# modprobe ci_hdrc_tegra
# lsmod
Module                  Size  Used by
ci_hdrc_tegra          16384  0
ci_hdrc                45056  1 ci_hdrc_tegra

After this patch:

# rmmod ci_hdrc_tegra; rmmod ci_hdrc; rmmod phy_tegra_usb;
# modprobe ci_hdrc_tegra
# lsmod
Module                  Size  Used by
Module                  Size  Used by
phy_tegra_usb          20480  1
ci_hdrc_tegra          16384  0
ci_hdrc                45056  1 ci_hdrc_tegra
