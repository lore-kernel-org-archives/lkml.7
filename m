Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E81CEC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 22:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3F8720867
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 22:10:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729457AbfJGWKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 18:10:25 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37999 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728654AbfJGWKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 18:10:25 -0400
Received: by mail-qt1-f196.google.com with SMTP id j31so21666875qta.5;
        Mon, 07 Oct 2019 15:10:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ejfq0Mc5y2dQchNRlWvp8Diy33ha1r0LaAd27i+X0Y8=;
        b=Qqgn7ETyz0nAJYUssdCPGKpvlDATHDL5/hpbmalgdVrmHZ3uJDU//jO41xoiKsGeq8
         G+Hx1TRhsI+ucGGRDc/JFfnrwRU65D/t7rAgREP6pgLM4Xq1HdXm2VpQlASwstv6ylp/
         QG1EpFtr3fF1a3M2SzS/dXLl63KEW4yuc0qklcyzqgJLraVvYdbcOHotLUipOfFMyfF9
         7MpuK/WCfUdn9DHDQc955qUjJxfRvSOJfnQVKIKrEsgA6qSNfor/MmJvSrAg5WeTP3lS
         aK11RDh7B4VsE2aH0A9CLr8yqDJ3eoUb3bN8FZkcaYkWaB0/J+D2owqQSHUZHKDs+rbi
         4R5g==
X-Gm-Message-State: APjAAAVz2zNwp5+gC98vtH2BY0hpwbX2FDkqcUx8eg/ZUOsBLD0gQ3MX
        Cll9EmuBf2WvApNtrhILu/WT5adu4rv8d8WBFT4=
X-Google-Smtp-Source: APXvYqzPRJFxFYuWxT4+ZfBG+w2vGH6NTchROSOQUcdmM5fCIL2BX1QvKN3iJG9HKm+wYCbZZdFHqvljXGP+vRDWt10=
X-Received: by 2002:ac8:342a:: with SMTP id u39mr32462138qtb.7.1570486224339;
 Mon, 07 Oct 2019 15:10:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190617221134.9930-1-f.fainelli@gmail.com> <CACRpkdbqW2kJNdPi6JPupaHA_qRTWG-MsUxeCz0c38MRujOSSA@mail.gmail.com>
 <0ba50ae2-be09-f633-ab1f-860e8b053882@broadcom.com> <CAK8P3a2QBQrBU+bBBL20kR+qJfmspCNjiw05jHTa-q6EDfodMg@mail.gmail.com>
 <fbdc3788-3a24-2885-b61b-8480e8464a51@gmail.com>
In-Reply-To: <fbdc3788-3a24-2885-b61b-8480e8464a51@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 8 Oct 2019 00:10:08 +0200
Message-ID: <CAK8P3a1E_1=_+eJXvcFMLd=a=YW_WGwjm3nzRZV7SzzZqovzRw@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] KASan for arm
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Michal Hocko <mhocko@suse.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Christoffer Dall <christoffer.dall@arm.com>,
        David Howells <dhowells@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        kvmarm@lists.cs.columbia.edu, Jonathan Corbet <corbet@lwn.net>,
        Abbott Liu <liuwenliang@huawei.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        drjones@redhat.com, Vladimir Murzin <vladimir.murzin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Jinbum Park <jinb.park7@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Landley <rob@landley.net>, philip@cog.systems,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Garnier <thgarnie@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 7, 2019 at 11:35 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> On 7/18/19 12:51 AM, Arnd Bergmann wrote:
> > On Thu, Jul 11, 2019 at 7:00 PM Florian Fainelli
> > <florian.fainelli@broadcom.com> wrote:
> >> On 7/2/19 2:06 PM, Linus Walleij wrote:
> >
> >>
> >> Great, thanks a lot for taking a look. FYI, I will be on holiday from
> >> July 19th till August 12th, if you think you have more feedback between
> >> now and then, I can try to pick it up and submit a v7 with that feedback
> >> addressed, or it will happen when I return, or you can pick it up if you
> >> refer, all options are possible!
> >>
> >> @Arnd, should we squash your patches in as well?
> >
> > Yes, please do. I don't remember if I sent you all of them already,
> > here is the list of patches that I have applied locally on top of your
> > series to get a clean randconfig build:
> >
> > 123c3262f872 KASAN: push back KASAN_STACK to clang-10
>
> This one seems to have received some feedback, not sure if it was
> addressed or not in a subsequent patch?

ebb6d35a74ce ("kasan: remove clang version check for KASAN_STACK")

got applied, it seems clang will remain broken with KASAN_STACK
for a while.

> > 053555034bdf kasan: disable CONFIG_KASAN_STACK with clang on arm32
>
> This one I did not take based on Linus' feedback that is breaks booting
> on his RealView board.

That likely means that there is still a bigger problem somewhere.

      Arnd
