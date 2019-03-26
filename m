Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30499C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9E8B20857
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ED38AvLY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731172AbfCZJGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 05:06:36 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51740 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727203AbfCZJGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 05:06:35 -0400
Received: by mail-wm1-f67.google.com with SMTP id 4so11708159wmf.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 02:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=RB6x0VJEacpS2eY4xQmvJBOHD6VE/EHmz1NdIikqC84=;
        b=ED38AvLYH+RHkvI5jdm7QKd00uGBFI2+VzTci7vOTbUWL3dL83NEp34IjnCU1LBKNy
         AL4Iq+Ue2uILvlnqyVcK5Q3Kzx2h764FHrMfsyqkkiL7oxClRjr0jIbkVF6mge8gnSzO
         dc8PR2lxhC6JdzTduiA4WzDptzsszN4zM1Px9k9MEUHJFUsEtuzrs6zNJdW1oegOF9fT
         bFmpqW/A3qby+5q4gBLSZM4LrypY4yPKY3UpLruF37v5gHn4NwiiIKfhzSRaIYmgMTUU
         LUXHnh6RxCT4N2hqLIIUaKj4jCwbjnWSQPnDw2e62LWChGq1t62fDV36i7te1x8P5ARU
         OTlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=RB6x0VJEacpS2eY4xQmvJBOHD6VE/EHmz1NdIikqC84=;
        b=mQc+u5sFmu7+R+DG9co0CTz+vJ9Mh5h+N6MsGPpft2q/rryfQtea8D9SlUUHRrlxty
         y3RddoJIG4dgAB5qv6j72O3Bs4+wmMIqVNxnl5qHg86D8v/wrkBVq4yv2V4DlVDXIGLh
         225t3X1kVRjUEfcPB63Z3gJTj5/TdDfoa3A/FwEAdugr/mL2QxewiHl36dOCMFU4P19J
         nNeVCizQ+WtZ9uKbMfv9fImPve8NnHNqdJRAZYPxLEjjWAUSizCHQ2esSReZw7KwZFaC
         cSuA4eFWDt7IZLZKUy8EZgikfHV7vtHnkwumtvvfTX1zAPSyEUeC7fex2mNDSDMH1t5e
         pXWw==
X-Gm-Message-State: APjAAAUzHkroxlUpBylA7lN70LZrmeBR6PXSsfw1z1SprZ8MqrUHs+/S
        f6PEenKfPvwrmgTHT8RlniCczpy/1ZCi6m9t
X-Google-Smtp-Source: APXvYqyp/fK3TuRu2I9sSZNu6n5gY1LlWqFoq0RYs6jCiF83959qbj2RFqfpJVy9gKIqc53Td95LCw==
X-Received: by 2002:a1c:9c0e:: with SMTP id f14mr14831806wme.78.1553591192843;
        Tue, 26 Mar 2019 02:06:32 -0700 (PDT)
Received: from [192.168.1.62] (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id y132sm17428466wmg.38.2019.03.26.02.06.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 02:06:32 -0700 (PDT)
Subject: Re: [PATCH 0/1] pwm: meson: fix scheduling while atomic issue
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     thierry.reding@gmail.com, jbrunet@baylibre.com,
        linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190324220217.15813-1-martin.blumenstingl@googlemail.com>
 <20190325084153.l44pzfewcqlkoaoe@pengutronix.de>
 <CAFBinCAn-9oETMKMfSXoJOMBrQyrCFN7AyHG02bQaoxG1px3YA@mail.gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <ec428b82-f7d9-0f14-363c-a40d14ce4414@baylibre.com>
Date:   Tue, 26 Mar 2019 10:06:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAFBinCAn-9oETMKMfSXoJOMBrQyrCFN7AyHG02bQaoxG1px3YA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/03/2019 18:41, Martin Blumenstingl wrote:
> Hello Uwe,
> 
> On Mon, Mar 25, 2019 at 9:41 AM Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
>>
>> Hello Martin,
>>
>> On Sun, Mar 24, 2019 at 11:02:16PM +0100, Martin Blumenstingl wrote:
>>> Back in January a "BUG: scheduling while atomic" error showed up during
>>> boot on my Meson8b Odroid-C1 (which uses a PWM regulator as CPU supply).
>>> The call trace comes down to:
>>>   __mutex_lock
>>>   clk_prepare_lock
>>>   clk_core_get_rate
>>>   meson_pwm_apply
>>>   ..
>>>   dev_pm_opp_set_rate
>>>   ..
>>>
>>> Jerome has also seen the same problem but from pwm-leds (instead of a
>>> pwm-regulator). He posted a patch which replaces the spinlock with a
>>> mutex. That works. I believe we can optimize this by reducing the time
>>> where the lock is held - that also allows to keep the spin-lock.
>>>
>>> Analyzing this issue helped me understand the pwm-meson driver better.
>>> My plan is to send some cleanups (with the goal of re-using more of the
>>> goodies from the PWM core in the pwm-meson driver) after this single fix
>>> is merged (they can be found here: [1]).
>>
>> I didn't look over these in detail, but I see an issue that according
>> to the shortlogs isn't addressed: In the .apply callback there is
>> (simplified):
>>
>>         if (!state->enabled) {
>>                 meson_pwm_disable(meson, pwm->hwpwm);
>>                 return;
>>         }
>>
>> This results in the wrong output after:
>>
>>         pwm_apply_state(pwm, { .enabled = true, .polarity = PWM_POLARITY_NORMAL, ...});
>>         pwm_apply_state(pwm, { .enabled = false, .polarity = PWM_POLARITY_INVERTED, ...});
>>
>> because the polarity isn't checked.
> let me rephrase this to make sure I understand this correctly:
> - applying a PWM state with .enabled = true and PWM_POLARITY_NORMAL
> will enable the PWM output
> - applying a PWM state with .enabled = false and PWM_POLARITY_NORMAL
> will disable the PWM output
> - applying a PWM state with .enabled = true and PWM_POLARITY_INVERTED
> will disable the PWM output
> - applying a PWM state with .enabled = false and PWM_POLARITY_INVERTED
> will enable the PWM output
> 
> in other words: the polarity doesn't only apply to period and
> duty_cycle but also to the enabled state.

Sorry I don't understand your point.
If the apply state is disable, well we disable the PWM output, I don't see why
the polarity changes the enable state.

I'd like to point out the architecture of the PWM.
The PWM is only a set of Gates, Dividers and Counters.

We achieve a PWM output by calculating a clock that permits us to calculate
2 periods (low and high) and we set the counter to switch after N cycles
for the first half period.

We do not have an explicit "polarity" setting, we simply reverse the period
cycles (the low length is inversed with the high length).

To apply the dividers and counters, we need to disable the PWM input clock
gate, set the dividers and counter and release the input gate.

So yes, we should maybe stop disabling the PWM for a long period of time
when we calculate the new settings, it can be fixed easily by calculating
the settings and applying in a separate code path.

But while re-reading the code, I can't find the issue you point at.

Neil

> 
>> If you want to implement further cleanups, my questions and propositions
>> are:
>>
>>  - Is there a publicly available manual for this hardware? If yes, you
>>    can add a link to it in the header of the driver.
> yes, it's documented in the public S912 datasheet [0] page 542 and following
> I'll add a patch which adds the link to the driver
> 
>>  - Why do you handle reparenting of the PWM's clk in .request? Wouldn't
>>    this be more suitable in .apply?
> Jerome's answer (not long after yours) basically covers this:
> - the assigned-clock-parents property could have been used but it wasn't
> - the driver could automatically set the correct parent, but this
> isn't implemented
> 
> (I assume this was done to keep it short and simple to for the first
> version of the driver)
> 
>>  - Does stopping the PWM (i.e. clearing MISC_{A,B}_EN in the MISC_AB
>>    register) freeze the output, or is the currently running period
>>    completed first? (The latter is the right behaviour.)
> I don't know, I would have to measure this with a logic analyzer.
> can you please explain why this is important?
> 
>>  - Please point out in the header that for changing period/duty
>>    cycle/polarity the hardware must be stopped. (I suggest to apply the
>>    style used in https://www.spinics.net/lists/linux-pwm/msg09262.html
>>    for some consistency.)
> I'm not sure about this. Amlogic's vendor kernel uses a modified
> version of this driver [1] which has an explicit comment not to
> disable the PWM output when changing the period/duty cycle.
> the PWM is configured with two separate registers (PWM_MISC_REG_AB
> contains the divider and PWM_PWM_A contains the high/low count).
> there's a short timeframe where the PWM output signal is neither the
> "old setting" nor the "new setting" (but rather a mix of both). what
> do other PWM drivers do in this case (if this is a common thing)?
> 
>> Another thing I just noted: The .get_state callback only sets .enabled
>> but nothing of the remaining information is provided.
> as far as I can see the PWM core uses .get_state only during registration:
> this means we should read (and calculate) .duty_cycle and .period from
> the register values. polarity always has to be "normal" since there's
> no information about it in the registers.
> 
> 
> Regards
> Martin
> 
> 
> [0] https://dl.khadas.com/Hardware/VIM2/Datasheet/S912_Datasheet_V0.220170314publicversion-Wesion.pdf
> [1] https://github.com/hardkernel/linux/blob/9a4a1f4b14fe66d7ebd73323b39fbf3bda9e1356/drivers/amlogic/pwm/pwm_meson.c#L381
> 

