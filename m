Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E05C31E50
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 23:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B1D9217D6
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 23:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ZeLyUTv0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfFNX01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 19:26:27 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38530 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfFNX01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 19:26:27 -0400
Received: by mail-pl1-f196.google.com with SMTP id f97so1601380plb.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 16:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=txevGFdZuzBEDJGiWgJSEl3KtJMa2A1EwegQ2ClWo7Q=;
        b=ZeLyUTv0uYJ5hEPB7IEAFeiDjo7xDzKAvcGAl5pLbVYX7Le3G2x6V+kc+HKai82pKb
         KG2ze4kSons5LiQdoZW568SCESgX2Fa81ZPT4f90AkBercg6UABHZhjMl/NLPAU8C71a
         FLlPUcFVktoDfDyUEPwzlVS00DTHdHPQpD07mE7Sv8SumaVbnGe0JYvyJy0YA+9D/b9M
         uCOIILN48ezUlW5gQTzCMZh0oWZ0vMryGFBNotSmHJUDRT4CTmAb8ccpXuERhvH/NEY+
         RvxS9N2hWMHaxZkh7secmk9YrRNLKTij1eT4Mx5y3kDiuyQwPMOCvaXfbEtJ+lhYSse2
         UWcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=txevGFdZuzBEDJGiWgJSEl3KtJMa2A1EwegQ2ClWo7Q=;
        b=ISrbZQ6lnHO5mYZmpwJb7iMfLhXBQkvpo5eHuzspRv37Arv7koYztAcgsy1t5HKPX5
         dOBhhAHc6KzHr/GDNQvdDdR3s6oRwKCNAwgtOd08gzReCTTAtAOUwfFbUAIBX+eWFdAF
         pElhkdRnPbaw9I27/PWdGBsz44xNif4Mc0idnpdvfZzhxMeSV6mSU3UUxEed/I6dy1qF
         znV2rqKYQj6ErPaWRR54jYxmVn0VV44xUDH/Os+/DSoRZg31aSRaBZqGD5EiFsis+69v
         4efGGxbxJ/7HKOnLquJeJ1zuDH7M5eaCEdFU2Q+qzjv3a071lY+/tOtp8g8GSuZsNlki
         ws4g==
X-Gm-Message-State: APjAAAURYTAEMcoT7rMEWSCxjjtKvHo/F7h74UaJXajvR778jS2Klmh8
        8m7xhKr6RpLCoXQVSEFRDrcxlA==
X-Google-Smtp-Source: APXvYqzm5PDiqQqzsIvfn/LmZzXIR8BpV5+IdKHziBqsEa3r1EdH/tZs9utNM8iLfpFvrT8HIxiL1w==
X-Received: by 2002:a17:902:760a:: with SMTP id k10mr75503097pll.83.1560554786407;
        Fri, 14 Jun 2019 16:26:26 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id a3sm4508235pje.3.2019.06.14.16.26.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Jun 2019 16:26:25 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>, jbrunet@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: meson-g12a-x96-max: add sound card
In-Reply-To: <20190611150101.30413-1-narmstrong@baylibre.com>
References: <20190611150101.30413-1-narmstrong@baylibre.com>
Date:   Fri, 14 Jun 2019 16:26:24 -0700
Message-ID: <7h5zp7eokf.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> Enable the sound card on the X96 Max, enabling HDMI output using the
> TDM interface B, being aligned on other boards sound cards.
> SPDI/F support is also enabled to the physical toslink port and to HDMI.
>
> The internal DAC connected to the audio jack will be added later on, when
> driver support is added.
>
> Tested by running:
> tinymix set "FRDDR_A SRC 1 EN Switch" 1
> tinymix set "FRDDR_A SINK 1 SEL" "OUT 1"
> tinymix set "FRDDR_B SRC 1 EN Switch" 1
> tinymix set "FRDDR_B SINK 1 SEL" "OUT 1"
> tinymix set "FRDDR_C SRC 1 EN Switch" 1
> tinymix set "FRDDR_C SINK 1 SEL" "OUT 1"
> tinymix set "TOHDMITX I2S SRC" "I2S B"
> tinymix set "TOHDMITX Switch" 1
>
> then:
> tinymix set "TDMOUT_B SRC SEL" "IN 0"
> speaker-test -Dhw:0,0 -c2
>
> then:
> tinymix set "TDMOUT_B SRC SEL" "IN 1"
> speaker-test -Dhw:0,1 -c2
>
> then:
> tinymix set "TDMOUT_B SRC SEL" "IN 2"
> speaker-test -Dhw:0,2 -c2
>
> testing HDMI audio output from the all 3 ASoC playback interfaces.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Queued for v5.3,

Thanks,

Kevin
