Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EAD2C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 15:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5DFD214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 15:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="uBvEJvm6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729535AbfLLPsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 10:48:22 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33622 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729013AbfLLPsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 10:48:22 -0500
Received: by mail-wm1-f65.google.com with SMTP id d139so3913562wmd.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 07:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=ZSDD0/glpJ1MgC2m3fsC6RmNqv5qfMCzBU/Ws2SvIi8=;
        b=uBvEJvm6xdv/CK4SU85EVr9Mxaq6c28Tocn0XUIdJ+tDyPSZrt0IRxbFwAAZ62yiW5
         9KQVcubwDSY+6CA8hl1fFj9eJov2sRbL/5ESoQ/0bw8vPsA8+jUb149QEZlxiuaHM6gO
         xfkZyTDKaqE4d4r+JCCuwBQv5GWOYOFYudxnuQu6fjI/B0PJXfRn/Ehp46d3CgXQXCiK
         gbIwUpYQ3S+yRiAnpcjUPo8nO5nRZFvC9OK58nUPRUiv//D0JhQBh+VSvn4UN2UHfPTp
         R8xFcowCLsIU3cJ/DPXOlSpTfYNh12UTR1/DeTmqbb1LcZYE2U5lMvCreTJgZ3l4ZzUY
         o+PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=ZSDD0/glpJ1MgC2m3fsC6RmNqv5qfMCzBU/Ws2SvIi8=;
        b=kG2ILE1MSMrBf50/PpQCO9cBb+elVsUxtK0cfF11x30lnrR4r9JM5pDCn+Gyvm0feS
         8qbNI7dxHWpinUxRnNo+HxrXfMcAOnsBVPGkDtNl+QPuNT2RyUJLKk9zNqm4rZCMcZI/
         nNGi5Br5WPIflW7iggXHK7FayDVtk8c6yuK1l6kKTPBoWkNO+aJfVyhtOPZOCHXLBsI6
         kwlPOESo5tWbZaKEonFw62bqmwi81OwVK2d6n4MpP4D7Zunx6/IwBgYXT5bXaTGq4wov
         y5zifgNMV3xBlcyK6R4eScdSFg0hIyez6Um8ZuE/zvCOcimJpf1J+KvSM7ekz1R1byIT
         GARQ==
X-Gm-Message-State: APjAAAVXj1mr6wpRfQt6A0K82VCSOV/ypVNO1kFRitcr5wsC/NJ2g6pf
        8LgaBRAiFJKcllGZv6906Ie8JwC/AMM=
X-Google-Smtp-Source: APXvYqwXq66n5SLrBk1VKsZ4xywwLs9fJTHh0tdpXlZ2eIUT6PJDbAVb67zUzRsHvrqVeSqYp7yuWg==
X-Received: by 2002:a1c:3141:: with SMTP id x62mr7208553wmx.18.1576165700213;
        Thu, 12 Dec 2019 07:48:20 -0800 (PST)
Received: from localhost (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id b17sm6464442wrp.49.2019.12.12.07.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 07:48:19 -0800 (PST)
References: <20191208180525.1076152-1-martin.blumenstingl@googlemail.com>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] ARM: dts: meson: clock updates
In-reply-to: <20191208180525.1076152-1-martin.blumenstingl@googlemail.com>
Date:   Thu, 12 Dec 2019 16:48:18 +0100
Message-ID: <1j8snhbl4t.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun 08 Dec 2019 at 19:05, Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> This series moves the XTAL clock out of the main (HHI) clock controller
> because it's an actual dedicated crystal on the PCBs.
>
> The last two patches add the DDR clock controller whose output is used
> as input for some of the audio clocks.
>
>
> Dependencies:
> - patch #1 has a runtime dependency on my other series:
>   "provide the XTAL clock via OF on Meson8/8b/8m2" [0]
>   Jerome has already queued this for v5.6
> - patches #2 and #3 have a compile time dependency on my other series:
>   "add the DDR clock controller on Meson8 and Meson8b" [1]
>   Jerome has already queued this for v5.6, but you need an immutable
>   tag for the dt-bindings

Bindings tag clk-meson-dt-v5.6-1 available with the necessary ids
branch v5.6/drivers with the actual driver changes

>
>
> Jerome: can you please rebase the v5.6/dt branch tomorrow on top of
> v5.6-rc1 and provide a tag so Kevin can apply this series?
>
>
> [0] https://patchwork.kernel.org/cover/11248377/
> [1] https://patchwork.kernel.org/cover/11248423/
>
>
> Martin Blumenstingl (3):
>   ARM: dts: meson: provide the XTAL clock using a fixed-clock
>   ARM: dts: meson8: add the DDR clock controller
>   ARM: dts: meson8b: add the DDR clock controller
>
>  arch/arm/boot/dts/meson.dtsi           |  7 +++++++
>  arch/arm/boot/dts/meson6.dtsi          |  7 -------
>  arch/arm/boot/dts/meson8.dtsi          | 24 +++++++++++++++++-------
>  arch/arm/boot/dts/meson8b-ec100.dts    |  2 +-
>  arch/arm/boot/dts/meson8b-mxq.dts      |  2 +-
>  arch/arm/boot/dts/meson8b-odroidc1.dts |  2 +-
>  arch/arm/boot/dts/meson8b.dtsi         | 24 +++++++++++++++++-------
>  7 files changed, 44 insertions(+), 24 deletions(-)

