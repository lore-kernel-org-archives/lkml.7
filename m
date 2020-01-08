Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D5BFC33CA1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 23:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 338CF20692
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 23:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s4oiBbU1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbgAHXMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 18:12:32 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45118 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbgAHXMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 18:12:32 -0500
Received: by mail-lj1-f195.google.com with SMTP id j26so5077661ljc.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 15:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9PdCnLDfRrpTe57HbjA01QxkIMaIeln31WkhfMvjiwc=;
        b=s4oiBbU1nrcXdyE6ajcf/7ipB/YOE89ljAV/j8S3V1GrEIqoBOr47JYnVmEsKRV8GJ
         m4q0+MdmjmzPl9uXRDzb5Amt57zy3bc3WxPF0K5yDX2VpMdCN/AhXoZnSdWYKA7heegf
         wRS55OdtQNKvabxlFMD4rrY3EAmDaAyQ/BZXlmPZ0CYqE3Lb2AxGF4u8Wn6qmi2T8j5O
         cdnewIk+KP+Htuwy0PgAnh2udE8rVTcaKVrkgALjESDjkQ3mY3GfGNqQXizf+0ZMl2Q6
         vXSmyvELflYoWLjnjXyFw556vBiDknK3YpTds+gEithiEvcry2P64oYpOGLedDWey+af
         esbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9PdCnLDfRrpTe57HbjA01QxkIMaIeln31WkhfMvjiwc=;
        b=W6Yy1uMzGjNsL+9x2B4rR8fgmDCcaNB40o/LgU3/VksOJuhEwigKcTt0Fjh6wvI18w
         SICb0v5g9YYn5oaNcLytBAE8inR+2uaqhOOtGRt/iGMQFC1UjvmzULkCapdVaM8zXEes
         yPYUs7FvzoKyhwTDE2RQ08PrKvjZpxzGr6YtR1bQ4gIeUpBcFCallHko4lRcu9sfDzp2
         wKL7tTws6OGIqeRpp3Ewf6c6/IaCPW8C/QNLgo70hBOygfw+U365g3qVDmctzb9dltNA
         06kHnWO0rsRWsi4wX1eAH4IdThSPO0JkWEohIWD3QzZYXFlWlFel5tcSg3bWpZ+iiBSt
         cR1w==
X-Gm-Message-State: APjAAAX+ejYM2TW/2LMmvIAr8sjZkjRR8qPfBE66keEYjw7dskNOGDuz
        8Fo/HFtXENMSIQ/7Z21uHMST/kWI7hbTVcP+Lrf5qg==
X-Google-Smtp-Source: APXvYqzqb9iQtaKF+nk9oiPjLBxsjLdTUTmVU669xZcPD3ecVDu582+r9iYp2mPEVpHt4i81yKoxko8lyI3k7+1q8V0=
X-Received: by 2002:a2e:844e:: with SMTP id u14mr4342769ljh.183.1578525150247;
 Wed, 08 Jan 2020 15:12:30 -0800 (PST)
MIME-Version: 1.0
References: <20191127084253.16356-1-geert+renesas@glider.be>
 <20191127084253.16356-6-geert+renesas@glider.be> <CACRpkdaW7nmpE99FAvBDBTmkTZOTQ5WdM=JbMzBTLk7cbLRXPw@mail.gmail.com>
 <CAMuHMdVbk5S__8OK-zNXmiW66=WVA8Jzyc=hUvf_hJSU=u9TFg@mail.gmail.com>
 <CACRpkda8QD_tDA=YVDRNVnHd8QHs-yHBTzZuJHsnocgMdxv9cA@mail.gmail.com> <CAMuHMdUGGcjoX8TDDS5qGLtJZxizUK=BpasSQK3t1K-dhEgZCg@mail.gmail.com>
In-Reply-To: <CAMuHMdUGGcjoX8TDDS5qGLtJZxizUK=BpasSQK3t1K-dhEgZCg@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 9 Jan 2020 00:12:18 +0100
Message-ID: <CACRpkdZYFx3q=eS=y50hsQY5v5EMY-0XmyHsUQRczrS6PRN1+w@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] gpio: Add GPIO Aggregator/Repeater driver
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Harish Jenny K N <harish_kandiga@mentor.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Alexander Graf <graf@amazon.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Phil Reid <preid@electromag.com.au>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 6, 2020 at 9:23 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> > The rest I think we cleared out else I will see it when I review again.
>
> The remaining discussion point is "GPIO Repeater in Device Tree", i.e.
> the GPIO inverter usecase, which might be solved better by adding a
> GPIO_INVERTED flag.
>
> Shall I rip that out, incorporate review comments, and report?

Don't know, if it blocks progress I guess the diplomatic solution is to
do that, divide and conquer. But review is a social process so I don't really
know the right strategy.

Yours,
Linus Walleij
