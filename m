Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F70C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 15:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9F4320656
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 15:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hfRTSKOt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732747AbfDQPpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 11:45:15 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:54858 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732689AbfDQPpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 11:45:14 -0400
Received: by mail-it1-f194.google.com with SMTP id a190so5336614ite.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 08:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R5ZsyseOLnuHeSKjZsorqJlQkydNJIKNBtGzV6Hi2TA=;
        b=hfRTSKOtzz7SeAIJhCK74qstaz29akae1OJKwDhZJOT+qpgK4pKFK9+LJScJED6dNr
         47fea44IWjMUGuCKEfk8RooN9SgyxIcvituc1aYZ+LwyYYmZiG4bQRalT4ue8WvMpmKG
         j0UH0/gFn1yZI+lablNAsv+Lfeg+5Y/IHZjyL73FMyodBvBaCMGe0MYTKBKp4Pk/8ACy
         gqq9tPO2OgbLMAmmxapyNwtG9O4946MsF9Uqhag5xtS+pQSB7RQjVvPVw8IWPfCl0XLF
         4VJnEpRClFYUfN7GtCk45duAXOnszRgGnrHhn7+QscHOhLxuRm6RrMnfVCmrOYNmyMZD
         sdUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R5ZsyseOLnuHeSKjZsorqJlQkydNJIKNBtGzV6Hi2TA=;
        b=ouI75oss25EeBmLVdP+PZYZsvcA/qOd3tfW19as3QJ4rlxE9F8RRYuBMli23g+H0Yq
         3SczZ6djO6+TCbc+zj4ajzk6/15FxE09KO0qvXY854Mxz8c/q7Qa9Cux779o5dXTp06k
         jPSl+lzonqC74zAiclO7h0AVi21rkp8f8pOWBLuCIEF8aHxHGkMg0EYrWLbHlLYd/ddq
         cRpI3wiUsZ7gHjAlD+HtGHBBabI9oL5+hE3d0jL+GbdhKPZlLljVH/PVuHbopmoQm7fU
         0sy7eI/ZRWPnfjLK4/eFX/BR8z16VJgYOqFTE6QsFY8oib0s6oiN0I8yaxs/p8udDrsq
         ZuKw==
X-Gm-Message-State: APjAAAUa1Y/Apg4IrrrA1ze12MN2aE9vJfnfWiiVg8fMldyED3ClCb//
        Kf0iPiy52peYoPu04Ay+iw830L1/TvaCrU8HFsN48A==
X-Google-Smtp-Source: APXvYqyLZwJTIVd7jAEIyDYdfUL9eZwtlDcO9U1EQjk/IpUaIcMfy6FVX9jafPt7Q3U3jKmkpIxjMMpAJU3ALKFPOqE=
X-Received: by 2002:a24:1312:: with SMTP id 18mr34649710itz.121.1555515913599;
 Wed, 17 Apr 2019 08:45:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190412080152.3718-1-jian-hong@endlessm.com> <tip-0082517fa4bce073e7cf542633439f26538a14cc@git.kernel.org>
 <20190416082042.GA69717@gmail.com> <CAD8Lp44pQRYdw4cbfMt3uOSO23dzy_mWTt5T-Zjft08WWu_yUA@mail.gmail.com>
 <20190417061650.GA31060@gmail.com> <CAD8Lp45BLaoXF=RNcncqcTtNvaGHP72+a1CxcjoeBXDiw9TKbA@mail.gmail.com>
 <17516564-37AC-4F77-9C0D-0DD71F8045EA@zytor.com>
In-Reply-To: <17516564-37AC-4F77-9C0D-0DD71F8045EA@zytor.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 17 Apr 2019 08:45:03 -0700
Message-ID: <CAKv+Gu_jqoKiqq4ozcPwSxLmpuaWsFKy_xyYGhECLz+KLHOjOw@mail.gmail.com>
Subject: Re: EFI reboot vs. ACPI reboot (was: Re: [tip:x86/urgent] x86/reboot,
 efi: Use EFI reboot for Acer TravelMate X514-51T)
To:     "H. Peter Anvin" <hpa@zytor.com>,
        "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
Cc:     Daniel Drake <drake@endlessm.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        linux-efi <linux-efi@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        linux-tip-commits@vger.kernel.org,
        Endless Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Apr 2019 at 08:16, <hpa@zytor.com> wrote:
>
> On April 17, 2019 5:38:41 AM PDT, Daniel Drake <drake@endlessm.com> wrote:
> >On Wed, Apr 17, 2019 at 2:16 PM Ingo Molnar <mingo@kernel.org> wrote:
> >> Ok, so acpi_gbl_reduced_hardware is set when the ... 'reduced
> >hardware'
> >> bit is set:
> >>
> >>         acpi_gbl_reduced_hardware = FALSE;
> >>         if (acpi_gbl_FADT.flags & ACPI_FADT_HW_REDUCED) {
> >>                 acpi_gbl_reduced_hardware = TRUE;
> >>         }
> >>
> >>
> >> which is described as:
> >>
> >>  #define ACPI_FADT_HW_REDUCED        (1<<20)     /* 20: [V5] ACPI
> >hardware is not implemented (ACPI 5.0) */
> >>
> >> That seems counter-intuitive to me: if no full ACPI hardware is
> >> implemented then we should assume reduced ACPI functionality, i.e. if
> >the
> >> EFI runtime is otherwise available we should default to it.
> >
> >It's a bit confusing, but my loose understanding is that previous
> >versions of the ACPI spec required system implementors to implement
> >the whole thing; but that's increasingly impractical today, e.g. with
> >ARM systems coming along, which do not gel well with some of the
> >historical x86-rooted design aspects that spilled over into ACPI. The
> >V5 spec introduces reduced mode as an opt-in new feature, but for
> >compatibility with pre-V5 implementations it needs to consider "full
> >hardware" mode as the default.
> >
> >> Feel free to send a patch that makes EFI reboot the default one under
> >> these circumstances,
> >
> >Just to check, you mean: EFI reboot (and shutdown) become the default
> >methods when the machine is booted in EFI mode, and EFI stuff has not
> >been disabled with a kernel parameter?
> >Even when running in full hardware ACPI mode.
> >
> >Thanks
> >Daniel
>
> This, I believe, is known to not work.

It definitely used to be the case that EFI reboot was unreliable, but
I don't know the details. I have added Sai to cc, he may be able to
provide a bit more context here, since he added the code to deal with
page faults during EFI runtime service invocations (which was inspired
by a EFI reboot issue IIRC). That feature may have improved the
situation, but I am not confident at all that it fixes all systems.
