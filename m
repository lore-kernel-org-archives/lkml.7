Return-Path: <SRS0=7h0X=2M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0C9C2D0C8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 21:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8FBD2067C
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 21:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o/pWomjH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfLVVsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Dec 2019 16:48:14 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46820 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbfLVVsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 16:48:14 -0500
Received: by mail-lj1-f194.google.com with SMTP id m26so13490104ljc.13;
        Sun, 22 Dec 2019 13:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iV2JaFYjdyqZDs2Zs17QJiFtp5Q2tDLfbKkGPZeyXhE=;
        b=o/pWomjH8LoXosHuW/rsJRPXnQisNZucUFilhnwjOLq8IM8q2zvmr1hc5MQn158dYS
         vjQxKARjC56Ob7XimUnVUiZgupJs0B81EUHVYySIIyOAM8I4wScfmc9RiDRhNSSoQXTC
         ffSRma8X+Zdd4FFAjab3DbBlvEyJxNrzTZSJY5NxLYv2iy1fuiu5PeoTz3iTn0/m2SKM
         DGiAKPbX1Cn2dSBiZAdMnkYR2WCET5EKrG7lg6cBJOT93TYO3EiRTkqAvKl/N8ap8to8
         m5vabg0MF93+bEfI19xWeHVHnAdHF45Xl4GsgEwgCAn2cVxSxPaWUZ0CAwqLBdPhhTiT
         0ybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iV2JaFYjdyqZDs2Zs17QJiFtp5Q2tDLfbKkGPZeyXhE=;
        b=Mjaaum04jXPlsLo+kK+eWOxAchYiHEy2po/Kludm1CxX4iUXzJrUB8ZL9PA97x0THw
         ZdmtorZjs50ZFsmZRxEo+rGay/ZLt52w8RvK/dDo0FY6ZaB7qID1abZrygg6MrfKQptY
         2k5G95HksByUPZ/7w7lL71mHMuSpUoRdPmXEPTW6JC7e4bnCn3xykJ+nJBiVKmeCrRzy
         ob6Zgh9v6R7eK4tKW6xp8KZJx+LwaJsO7MFW2aXLohb0iOIetKPfpSPtsZ7Qljq3VdJ2
         60ezcLpzm7lyr9IQgTflt33FXIB9Rub3dAOlYRTnuo/IvRNpY3TqERnyxlVLXKtlDPhe
         NT5Q==
X-Gm-Message-State: APjAAAVq7I1SQwuMb9YPXUvXcVaAkFxMk6KZpirobGLLw12Wojv47Vps
        fvKN8LDHapOW0Pzhw9SpnGGdDbBU
X-Google-Smtp-Source: APXvYqwOTqgvWce7/MVd7HoaiHFJL1T28xfufwZprUvX1/E5Sb2Gc8uiSryeL2yp7NWaqOg7LxqQvg==
X-Received: by 2002:a2e:86d6:: with SMTP id n22mr4754387ljj.77.1577051291473;
        Sun, 22 Dec 2019 13:48:11 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id x21sm7583782ljd.2.2019.12.22.13.48.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Dec 2019 13:48:10 -0800 (PST)
Subject: Re: [PATCH v2 08/10] usb: phy: tegra: Use u32 for hardware register
 variables
To:     Dejin Zheng <zhengdejin5@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <Peter.Chen@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Felipe Balbi <balbi@kernel.org>, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191220015238.9228-1-digetx@gmail.com>
 <20191220015238.9228-9-digetx@gmail.com> <20191222132227.GA7096@nuc8i5>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <6c0fbeb2-3db2-f331-fc0a-a900241a32f5@gmail.com>
Date:   Mon, 23 Dec 2019 00:48:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191222132227.GA7096@nuc8i5>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

22.12.2019 16:24, Dejin Zheng пишет:
> On Fri, Dec 20, 2019 at 04:52:36AM +0300, Dmitry Osipenko wrote:
>> There is a mix of u32/ULONG usage in the driver's code. Let's switch to
>> u32 uniformly, for consistency.
>>
>> Suggested-by: Thierry Reding <thierry.reding@gmail.com>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/usb/phy/phy-tegra-usb.c | 28 +++++++++++++++-------------
>>  1 file changed, 15 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/usb/phy/phy-tegra-usb.c b/drivers/usb/phy/phy-tegra-usb.c
>> index d5739b6e0b6c..551c94e3877a 100644
>> --- a/drivers/usb/phy/phy-tegra-usb.c
>> +++ b/drivers/usb/phy/phy-tegra-usb.c
>> @@ -202,7 +202,7 @@ static inline struct tegra_usb_phy *to_tegra_usb_phy(struct usb_phy *u_phy)
>>  static void set_pts(struct tegra_usb_phy *phy, u8 pts_val)
>>  {
>>  	void __iomem *base = phy->regs;
>> -	unsigned long val;
>> +	u32 val;
>>  
>>  	if (phy->soc_config->has_hostpc) {
>>  		val = readl_relaxed(base + TEGRA_USB_HOSTPC1_DEVLC);
>> @@ -221,7 +221,7 @@ static void set_pts(struct tegra_usb_phy *phy, u8 pts_val)
>>  static void set_phcd(struct tegra_usb_phy *phy, bool enable)
>>  {
>>  	void __iomem *base = phy->regs;
>> -	unsigned long val;
>> +	u32 val;
>>  
>>  	if (phy->soc_config->has_hostpc) {
>>  		val = readl_relaxed(base + TEGRA_USB_HOSTPC1_DEVLC);
>> @@ -320,7 +320,8 @@ static int utmip_pad_power_on(struct tegra_usb_phy *phy)
>>  {
>>  	struct tegra_utmip_config *config = phy->config;
>>  	void __iomem *base = phy->pad_regs;
>> -	unsigned long val, flags;
>> +	unsigned long flags;
>> +	u32 val;
> Why are you still using unsigned long here?

Please take a look at [1][2], the types are matching callees.

[1]
https://elixir.bootlin.com/linux/v5.5-rc2/source/include/linux/spinlock.h#L249

[2]
https://elixir.bootlin.com/linux/v5.5-rc2/source/include/asm-generic/io.h#L297
