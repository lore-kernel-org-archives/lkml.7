Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAFDBC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 16:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C4332133F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 16:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Epxyky7N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbfCDQk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 11:40:26 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33670 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbfCDQkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 11:40:25 -0500
Received: by mail-lf1-f68.google.com with SMTP id z23so3996272lfe.0;
        Mon, 04 Mar 2019 08:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qHkmOhH9DvOvWv6aVRUew9TiCYNRN37JpICJc4EYrKw=;
        b=Epxyky7NDe/1cwhZLx75j+6nSLy1+0ekm9u3Yvags2nAlkRvfNAWmuNr68SPjDRN4+
         K8rNzPb6H4l6iC+P1otAcHbGYoeFPDyIfyWnVZVy0b19SWaOUJRzIKSnP08flDhPwgjy
         3TBPd82Claue56N4PvJK86sazXCr1pWpctfraRitwq4hF+hTD05XWRj+YHdUxu/iRwjl
         x8GRwZYWxQzenFak1/4iAlgJQFzZmcC4b02COSlobN2W/jLaLdZWMWPVtO5h/zGY37yY
         UYolb1z6Ato+pJ60dIXb5ahY04cBOZ++0iB+LJBMQ03PoCb4J/nVxT8Jxg4E027JNlYG
         TEFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qHkmOhH9DvOvWv6aVRUew9TiCYNRN37JpICJc4EYrKw=;
        b=hSA2oNdEzYYqEK8jAIMtBda8408XLhYojxBvfX+hvATvzlZZsDVGtVnzo7TspWcQMk
         qNb/+EQoWBjP2iqGXYp8F3+Y3Fs1/WftU86pXB5kTZiccvSULsdKejUnjDuj/CRJIAJ1
         c6GDEJy7jUAknvlQmeMdO0Rq0B0vtQ0N/x0xBcERSRQj7wFKaFxmyziySc0KgzwzenDe
         8Ug0opHzyZ36QvYMu7BTm3l4Z/n54yfsQuPxYPki56//hkjUdgXRmwDuA44+mbe/xAxp
         +69rwCAoUBzmZ6MpbsXEYjkD131RSYAyRRmY7pUs3oc0XboDfIDpo5D7BfQocjU+qCYn
         4L3g==
X-Gm-Message-State: APjAAAUjla8YShQw6rvgSQGDkJpfYZJyUqncFa0pVwxQp1m9W+uR2JlD
        7mpZoGvPc1xYIL+PqzLa0nde9oXq
X-Google-Smtp-Source: APXvYqwHm+km/9c3dwphxE/uvWS1mslApQIPW1rfbw6EBXJeiEA26+t3eQtzKT2a3klaHFrwuMpVGg==
X-Received: by 2002:a19:9104:: with SMTP id t4mr7695471lfd.22.1551717622964;
        Mon, 04 Mar 2019 08:40:22 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id x2sm1613768ljj.79.2019.03.04.08.40.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 08:40:22 -0800 (PST)
Subject: Re: [PATCH v9 1/7] ARM: trusted_foundations: Support L2 cache
 maintenance
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Robert Yang <decatf@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190303171214.24821-1-digetx@gmail.com>
 <20190303171214.24821-2-digetx@gmail.com>
 <20190304154729.GA13794@qmqm.qmqm.pl>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <f028feef-0875-5491-02ae-94258fc6c156@gmail.com>
Date:   Mon, 4 Mar 2019 19:40:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190304154729.GA13794@qmqm.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

04.03.2019 18:47, Michał Mirosław пишет:
> On Sun, Mar 03, 2019 at 08:12:08PM +0300, Dmitry Osipenko wrote:
>> Implement L2 cache initialization firmware callback that should be
>> invoked early during boot in order to set up the required outer cache
>> driver's callbacks and add the callback required for L2X0 maintenance.
> [...]
>> @@ -43,6 +46,11 @@ void register_trusted_foundations(struct trusted_foundations_platform_data *pd);
>>  void of_register_trusted_foundations(void);
>>  
>>  #else /* CONFIG_TRUSTED_FOUNDATIONS */
>> +static inline void tf_dummy_write_sec(unsigned long val, unsigned int reg)
>> +{
>> +	if (reg == L2X0_CTRL && val == L2X0_CTRL_EN)
>> +		pr_err("Trusted Foundations unavailable, ignoring request to enable L2C\n");
>> +}
>>  
>>  static inline void register_trusted_foundations(
>>  				   struct trusted_foundations_platform_data *pd)
>> @@ -53,6 +61,10 @@ static inline void register_trusted_foundations(
>>  	 */
>>  	pr_err("No support for Trusted Foundations, continuing in degraded mode.\n");
>>  	pr_err("Secondary processors as well as CPU PM will be disabled.\n");
>> +#if IS_ENABLED(CONFIG_CACHE_L2X0)
>> +	pr_err("L2X0 cache will be disabled.\n");
> [...]
> 
> I guess this is redundant since tf_dummy_write_sec() will say the same
> thing when trying to enable the cache.

Yes, thanks. I'll change that in the next iteration, for now will wait for awhile for more comments.
