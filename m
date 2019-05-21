Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B78C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 07:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2174521019
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 07:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ztqxpie7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfEUHp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 03:45:28 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36888 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfEUHp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 03:45:27 -0400
Received: by mail-wm1-f65.google.com with SMTP id 7so1756562wmo.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 00:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7W2uW0GKbANg0YRRJwfDi3S83JuyE8bC4TgR386g+ig=;
        b=Ztqxpie7c7XA0ZxhayhLFU5YfLTiyHUepsEAmGYq+FUlQAfXb3LwgAtRxGq3DBMLDp
         sAAXnOa9PYGcZ2g3jo2609OGB/QROfchy98+Lz36qwm1cKApYb3XTOi+Fp9cR8bVxbXX
         QV+o57b8E7XeETrpYw4/yQsK5KmNqLoEwQFrC4dJdS3WKZ6c1N5mTanXGuLa48ZI4/Ju
         kuXzRua9Q0TL1j1xdYisI51IrpaRbwBKzlhgJLH1nVvULMnfAGM+/MOoxzlW5IpXIvk7
         nD1ATrlT7CCZu3wOLugC1MEkaGYXRLATx+0g0WSbNuhvwOd2J1mwx5rEy2A8ApafFmxY
         7ImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7W2uW0GKbANg0YRRJwfDi3S83JuyE8bC4TgR386g+ig=;
        b=ovTKTpJcmMuGCU938JwjAV6MdFzSqP/vi9NX5IUkUePiDNrS8VohM9HK3xlemuXmdT
         8NHXSQt4FB/nyaJp37IYGB4uLrhMUlLEyIjMmZ8fUnQcMtjYGWwxtK581svOAHo/i5wm
         ahTlrP8d907RhKalS2HAqbf8YSt7dg8x6s8NCun0x6lO5wm0xz8aZf7IHrTKLy99EO+c
         UJHEnf21DSQAL5S041xp0llcSrSxqAkQPMGVs8+J0UTcuTEWrhUZ8RUzEghZDqijHTJY
         3fH9s6cDxd5aKheGtfGM4ZVEPMpAHr0JHoS2x2Ziz/d7PMAvOGESZq9nqRHlFh4Bzv8N
         Z1Rg==
X-Gm-Message-State: APjAAAXOf5L74C6+YCwBuuBINX+4/4M/cCjHqwICmw06PPZflwnzAPIl
        ow7QN+WukMvsBbtwF1hjRPWq9IVJRQNfHQ==
X-Google-Smtp-Source: APXvYqyxfn6nygtboQpBoFArmbb8LvGA5vlw84HB75QJRhHbSdB1cLdCnbsbPzvasZc5W/5o+FBHzg==
X-Received: by 2002:a1c:9e8e:: with SMTP id h136mr2140540wme.29.1558424725333;
        Tue, 21 May 2019 00:45:25 -0700 (PDT)
Received: from [10.1.203.87] (nat-wifi.sssup.it. [193.205.81.22])
        by smtp.googlemail.com with ESMTPSA id u7sm6381826wmg.25.2019.05.21.00.45.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 00:45:24 -0700 (PDT)
Subject: Re: [PATCH] clocksource: timer-meson6: update with SPDX Licence
 identifier
To:     Neil Armstrong <narmstrong@baylibre.com>, tglx@linutronix.de
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190520140007.29042-1-narmstrong@baylibre.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <4262cc03-51eb-67fd-b899-61a2ed03dffa@linaro.org>
Date:   Tue, 21 May 2019 09:45:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190520140007.29042-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/2019 16:00, Neil Armstrong wrote:
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---

Applied, thanks.

  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

