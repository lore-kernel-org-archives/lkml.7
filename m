Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF8CC33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 16:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45248208C4
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 16:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJF0sSU3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbgAGQNR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 11:13:17 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39313 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbgAGQNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 11:13:17 -0500
Received: by mail-lf1-f65.google.com with SMTP id y1so118268lfb.6;
        Tue, 07 Jan 2020 08:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ymg9tFhRWBlYC+u+Mak0dVXKfWnjuwdtb1AElirNlro=;
        b=ZJF0sSU3ozdLy8r2JHnOWFm4CsgC2u7WWLvFAqvX8M+DlLjjE1D+jLaQD6zP82uWWB
         3IHKO46Gj+0Q++15yyc23fS4nrSK168BuzRwpNcl37LRATkan90NNwJCdM1F4pXdw1B6
         57adez0n6w0vrRusR8p89wkdiYGb9vvgiByRUUB3Mg9Ox2QC+KV7ZUxpR7btJXkaTcxt
         dRyigVTF8OQN59tlZ8Z61KCdlI54RaZWZXsOKSi1DWLO6vdy8tUjF2p2zaSiGQvFz8Jj
         UuYP09fSfJSdHGeewe42mtUReKHJH1FtDiCfXb+PuL2NPib0G9XikhzKPf9LoDy4TaNp
         qjuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ymg9tFhRWBlYC+u+Mak0dVXKfWnjuwdtb1AElirNlro=;
        b=qc6oJygq5VWH9LJrLr/MQkxEV34xO7yWni2v8De6Dt/zEDz7UNXu9lCs85NC2+vLaS
         E4hBCNLsyxb+GDf/XNwMpHTOx6jwhFgl5qdPVNX0Z+ymUZwsB5RVwIfppGfM7QoV2iw6
         8FWHBSulC0HSdltZbvF8wUq4/2UvUwvQ5EDtsbBwQpeoiE6tc9u8MCjYqPXXrN9iG7ZP
         3wUnQTgaNnCRsTJ0Wl6ojJlMeDFYmmb+N8gY1l//XGAKhz5uuE/rDPFcFq0rApwe+biO
         /ps/Mpjwx6o9N1wF7Hwdr/g9Zw4gVoh9qPXgcGUyTopSJdTbza93c/VuKUPuOw6kmFYF
         Ul2A==
X-Gm-Message-State: APjAAAUoia2VrvyUR56p3A757VHXylketfSWZ9q8oMydAKPCQ/ziV5P8
        BjJ4uflzrdTmQjjBpl3Lp82UJdyo
X-Google-Smtp-Source: APXvYqwncxIuEnNaBcuSFBD5ZgFQQ+d1c9tv03aE3H2OKwXUAxS9g9k6dKPyff5Sn/NM8qT502+u+Q==
X-Received: by 2002:a19:888:: with SMTP id 130mr117981lfi.167.1578413594903;
        Tue, 07 Jan 2020 08:13:14 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id n30sm78066lfi.54.2020.01.07.08.13.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2020 08:13:13 -0800 (PST)
Subject: Re: [PATCH v4 20/20] usb: host: ehci-tegra: Remove unused fields from
 tegra_ehci_hcd
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <Peter.Chen@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Felipe Balbi <balbi@kernel.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44L0.2001061014430.1514-100000@iolanthe.rowland.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <b5c262a9-4a7f-6293-e3c4-31ba4822cd12@gmail.com>
Date:   Tue, 7 Jan 2020 19:13:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.44L0.2001061014430.1514-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

06.01.2020 18:16, Alan Stern пишет:
> On Mon, 6 Jan 2020, Dmitry Osipenko wrote:
> 
>> There are few stale fields in tegra_ehci_hcd structure, let's remove them.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/usb/host/ehci-tegra.c | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/usb/host/ehci-tegra.c b/drivers/usb/host/ehci-tegra.c
>> index 1eb94205a5ac..d6433f206c17 100644
>> --- a/drivers/usb/host/ehci-tegra.c
>> +++ b/drivers/usb/host/ehci-tegra.c
>> @@ -42,12 +42,10 @@ struct tegra_ehci_soc_config {
>>  };
>>  
>>  struct tegra_ehci_hcd {
>> -	struct tegra_usb_phy *phy;
>>  	struct clk *clk;
>>  	struct reset_control *rst;
>>  	int port_resuming;
>>  	bool needs_double_reset;
>> -	enum tegra_usb_phy_port_speed port_speed;
>>  };
>>  
>>  static int tegra_reset_usb_controller(struct platform_device *pdev)
> 
> For patches 2, 19, and 20:
> 
> Acked-by: Alan Stern <stern@rowland.harvard.edu>
> 
> It's nice to see that patch 2 makes the sequence of events in 
> tegra_ehci_remove() exactly the same as the failure pathway in 
> tegra_ehci_probe().

Thank you very much for taking a look at the patches!
