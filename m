Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE9EC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDF12214C6
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="PvAGkyf/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731955AbfDAHZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 03:25:44 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40908 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731891AbfDAHZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 03:25:44 -0400
Received: by mail-wr1-f65.google.com with SMTP id h4so10472518wre.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 00:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=C3zeyacTUIM75PfS17F1GM1uexn2ZeAEk6WfGpXmlfM=;
        b=PvAGkyf/eE5bmgMNXxg/Xh/dHMKrI9nnt/kgiX1HQpe7E//YrkmooDfjUv8xmIIitS
         bTVtJzJrh1J3dBc9cZoUdCIl8s9DQaXaXOJqhca8ho9a3g2rr3e40Ub5kf5JcS8L5BSt
         vwicN7h3+1uFDpnCTDUoVhc7Z5T4GQu9YXEv+aeU8vjTGnU5SVa9/0dr48IWramZUh63
         noNefHoWUMCr5Ws++ZwwLyihCwqxFQG1pLSgRE0kqSCQxYrdhW36lxyBXYFlhgSmNRUI
         WEv2IPOGO2nEdwTsgX5PbzSZY5NBnXL21bFW5grYVduINTThcDQ4ySAaSs93zKlLgtQ5
         01Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=C3zeyacTUIM75PfS17F1GM1uexn2ZeAEk6WfGpXmlfM=;
        b=aUThZ3eUjKVEXgOoZaMdvACsiAOMGkzN5YKib/SJ6VUk/Rljn49aH0BiKBFVogRI4e
         Ltl3BT8GRGbOfl7mFEaR587bKQ6aylHkwk73ci3X0qAYSOrc7ip7/k1z4F7ZaWfNFigE
         Gn2QHg8pp0xL6UGnN7rs7I/PSh3fP3bCB996g0UPNUeZ8HF+FUexZourCljWQc0ZuQxk
         3uZz5f98fMIUhUFE+ZxIsTuQZH7fzgeX0xtLcGwqH7Y31Uqvmgzw6qnP/bS84pIJdb3a
         cn5pZdGsOdx7Y6u11LlO2GTGAU9IitUTmgZkyq7MZrr3ni9k40rLRzp6KWz8P1Z4lhK7
         urRw==
X-Gm-Message-State: APjAAAVItC7Ybtx8yNq6TrSNN1lW983uyHGUCgNcWhKpD+zh82+rj4TG
        Rr+xw3qHcsuQuFyXVdg5hyZqKw==
X-Google-Smtp-Source: APXvYqyujZM39rJ5POkm7/D4yTpFoaEC8iCRnjaH+RFx1MU8GLqI5XPjEnrTbnii2mROlFF6KtIdkA==
X-Received: by 2002:adf:dcce:: with SMTP id x14mr28929352wrm.315.1554103541660;
        Mon, 01 Apr 2019 00:25:41 -0700 (PDT)
Received: from [192.168.1.62] (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id r30sm22068537wrr.46.2019.04.01.00.25.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 00:25:40 -0700 (PDT)
Subject: Re: [PATCH 0/1] pwm: meson: fix scheduling while atomic issue
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     thierry.reding@gmail.com, jbrunet@baylibre.com,
        linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
References: <20190324220217.15813-1-martin.blumenstingl@googlemail.com>
 <20190325084153.l44pzfewcqlkoaoe@pengutronix.de>
 <CAFBinCAn-9oETMKMfSXoJOMBrQyrCFN7AyHG02bQaoxG1px3YA@mail.gmail.com>
 <20190325200730.cx73jgxfexz6ybzq@pengutronix.de>
 <CAFBinCCGWsb+1WHFe6uwrpUYgH4iix0WT8_v_Nj5BhGKRyjiLQ@mail.gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <1e6f9589-ff9a-f0fd-f12d-d680ffd58752@baylibre.com>
Date:   Mon, 1 Apr 2019 09:25:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFBinCCGWsb+1WHFe6uwrpUYgH4iix0WT8_v_Nj5BhGKRyjiLQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/03/2019 20:29, Martin Blumenstingl wrote:
> Hello Uwe,
> 
> On Mon, Mar 25, 2019 at 9:07 PM Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
> [...]
>>>>  - Does stopping the PWM (i.e. clearing MISC_{A,B}_EN in the MISC_AB
>>>>    register) freeze the output, or is the currently running period
>>>>    completed first? (The latter is the right behaviour.)
>>> I don't know, I would have to measure this with a logic analyzer.
>>
>> In practise you can do this with a multimeter, too. Just do something
>> like:
>>
>>         pwm_apply_state({ .enabled = true, .period = 5s, .duty_cycle = 5s, .polarity = PWM_POLARITY_NORMAL });
>>         pwm_apply_state({ .enabled = false, .period = 5s, .duty_cycle = 5s, .polarity = PWM_POLARITY_NORMAL });
>>
>> (assuming the PWM supports periods that long). The expectation is that
>> the last command takes nearly 5 s to complete and while it waits the
>> output is high and on return it's low. If that isn't the case, there is
>> a bug somewhere.
> the longest supported period (using the 24MHz crystal as input, which
> is the slowest input clock and thus gives the longest possible
> duration) is 349514407ns (that's approx. 0.35 seconds). my multimeter
> isn't fast enough to measure this so I'm using my logic analyzer with
> puleseview instead: [0]
> 
> I added the following code to meson_pwm_request:
>   struct pwm_state enable = {
>         .enabled = true,
>         .period = 349514407U,
>         .duty_cycle = 349514407U,
>         .polarity = PWM_POLARITY_NORMAL };
>   struct pwm_state disable = {
>         .enabled = false,
>         .period = 349514407U,
>         .duty_cycle = 349514407U,
>         .polarity = PWM_POLARITY_NORMAL };
>   pwm_apply_state(pwm, &enable);
>   pwm_apply_state(pwm, &disable);
> 
> this returns immediately. my logic analyzer doesn't see signal change
> (I'm sampling at 1MHz).
> 
> can you please confirm that my test code and measurement procedure is correct?
> if it is then my observation is that disabling the PWM does so
> immediately, without waiting for the current period to complete

I'm pretty 100,00000000000000% sure the HW doesn't permit waiting for a period to finish.

For disable states, we can either play on the period (high period at 0xffff for disable
at PWM_POLARITY_INVERSED and high period at 0 for PWM_POLARITY_NORMAL, if the HW behaves
correctly) or by adding some pinctrl states switching to GPIO modes and adding the
enable output high and output low property.

Neil


> 
> 
> Regards
> Martin
> 
> 
> [0] https://sigrok.org/wiki/Lcsoft_Mini_Board
> 

