Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E324BC33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 12:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B93B12080A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 12:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="paHxzlrV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbgAGMul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 07:50:41 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37574 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbgAGMul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 07:50:41 -0500
Received: by mail-lf1-f65.google.com with SMTP id b15so38796620lfc.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 04:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qMXhXLoLeVvu5/KYc9JCl6rH4kjAJAtUCGbVA3bRuPs=;
        b=paHxzlrVDhvmFYeN1JGQwt2RwNg4fYmXZskPhFpHB3VCz1uJBigeHzwAv3aET5bv66
         25q2+0DyIkpyxS6j91qo5s9cKu6uckc+sNnqV9/5GG/SknHh7lJRgxJYlQfXIEN9PsAf
         +2HLTcKYN97TqviPUtqfs9qQWyjdbo8lg4R+k1XuJxkxlJ71gfJvjZMhIXBemRffD9XY
         89rcRqRZk1QW21k/VTCD7nCpH9B08Dem2GE3C1KIbg8aOulLbfrtb1R1YqpAU12q3aRW
         WBYntYA07sAdZOyekyHdoPm8s8BVUMPrlz5EQGLidmsr7sq1UrIWeOeEmT8Wc6z+CDfQ
         eTDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qMXhXLoLeVvu5/KYc9JCl6rH4kjAJAtUCGbVA3bRuPs=;
        b=OItirVKBBaG6SYEFrMpDoI2LQG57SIW8PfP1yI9Yr6nPhmMwkhMKU0mvEpASkFPAHJ
         VizkPckUwdt6v5ChlMqEw/jjkEO39ZVuyt/LLjdo9u2LgNfpV/I8VGh/4iEn3A74Dhj9
         vbQT2IlrCbGRhMgxQTIs+aJh4TJ9ftheO+6MhraouZuM/S0XYdiea5YorGNv0dvRIAmQ
         6Q2tE/QiHrmc+EaOz+wvkpt0ym5tZtdjqh/dJK/nKLa1by7kulDDuSupO/QWnMoNIGaG
         1eiyHP2wYwOH3qp4oKsAiRIz5dUkk3T8BA8AC2O4/aYRFC922chWqxRE3obKrV3u7PF4
         Trxw==
X-Gm-Message-State: APjAAAWQqWPLWlqK+JnyG0KKLSY6AImrKTOa+T3qSBr9d2MxdzPviO82
        pGSnsD+eMjCtfk8DBy1E6QRpMFYMfx4G/ZS/G12I8g==
X-Google-Smtp-Source: APXvYqxktsFdjUU+MPfexe9Q+wp4ek2hQ056LJObVZR3yFINNyTkjkuQciwpvjnY63x1130vLWSj+yy7dPiIs6Siioc=
X-Received: by 2002:a19:8a41:: with SMTP id m62mr59272175lfd.5.1578401439549;
 Tue, 07 Jan 2020 04:50:39 -0800 (PST)
MIME-Version: 1.0
References: <20191224120709.18247-1-brgl@bgdev.pl> <CACRpkdZ_TroKCAnDWiY-jPbe0NL+ingm1pMLQLPxT1Uh78kx8g@mail.gmail.com>
 <CAMpxmJXikLw0d1e1Eq7vVzoORz3utEBxfG6nRmkngLqezVqtuA@mail.gmail.com>
In-Reply-To: <CAMpxmJXikLw0d1e1Eq7vVzoORz3utEBxfG6nRmkngLqezVqtuA@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 7 Jan 2020 13:50:28 +0100
Message-ID: <CACRpkdY2NXNrAk9VY18YDeQ2WDfDfAyi4mgW26JuTPHdEOE-uQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/13] gpiolib: add an ioctl() for monitoring line
 status changes
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stefani Seibold <stefani@seibold.net>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Kent Gibson <warthog618@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 7, 2020 at 11:38 AM Bartosz Golaszewski
<bgolaszewski@baylibre.com> wrote:
> wt., 7 sty 2020 o 11:07 Linus Walleij <linus.walleij@linaro.org> napisa=
=C5=82(a):

> > The patch set overall looks good to me, I don't understand the kfifo
> > parts but I trust you on this, though we need review from a FIFO
> > maintainer.
>
> Ha! This may be a problem - there doesn't seem to be one. This is why
> I Cc'd Greg.

I was under the impression that KFIFO was part of the driver core.
Let's try to CC the actual author (Stefani Seibold) and see if the mail
address works and if he can look at it. Or did you already talk to
Stefani?

(git blame is always my best friend in cases like this, hehe)

Yours,
Linus Walleij
