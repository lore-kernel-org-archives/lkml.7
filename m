Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C46DC5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 19:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D94E217D7
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 19:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="q9IIk3N0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729435AbfKFTfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 14:35:53 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41848 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfKFTfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 14:35:52 -0500
Received: by mail-wr1-f68.google.com with SMTP id p4so27441253wrm.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 11:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=Svt0Prn9o6q9bRi2+Z71xLOP8eaZ+QBmItrF2aM0ga4=;
        b=q9IIk3N0mImL9Zq2/ZsglmYzRHe8LvSH4HOm2W+RTudvjNo5s5lAxnFr5bmJSNSw27
         Qw3oITHHNNjuSyYlXtyhNuzi75kFzY+upd6DMsEDo/jzMXzhf3EEDNelH3Fdi2cYhDky
         fRwv7kxmZrslp1sKm75QW/F8HM1WlNCid38gtm3uUiGtZLND5VsrEu3pzVtZQMgqbTBR
         mOyiZcWxhwz/98a3C2Mal9trGeroRzY5pqlHvOyJ+6YewtI7J/97G5MvL8CDEqUXgAKH
         v6ummHlWnV3CW56zPq85BsIA0hKvApNHdOGNV3NDDQT1VAYJyRyNS2nHbVSgmsFkkBek
         EfvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Svt0Prn9o6q9bRi2+Z71xLOP8eaZ+QBmItrF2aM0ga4=;
        b=r1icbelU/eelPJhZCNaclf/u/neuGZR/5Tnz2VdD6aFiF4c4aKnrlwGiVOj9VbGSlN
         1k59r2fAWQRmabXWIrDM87JGImmWcLgHRvd2Au9O72EfmM+N29zqjYHpDqTDCOTfpcNk
         9lEa0vafB+Cu6rND01Rx1cQsQf5vkoxaCrtdN6yDglQmZPBsgziOJ1sIGGcyC7ih8fd6
         wmXgbZcGk2cHCEsHABx+SzqplxPSWaFftzQE+F7RCv6Frq+0KOqgaXlE7PEcf5R9GoE8
         sO5dq4boawqfE+blPUOCKAbrRGddM2y/Y+RhrQFw6uCR8I3aBAce7Jzw4JI6WnpFZg6M
         4qAw==
X-Gm-Message-State: APjAAAXXj0zjzub5jhIpY1LaMaK7PfwGlWt/vcmnPjLOcQOTkiISPutf
        64pNkBqwgKBGMmsKjwqCcKALZw==
X-Google-Smtp-Source: APXvYqz6zkvJvFecNHz0gOcK2N6VovMdJvan9hQM6kndetNbNVDayZPMavQNRQqFjByWobWfaToSrQ==
X-Received: by 2002:adf:97dd:: with SMTP id t29mr4070073wrb.283.1573068950319;
        Wed, 06 Nov 2019 11:35:50 -0800 (PST)
Received: from localhost (amontpellier-652-1-71-119.w109-210.abo.wanadoo.fr. [109.210.54.119])
        by smtp.gmail.com with ESMTPSA id w13sm30928713wrm.8.2019.11.06.11.35.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Nov 2019 11:35:49 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: Re: [PATCH] arm64: dts: meson: khadas-vim3: move audio nodes to common dtsi
In-Reply-To: <7h4kzg7rev.fsf@baylibre.com>
References: <1571416185-6449-1-git-send-email-christianshewitt@gmail.com> <7h4kzg7rev.fsf@baylibre.com>
Date:   Wed, 06 Nov 2019 20:35:48 +0100
Message-ID: <7hk18c6bmz.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin Hilman <khilman@baylibre.com> writes:

> Christian Hewitt <christianshewitt@gmail.com> writes:
>
>> Move VIM3 audio nodes to meson-khadas-vim3.dtsi to enable audio for all
>> boards in the VIM3 family including VIM3L.
>>
>> This change depends on [1] being merged/applied first.
>>
>> [1] https://patchwork.kernel.org/patch/11198535/
>>
>> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
>
> Queued for v5.5, but...
>
>> -&frddr_a {
>> -        status = "okay";
>> -};
>
> This node doesn't exist upstream...

oops, nevermind.  I see it's not upstream because it's still in my fixes
branch.

Kevin
