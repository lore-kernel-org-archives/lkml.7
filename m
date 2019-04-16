Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEFD7C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 19:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 931BC20663
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 19:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Mc8Agh+D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730327AbfDPTAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 15:00:49 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45558 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbfDPTAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 15:00:48 -0400
Received: by mail-pf1-f194.google.com with SMTP id e24so10846674pfi.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 12:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=0JQV48hIzZ/FzBbugyzkr1KYXifoUeGs64dn0ua1AFY=;
        b=Mc8Agh+Dm9E+fghpZBYHDgk6Myzm+xHK0tOOVqkcGEEjEYe4Np574RwN6hWCIQGFB6
         5fMKN46SCAUcgDSyRvRMBhYw4v4QQNI8U0zLjn+vJ/xfF+KFPAHtKMuFn6KuCy2dEYYr
         P0C9/uHz1iq1X0y4P0Cl67tFNL/KmT5ItfwVojBnpS72E5uts6Qz/E54Rm6bpAzY05Gg
         YW5xxEmYUSiW2+lS+rGgH9OgZxA8wq9bnBtGLGYyYQmS0d0+174olX2LwdKCCaLq2dCF
         AzHYJM01pYmeqJJcmntHdXoGq7AHEc9fc3rRNlmhT4rE6cCsnWNY+1wqsOb2vlsLppbR
         tn3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=0JQV48hIzZ/FzBbugyzkr1KYXifoUeGs64dn0ua1AFY=;
        b=DYXYzivjKMFwtpQNVS18YcxnRbRDFa05L+iYHLXbGKgFNFdPL+ZyAOpJCRpnt4ZD5o
         adKgki/cWZcRC1JJtHZivIPbkiqFl+N0PykLWCQDpoceQl8WLfBWEYefHZAFXirm/k1Q
         1TZEKvy1IxDzEn1RXXpD/6ZgjAZ9hU6UP4F6KpkvEJQmVKGSK+lQnqyrvttJV2QriNdo
         i0s8TdjP1Y27d24LtbKqXADu6/k5vy2RtUUL//K8YAtK6fqy6Ziv0UuX7r+2MX3aZrQh
         0qGMnjbYyHBP1m/gj8knV8VNUsvFf+cItG9tMobXYrHVbcgost9UPOqO9ixK956Q5rvi
         lVMg==
X-Gm-Message-State: APjAAAXUeiuJaNwaveqjZvOhR4oMvrAR12UZ3cIz+HO5erKFjXNZismX
        Xkb+VA4FqGILyOC8JkFSAAZzng==
X-Google-Smtp-Source: APXvYqyMIZV/2yavc4XgCJu06lF8stLgFI1H3u1IzwkYXPNXJnSgnx0sv0MG3fc3+pTilBRPu1P1fw==
X-Received: by 2002:a63:4616:: with SMTP id t22mr78875699pga.217.1555441247191;
        Tue, 16 Apr 2019 12:00:47 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:c45e:7ed8:c242:3563])
        by smtp.googlemail.com with ESMTPSA id q74sm97636432pfc.111.2019.04.16.12.00.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Apr 2019 12:00:46 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jianxin.pan@amlogic.com, ccaione@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH 3/3] ARM: dts: meson8b: odroid-c1: prepare support for the RTC
In-Reply-To: <20190413163423.15149-4-martin.blumenstingl@googlemail.com>
References: <20190413163423.15149-1-martin.blumenstingl@googlemail.com> <20190413163423.15149-4-martin.blumenstingl@googlemail.com>
Date:   Tue, 16 Apr 2019 12:00:45 -0700
Message-ID: <7hwojtojvm.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> The Odroid-C1 has the 32.768 kHz oscillator (X3 in the schematics) which
> is required for the RTC. A battery can be connected separately (to the
> BT1 header) - then the "rtc" node can be enabled manually. By default
> the RTC is disabled because the boards typically come without the RTC
> battery.
>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  arch/arm/boot/dts/meson8b-odroidc1.dts | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/arch/arm/boot/dts/meson8b-odroidc1.dts b/arch/arm/boot/dts/meson8b-odroidc1.dts
> index 0157646e3a89..f3ad9397f670 100644
> --- a/arch/arm/boot/dts/meson8b-odroidc1.dts
> +++ b/arch/arm/boot/dts/meson8b-odroidc1.dts
> @@ -124,6 +124,14 @@
>  		io-channels = <&saradc 8>;
>  	};
>  
> +	rtc32k_xtal: rtc32k-xtal-clk {
> +		/* X3 in the schematics */

Always nice to see the names from the schematics.

Thanks!

Kevin
