Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFEA2C31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 15:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8BBA2187F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 15:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Voz3JLvp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729202AbfFSPXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 11:23:01 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54851 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfFSPXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 11:23:01 -0400
Received: by mail-wm1-f67.google.com with SMTP id g135so2266915wme.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 08:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Btr9AY8nFOSZFQQa6OLvfTmDFBlPBiJQhlPwHQK99Bk=;
        b=Voz3JLvpp6hNRBtcCMY+hsLLUAxTwYSxNFffW5t0XZT/zlVyHLxlgMejP7hhVcCFlJ
         rPeaL2eDyAHs9KBNp+NtDRTB8y0J6TM6xQ+zBn/3nLEBbHQyGOttlO1fYcQ9+dEGuXoa
         vcfYBLeu+FQNxRmxhNX//Bk426aZWvjWeSae4fgi2+H9v+uBjQYLiI1Y+8qxT5IOKHZD
         VZSfHsRuzOQ93Va0JA+g1kfN9q9vKa287K6I3IJkJRfcJqBtMlq196FuZMuK8mLS4CX1
         Uxd33aM3duYuVMC4MSTe1dw1wzJWMjWMlMCksvIpNsDoN+mBnofstpfVI+hz4BHNXxl7
         fd5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Btr9AY8nFOSZFQQa6OLvfTmDFBlPBiJQhlPwHQK99Bk=;
        b=OSTJUuaeyNJzVQ4wz5w9FdvCgfyfgKI6uMVxgY63URGXbhEBdq7VFnIe6Y4pgeWZz5
         fxFeEd6OjmrXHsxhHkoTQ6IhIee5oJ0In/LdcT6EMyifQa4tDDEVXfcymhXTSLcP0qvg
         9asEdHMXoQMqT6AmuwS585tqWH9Dwvhd7POzufRd1RxUVrEbpCEZm5eJxI3gLE+DpK3a
         TCp350pAWnthzQG80EaqhwCWyO/fw6BkkYPnUX1hN0UopS13vWJRAM42iF55XP4XYwW2
         tE2Sg1msXy0UHx4fBamOG7JBTmYqkObSn42jAx0eNufyRrhJj6XnwiXBYSvhIx7bmSFm
         72jQ==
X-Gm-Message-State: APjAAAXATVpkEWOF9vUgGKMCRTI2d9Ft3ry5Q58TSekdrBxr8B9B6eu6
        H5uPRgEDCRG05/frCg5HCGMJxA==
X-Google-Smtp-Source: APXvYqx8TGPVPngaABxWz2gFmiu8TyKUlDsVMwrBAc/qnjWmednIBnI4pHR107r2KLKcpV2KR0Pxaw==
X-Received: by 2002:a7b:cb84:: with SMTP id m4mr9509470wmi.50.1560957777470;
        Wed, 19 Jun 2019 08:22:57 -0700 (PDT)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id s10sm17124521wrt.49.2019.06.19.08.22.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 08:22:56 -0700 (PDT)
Subject: Re: [PATCH] drm/bridge/synopsys: dw-hdmi: Handle audio for more clock
 rates
To:     =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@siol.net>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        seanpaul@chromium.org, heiko@sntech.de, jonas@kwiboo.se,
        linux-rockchip@lists.infradead.org, dgreid@chromium.org,
        cychiang@chromium.org, David Airlie <airlied@linux.ie>,
        Zheng Yang <zhengyang@rock-chips.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Vetter <daniel@ffwll.ch>
References: <20190617235558.64571-1-dianders@chromium.org>
 <6219398.I55JWXAmVF@jernej-laptop>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <9bba43cb-7070-8b2a-cfc6-f601fd22a315@baylibre.com>
Date:   Wed, 19 Jun 2019 17:22:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <6219398.I55JWXAmVF@jernej-laptop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/06/2019 19:23, Jernej Škrabec wrote:
> Hi!
> 
> Dne torek, 18. junij 2019 ob 01:55:58 CEST je Douglas Anderson napisal(a):
>> Let's add some better support for HDMI audio to dw_hdmi.
>> Specifically:
>>
>> 1. For 44.1 kHz audio the old code made the assumption that an N of
>> 6272 was right most of the time.  That wasn't true and the new table
>> should give better 44.1 kHz audio for many more rates.
>>
>> 2. The new table has values from the HDMI spec for 297 MHz and 594
>> MHz.
>>
>> 3. There is now code to try to come up with a more idea N/CTS for
>> clock rates that aren't in the table.  This code is a bit slow because
>> it iterates over every possible value of N and picks the best one, but
>> it should make a good fallback.
>>
>> 4. The new code allows for platforms that know they make a clock rate
>> slightly differently to pick different N/CTS values.  For instance on
>> rk3288 we can make 25,176,471 Hz instead of 25,174,825.1748... Hz
>> (25.2 MHz / 1.001).  A future patch to the rk3288 platform code could
>> enable support for this clock rate and specify the N/CTS that would be
>> ideal.
>>
>> NOTE: the oddest part of this patch comes about because computing the
>> ideal N/CTS means knowing the _exact_ clock rate, not a rounded
>> version of it.  The drm framework makes this harder by rounding rates
>> to kHz, but even if it didn't there might be cases where the ideal
>> rate could only be calculated if we knew the real (non-integral) rate.
>> This means that in cases where we know (or believe) that the true rate
>> is something other than the rate we are told by drm.
>>
>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> 
> Which bus is used for audio transfer on your device? If it is I2S, which is 
> commonly used, then please be aware of this patch:
> https://lists.freedesktop.org/archives/dri-devel/2019-June/221539.html
> 
> It avoids exact N/CTS calculation by enabling auto detection. It is well 
> tested on multiple SoCs from Allwinner, Amlogic and Rockchip.
> 
> Best regards,
> Jernej
> 
> 
Hi Douglas,

Thanks for your work !

If you could rebase on top of https://lists.freedesktop.org/archives/dri-devel/2019-June/221539.html
so we can make use of your extended N table with automatic CTS HW calculation, it would be great !

Finally could you add the plat_data tmds table as a separate patch to simplify review ?

Thanks,
Neil
