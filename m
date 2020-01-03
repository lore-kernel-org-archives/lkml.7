Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B41A5C00523
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 23:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85CDF22B48
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 23:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fiMkZOvk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgACXx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 18:53:29 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45423 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbgACXx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 18:53:29 -0500
Received: by mail-lf1-f66.google.com with SMTP id 203so32818857lfa.12;
        Fri, 03 Jan 2020 15:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IkWuwHhNqLcza831ZlMeVrnl9ktIFXitOGr/KLniDZ8=;
        b=fiMkZOvkxr3/Ka139fV+tAEu9JXx99jZA4+ujYgmvL2yF5YWP9Tr04cRPJCjwQI2pU
         +gdWogmZwiOzXVseFUmxw0YnlKA2rfini6TsZF/LPKJkcoSFgv0s9b5Zmy+soFK41Z7Q
         D2NSm2hUtbVWTA2Q1rlnTJ6Hw4ddY30CNW6emOCNeg5E0lsuvwso2CgBYXneKD/J11vl
         qofxNzKLDUrHuUe1j0dw0eUMG7LAegBar2VMCh3hgIzMkoXDxMO3uhe5HoqGPw0F6fT5
         QG47+r4diPjGqUYAlHclycTZL8TqgY2vHyKGeuJx9lN6oBJt8Dzc2f/aoS1ZGF45w0+s
         ECtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IkWuwHhNqLcza831ZlMeVrnl9ktIFXitOGr/KLniDZ8=;
        b=XC1rGZT2pr1shVxoGXUb1Z1TV8U2cIT14IzDtThjgMGl8ZhRNg0NcPZXHJBtmv3TrR
         DZtBl0/tJ0f3I+T1p5SuM4DrVXBPoVQ9IrhrPtO8RBm5Tb/3rVDsQdrtOlKqwjkts3kN
         qo5Q6A3BsLGLD/UGqiGmxaqHu4/suf1MGY2PdhkWqmSx6n/0s+KZkBsagkOP/mFHHuf9
         5JUvLej/ZbpzXcU0fkCTURiBt9tlMe7Kt8jwSZ3v8laDDtN/PEVgZa+LbHF7pgqpywR7
         /quAOXNx6u2BT4L9DsCz0J44CAvmrV+RozejqZz4YEEUy0mAijdnG8RfEdgfHzUIzMyS
         1mbw==
X-Gm-Message-State: APjAAAV9K5+dGX5z+IVVXphtilIBX800YSF0Ysggz8N+X2Di2jXlkBR3
        7aWTvzU0L+gdLQE1cQBr7laa7w6b
X-Google-Smtp-Source: APXvYqxYnPraSPjUxGGCPLBWOykvd7sszKxpAFINbaJxoztv8+s1SAv8apNOvOV/UaIcDOph2saGKA==
X-Received: by 2002:a19:ca59:: with SMTP id h25mr50410860lfj.27.1578095606543;
        Fri, 03 Jan 2020 15:53:26 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id q11sm17503060ljm.76.2020.01.03.15.53.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jan 2020 15:53:25 -0800 (PST)
Subject: Re: [PATCH v3 10/16] usb: phy: tegra: Use device-tree notion of
 reset-GPIO's active-state
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <42f1d6c9-99f2-b829-0d2c-649fcdfb156d@gmail.com>
Date:   Sat, 4 Jan 2020 02:53:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200103075803.GC14228@qmqm.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

03.01.2020 10:58, Michał Mirosław пишет:
> On Sat, Dec 28, 2019 at 11:33:52PM +0300, Dmitry Osipenko wrote:
> [...]
>>  static int ulpi_open(struct tegra_usb_phy *phy)
>>  {
>> -	int err;
>> -
>> -	err = gpio_direction_output(phy->reset_gpio, 0);
>> -	if (err) {
>> -		dev_err(phy->u_phy.dev,
>> -			"ULPI reset GPIO %d direction not deasserted: %d\n",
>> -			phy->reset_gpio, err);
>> -		return err;
>> -	}
>> +	gpiod_set_value_cansleep(phy->reset_gpio, 1);
>>  
>>  	return 0;
>>  }
> 
> The message now removed seems inverted to the meaning of the code. Is
> this a bug, or the reset really should be asserted here?

The removed message was added in patch #2 and indeed it should say
"asserted". Good catch, thanks!

> I can see that
> it is deasserted in phy_power_up, but that goes before or after ulpi_open()?

The ulpi_phy_power_on happens after the ulpi_open, please take a look at
tegra_usb_phy_init().

> After the change below, the reset is asserted at probe() time now.

Yes, the probe now asserts the reset. It is an intended change because
it should be a bit better to explicitly per-initialize the GPIO state to
an expected state during of the GPIO retrieval, like most of other
drivers do and which should be a "generic/common way".

Actually, the reset assertion of ulpi_open() could be removed safely now
since it doesn't do anything useful, given that probe asserts the reset.

> [...]
>> -		err = devm_gpio_request(&pdev->dev, tegra_phy->reset_gpio,
>> -					"ulpi_phy_reset_b");
>> +		gpiod = devm_gpiod_get_from_of_node(&pdev->dev, np,
>> +						    "nvidia,phy-reset-gpio",
>> +						    0, GPIOD_OUT_HIGH,
>> +						    "ulpi_phy_reset_b");
>> +		err = PTR_ERR_OR_ZERO(gpiod);
>>  		if (err) {
>> -			dev_err(&pdev->dev, "Request failed for GPIO %d: %d\n",
>> -				tegra_phy->reset_gpio, err);
>> +			dev_err(&pdev->dev,
>> +				"Request failed for reset GPIO: %d\n", err);
>>  			return err;
>>  		}
>> +		tegra_phy->reset_gpio = gpiod;
> 
> A nice extension to kernel's printf - "%pe" format - has just landed in
> Linus' master tree.

Thank you very much, I didn't know about that.

I'll prepare v4 with the above things addressed, thank you again and
please let me know if you'll spot anything else!
