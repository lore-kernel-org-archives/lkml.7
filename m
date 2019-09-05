Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68DBEC3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 13:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC0E52082C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 13:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="NNmVKe+g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731630AbfIENtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 09:49:25 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33138 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731008AbfIENtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 09:49:24 -0400
Received: by mail-wm1-f66.google.com with SMTP id r17so5060023wme.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 06:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=XBe7hapo8VIv9FGywEZnTde+FM9t0QipyXbz4HQwDik=;
        b=NNmVKe+gYj2zmCAKNEpHRXFel1XGOBUM5BdJv61MOU0uEeTYbur+2NxeQWpfXzezof
         CH105UK9xaziLMZYFSoJNixQiwBXLP6tRq8Y1pa8gH8hT/iJSnsJWXy1XoFfKixRSm/B
         cGWVRkTM6hDd+IEb0buHX/YlVSx+vovAHXAxc30bVWQDSNNlUfM2a4L66AcXR3+CKn5n
         aGzzIDchkSgpVPOORYF+4wO/RvE3esCw/SEs3XIsDJlbmDsL0N4xZLQdTzPtTizJAKbJ
         xsPflXJlJQWsf7L99jD0UlynAnl4UL8AtNRII68hK28T9sdVcAFSRbZvg4Ai1zvDKcMY
         Ne0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=XBe7hapo8VIv9FGywEZnTde+FM9t0QipyXbz4HQwDik=;
        b=gzPZLlm7xflYYdxLTCbBja+sji9l2GTla0r6E+w1QgvgwFYg2jyL0FX85TOfIRWycF
         jzVkCUbbMrNJSPvAnu4ieoTfL9bukBa+qXuWBrUxbl6+QCZBCHWc0Pc2C25QOSXVJS4W
         EgCZQMcizW7cjnAnMqQ7lMH/CEB7vaTCv0PkHbhpT1Ye+OHrNimeWXubFmTvXb5sDl9y
         g9FXVncw2isKsJgtF6u60N4P/AGwt2UY73uOD6jpQX7AZuxU1UNlnb4lY7EH8vBIlKDI
         2VBoHL69XJOj5VJsDVsffUpWe4aKRbydow7HfwuSBGewp5MWhuCABvml+PVeJxVobGmS
         8gWg==
X-Gm-Message-State: APjAAAV6ARYUU1VBoezpXtVWxKGJ3zYHUqXZK/Qc7S7TSJJVq8s4Mojm
        nxzURSLDmYGW2170qWO9hSFL+oCAzaFseg==
X-Google-Smtp-Source: APXvYqz5hvMVOU3GkSs3bnICjN9E5pOwumr/MJ++gxH6QbGJtQXlycSkXIi4pw0O7QGOXdpcl6Fptw==
X-Received: by 2002:a1c:1981:: with SMTP id 123mr3011546wmz.88.1567691361161;
        Thu, 05 Sep 2019 06:49:21 -0700 (PDT)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id h12sm2317165wrt.16.2019.09.05.06.49.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Sep 2019 06:49:20 -0700 (PDT)
Subject: Re: [PATCH] drm/panfrost: Fix regulator_get_optional() misuse
To:     Steven Price <steven.price@arm.com>,
        Mark Brown <broonie@kernel.org>
Cc:     David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190904123032.23263-1-broonie@kernel.org>
 <CAL_JsqK8hn8aHa0e-QhT5=dMqCd0_HzNWMHM1YbEC_2z8n-tXg@mail.gmail.com>
 <feaf7338-9aa1-5065-7a83-028aeadd5578@arm.com>
 <20190905124014.GA4053@sirena.co.uk>
 <93b8910d-fc01-4c16-fd7e-86abfc3cc617@arm.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <677fc044-6c12-6fb4-9d85-1e4d6c4b96ae@baylibre.com>
Date:   Thu, 5 Sep 2019 15:49:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <93b8910d-fc01-4c16-fd7e-86abfc3cc617@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/09/2019 15:02, Steven Price wrote:
> On 05/09/2019 13:40, Mark Brown wrote:
>> On Thu, Sep 05, 2019 at 10:37:53AM +0100, Steven Price wrote:
>>
>>> Ah, I didn't realise that regulator_get() will return a dummy regulator
>>> if none is provided in the DT. In theory that seems like a nicer
>>> solution to my two commits. However there's still a problem - the dummy
>>> regulator returned from regulator_get() reports errors when
>>> regulator_set_voltage() is called. So I get errors like this:
>>
>>> [  299.861165] panfrost e82c0000.mali: Cannot set voltage 1100000 uV
>>> [  299.867294] devfreq devfreq0: dvfs failed with (-22) error
>>
>>> (And therefore the frequency isn't being changed)
>>
>>> Ideally we want a dummy regulator that will silently ignore any
>>> regulator_set_voltage() calls.
>>
>> Is that safe?  You can't rely on being able to change voltages even if
>> there's a physical regulator available, system constraints or the
>> results of sharing the regulator with other users may prevent changes.
> 
> Perhaps I didn't express myself clearly. I mean that in the case of the
> Hikey960 it would be convenient to have a "dummy regulator" that simply
> accepted any change because ultimately Linux doesn't have direct control
> of the voltages but simply requests a particular operating frequency via
> the mailbox.
> 
>> I guess at the minute the code is assuming that if you can't vary the
>> regulator it's fixed at the maximum voltage and that it's safe to run at
>> a lower clock with a higher voltage (some devices don't like doing that).
> 
> No - at the moment if the regulator reports an error then the function
> bails out and doesn't change the frequency.
> 
>> If the device always starts up at full speed I guess that's OK.  It's
>> certainly in general a bad idea to do this in general, we can't tell how
>> important it is to the consumer that they actually get the voltage that
>> they asked for - for some applications like this it's just adding to the
>> power saving it's likely fine but for others it might break things.
> 
> Agreed.
> 
>> If you're happy to change the frequency without the ability to vary the
>> voltage you can query what's supported through the API (the simplest
>> interface is regulator_is_supported_voltage()).  You should do the
>> regulator API queries at initialization time since they can be a bit
>> expensive, the usual pattern would be to go through your OPP table and
>> disable states where you can't support the voltage but you *could* also
>> flag states where you just don't set the voltage.  That seems especially
>> reasonable if no voltages in the range the device supports can be set.
>>
>> I do note that the current code requires exactly specified voltages with
>> no variation which doesn't match the behaviour you say you're OK with
>> here, what you're describing sounds like the driver should be specifying
>> a voltage range from the hardware specified maximum down to whatever the
>> minimum the OPP supports rather than exactly the OPP voltage.  As things
>> are you might also run into voltages that can't be hit exactly (eg, in
>> the Exynos 5433 case in mainline a regulator that only offers steps of
>> 2mV will error out trying to set several of the OPPs).

In case we need a fixed voltage, simply add a new fixed-regulator in the board/soc DT,
use this regulator for panfrost and use the same fixed voltage in the OPP table.

It relies on a correct DT, but isn't is the goal of mainline linux ?

Neil

> 
> Perhaps there's a better way of doing devfreq? Panfrost itself doesn't
> really care must about this - we just need to be able to scaling up/down
> the operating point depending on load.
> 
> On many platforms to set the frequency it's necessary to do the dance to
> set an appropriate voltage before/afterwards, but on the Hikey960
> because this is handled via a mailbox we don't actually have a regulator
> to set the voltage on. My commit[1] supports this by simply not listing
> the regulator in the DT and assuming that nothing is needed when
> switching frequency. I'm happy for some other way of handling this if
> there's a better method.
> 
> At the moment your change from devm_regulator_get_optional() to
> devm_regulator_get() is a regression on this platform because it means
> there is now a dummy regulator which will always fail the
> regulator_set_voltage() calls preventing frequency changes. And I can't
> see anything I can do in the DT to fix that.
> 
> Steve
> 
> [1] e21dd290881b drm/panfrost: Enable devfreq to work without regulator
> (plus bug fix in 52282163dfa6)
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 

