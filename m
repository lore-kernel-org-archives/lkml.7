Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014B3C4646C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 23:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1FB420674
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 23:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="fNoiNIAl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbfFXXPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 19:15:33 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:32780 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbfFXXPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 19:15:33 -0400
Received: by mail-pl1-f193.google.com with SMTP id c14so7732836plo.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 16:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=2IMAKyHpnPJ1yDvedXi3maHRvnqNVDYJ2coEjzpqvcg=;
        b=fNoiNIAlRLn2QPb90BjGH37+vFNKA/mLAyGEzncUaIUNKlz7FLzTUan3SXPxa1rNq8
         7saw0x1+SkHrlvHHaLtCzAuR7AUl5tVeWeM7dauo2/iU1K+AVzbwctFJ5zSEeVx94FuT
         7MMlmAJrW3AOOmVZ7ElmnT16ufcPs1Zow5dWLjMaqdWX+cWwAom1Wk+c0lBAehDJdbr2
         unMFbvikaH6zQO3eS25IrkX5zlnygUySo3Ybd8VG/p9wqDGJZ0CibWSLbx/Bn46+GRrn
         C9SbdikcTznE1mRjY+HDMes2guFt2BWypwoXZuPoBwsmUusAWHuddfXUtfS0d8dJlRFd
         Hhqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=2IMAKyHpnPJ1yDvedXi3maHRvnqNVDYJ2coEjzpqvcg=;
        b=TO/VHDfNgZuosCbLE/rc3Fwf9Rwj4fMAR9RoLA5uH5wun4zCPsdLVj96BMBuClCk5b
         t0KVvENrXJMk4gOlTZSBiMvy6RCAXFQaOuKq8Neus7tVh1U3IlNl2YZXMIEMAr4yhmtW
         mgkBgBovj3NPyWW9cmj1i4RsP8N9F+kXHYlneLahtT0pq1TEvOC9aYT8quIQQUZxzLK8
         M188uG0gnDJ7BjMsClOgzeTP/ExVFAZ6toD57zPvXh0upCkDwy5hm9QaxPyAkAn9b8KO
         M4ZaLV+ETI3g2GHS/QCHG9gbHafoVwpIypwcT/fVEB9uS0ThEux+aXFrAYXdKpeAlDrx
         dvdQ==
X-Gm-Message-State: APjAAAWszvGRNRbCm8OBsmagyPlFXnEybSuGCK93N7aCggsnX6MGJAkF
        MmwrmWOc7IlGCzTCgYTUpLF5OA==
X-Google-Smtp-Source: APXvYqwROTeApbbRvj7XZr2xOey7lePNY05i1p2vtda9bu6wK0pvM2dbxuFwX8hcBJqIgVsFRVqElQ==
X-Received: by 2002:a17:902:42d:: with SMTP id 42mr144122426ple.228.1561418132182;
        Mon, 24 Jun 2019 16:15:32 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:559b:6f10:667f:4354])
        by smtp.googlemail.com with ESMTPSA id v9sm16566583pgj.69.2019.06.24.16.15.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Jun 2019 16:15:31 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     86zhm782g5.fsf@baylibre.com,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Julien Masson <jmasson@baylibre.com>
Subject: Re: [PATCH 4/9] drm: meson: vpp: use proper macros instead of magic constants
In-Reply-To: <86tvcf82eu.fsf@baylibre.com>
References: <86zhm782g5.fsf@baylibre.com> <86tvcf82eu.fsf@baylibre.com>
Date:   Mon, 24 Jun 2019 16:15:28 -0700
Message-ID: <7h36jyy3qn.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Julien Masson <jmasson@baylibre.com> writes:

> This patch add new macros which are used to set the following
> registers:
> - VPP_OSD_SCALE_COEF_IDX
> - VPP_DOLBY_CTRL
> - VPP_OFIFO_SIZE
> - VPP_HOLD_LINES
> - VPP_SC_MISC
> - VPP_VADJ_CTRL
>
> Signed-off-by: Julien Masson <jmasson@baylibre.com>

[...]

> @@ -97,20 +97,22 @@ void meson_vpp_init(struct meson_drm *priv)
>  	else if (meson_vpu_is_compatible(priv, "amlogic,meson-gxm-vpu")) {
>  		writel_bits_relaxed(0xff << 16, 0xff << 16,
>  				    priv->io_base + _REG(VIU_MISC_CTRL1));
> -		writel_relaxed(0x20000, priv->io_base + _REG(VPP_DOLBY_CTRL));
> -		writel_relaxed(0x1020080,
> +		writel_relaxed(VPP_PPS_DUMMY_DATA_MODE,
> +			       priv->io_base + _REG(VPP_DOLBY_CTRL));
> +		writel_relaxed(0x108080,

nit: still a magic constant here, and it's not obvious why it's
different from the current one.

Kevin
