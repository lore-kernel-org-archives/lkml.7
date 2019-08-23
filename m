Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5859C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 20:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A208721848
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 20:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Z8fHU3xa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392935AbfHWUzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 16:55:24 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39277 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392871AbfHWUzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 16:55:24 -0400
Received: by mail-pg1-f196.google.com with SMTP id u17so6398279pgi.6
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 13:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=DOMSbUFejjbvhh3syNx2mPd1ccD1hkCqGREmnUI4Bh4=;
        b=Z8fHU3xaHyWUdk8aM+/Zr1k32eHFHXEUQIEGhm0QTklwjF6o2yeRak8xLVTnReEHws
         mnfMwuQHrRUYoES3KexwZ32OsGrcnrb1s9qJzgF9ziCfP9tYYhWZXUSlT/TmnyHCQoSD
         EH2wLU7ldNI647pM/cNY8j+L2MWrI3yOfrObg6w/dFr02If3S0v5jO00vVaybZ04gUw6
         SZaeYbscZ35Rk1qZJNQq70E3JvuhKldBFpRGdwFURY39FdTznEdVQq7XzppcqHi7VNkr
         hf3Uysejz+aJrF8U3J3YFeAoa5fEXvw8IQqJjVHzxN+LCfK73FdybzahiiwbNaM6mbwE
         JLmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=DOMSbUFejjbvhh3syNx2mPd1ccD1hkCqGREmnUI4Bh4=;
        b=kOgIl8vYekaLw5kQC6JzE8nJ6YSLREpwBBz23a3UovH7ksaInvxn3scGm+y9gtsvrR
         TpiguDgPM+4UEOPfDBypUv3Q3p34axl8MbDnlFUiPvMBpoic5ZV3uBv9mNEBao2YiYoq
         /KJZt4eHJV/drk6OQUEwM9ofmGWnKJqMWHkyP69ziF6twQew6lM5DEmEa6rJJ3I+Tyh9
         U+JR4v614U+IcKyc7Xb5okqWwc5waCRpFINJ2+WXYKwqRREof5Oas/tFg4VxsJww8SlH
         rZWoRRtxcaK4ycpcBknXy6F0yJCh8BCLKm8q4a00mFSz9j8A1VaFBXUN8C41Uraa43M1
         7AWw==
X-Gm-Message-State: APjAAAUV0wUm98joHVwdKJE3Ruwu1VN4pf54XCYGterzu21gpdr+urRD
        uqEHUwb1rD791lv8HbMctMSnNHpNEEU=
X-Google-Smtp-Source: APXvYqwWqXwZanA/RIBsBivTmQ7OMMhM9wxbpGObupZqpUyHXrFJ3OB2nqQJqczKD3p98hiZv47Gzg==
X-Received: by 2002:a17:90a:f995:: with SMTP id cq21mr5481913pjb.27.1566593723715;
        Fri, 23 Aug 2019 13:55:23 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:89d4:68d1:fc04:721])
        by smtp.gmail.com with ESMTPSA id w10sm3132874pjv.23.2019.08.23.13.55.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Aug 2019 13:55:23 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Chrisitian Hewitt <christianshewitt@gmail.com>,
        Oleg Ivanov <balbes-150@yandex.ru>
Subject: Re: [PATCH 3/3] arm64: dts: meson-g12b-ugoos-am6: add initial device-tree
In-Reply-To: <1566565717-5182-4-git-send-email-christianshewitt@gmail.com>
References: <1566565717-5182-1-git-send-email-christianshewitt@gmail.com> <1566565717-5182-4-git-send-email-christianshewitt@gmail.com>
Date:   Fri, 23 Aug 2019 13:55:22 -0700
Message-ID: <7hv9uny539.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Hewitt <christianshewitt@gmail.com> writes:

> Tested-by: Oleg Ivanov <balbes-150@yandex.ru>
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>

nit: empty changelog.  I'd rather see the changelog from patch2 here.

> ---
>  arch/arm64/boot/dts/amlogic/Makefile               |   1 +
>  .../boot/dts/amlogic/meson-g12b-ugoos-am6.dts      | 567 +++++++++++++++++++++
>  2 files changed, 568 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-ugoos-am6.dts
>
> diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
> index 07b861f..21e2810 100644
> --- a/arch/arm64/boot/dts/amlogic/Makefile
> +++ b/arch/arm64/boot/dts/amlogic/Makefile
> @@ -4,6 +4,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-g12a-sei510.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-g12a-u200.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-g12a-x96-max.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-g12b-odroid-n2.dtb
> +dtb-$(CONFIG_ARCH_MESON) += meson-g12b-ugoos-am6.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-nanopi-k2.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-nexbox-a95x.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-odroidc2.dtb
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-ugoos-am6.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-ugoos-am6.dts
> new file mode 100644
> index 0000000..27d1d62
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12b-ugoos-am6.dts
> @@ -0,0 +1,567 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2019 BayLibre, SAS
> + * Author: Neil Armstrong <narmstrong@baylibre.com>
> + * Copyright (c) 2019 Christian Hewitt <christianshewitt@gmail.com>

This is a bit confusing.

I'm assuming you kept Neil's authorship because you copied from another
g12b board.  If so, it would be helpful in the changelog to describe the
origins of this file.  I'm assuming it was copied from odroid-n2 and
then tweaked.  That's fine, just note that as "originally based on
meson-g12b-odroid-c2".

Other than that, thanks a lot for your work on adding these new boards!

Neil, I'm starting to see a lot of duplication in the g12b .dtb files.
Should we start thinking about factoring out some of the common stuff
that's standard across all these boards?

Kevin
