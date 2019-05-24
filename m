Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 471EDC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 13:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CCC521850
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 13:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="hEqELOMj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403924AbfEXNuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 09:50:21 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43793 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403876AbfEXNuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 09:50:21 -0400
Received: by mail-pl1-f195.google.com with SMTP id gn7so4194200plb.10
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 06:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=mfjGRiMHKLKe40QcPzGgiXQKqFosuxoiydIUgFnM900=;
        b=hEqELOMjryeiq/Lz0j9sXaizVrFc6bSfFOPrXONo19/tKBN7s3fxW+KghW5RryeTIF
         H4mhqxlbjBImKESJHTVUZWQ8tcdwfqfHaaOBK/Z6lxTMKaTRztgUhKJ0F1A5k6RtXUfW
         gjk/ADbWI3Z6HeOupBvKaf0MxJhbqVirqA6CQiQGxn+pXTFPsYCljQoEW3t0VGO1oCGX
         QIJ9h149YB3yPIZgVgQqLEvH4JNMPFy+hEPqh46tGhlBb/uCVbMqFXh9Dy4JQmoZnBTa
         dJI29pKUP74aWLR015xqFhcHMR1lyKfox9scN8JcJ2PAqM928cFBcvQDxTd2pibUH7Gn
         Rcxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=mfjGRiMHKLKe40QcPzGgiXQKqFosuxoiydIUgFnM900=;
        b=LL25RZHtpxoF1Pysc372ReG/Um7C97BRU6gQSAE4FAyT1UmUViI7X/xfphkrsuJr7e
         me7JvluCH3ZIQgz3A0jV9SVbpaHcb3cQLx89xlxF4J/0bVPjgYArBse0/gFar+QaKHs7
         hPqmcptvp0tJrX70S0cFTWW8IJ7IrAtzHaOCsJrWwrUDcf61UOPtRK9BYmRF/641e35w
         v+H6QjJnnIMouZ1DLkWuLBT5WG53RY/QtR8p9+7iVu3N3wqxjM1g3+vYC1QDLBHfE39F
         sV6S2pudi3Q0ezHZrV5PParREACHY5FUAQkYhuudus2vXmvSs2NE3GnwphpyBwfkwJ2i
         C5Cg==
X-Gm-Message-State: APjAAAU7/vYfUlM8LO5RNcSEjKW3fcmoGZ+W9HvD4k+K3pVX8oHqhaOS
        Ew3k4VJunl9yTsQfoEvnTi0QkA==
X-Google-Smtp-Source: APXvYqx50QVTouTpwq7kMvsDqLVK19AQ+I3Ki7CVWSIIkSQ5uiFK6uhw/4n9Kco9j2EHKt32XLCrWQ==
X-Received: by 2002:a17:902:3183:: with SMTP id x3mr3353568plb.321.1558705820424;
        Fri, 24 May 2019 06:50:20 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:ed4f:2717:3604:bb3f])
        by smtp.googlemail.com with ESMTPSA id a9sm2551220pgw.72.2019.05.24.06.50.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 May 2019 06:50:19 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     "kernelci.org bot" <bot@kernelci.org>, tomeu.vizoso@collabora.com,
        guillaume.tucker@collabora.com, mgalka@collabora.com,
        Neil Armstrong <narmstrong@baylibre.com>, broonie@kernel.org,
        matthew.hart@linaro.org, enric.balletbo@collabora.com,
        Jerome Brunet <jbrunet@baylibre.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-amlogic@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: mainline/master boot bisection: v5.2-rc1-172-g4dde821e4296 on meson-g12a-x96-max
In-Reply-To: <5ce78689.1c69fb81.58097.eacf@mx.google.com>
References: <5ce78689.1c69fb81.58097.eacf@mx.google.com>
Date:   Fri, 24 May 2019 06:50:18 -0700
Message-ID: <7hmujc0xnp.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"kernelci.org bot" <bot@kernelci.org> writes:

> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> * This automated bisection report was sent to you on the basis  *
> * that you may be involved with the breaking commit it has      *
> * found.  No manual investigation has been done to verify it,   *
> * and the root cause of the problem may be somewhere else.      *
> * Hope this helps!                                              *
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
>
> mainline/master boot bisection: v5.2-rc1-172-g4dde821e4296 on meson-g12a-x96-max
>
> Summary:
>   Start:      4dde821e4296 Merge tag 'xfs-5.2-fixes-1' of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux
>   Details:    https://kernelci.org/boot/id/5ce72c6259b514ed817a3640
>   Plain log:  https://storage.kernelci.org//mainline/master/v5.2-rc1-172-g4dde821e4296/arm64/defconfig+CONFIG_RANDOMIZE_BASE=y/gcc-8/lab-baylibre/boot-meson-g12a-x96-max.txt
>   HTML log:   https://storage.kernelci.org//mainline/master/v5.2-rc1-172-g4dde821e4296/arm64/defconfig+CONFIG_RANDOMIZE_BASE=y/gcc-8/lab-baylibre/boot-meson-g12a-x96-max.html
>   Result:     11a7bea17c9e arm64: dts: meson: g12a: add pinctrl support controllers

False alarm.

This one is failing in one lab but passing in another:
https://kernelci.org/boot/all/job/mainline/branch/master/kernel/v5.2-rc1-172-g4dde821e4296/

I'll look into what's the difference between labs.

Kevin
