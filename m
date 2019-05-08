Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A56C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 22:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAD15216C8
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 22:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Mfvex9BF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbfEHWmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 18:42:14 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45676 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbfEHWmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 18:42:13 -0400
Received: by mail-pf1-f196.google.com with SMTP id s11so181890pfm.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 15:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=BFe1QuxITumk3NtRUI5j6KVRf7tiVcFp6Ull8WpK1V0=;
        b=Mfvex9BFV2UhWcSvsxNqdfZF62RCtCtQrieU/ecep5z0+LlSwxbxe65oc8BqrABrVY
         D0GgFHhiO8JYLmuzd9gChNaLR/+E/4/JuekTQG9zwQPg75Bs8vW3zLWyFJjZSmvU3Wzh
         Rw4Yswz3b3zvMXAyyBahCY4JHGXRMcXjnuW49PAE3sO3I/urY9+uZjhcCAD0YoN02F6N
         3LLwm9nr6HAM+XI30F0kWBh2vNMSNm4yJqmJOHo6mrUCXT1peZ6OWylRIId699L57jnG
         WGOAag2H5f5NQtfOGri0KFAlW8SBMISCuDMeOc6pZx1RGPgYRw64zuvWYZZXU53m/Hof
         Kzyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=BFe1QuxITumk3NtRUI5j6KVRf7tiVcFp6Ull8WpK1V0=;
        b=GYzd804lEbsnHmb+eJyI8sWlKVuYsJ3U1i/AkWtrDmyUcqupO8YwQfLw98loWAWwc+
         pPdrn8dUsaLgaGHTwtYdYwlAcbaAXgXG9cE4RPLjG8t6aG3A4ClUAsI6D9PRCI3eYixi
         meA+REA2Nq6GOZYDcHR/eb1TAX0QfT692L0XLQKnpT8h/uajlmJ1Tl3x/iQz2kJ+hpG6
         hcePb/U0cDV/6X8Hrlb5iAAgRMRyidAm5IDkhC88aUN45Xwk6MYCFPgpyjrVf1n4Dp4a
         NMzteTxQ9dfcQibbaH2UYprNnSDkosOrFWnPgCgavFgwnNj1Cd/50wp+72gFfC/fo0F6
         rTCQ==
X-Gm-Message-State: APjAAAWvnAk33M6r8z3HGURSE5lyc4AMIK9itsVJhg0Hb9vee1l4kzuB
        +oYlEEaM32FnoLt1iCmdFyqElg==
X-Google-Smtp-Source: APXvYqx/VVXouF8rOT0oIb+thKazr2gkUBTz+7SSmre3OHZnik0jMYM3EW1igez7W+lucMT7jJVS3Q==
X-Received: by 2002:a63:1558:: with SMTP id 24mr900283pgv.126.1557355332383;
        Wed, 08 May 2019 15:42:12 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:a864:57af:5348:a6ea])
        by smtp.googlemail.com with ESMTPSA id u123sm376416pfu.67.2019.05.08.15.42.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 15:42:11 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>, thierry.reding@gmail.com
Cc:     baylibre-upstreaming@groups.io,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: meson-g12a: Add PWM nodes
In-Reply-To: <20190423133646.5705-4-narmstrong@baylibre.com>
References: <20190423133646.5705-1-narmstrong@baylibre.com> <20190423133646.5705-4-narmstrong@baylibre.com>
Date:   Wed, 08 May 2019 15:42:10 -0700
Message-ID: <7h7eb0in5p.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> This adds the EE and AO PWM nodes and the possible pinctrl settings.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Reviewed-by: Martin Blumenstingl<martin.blumenstingl@googlemail.com>

Since bindings are acked, and there's no build dependency on the driver
itself, queuing this for v5.3 (branch: v5.3/dt64)

Thanks,

Kevin
