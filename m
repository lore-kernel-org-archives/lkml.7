Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF893C2D0C1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 15:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3EAD206EC
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 15:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVtkEjgU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbfLSPY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 10:24:59 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35546 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbfLSPY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 10:24:58 -0500
Received: by mail-lj1-f194.google.com with SMTP id j6so6681206lja.2;
        Thu, 19 Dec 2019 07:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3yKXPaH8GS879pqXVR/snYWjruJaHyZcREhClQNij3g=;
        b=gVtkEjgUrkMRB8e7nkrrEaIOsKTs1U/wa+nxCOWiWK2ohBbnpEtzzySkl3TPG5SlH9
         oap5cxYuqSHChf6p+0P9sLdjWnlaAQl7UBIdJt7ZQHqqB6Qp2Q8TYhWSIHF+J0hNVmH7
         8IRAQmk9jMu5x16puZ0DQFlhkQBzvQS2NQi2k4ZgC3JNJjq0Pneo4KuhsI0pXpvUWBk+
         x+/SDePocPlvbP0VYnjCkMoEsA7cJUpLnZxUlA8cYftHpzHAG48S8X6uW6frpB7NkdRv
         qM3aV8C05fP1WqAJI8hhfI4IK7JMeuppmyTrhkhparmr8KAf5XWxwdFW6F971a8DXqOj
         ccWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3yKXPaH8GS879pqXVR/snYWjruJaHyZcREhClQNij3g=;
        b=fDhvEButImWQAHKvoGdekvqFA5TEq/h480RuQqe+rZSiE1UWqFrrVnwIbMUaGo4G63
         VW5VA7hZ0/7krxOzxZfz+kHSpuTVu6/s5b5Rl9Bi+HmNyuugijSi96bbcTdwGH2eO1i6
         QowhZrSJW/AeydexQkzeFXGfl5bUpwV3VCYRmPqCrCEBCANmUxfomMFoo68thmV5ZTLw
         M6vB3L/pKj7eSo9VqdWNVPTucF6Gu5R5J6KuVT67JTDuE7nr8beghAcmCzQVx7LTWEH7
         tCkJJAN6I0nsSljxv1hOelNqgw0SYQ/w74HWdPi2Ui6/ipRDlGuRt3OPqQlBrLGia3bY
         VpBA==
X-Gm-Message-State: APjAAAVdM1GW9or+dXhbOo0nnesDJONICt4hJZhbNR3S0Rxt9bcHXx7+
        NXY17SYBM93DPm+a4IE4UD4C9naj
X-Google-Smtp-Source: APXvYqyJssPSlz0Dc0X/2QV7w34lCHn5qTLPDN/x0+7lKWei8juRmm7o9Avf0Tmdmr2p9Nl1kh7MFA==
X-Received: by 2002:a2e:90da:: with SMTP id o26mr6426240ljg.25.1576769095399;
        Thu, 19 Dec 2019 07:24:55 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id y1sm691185ljm.12.2019.12.19.07.24.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2019 07:24:54 -0800 (PST)
Subject: Re: [PATCH v1 2/4] usb: phy: tegra: Hook up init/shutdown callbacks
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
References: <20191218175313.16235-1-digetx@gmail.com>
 <20191218175313.16235-3-digetx@gmail.com>
 <20191219065619.GA19921@b29397-desktop>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <d10ca21c-3918-3f2c-f279-c0ce9f37aca5@gmail.com>
Date:   Thu, 19 Dec 2019 18:24:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191219065619.GA19921@b29397-desktop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

19.12.2019 09:56, Peter Chen пишет:
> On 19-12-18 20:53:11, Dmitry Osipenko wrote:
>> Generic PHY provides init/shutdown callbacks which allow USB-host drivers
>> to abstract PHY's hardware management in a common way. This change allows
>> to remove Tegra-specific PHY handling from the ChipIdea driver.
>>
>> Note that ChipIdea's driver shall be changed at the same time because it
>> turns PHY ON without the PHY's initialization and this doesn't work now,
>> resulting in a NULL dereference of phy->freq because it's set during of
>> the PHY's initialization.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/usb/chipidea/ci_hdrc_tegra.c |   9 --
>>  drivers/usb/phy/phy-tegra-usb.c      | 165 +++++++++++++++++----------
>>  2 files changed, 102 insertions(+), 72 deletions(-)
>>
>> diff --git a/drivers/usb/chipidea/ci_hdrc_tegra.c b/drivers/usb/chipidea/ci_hdrc_tegra.c
>> index 0c9911d44ee5..7455df0ede49 100644
>> --- a/drivers/usb/chipidea/ci_hdrc_tegra.c
>> +++ b/drivers/usb/chipidea/ci_hdrc_tegra.c
>> @@ -83,13 +83,6 @@ static int tegra_udc_probe(struct platform_device *pdev)
>>  		return err;
>>  	}
>>  
>> -	/*
>> -	 * Tegra's USB PHY driver doesn't implement optional phy_init()
>> -	 * hook, so we have to power on UDC controller before ChipIdea
>> -	 * driver initialization kicks in.
>> -	 */
>> -	usb_phy_set_suspend(udc->phy, 0);
>> -
>>  	/* setup and register ChipIdea HDRC device */
>>  	udc->data.name = "tegra-udc";
>>  	udc->data.flags = soc->flags;
>> @@ -109,7 +102,6 @@ static int tegra_udc_probe(struct platform_device *pdev)
>>  	return 0;
>>  
>>  fail_power_off:
>> -	usb_phy_set_suspend(udc->phy, 1);
>>  	clk_disable_unprepare(udc->clk);
>>  	return err;
>>  }
>> @@ -119,7 +111,6 @@ static int tegra_udc_remove(struct platform_device *pdev)
>>  	struct tegra_udc *udc = platform_get_drvdata(pdev);
>>  
>>  	ci_hdrc_remove_device(udc->dev);
>> -	usb_phy_set_suspend(udc->phy, 1);
>>  	clk_disable_unprepare(udc->clk);
>>  
>>  	return 0;
>> diff --git a/drivers/usb/phy/phy-tegra-usb.c b/drivers/usb/phy/phy-tegra-usb.c
>> index ea7ef1dc0b42..15bd253d53c9 100644
>> --- a/drivers/usb/phy/phy-tegra-usb.c
>> +++ b/drivers/usb/phy/phy-tegra-usb.c
>> @@ -238,23 +238,6 @@ static int utmip_pad_open(struct tegra_usb_phy *phy)
>>  {
>>  	int ret;
>>  
>> -	phy->pad_clk = devm_clk_get(phy->u_phy.dev, "utmi-pads");
>> -	if (IS_ERR(phy->pad_clk)) {
>> -		ret = PTR_ERR(phy->pad_clk);
>> -		dev_err(phy->u_phy.dev,
>> -			"Failed to get UTMIP pad clock: %d\n", ret);
>> -		return ret;
>> -	}
>> -
>> -	phy->pad_rst = devm_reset_control_get_optional_shared(
>> -						phy->u_phy.dev, "utmi-pads");
>> -	if (IS_ERR(phy->pad_rst)) {
>> -		ret = PTR_ERR(phy->pad_rst);
>> -		dev_err(phy->u_phy.dev,
>> -			"Failed to get UTMI-pads reset: %d\n", ret);
>> -		return ret;
>> -	}
>> -
>>  	ret = clk_prepare_enable(phy->pad_clk);
>>  	if (ret) {
>>  		dev_err(phy->u_phy.dev,
>> @@ -315,6 +298,18 @@ static int utmip_pad_close(struct tegra_usb_phy *phy)
>>  	return ret;
>>  }
> 
> Acked-by: Peter Chen <peter.chen@nxp.com>
> 
> Felipe, would you please queue this series after reviewing for USB PHY
> changes? If not, Dmitry may need to split the patch.

I'll take a closer look whether it is possible to factor out ChipIdea's
driver change into a separate patch in a sensible way. Thanks!
