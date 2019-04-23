Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7141C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A264321738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZdVwcitM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbfDWOiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 10:38:07 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:46018 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfDWOiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 10:38:07 -0400
Received: by mail-vs1-f65.google.com with SMTP id o10so8382635vsp.12
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 07:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tjUdRTxC2HqEQbCC3MvI1VPZOK/DQV2jzwDn5SIzkd8=;
        b=ZdVwcitMP6/zmTwelR0TJjC5zV5iPDhIWO52cJgTNkxbiEzprC2fegYTNbpdI2tdS6
         BggYUBq2lUQEZVFHTeYK5EHTOeG6if86kqkntzuSyjn3Cka7qRkxnv3dSDj+KHOijGn+
         sfGQNFQ0OR5j3wJgXCfHQwGedrqRjaFt7iqQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tjUdRTxC2HqEQbCC3MvI1VPZOK/DQV2jzwDn5SIzkd8=;
        b=tr+UKBlr88G1ewCViZy0kInzNZBnyjDIQu0fDl5u2zarYj2AG7b2Z1H6f74I/sW7Fx
         IV6mYu5GCOUbvSopA66h119BPdvIOFcfsFUIkiLg4zFWaV8RCF07uoY6SxxV8j9krfSw
         SnwjvPJ3OarUa9QxOSC3XEHQh7gBKS2ql9rJZG717WNodG0mbr7qWO6e6vQMNYODneHt
         Sylqjn8dt/4kbyQbSJOu3XNupd9vEcfB7j2MfnTSnUYrwMwUl/yanSWwwx5ZA+rd5qO5
         pN3ccj2znlGJ7I453skSNiWI3FqB4jYp7wP8tFEYdy57oBtwJkYRf1ZNheh33mRWtKuL
         n61Q==
X-Gm-Message-State: APjAAAUocfZIUF8Ty26wpiXx2HLpGTbQUT9WXZIgWTDTCNKn2IjGBGuh
        ChEdjDjMmOcVDfTe5fY2myQ+LHmMy7o=
X-Google-Smtp-Source: APXvYqx3Z3xjGafDk+lLoyooaNxQHYPJwu+Mpe5UY1qZ+/N4ckBQ7FqqHBgWH4ihN+zuzGNVOm81IA==
X-Received: by 2002:a67:ef8d:: with SMTP id r13mr13707660vsp.6.1556030284576;
        Tue, 23 Apr 2019 07:38:04 -0700 (PDT)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id p6sm5796863vke.16.2019.04.23.07.38.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 07:38:03 -0700 (PDT)
Received: by mail-vs1-f43.google.com with SMTP id w13so8393604vsc.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 07:38:03 -0700 (PDT)
X-Received: by 2002:a67:bc01:: with SMTP id t1mr14189777vsn.149.1556030282800;
 Tue, 23 Apr 2019 07:38:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190419221803.99322-1-dianders@chromium.org> <20190419221803.99322-2-dianders@chromium.org>
 <c28d37ab-b6d1-4bd0-9e03-dcf9ce499fc8@arm.com>
In-Reply-To: <c28d37ab-b6d1-4bd0-9e03-dcf9ce499fc8@arm.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 23 Apr 2019 07:37:53 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XWGm6vhdDdYJOSfftYsevnS8VuQUox_9z-kU=08M1oJg@mail.gmail.com>
Message-ID: <CAD=FV=XWGm6vhdDdYJOSfftYsevnS8VuQUox_9z-kU=08M1oJg@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: errata: add support for A12/A17 errata CR711784
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        Jose Salvador Climent Bayarri <Salva.Climent@arm.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Sonny Rao <sonnyrao@chromium.org>,
        Will Deacon <will.deacon@arm.com>,
        Bobby Batacharia <bbatacha@arm.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Tony Lindgren <tony@atomide.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Apr 23, 2019 at 3:19 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> Hi Doug,
>
> On 19/04/2019 23:18, Douglas Anderson wrote:
> > This adds a code for turning on chicken bit 11, which appears to avoid
> > a potential CPU deadlock that could occur.  The exact set of
> > instruction needed to trigger this errata is not totaly known but we
> > have a high level of confidence that the problem is fixed by setting
> > chicken bit 11.
> >
> > All details are in http://crbug.com/711784
> >
> > This erratum has no known number and thus I have tagged it CR711784
> > (after the Chrome OS bug number).  I have created separate A12 / A17
> > configs to match how the rest of the A12 / A17 errata is handled.
>
> The written-up workarounds for 85727[12] do actually say to set both
> bits 10 and 11 of the diagnostic register, so you could probably just
> fold this into the first patch and not have to worry about what to call it.
>
> Robin.

Thanks!  I was unable to find any official docs here and my past
contacts with ARM about this matter have been silent.  All I had was a
preliminary errata description and it only included bit 10.

I'll spin a v2 with them both together then.

-Doug
