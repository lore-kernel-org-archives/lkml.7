Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E931C31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 11:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D98B82084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 11:16:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="iAwdTAm7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbfFQLQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 07:16:23 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34693 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbfFQLQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 07:16:22 -0400
Received: by mail-lf1-f67.google.com with SMTP id y198so6212763lfa.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 04:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Az1PsId6AG7zrE/e92guw8M5OvqzRvBrnplgaPfEwcw=;
        b=iAwdTAm7d1j7Fy86A9WNwUIIPoE1zIu2cV4bWwdR7BuLmdfbtfKcJmSezpSob9uyX6
         y01FclKM/Is3Qb4jVv6QnxM9EQcvoE6xuynnh4PECqeAadE1vTbXCLgg36nhvpqtTjy9
         493u6NeeunXp2GdJ9WoAkK6KyTeTuImRWpp2rEmUCTZkMid45PFKnhZ7xih/PSPBJJfZ
         nEkQah3nMTlY7wOG9SwxnT1Kac1SB2teBXGdpQgu+dbRanIAymF8wsE8codJrzZ6jMZ9
         r4V+5Vlqqk4S8kHnoDPpUOXQVEn0arHZ4O/7gv7E9mxTOtL+KUf2kc2uvhkSY+qIvuq6
         iP0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Az1PsId6AG7zrE/e92guw8M5OvqzRvBrnplgaPfEwcw=;
        b=BiZIvmNbrofRac6a8tzg5RANRJpwqGB/mF8TgQDwiP5PNy1CH8P5ledOniWtau3mg/
         adDJ0xKTJcFiBCLRco4ogWeTGXHR/XJshtwUohcvVSywvOeyTDpRB8FvNQT9WFAPhgWk
         7tsmKvBYrAJLzsXggWIL+uhfnhQvVPpBEYe9WIV16QviY99lDkXcQ+I81GIRia8ZgYY1
         N68S7AYeTRXCbjwPEI99cHu9HhKqD+bCMLh5eYppSaXPACdOWEkt0Ok3O0DJF7BNmAer
         TrBV6ipMsAYMrjaPEXOF0qpc9UaGUfA7lUgNsnuTui8tStJQi++vDAvf14wOg7Pyla42
         pCZQ==
X-Gm-Message-State: APjAAAXuwP8b726W0o/5GRUqCnlBBDc5RYgk/1ijuYSFtTKo3Brxprj1
        iiSgui2KH/LiATXyZ8MGFrqv+IcenzvE4gfKdVQBXg==
X-Google-Smtp-Source: APXvYqypsC4+KqqqqByXUQwFLS5k7sdZwXfVUz0JR59Biy8/qI2ghsrwN4NbcoApA/Kx9X1aql6XpI8678au/x+gMGg=
X-Received: by 2002:ac2:446b:: with SMTP id y11mr49980373lfl.158.1560770180454;
 Mon, 17 Jun 2019 04:16:20 -0700 (PDT)
MIME-Version: 1.0
References: <1560745167-9866-1-git-send-email-yash.shah@sifive.com>
 <mvmtvco62k9.fsf@suse.de> <alpine.DEB.2.21.9999.1906170252410.19994@viisi.sifive.com>
 <CAJ2_jOH-CacU9+Lce80PQzG1ytxvSZmjfSMwL9=kbXpWxyU96Q@mail.gmail.com> <alpine.DEB.2.21.9999.1906170324250.19994@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1906170324250.19994@viisi.sifive.com>
From:   Yash Shah <yash.shah@sifive.com>
Date:   Mon, 17 Jun 2019 16:45:44 +0530
Message-ID: <CAJ2_jOEdejgb-ryx3og5gzWP7wSw0tp1Enk-pjD2rZqJ4JcO3A@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Add macb support for SiFive FU540-C000
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Andreas Schwab <schwab@suse.de>,
        David Miller <davem@davemloft.net>, devicetree@vger.kernel.org,
        netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        =?UTF-8?Q?Petr_=C5=A0tetiar?= <ynezz@true.cz>,
        Sachin Ghadi <sachin.ghadi@sifive.com>,
        Sagar Kadam <sagar.kadam@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 3:58 PM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>
> On Mon, 17 Jun 2019, Yash Shah wrote:
>
> > On Mon, Jun 17, 2019 at 3:28 PM Paul Walmsley <paul.walmsley@sifive.com> wrote:
> >
> > > On Mon, 17 Jun 2019, Andreas Schwab wrote:
> > >
> > > > On Jun 17 2019, Yash Shah <yash.shah@sifive.com> wrote:
> > > >
> > > > > - Add "MACB_SIFIVE_FU540" in Kconfig to support SiFive FU540 in macb
> > > > >   driver. This is needed because on FU540, the macb driver depends on
> > > > >   SiFive GPIO driver.
> > > >
> > > > This of course requires that the GPIO driver is upstreamed first.
> > >
> > > What's the impact of enabling CONFIG_MACB_SIFIVE_FU540 when the GPIO
> > > driver isn't present?  (After modifying the Kconfig "depends" line
> > > appropriately.)
> > >
> > > Looks to me that it shouldn't have an impact unless the DT string is
> > > present, and even then, the impact might simply be that the MACB driver
> > > may not work?
> >
> > Yes, there won't be an impact other than MACB driver not working.
>
> OK.  In that case, there doesn't seem much point to adding the Kconfig
> option.  Could you please post a new version without it?

Sure, will do that.

>
> > In any case, without GPIO driver, PHY won't get reset and the network
> > interface won't come up.
>
> Naturally, in the medium term, we want Linux to handle the reset.  But if
> there's no GPIO driver present, and the bootloader handles the PHY reset
> before the kernel starts, would the network driver work in that case?

Yes, if bootloader handles the PHY reset then the network driver will
work in that case.
I will post a new version without the GPIO driver dependency.

>
>
> - Paul
