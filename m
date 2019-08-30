Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175EEC3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 07:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D058A21897
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 07:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="BrEbiUqf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbfH3HbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 03:31:11 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38330 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbfH3HbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 03:31:11 -0400
Received: by mail-wm1-f65.google.com with SMTP id o184so6303711wme.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 00:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=eT0V9By0wFOQbPXq6H4vvmj3LHP78Pt4zF687HucEZU=;
        b=BrEbiUqfta0ytJ1900WPvFX7spWQ+TDoAzBxqX6mDdxRoSlNEcU0R5WVAf9vhO9KeQ
         RS0CDXWvw5LgU/cTijsQ0GR4LC1aaFnKTQ3rNnGTpCo9E6o5X+RXmeOqWm89WgMg1dDo
         j7SI/sZlj/qo4HGcDMbPQ5VaH5WomS20xtsva/trCFfbFANoHH1AEVZ8QS8h1SNBpAYH
         wwJj1MHgErXGliymGwWD1o7k5IHqNIibm9VjD9LrfrRLaUfTrcbaA7dEo6ND3pZcpoWi
         oR6kyyRc/yCIjt9BhKx1/tOMT/SOZ5IbAO2lCSeQ+fzDeCej1vM+XrIuq8fesWlp1e5J
         7CEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=eT0V9By0wFOQbPXq6H4vvmj3LHP78Pt4zF687HucEZU=;
        b=EnCuV+5GFXhOVg7ZI4NNaXSjYn0uD+MWp/HUV/y8JZuHoQmvPy13O77PiqLikD4nJp
         epFeKGDU6v9dIr2sBJe3XEO5tAjcWzV+nkOScsuuE6foh3MSddxQBmT01El8JmS4UQhB
         5XBGTLd6sFT8QQWCmAkwziWHbBFIpDrK7UJbEgaVAD+pj5iw1IKTuSUNjLIi6Dhtrtve
         w7BrN1ghZUTH46/qoiMpdqiRFjpHbJbbjD6f9v+l805t4MKSJFyJP4QnRllM28tVz4MF
         m6UWkdgzQv9P9nUtBGRJI7W/uVsRJ9evlgz54WO3Qv0x+L6kkTbk44EAfhAZBezoSOMt
         YIIA==
X-Gm-Message-State: APjAAAXADj6ouY5cFcyEgP4p8x4/l+eisZj5UTvZ0LQW6/m5IzPkVRJ/
        EnvnpR/OXJzFEY/d4UrxD4rb5knlpeFkig==
X-Google-Smtp-Source: APXvYqxXcMOWh19YnabgtyHTqH8xVJ2EuxiFv86HFpNTTKT/Hj/XNspHRc2IP5QiTflz7jrI8x0LoA==
X-Received: by 2002:a1c:720e:: with SMTP id n14mr8249776wmc.54.1567150268718;
        Fri, 30 Aug 2019 00:31:08 -0700 (PDT)
Received: from [192.168.1.62] (wal59-h01-176-150-251-154.dsl.sta.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id n8sm10261657wma.7.2019.08.30.00.31.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Aug 2019 00:31:08 -0700 (PDT)
Subject: Re: [PATCHv1 0/3] Odroid c2 missing regulator linking
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
References: <20190828202723.1145-1-linux.amoon@gmail.com>
 <8c40f334-c723-b524-857c-73734b7d0827@baylibre.com>
 <CANAwSgShr-K-44UzdxFC7pvpTye_pbEMdS6ug1eWwYhnsVNGdQ@mail.gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <101a12ac-1464-8864-4f8c-56bb46034a08@baylibre.com>
Date:   Fri, 30 Aug 2019 09:31:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CANAwSgShr-K-44UzdxFC7pvpTye_pbEMdS6ug1eWwYhnsVNGdQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/08/2019 20:35, Anand Moon wrote:
> Hi Neil,
> 
> On Thu, 29 Aug 2019 at 13:58, Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> On 28/08/2019 22:27, Anand Moon wrote:
>>> Below small changes help re-configure or fix missing inter linking
>>> of regulator node.
>>>
>>> Changes based top on my prevoius series.
>>
>> For the serie:
>> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
>>
> 
> Thanks for your review.
> 
>>>
>>> [0] https://patchwork.kernel.org/cover/11113091/
>>>
>>> TOOD: Add support for DVFS GXBB odroid board in next series.
>>
>> I'm curious how you will do this !
> 
> I was just studying you previous series on how you have implemented
> this feature for C1, N2 and VIM3 boards.
> 
> [0] https://patchwork.kernel.org/cover/11114125/
> 
> I started gathering key inputs needed for this ie *clk / pwm*
> like VDDCPU and VDDE clk changes.
> 
> But it looks like of the complex clk framework needed, so I leave this to the
> expert like your team of developers to do this much quick and efficiently.

On GXBB, GXL, GXM and AXG SoCs, CPU Frequency setting and PWM Regulator setup is
done by the SCPI Co-processor via the SCPI protocol.

Thus, we should not handle it from Linux, and even if we could, we don't have the
registers documentation of the CPU clusters clock tree.

SCPI works fine on all tested devices, except Odroid-C2, because Hardkernel left
the > 1.5GHz freq in the initial SCPI tables loaded by the BL2, i.e. packed with U-Boot.
Nowadays they have removed the bad frequencies, but still some devices uses the old
bootloader.

But in the SCPI case we trust the table returned by the firmware and use it as-in,
and there is no (simple ?) way to override the table and set a max frequency.

This is why we disabled SCPI.

See https://patchwork.kernel.org/patch/9500175/

Neil

> 
> Best Regards,
> -Anand
> 

