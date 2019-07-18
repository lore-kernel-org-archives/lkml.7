Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2918AC76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 07:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08E66208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 07:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389312AbfGRHvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 03:51:19 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43498 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbfGRHvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 03:51:19 -0400
Received: by mail-qt1-f193.google.com with SMTP id w17so26183599qto.10;
        Thu, 18 Jul 2019 00:51:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AMIbdcIyPjXgBsFnQdrxIvDXu584wusUv2Znj2VCflY=;
        b=rJftV391PX20sTps19CSDJMV3MWFWIWZrnUl8iXIIUhSdgS9mUI2/OEvhOF8GqEDhS
         VsMAQQimlyV14v63OCsJO1Pln+bVB5TKEmVpPOzwN0iiq/EmjRnEbEddPfE/OUY6UKif
         YURgoFKXXwhZUEYZQfCRM9lJblx/pUrJ9TmyMEuibKHOEQyCJsrGtUOZBRp1oxKF97tX
         YzHxYaFvmO28Vh21x9i/T9xhZzcgWgE2PhVJ2JCAP4Ad4TnIgw41L9njMUO4VoBHzC+Z
         md1McOvl/aPyCltCbSyNYRJ5MKoSgWtM+MuMhnnsMbYjfe0LKTnxzr6pEcNU6RbOLcMX
         kkqQ==
X-Gm-Message-State: APjAAAVmSzfxCZT8yAPwyYN3+b+Pr8raSnTxKf0SsZfQ5WpVooBb7mGI
        DFsTfcpaiVqbc7JBaZF8A/j4oOQJ3fsqdnYsbAg=
X-Google-Smtp-Source: APXvYqyzjKBdgrNsfXbtaWuBwJsPbX/hOAYTtfb23UeIC61bLsX6rwes0aTlraCVeKg7z22IOXq9fA3u8pg4isBRck0=
X-Received: by 2002:ac8:5311:: with SMTP id t17mr30079223qtn.304.1563436278053;
 Thu, 18 Jul 2019 00:51:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190617221134.9930-1-f.fainelli@gmail.com> <CACRpkdbqW2kJNdPi6JPupaHA_qRTWG-MsUxeCz0c38MRujOSSA@mail.gmail.com>
 <0ba50ae2-be09-f633-ab1f-860e8b053882@broadcom.com>
In-Reply-To: <0ba50ae2-be09-f633-ab1f-860e8b053882@broadcom.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 18 Jul 2019 09:51:01 +0200
Message-ID: <CAK8P3a2QBQrBU+bBBL20kR+qJfmspCNjiw05jHTa-q6EDfodMg@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] KASan for arm
To:     Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Michal Hocko <mhocko@suse.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        kvmarm@lists.cs.columbia.edu, Jonathan Corbet <corbet@lwn.net>,
        Abbott Liu <liuwenliang@huawei.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        kasan-dev <kasan-dev@googlegroups.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>, drjones@redhat.com,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Andre Przywara <andre.przywara@arm.com>, philip@cog.systems,
        Jinbum Park <jinb.park7@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Rob Landley <rob@landley.net>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Garnier <thgarnie@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2019 at 7:00 PM Florian Fainelli
<florian.fainelli@broadcom.com> wrote:
> On 7/2/19 2:06 PM, Linus Walleij wrote:

>
> Great, thanks a lot for taking a look. FYI, I will be on holiday from
> July 19th till August 12th, if you think you have more feedback between
> now and then, I can try to pick it up and submit a v7 with that feedback
> addressed, or it will happen when I return, or you can pick it up if you
> refer, all options are possible!
>
> @Arnd, should we squash your patches in as well?

Yes, please do. I don't remember if I sent you all of them already,
here is the list of patches that I have applied locally on top of your
series to get a clean randconfig build:

123c3262f872 KASAN: push back KASAN_STACK to clang-10
d63dd9e2afd9 [HACK] ARM: disable KASAN+XIP_KERNEL
879eb3c22240 kasan: increase 32-bit stack frame warning limit
053555034bdf kasan: disable CONFIG_KASAN_STACK with clang on arm32
6c1a78a448c2 ARM: fix kasan link failures

      Arnd
