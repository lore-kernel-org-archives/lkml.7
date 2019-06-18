Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22321C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 11:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E91562070B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 11:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="k38HwrCb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729680AbfFRLAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 07:00:05 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:39800 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfFRLAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 07:00:05 -0400
Received: by mail-io1-f68.google.com with SMTP id r185so22740888iod.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 04:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kO+Ld9oYjzAATMOMgs9ipgnAjY1R155cPSoZsGOuzvw=;
        b=k38HwrCbmC3eCmrmtgABfdfrVM7qEZtCCm57u1eT0iBPWQTRkN9T279vnl54dQsROk
         VZps4HuMSCod0NNe+C0Wx4K7EA3G/tUYAnBoS+itZKD4yvF37EfGtB2zC84Vdt3v3SW7
         l7JR3JfrZmQktJuK5PTfW+Iwj24COPpoDb/VojmW9Rq64ZP2X7bW8YXODnEcG+nBZoW4
         n3IPWiPSnclpe75r5M2CsaVSbPA5QKAiiYlF0WSSH60C3g9Z6PVBS8H2slAvAS5VU7vN
         9g1Tus6PQ5hO9i3PEBGnTrBcsBrpYX5qjq1KnAU0s/VJIu7LoyzVUCfcrCDtPYCV0Brw
         57BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kO+Ld9oYjzAATMOMgs9ipgnAjY1R155cPSoZsGOuzvw=;
        b=STQ3S7hZ74IwwB5cmhQbckazY4HgBsPoS4kagfDRzjpcoj7oxLn89VXhnlS4MoA4gG
         0BoB/BbzZP0rxfPBsnQ7LCNz5C4lB4QgnPdQcI1/v7ZEqv6d7QbGA2EYUoiBAyV9IkOA
         jYxJFXcYiiKYr6FZVAWdvYt27dlm8xI65oY1gORr/GfQHZhyQ6WU8YCJpkNZHRcrWUQa
         OeGkfmD5hZDtiTD68tiSg8Q2q6ZsCzEesy9euI8SC0yiDmkQ2KKG39tRANFXdbylMkxg
         lfKk2LIw3T05VwuEDP1Y/+2GaVdvQlHYDXDFAiHP3omApmeNrtvAwk7DZYpPJYW92LTo
         TjTg==
X-Gm-Message-State: APjAAAULz6daeklm9BeAWY/OWMe/7/XlXxL866NpcqZiIJL8diyOqq7J
        h+spQQfK0jMYeDsdwrVzy49RvyzDQf7SX4gnOUdEiw==
X-Google-Smtp-Source: APXvYqwXvXgzzgcpl5G2fh6wX92HRT8JWqYU42X7PPvD/O88q1XVoNNuNUd+bUFwaXY/YrFLbvjH5EKejj0YJ1h8ZwE=
X-Received: by 2002:a5d:94d0:: with SMTP id y16mr33611523ior.123.1560855604399;
 Tue, 18 Jun 2019 04:00:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190617122449.457744-1-arnd@arndb.de> <20190617122449.457744-2-arnd@arndb.de>
In-Reply-To: <20190617122449.457744-2-arnd@arndb.de>
From:   Olof Johansson <olof@lixom.net>
Date:   Tue, 18 Jun 2019 11:59:52 +0100
Message-ID: <CAOesGMhU9OHg_4xAiGy20KmXXLU62kONQxZ6DV5Tj+PKeBSJTg@mail.gmail.com>
Subject: Re: [PATCH 2/3] ARM: ixp4xx: mark ixp4xx_irq_setup as __init
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     ARM-SoC Maintainers <arm@kernel.org>,
        Linus Walleij <linusw@kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 1:25 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Kbuild complains about ixp4xx_irq_setup not being __init
> itself in some configurations:
>
> WARNING: vmlinux.o(.text+0x85bae4): Section mismatch in reference from the function ixp4xx_irq_setup() to the function .init.text:set_handle_irq()
> The function ixp4xx_irq_setup() references
> the function __init set_handle_irq().
> This is often because ixp4xx_irq_setup lacks a __init
> annotation or the annotation of set_handle_irq is wrong.
>
> I suspect it normally gets inlined, so we get no such warning,
> but clang makes this obvious when the function is left out
> of line.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied to arm/fixes. Thanks!


-Olof
