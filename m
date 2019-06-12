Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E96CC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0378F20874
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X4fqxkFU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405792AbfFLI7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 04:59:15 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43595 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729413AbfFLI7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 04:59:14 -0400
Received: by mail-lf1-f65.google.com with SMTP id j29so11445246lfk.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 01:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V2L+zl6dowkd/yIBbT7eRrGp601e57v2tAHbEjBGJTw=;
        b=X4fqxkFUUtZqYl036ehGL/EeenuwWFqKCNrIgtl0sfKO1CziKoyuiKNHtxSW7mmdT/
         GmMSjXhOyHCeA2bLmKJ4EYbomOxRED8IWzZlcIOAzfR30W2mt8A2uoEoKFoVGcG5Ihxj
         GFrYwP1ohGAB58nb+WHlzAwM0jSdY3H/80yFHE/XZ+IgCbPGlbi1HDfBC9PbEtgPAn99
         nQxs3HRHSInY1DkPn/OAJ9SKqQ5nqiDk5sZkBuJuWFkpBFuB38xQt5fJ1Fm9eqKu8OgJ
         PT0emqTy4xxMN4Rr552UHUcBV9d0PjU9STLc/KZiaiv5JPdhC6w+GrFWUxEn/fdfq0+/
         OtOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V2L+zl6dowkd/yIBbT7eRrGp601e57v2tAHbEjBGJTw=;
        b=LvhWfFXjD7jngz9nYRPnuTRhjGxcrSepkccd1A+2PYhLG45+0kcLgU1vUqYInxz/5U
         asUQA2Dtavp7WQCzzbvMJ+id1lAkG1MBDCqAvivzc+iy0/xNdbmaWRMGEJxPU1RdXyy1
         MKuaC4Yaby99dDTHw6ekpoTlFj50ZPlglf+o5GH1AGQqguk61edn5Sm4N2vPxV8OKBpg
         FkjstvA/UykfgFmFBczYsJPI94KWa61mOxasAYx6g0o9t1AM9zVHd+kzr2qPxGpdKKRW
         ApU1TatDA58PszoX41TQIr05pQBhGblRoZAGN0EpXfbt8LkkrJ3qk4mM4QM7uoWCKoj4
         nikA==
X-Gm-Message-State: APjAAAUbH4dklPk8G1KeHFU7bP3EuHpL+SiSg3ydjkBJp8Skr+2CVWJO
        OXlWwYN3jjE09wK3OfNqeNGbzEnNjhop8w9gDYVCW+wRDpE=
X-Google-Smtp-Source: APXvYqxjS/7aTV8YOZIs8AdNxK6uGmYNc9VJ3EJJBU3O7jWDspDz9e4LDwcqW1lbvKFFYrHG6CHJ4s9KIP+m6y6ZICQ=
X-Received: by 2002:ac2:598d:: with SMTP id w13mr39036425lfn.165.1560329952465;
 Wed, 12 Jun 2019 01:59:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190610171103.30903-1-grygorii.strashko@ti.com> <20190610171103.30903-20-grygorii.strashko@ti.com>
In-Reply-To: <20190610171103.30903-20-grygorii.strashko@ti.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 12 Jun 2019 10:59:00 +0200
Message-ID: <CACRpkdYdcj9kEntzZ0q=xkEKjdzH6tmWPYBAH+8iSpPGvMaT5w@mail.gmail.com>
Subject: Re: [PATCH-next 19/20] gpio: gpio-omap: irq_startup() must not return
 error codes
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     Russell King <rmk@arm.linux.org.uk>,
        Tony Lindgren <tony@atomide.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 7:13 PM Grygorii Strashko
<grygorii.strashko@ti.com> wrote:

> From: Russell King <rmk+kernel@armlinux.org.uk>
>
> The irq_startup() method returns an unsigned int, but in __irq_startup()
> it is assigned to an int.  However, nothing checks for errors, so any
> error that is returned is ignored.
>
> Remove the check for GPIO-input mode and the error return.
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Patch applied.

Yours,
Linus Walleij
