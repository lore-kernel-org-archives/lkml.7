Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F020C31E50
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 23:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF159217D6
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 23:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="I6dxrrNm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbfFNX0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 19:26:14 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35834 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfFNX0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 19:26:14 -0400
Received: by mail-pg1-f196.google.com with SMTP id s27so2363243pgl.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 16:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=X0PaE8UgoSXCd5aH+z1B3Qe35NkfrQQNqk1NT+8oFYY=;
        b=I6dxrrNm0Se40AINnZKnyGQJ06/YQci/tt03JWr+PGNRuMl/6+Hov9DrEm575HWHSk
         V9VysQXgsdArAItkM+P5p30FxsyGS/OvIHA3GVfrNLcMkTCzNth27BnGvGSecv/UYYKe
         m9mar59Z3WQJDD07KEadz1JVDhXTqioVAc5hMvLtwLL+o8a+bpXrIp9mX6HH7q23UK5x
         vmI6E85am3K1i3hm3pxlQDrXPuhAieTErM2TOkN9pgigqOT+yT9orTFLscdibRzdfVZg
         B5ebeZydNzHStUkxJ6nfO9mwZstU/6PqUqqlSIYlJ+KqWtdXZn9hRwFlSVyKEOUOh2tJ
         grLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=X0PaE8UgoSXCd5aH+z1B3Qe35NkfrQQNqk1NT+8oFYY=;
        b=WU4WR2erDBSrWhZklJpRntykhFIu9Gj5tSfkkMP75vY0lEkiPZwS3PvavWaQKnHcwF
         hYEGuCGvZECV9mA6uKh0ytHwQVGqg3QcIoBGOAEpJxVywfS7bH0Ufa/O2tLBBHKWIDDT
         eiqfQnN3w82CGZJordGB6CUMA3kciP7cjUuUeDfAlbCHlX60DWf75kETstF4mTc77694
         h145Dp6sGM03sPwwcdISaJSrpVhxhw3GC8PMLOV1lkj4pCPSKXLXTjQqAwfV81nHYDGY
         ljMJili+J0ucBQUP8Hz1NtSd6gsWsdHXwHUWJeOPjwidfNzrTqMDuLGlvYq5lYzc31lC
         3WQw==
X-Gm-Message-State: APjAAAV14iR9Ndq2zpRhX7/ExjqGnluWHoMzjsQmCUksyntj61v/j78e
        jiLGvSYtIe2JGB1AgVMCIG4LnOrA/8I=
X-Google-Smtp-Source: APXvYqzPsMayZPDa651TozhfBKS4Z0Ea6ktolXjYCwX53TQIkUwRp3PKK3Daaxs62z9Bgmauuz/pVA==
X-Received: by 2002:a17:90a:9503:: with SMTP id t3mr13459977pjo.47.1560554773640;
        Fri, 14 Jun 2019 16:26:13 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id e184sm7032630pfa.169.2019.06.14.16.26.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Jun 2019 16:26:12 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>, jbrunet@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: meson-g12b-odroid-n2: add sound card
In-Reply-To: <20190611143120.25074-1-narmstrong@baylibre.com>
References: <20190611143120.25074-1-narmstrong@baylibre.com>
Date:   Fri, 14 Jun 2019 16:26:12 -0700
Message-ID: <7h8su3eokr.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> Enable the sound card on the Hardkernel Odroid-N2, enabling HDMI output
> using the TDM interface B, being aligned on other boards sound cards.
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
