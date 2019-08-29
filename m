Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44403C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 17:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18A982173E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 17:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="P1pISjr6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbfH2RJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 13:09:49 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37542 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727602AbfH2RJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 13:09:48 -0400
Received: by mail-pf1-f194.google.com with SMTP id y9so2491306pfl.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 10:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=kSCvC7aVTpQ+5LOQ01CXKZx0peCTBxlJNW1z1aZAAro=;
        b=P1pISjr61U4xB0MG3dgJBQVHmfOJJWK90GKoue2kLfUe0Fop2XP6stoFZIBeKcvh9+
         shq44hi6CMZn/Oltt7P6xvh0S7ywrEOkSw6SctxmynGF466/3BmPev8K/1uF84zI6RbH
         4tS7AOhquP4b/VwP5sK2pyxdHWR0sd48ydHizuoNqCGrGHy/2tY66wc8oyBPKyKmtpRt
         AI+JAUYpZLI1a/7Z+Ku0X6hfkQ8fYiCKUfnBl/knEfCapbe7VPhk5RsMTBJHHjf1e3+U
         2a0hfwcPclnAeZ8QC5JArj1K4yj2KMlbOlIKDFGpXaXoruQ9mj1hfhzBGPZpmM4OU3Wu
         6oZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=kSCvC7aVTpQ+5LOQ01CXKZx0peCTBxlJNW1z1aZAAro=;
        b=PLVeMg1lhMAYV6uOo6WgbYFX084BZ+wMpfCJcz8aJHivQBHalRBEZpQR1noz0As00G
         P9t/OtXiUCbujKG9u5TafAqqE6DwIYWJxANTfjoebFOrMDcQ+3rGeIS4cdjpSLI+VF3E
         7b7ladCTC8HTtnPpMkx7pDYO/dX0+5+ynq1ZxPbZql5rx6RPKHnsnsFSO2UZHd5yFGri
         fdVJUkW9ogX122WhsRCM3QB1thfjInPRx0x7Ob0HA41eKRxZc+c6Xi8A/7ni+SjJF7IL
         24atieNC97uL3xaMxZXrz9hzMmnyEWoHDcBZpJA3/RzBBC4N/tENvrHU6DbQOMk/9+O6
         Wl6g==
X-Gm-Message-State: APjAAAUu2P2yKda4gKlrQylt7wowPE/q1lChZ68lQAdTckIYwcHEck/R
        445PZbu46qti6jrJM8rTi5qxCg==
X-Google-Smtp-Source: APXvYqywtLj0EIwj8vrGaKEIe6n3GWqW4YuS6SjpLbQ2EYDKhDAJrlcrmdCGxwFe+Qvstx8Qi3oH8g==
X-Received: by 2002:a17:90b:907:: with SMTP id bo7mr11106379pjb.107.1567098588093;
        Thu, 29 Aug 2019 10:09:48 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id i9sm2554788pgg.38.2019.08.29.10.09.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Aug 2019 10:09:47 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] arm64: meson-sm1: add support for the SM1 based VIM3L
In-Reply-To: <70d75312-68f0-351c-26b8-0f357721dd9e@baylibre.com>
References: <20190828141816.16328-1-narmstrong@baylibre.com> <7hblw9rx8f.fsf@baylibre.com> <70d75312-68f0-351c-26b8-0f357721dd9e@baylibre.com>
Date:   Thu, 29 Aug 2019 10:09:46 -0700
Message-ID: <7h1rx3sxt1.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> On 28/08/2019 19:55, Kevin Hilman wrote:
>> Neil Armstrong <narmstrong@baylibre.com> writes:
>> 
>>> This patchset adds support for the Amlogic SM1 based Khadas VIM3L variant.
>>>
>>> The S903D3 package variant of SM1 is pin-to-pin compatible with the
>>> S922X and A311d, so only internal DT changes are needed :
>>> - DVFS support is different
>>> - Audio support not yet available for SM1
>>>
>>> This patchset moved all the non-g12b nodes to meson-khadas-vim3.dtsi
>>> and add the sm1 specific nodes into meson-sm1-khadas-vim3l.dts.
>> 
>> Reviewed-by: Kevin Hilman <khilman@baylibre.com>
>> Tested-by: Kevin Hilman <khilman@baylibre.com>
>> 
>> Basic boot test + suspend/resume test OK on my vim3L (thanks to Khadas
>> for the board!)
>> 
>>> Display has a color conversion bug on SM1 by using a more recent vendor
>>> bootloader on the SM1 based VIM3, this is out of scope of this patchset
>>> and will be fixed in the drm/meson driver.
>>>
>>> Dependencies:
>>> - patch 1,2: None
>>> - patch 3: Depends on the "arm64: meson-sm1: add support for DVFS" patchset at [1]
>> 
>> I tested in my integ branch where this series is applied, but I'm not
>> seeing any OPPs created (/sys/devices/system/cpu/cpufreq/)
>
> These patches were sent from your integ branch, on top of :
> commit 395df5af4c782ad19fb34b9a2009ca240eeb9749 (khilman-amlogic/v5.4/integ)
> Merge: 2fcc5666dd45 9557737987bb
> Author: Kevin Hilman <khilman@baylibre.com>
> Date:   Tue Aug 27 15:39:46 2019 -0700
>
>     Merge branch 'v5.4/testing' into tmp/aml-rebuild
>
> Rebuilt and retested, and I get the OPPs just fine :
> # cat /sys/bus/cpu/devices/cpu0/cpufreq/scaling_available_frequencies
> 100000 250000 500000 666666 1000000 1200000 1404000 1500000 1608000 1704000 1800000 1908000

Thanks for confirming.

Indeed, there was an issue with my most recent `integ` branch (it was
missing the driver side of some SM1 clocks.)  Fixing that issue, and
retesting this series it all works well.

Queuing for v5.4,

Thanks,

Kevin
