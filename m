Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D787CA9EBD
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 20:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0525020867
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 20:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ocEA2/Up"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfJZUbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 16:31:04 -0400
Received: from mail-lf1-f50.google.com ([209.85.167.50]:40479 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbfJZUbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 16:31:04 -0400
Received: by mail-lf1-f50.google.com with SMTP id i15so4807441lfo.7;
        Sat, 26 Oct 2019 13:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C3Bnj79/MdmyOPceI8w6ogw+VOwoEwR2LfbvEH8/Jt8=;
        b=ocEA2/UpEZub4FfzrES/35kLEEgf+iuM14yuJDnzueb3oicjVf5VjH8yPNzykDM3CI
         0ySJFqTK5wy/ITLl5r/AeF199mbKYCUlQe1acfJZ5OhvbURawEi5O+XvdN9rqYmKETtf
         IC4fsanTSIIn0AuZ928OzFys+/+zrqPd7vALXtU348vu0tp9fVZM93c8V5ZMRvOv6k3O
         zF08+RBUuiBLGBuqG0409jY8ynGQnCTTBp7hGXvgGTKWkIWQmOEDqYk2MMIl0mIF7Pld
         TI0erEKwKnwVhZpDN3Se0CJNro3iFgZ84BgBVQI0u1n2a2vvUQ2YIqlEi/FFJJE1r/uF
         9BBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C3Bnj79/MdmyOPceI8w6ogw+VOwoEwR2LfbvEH8/Jt8=;
        b=J3tEuV4nZRnxkmo5nLd9c+w0k1CF7cYyJxDF/Xmgk+/FWJKw+MU4+JSBa4RitC2z5U
         pzD0kkmEgBpjNtG8Rfso+mfTLzPeh8NMHHMYJ/7xluO9uS+ZsLbta6wF/CTxGn1WtZhp
         f5V87Zvfzf4PzG045SFKeNoHhzByu2lrFCai/fGq48oRj1miYFypxM7sitnpHYvwWVzf
         OqJOhb1RW/+fD/FBcV00nwnTtQMpjwqqNqvkGnLoGl4H0Rys/cXrjWKoW+228b71V6GP
         ms7SnazSSfH90ZgzuZzG4V3uRYn+FA/CKWiDdUKUE6N9CJSKyTtridDAtURfukKi6HRM
         lq1g==
X-Gm-Message-State: APjAAAUY74g2DJDdrIXbNEGlPKJ1XI0Cxf638ICfrOznzYL2n7UZz/li
        qmcEul1R1QdVnjqOTVNBASSEDwgp1KkuE3CeqFA=
X-Google-Smtp-Source: APXvYqxEG+sO1ju1+zh7t26iFYHaqIQbdb0pBFNYp8W2WOu8r2gmg1A+zmEJq4oiggzRPaPkW5vjk856OE6jCWTnw7E=
X-Received: by 2002:ac2:4c29:: with SMTP id u9mr6709818lfq.90.1572121861966;
 Sat, 26 Oct 2019 13:31:01 -0700 (PDT)
MIME-Version: 1.0
References: <20191026194522.28293-1-frank-w@public-files.de>
In-Reply-To: <20191026194522.28293-1-frank-w@public-files.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sat, 26 Oct 2019 17:31:03 -0300
Message-ID: <CAOMZO5Bb=1CUpw__xxS2N0w+ZP0+LnBBW9+JLVr03x6TC2Z7=g@mail.gmail.com>
Subject: Re: [PATCH, RESEND] serial: 8250-mtk: Ask for IRQ-count before
 request one
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     linux-mediatek@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-serial@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 26, 2019 at 4:46 PM Frank Wunderlich
<frank-w@public-files.de> wrote:
>
> at least on bananapi-r2 we have only 1 IRQ and need to
> check for IRQ-count to fix following Errors during probe:
>
> [    4.935780] mt6577-uart 11004000.serial: IRQ index 1 not found
> [    4.962589] 11002000.serial: ttyS1 at MMIO 0x11002000 (irq = 202, base_baud = 1625000) is a ST16650V2
> [    4.972127] mt6577-uart 11002000.serial: IRQ index 1 not found
> [    4.998927] 11003000.serial: ttyS2 at MMIO 0x11003000 (irq = 203, base_baud = 1625000) is a ST16650V2
> [    5.008474] mt6577-uart 11003000.serial: IRQ index 1 not found
>
> based on Patch from Anson Huang
> https://patchwork.ozlabs.org/patch/1164500/

The solution that was accepted for this case was to use
platform_get_irq_optional() instead.

You could try using platform_get_irq_optional() here as well.
