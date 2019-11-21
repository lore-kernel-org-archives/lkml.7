Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1186EC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 23:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D71F6206D8
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 23:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="dw/zbwX8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbfKUXqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 18:46:11 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:42188 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfKUXqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 18:46:11 -0500
Received: by mail-io1-f67.google.com with SMTP id k13so5695842ioa.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 15:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=sRD24CZU3AA7e2Mtg/NoNBcTmeTnpOy0Fn8hZegqJhU=;
        b=dw/zbwX8lizHuxbYkQ37HvOTPMHVT1O74unioWCCsP5FWziIY32mR9aVshQjoffH0T
         80d1AP0tQOVmnjweBlGc2hW70TiBfDcfyxPn+R/h1Ec1uToFhEK3rjblbH5zBDKXjcJJ
         EwqwsPUj/n6Zja6eLxu2N/HsgurnGu+Eav6SlPkUVbXbbQgxsgJWqzyZlBreG9tEeUPL
         zQgwz8+R42jKYAHNV+uVlpvntohxWvXoV7F/EXkhFsTnGAhVJP4Dh16H5FIbTVMr4XCW
         Tl5HJeNYtHd9ZaiEk60UiO857HQbqySBryM0yXC+BASU1t4b56s5PsnQQvgAKISojrKC
         DCZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=sRD24CZU3AA7e2Mtg/NoNBcTmeTnpOy0Fn8hZegqJhU=;
        b=nhmU9B010GSL4l0/8E3ixGrLxM5enTfQEUb1cMVBBsD4dvV3ytZRGhfYmiA5Osw9SQ
         AIAkz/fxdABq7/ZwAea3RtlbmhtqTZRQUvYXMrGZnZcKr9MH7t2avuaKd5KSRYfu4lK5
         N8eNvRHO5x7C4gICG+lGgI7h+5Rze4NC0639X4esHH5bSbmE/qLhF4GmDBWxIm4Rdo1j
         zIwUR1KZJnCOpq/YbdFqF0kwTSAZEgK2pygej+ji0eVCWXqfNlhe4Lkt3eDVElWL5qHo
         K9n/CxnWfIqNJ69i3yp0NnRCnzQ4djooBFLFVQROtAxdarqVPJ6ap6neuLpZTdvurM5k
         A0og==
X-Gm-Message-State: APjAAAUQ3RVT0UQ1axWBNYue6KgBBAik5m3yGg4ucVf37OSuOKxWwP5e
        jAIOAzAuZaODhFgqQZ9ec5TJRw==
X-Google-Smtp-Source: APXvYqylVPal8XuHdeMGWRQk4bl4C77IYa6VGNLsq0lu8kumK0eFdylj7srKX7AWphuL35T0EhGFQg==
X-Received: by 2002:a5e:8b4a:: with SMTP id z10mr10230626iom.200.1574379970746;
        Thu, 21 Nov 2019 15:46:10 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id h22sm4217098pgn.78.2019.11.21.15.46.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Nov 2019 15:46:10 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH] ARM: dts: meson8: fix the size of the PMU registers
In-Reply-To: <20191117154154.170960-1-martin.blumenstingl@googlemail.com>
References: <20191117154154.170960-1-martin.blumenstingl@googlemail.com>
Date:   Thu, 21 Nov 2019 15:46:09 -0800
Message-ID: <7hlfs8n67y.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> The PMU registers are at least 0x18 bytes wide. Meson8b already uses a
> size of 0x18. The structure of the PMU registers on Meson8 and Meson8b
> is similar but not identical.
>
> Meson8 and Meson8b have the following registers in common (starting at
> AOBUS + 0xe0):
>   #define AO_RTI_PWR_A9_CNTL0 0xe0 (0x38 << 2)
>   #define AO_RTI_PWR_A9_CNTL1 0xe4 (0x39 << 2)
>   #define AO_RTI_GEN_PWR_SLEEP0 0xe8 (0x3a << 2)
>   #define AO_RTI_GEN_PWR_ISO0 0x4c (0x3b << 2)
>
> Meson8b additionally has these three registers:
>   #define AO_RTI_GEN_PWR_ACK0 0xf0 (0x3c << 2)
>   #define AO_RTI_PWR_A9_MEM_PD0 0xf4 (0x3d << 2)
>   #define AO_RTI_PWR_A9_MEM_PD1 0xf8 (0x3e << 2)
>
> Thus we can assume that the register size of the PMU IP blocks is
> identical on both SoCs (and Meson8 just contains some reserved registers
> in that area) because the CEC registers start right after the PMU
> (AO_RTI_*) registers at AOBUS + 0x100 (0x40 << 2).
>
> The upcoming power domain driver will need to read and write the
> AO_RTI_GEN_PWR_SLEEP0 and AO_RTI_GEN_PWR_ISO0 registers, so the updated
> size is needed for that driver to work.
>
> Fixes: 4a5a27116b447d ("ARM: dts: meson8: add support for booting the secondary CPU cores")
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Queued as a fix for v5.5-rc,

Kevin
