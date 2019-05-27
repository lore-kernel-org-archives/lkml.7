Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC3B0C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 18:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8770F21479
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 18:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="BnF33Qfc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfE0ShD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 14:37:03 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44358 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbfE0ShC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 14:37:02 -0400
Received: by mail-oi1-f193.google.com with SMTP id z65so12463123oia.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 11:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K/PmDBxFzH8tIFTHeCN8YYedLt/VhrXyZwuXh8ChqC8=;
        b=BnF33Qfc6hc04kvTbL33hHFtPEQe/ra0NYmvx7YSNe8q0ZZWZNZR2A6OUFcgD7KhD8
         0ed+u0dHO4dAKHTwLK+vrAYoR5sL3/aHw6MBuHPscIGOYEFh0s7WnKWJag93QdJrQ/iu
         GTPG0beSa3F4DNfgoh+IaEOu6sCA7SiiiIpSLl+5BjNCiAJqxq/6hy1mye5IGynfj10W
         YeXWzNboNqyDcKvUwmA+bOFn+HKubU5RLDahKXwPlt5YGkuC+p+HrLgAkNbhyRCjWNtc
         S4YJ1Bbs0wIEhE3hejpPQKiq+7nXt18sLO9OZmtJ9/lrqh4LA4VnnADhLAgxe3U+J7x0
         ZxPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K/PmDBxFzH8tIFTHeCN8YYedLt/VhrXyZwuXh8ChqC8=;
        b=KaAQVe51NwjFQOx7eIprvXV69j/tst5nejhnYsPMFkresn91Krk2aZcKYQ6GcnEibt
         gS/L/ztYH3c8Y2ZLBB9i+GBSCagzC3koHEt19gNdwvBRn+gFB/07KM0gshxE0SNRjMCY
         sMVyOT6VE12/gFPi0zvQnbnJ9x1zIO114Ls9qI1bRXFBGg8XLz1bqGyIktAVg/lZAIJy
         TygBbwPUoZ/WOc9gxVpjToYI0skEWII1FbtlvW5c+w5Qr2Wa2OS0GgCRrpYm/S4o5cqO
         3qhbcljKwxF49hmQg2EGCBtGYxd4eLOsLSUT7lcleO0fxSp2mg146S+hx3zBxFmY67+y
         dNVw==
X-Gm-Message-State: APjAAAVmq/QhvgEpNaQrigVBLSyP2fUdpfwTf9AA+MVsPu9CnYrAtUDV
        xc/aT8Zs0of5nlmqvds+LlcHSBn/2wK/WmTAKoxeUgJ/+2c=
X-Google-Smtp-Source: APXvYqy7PWeO9SByoGpDLEPMAWmWvYgNfuTseUq3cV5VsDUG4L7srEriatKm4lJuWJ76zmnViuz6ssDvlr761juw94I=
X-Received: by 2002:aca:ab04:: with SMTP id u4mr213510oie.15.1558982221761;
 Mon, 27 May 2019 11:37:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190527132200.17377-1-narmstrong@baylibre.com> <20190527132200.17377-3-narmstrong@baylibre.com>
In-Reply-To: <20190527132200.17377-3-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 27 May 2019 20:36:50 +0200
Message-ID: <CAFBinCBTK=6OW4kG=i0KZe-+AzGVXyou9g0frnh9yqLsdmB5+w@mail.gmail.com>
Subject: Re: [PATCH 02/10] arm64: dts: meson-gxm-khadas-vim2: fix Bluetooth support
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        Christian Hewitt <christianshewitt@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 3:22 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> From: Christian Hewitt <christianshewitt@gmail.com>
>
> - Remove serial1 alias
> - Add support for uart_A rts/cts
> - Add bluetooth uart_A subnode qith shutdown gpio
I tried this on my own Khadas VIM2:
Bluetooth: hci0: command 0x1001 tx timeout
Bluetooth: hci0: BCM: Reading local version info failed (-110)

I'm not sure whether this is specific to my board or what causes this.


Martin
