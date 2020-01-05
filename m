Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA5BC3F68F
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 00:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DE7D24670
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 00:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YlPShjYr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgAEA6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 19:58:44 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45449 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgAEA6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 19:58:44 -0500
Received: by mail-lj1-f196.google.com with SMTP id j26so47374879ljc.12;
        Sat, 04 Jan 2020 16:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=e2H8iTC4TclXe451rGcN5VwVjBNYdbfsTOdYq+HMKR8=;
        b=YlPShjYruZFAa+EwPMxY2fVR8YavY2F+Bmn0LOVydPfnyy21tqlzV4mjBiuNz2xjwQ
         /vzU1cJ/pJ/dTYNt21vk6rYJQ0RpWEuJ0l4SvV+fbmTfOiPwUHnrXLuzgkxj2hpbNXFQ
         gvc3tEZYpDTHWZtLeEz9QdFSoGFK0nfrXB+m7+lRdcErBBE41RIsx9PlqTB8qKljFL2O
         XVVQumpYKVcwbO/11c/fmi6v26NARJCYoyHlhh+sFdw1/DZ2NvVXu4PCYVbR4MCIhWhw
         IRc9OC3z04NFMc73d6eCbQOCiqu+ypb06+JGy5Q9mqVoAlvTxRMMaQycdsVYuYooknXG
         G2QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e2H8iTC4TclXe451rGcN5VwVjBNYdbfsTOdYq+HMKR8=;
        b=iNH52PrCk7WpGaUO3a82l2aIAEtUUjAa8P12lVaOng91vGyb0OzKFjrZtFi/KwcTFh
         asIBNxRJLdxZHcOg/LIpH5euw6yIKNe/9BMjzP8kTnL/jxCcplR/BeZO1Z7qlUS7/kHR
         bgY4KWT/+i3vB/wpV06weEW6cVaCy4G3wtra42FvkxZtg4yhi6+kqcrnXkCcB99gxavi
         WXqRxEuQc7nBbMJUIbLpIcFaP4DkLWQrUAp7NSjaBmIH+Quh/uDDJj/e6QuDuPFEF/zi
         5dv9DxOPfg0iRmvj9qmh6rzg2Jf1qJngpebbeANqECU5IWvwbOc6droLX9yjBdSW1z9k
         fPjg==
X-Gm-Message-State: APjAAAUF0BEvpEqSCJyFti/6RjsK73lWgiLMZYsG65TJfGZhahPMoVA2
        vDvDe6VcLgUU4J+piZkHdOzKl7q2
X-Google-Smtp-Source: APXvYqx0U6gevfu3Pv1xj2xCUODV9DyFqrG9UrDQLnS090r0V+DC6wFc8wHMWNFZGa4/lFL+eNrzHQ==
X-Received: by 2002:a2e:9183:: with SMTP id f3mr18677823ljg.64.1578185921483;
        Sat, 04 Jan 2020 16:58:41 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id b63sm27067209lfg.79.2020.01.04.16.58.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Jan 2020 16:58:40 -0800 (PST)
Subject: Re: [PATCH v3 10/16] usb: phy: tegra: Use device-tree notion of
 reset-GPIO's active-state
From:   Dmitry Osipenko <digetx@gmail.com>
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <Peter.Chen@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Felipe Balbi <balbi@kernel.org>, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191228203358.23490-1-digetx@gmail.com>
 <20191228203358.23490-11-digetx@gmail.com>
 <20200103075803.GC14228@qmqm.qmqm.pl>
 <42f1d6c9-99f2-b829-0d2c-649fcdfb156d@gmail.com>
Message-ID: <9fd12e5f-00c0-0292-b8a1-3fad48bfc4a3@gmail.com>
Date:   Sun, 5 Jan 2020 03:58:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <42f1d6c9-99f2-b829-0d2c-649fcdfb156d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

04.01.2020 02:53, Dmitry Osipenko пишет:
> 03.01.2020 10:58, Michał Mirosław пишет:
[snip]
>> [...]
>>> -		err = devm_gpio_request(&pdev->dev, tegra_phy->reset_gpio,
>>> -					"ulpi_phy_reset_b");
>>> +		gpiod = devm_gpiod_get_from_of_node(&pdev->dev, np,
>>> +						    "nvidia,phy-reset-gpio",
>>> +						    0, GPIOD_OUT_HIGH,
>>> +						    "ulpi_phy_reset_b");
>>> +		err = PTR_ERR_OR_ZERO(gpiod);
>>>  		if (err) {
>>> -			dev_err(&pdev->dev, "Request failed for GPIO %d: %d\n",
>>> -				tegra_phy->reset_gpio, err);
>>> +			dev_err(&pdev->dev,
>>> +				"Request failed for reset GPIO: %d\n", err);
>>>  			return err;
>>>  		}
>>> +		tegra_phy->reset_gpio = gpiod;
>>
>> A nice extension to kernel's printf - "%pe" format - has just landed in
>> Linus' master tree.
> 
> Thank you very much, I didn't know about that.

In this particular case PTR_ERR_OR_ZERO() results in a bit more cleaner
code than with IS_ERR() and PTR_ERR() [IMHO], so I'll probably keep it
as-is. Anyways, thanks again for the pointer to "%pe", it could come
handy later on.
