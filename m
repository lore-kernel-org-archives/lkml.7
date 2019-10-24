Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A9FCA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 12:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09E4521872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 12:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MQcij3Hn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501954AbfJXMi6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 08:38:58 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:34864 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbfJXMi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 08:38:57 -0400
Received: by mail-ua1-f68.google.com with SMTP id n41so7101271uae.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 05:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IDVS1e9hyUEZF9b7Qqy5YnFhITXSjbGZRVGhTJdweek=;
        b=MQcij3HnHK2jhBapvsLcbnyU0UuOTDO6+/fUMv5+ZYQ/svdkPAO8dOlLI2ab0GyqA6
         GqIb8QkWf/FqsUv056i6jSnyug9+WZpSaobr+itNAD+MqNDC0GrkJG0JIe9Tu8aAqAk9
         f69ncKQj0R770e8Yk05r/N2CrcHO+53N5G1GYIuczrAPdprJcw6CiPhT4Wgv19i/JmMj
         EJ2p/5saMFxfIE969G4ZVxgqXpRFa0ngLa2TufQoF7wp96n4YSl0+PjF6BhnBE716ntb
         cfeUAjX2Es4kJDzUnWsv9m3FlSga+JZAA3Pyxcwbkl0pJtKh8LW54atUoyEaxC6BL8YG
         wP2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IDVS1e9hyUEZF9b7Qqy5YnFhITXSjbGZRVGhTJdweek=;
        b=st7PsAHocX8/u037x2Y1TaXKSKKqohlBAXuEqbuZbfcQFamLBOz890V4SVqP4pK7m8
         oSXv8qTTNTmfY+UGQrlSqhMCXC+0lYerkVkNv2APkYXcmHZQAGzWbpz9TlW4VHkUlemT
         Fs12zyopGErXNoXGFFUTfuFYIvPhWtN4601+MbRCUj1JsI2IZMEgichgZrJCtEHWXDih
         IcGh1p4D1sMDb+zlVg1CtsTX4pDzfJ5RRz+Ohn6SuJP1wvoEzEJUKcBA/UCNMDh5KS3I
         UNOzjFgXA8jbk7p6IK+o/nxQVAmrOTdD4v/bYf6i45lboyb1yCgGzylk5DpuwZ+MEbVY
         19Aw==
X-Gm-Message-State: APjAAAW62WHU/FlqhNbBi52gMiW8XOeX7ZgmaF0eVdw8nL585DVdCKmE
        g99JuHWslTWlvlCpXdU486oUz2MYEdEPzMAkG5FFpjSc
X-Google-Smtp-Source: APXvYqwo8ZVYy1z4w8Ftf+vlrIbhLNjEfvmZbL6Vl641yfUdccFTWMVPTA1f71j/g5PFUaHJ/qO5AgczNDm07gUNphs=
X-Received: by 2002:ab0:30a1:: with SMTP id b1mr8030843uam.40.1571920736115;
 Thu, 24 Oct 2019 05:38:56 -0700 (PDT)
MIME-Version: 1.0
References: <20191017114906.30302-1-linux@rasmusvillemoes.dk>
 <20191017120310.GD25745@shell.armlinux.org.uk> <c4b6805b-67fe-6bce-1777-2d81e96b4ac9@rasmusvillemoes.dk>
In-Reply-To: <c4b6805b-67fe-6bce-1777-2d81e96b4ac9@rasmusvillemoes.dk>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 24 Oct 2019 14:38:44 +0200
Message-ID: <CACRpkdZJpJj7FVv25enweO3_cEdGLrJib3nzgCSDn8jY888AWQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] watchdog servicing during decompression
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gao Xiang <xiang@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 2:34 PM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
> On 17/10/2019 14.03, Russell King - ARM Linux admin wrote:
> > We used to have this on ARM - it was called from the decompressor
> > code via an arch_decomp_wdog() hook.
> >
> > That code got removed because it is entirely unsuitable for a multi-
> > platform kernel.  This looks like it takes an address for the watchdog
> > from the Kconfig, and builds that into the decompressor, making the
> > decompressor specific to that board or platform.
> >
> > I'm not sure distros are going to like that given where we are with
> > multiplatform kernels.

That's a very good point.

What we have for debug UART etc is explicitly just for
debugging on one specific platform and not for production
code.

But as pointed out there is code like this already.

> This is definitely not for multiplatform kernels or general distros,
> it's for kernels that are built as part of a BSP for a specific board -
> hence the "Say N unless you know you need this.".

Not much to do about that, we need to support it already and
adding another usecase just makes it more reasonable to
support I think.

What we need to think about is whether we can imagine some
solution that would work with multiplatform.

At one point we discussed putting some easily accessible
values in the device tree for the "decompressing...." message,
so easy to get at that the decompressor could access them
easily, or even providing a small binary code snippet in the
DTB file to write to the UART. None of this worked out
IIUC.

I think nothing really materialized from this and the problem
is swept under the carpet: no decompress messages for
multiplatform. I tried to think about something and just feel
I would be reinventing mach-types.

Do we have an idea of whether it is possible to dig into
a DTB in early boot and find the node for the UART and
watchdog and use the physical address from there?
Is it really hard or is it just that no-one tried?
(Sorry if this is a naive question...)

Yours,
Linus Walleij
