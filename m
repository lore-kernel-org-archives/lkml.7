Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94981C388F3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 09:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D336215EA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 09:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EHCoy2wu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729729AbfJAJlu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 05:41:50 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38747 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727130AbfJAJlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 05:41:50 -0400
Received: by mail-wm1-f68.google.com with SMTP id 3so2458788wmi.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 02:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vi+sFa/+bKOzmEgzPLyHTjnkLYnraiSelUjtcSuIz18=;
        b=EHCoy2wuDrKlcHpLccfnylgzN8VpxoY+w7gOmCndjNy7myqA2eGnN2c3OdFk5i+4yQ
         PtT+b21SKSVmhgcLkrIQZi5oV8kmtTnhFPRvHko54sohSTQlq8RZP4ycPlYXquW/5KFk
         lh4cLIn1L2ZsNfwWGY0OFadUygqKPF4HBFM6yzz9aHr7DdpoGPTWvSCovYLgy9x1U27x
         HhJMaycw007fJznmeFJKY9EogXH8OPMNLQR8HKSaQKOblz5I+U1ha9M1vXCXeB4C3AjA
         a/1uzJ+5ePKz0VW1y5jaIjoBrlMPgRX63Fqc1001Vulf1OIWxt9I7GsjvXbgDC7GN8f7
         aUzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vi+sFa/+bKOzmEgzPLyHTjnkLYnraiSelUjtcSuIz18=;
        b=s0k+HZGx1ru0bPicSrQOIvRo47edfYWTJ1TbzjBY0N/atllXsLn4LoxsEv3LsILq/w
         QCSGko1vWo8rekTZRpP33KvZ1VuwkE+89pfTgc4LiFy/wsVwSIwq29/Q5ZKEqD0wPEH2
         Npa/MlTtmGXpCEKx9+ME5uzC/L4uUVzbu5moDqSTj+DAVEPnHQCs+ErMD/dXTGZHJuBM
         N6Uxg2pw4qA5UbhXczEF37SU6mifOnAusLNXTKKmhJMqTG540i3pbjOSrBAu70bBziEK
         2IRnuChXKA/w0fk4PLeiHni50jBv+gYEOvj8tK1xgunQWrXvuoYNAcjbZLgLPE5XFqtT
         o36w==
X-Gm-Message-State: APjAAAVn4gwyMAd0pKCxBmjklbmtmT3Qn6NaxnSNftoNT7r08tcqND92
        Xu4gbIXKx+uytOhyltBFKdKJCtdvEEtQ2LlClwkFeg==
X-Google-Smtp-Source: APXvYqwczxAXrTbgBGOXAhD4ZakB4fvWFnguJrxw2LJF6kwEsICo7eng3AC6GjuGwAm2CQjpf8GOFgARh5ZiMjpzXf4=
X-Received: by 2002:a1c:e906:: with SMTP id q6mr1685973wmc.136.1569922908018;
 Tue, 01 Oct 2019 02:41:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190812150452.27983-1-ard.biesheuvel@linaro.org>
 <20190812150452.27983-5-ard.biesheuvel@linaro.org> <CAMuHMdXY5UH4KhcaNVuxa8-+GN-4bjyvCd0wzPYuFBY5Ch=fNA@mail.gmail.com>
 <CAKv+Gu-KPypju6roQaVKP0DHE3aZijVVqLGwNyhiRSNqn1r6-w@mail.gmail.com> <CAMuHMdV9m+Dbch46cVNqtn4cyB74qgHa18Qcm=HQv7Wx1rk==w@mail.gmail.com>
In-Reply-To: <CAMuHMdV9m+Dbch46cVNqtn4cyB74qgHa18Qcm=HQv7Wx1rk==w@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 1 Oct 2019 11:41:35 +0200
Message-ID: <CAKv+Gu9iLxkJgmxZR+1yvCTj6GiCDuyfN_QiGXEWBHS7uYUbfQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] efi: Export Runtime Configuration Interface table to sysfs
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Narendra K <Narendra.K@dell.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Xiaofei Tan <tanxiaofei@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Oct 2019 at 11:03, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Ard,
>
> On Tue, Oct 1, 2019 at 10:54 AM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
> > On Tue, 1 Oct 2019 at 10:51, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Mon, Aug 12, 2019 at 5:07 PM Ard Biesheuvel
> > > <ard.biesheuvel@linaro.org> wrote:
> > > > From: Narendra K <Narendra.K@dell.com>
> > > >
> > > > System firmware advertises the address of the 'Runtime
> > > > Configuration Interface table version 2 (RCI2)' via
> > > > an EFI Configuration Table entry. This code retrieves the RCI2
> > > > table from the address and exports it to sysfs as a binary
> > > > attribute 'rci2' under /sys/firmware/efi/tables directory.
> > > > The approach adopted is similar to the attribute 'DMI' under
> > > > /sys/firmware/dmi/tables.
> > > >
> > > > RCI2 table contains BIOS HII in XML format and is used to populate
> > > > BIOS setup page in Dell EMC OpenManage Server Administrator tool.
> > > > The BIOS setup page contains BIOS tokens which can be configured.
> > > >
> > > > Signed-off-by: Narendra K <Narendra.K@dell.com>
> > > > Reviewed-by: Mario Limonciello <mario.limonciello@dell.com>
> > > > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > >
> > > Thanks, this is now commit 1c5fecb61255aa12 ("efi: Export Runtime
> > > Configuration Interface table to sysfs").
> > >
> > > > --- a/drivers/firmware/efi/Kconfig
> > > > +++ b/drivers/firmware/efi/Kconfig
> > > > @@ -180,6 +180,19 @@ config RESET_ATTACK_MITIGATION
> > > >           have been evicted, since otherwise it will trigger even on clean
> > > >           reboots.
> > > >
> > > > +config EFI_RCI2_TABLE
> > > > +       bool "EFI Runtime Configuration Interface Table Version 2 Support"
> > > > +       help
> > > > +         Displays the content of the Runtime Configuration Interface
> > > > +         Table version 2 on Dell EMC PowerEdge systems as a binary
> > > > +         attribute 'rci2' under /sys/firmware/efi/tables directory.
> > > > +
> > > > +         RCI2 table contains BIOS HII in XML format and is used to populate
> > > > +         BIOS setup page in Dell EMC OpenManage Server Administrator tool.
> > > > +         The BIOS setup page contains BIOS tokens which can be configured.
> > > > +
> > > > +         Say Y here for Dell EMC PowerEdge systems.
> > >
> > > A quick Google search tells me these are Intel Xeon.
> > > Are arm/arm64/ia64 variants available, too?
> > > If not, this should be protected by "depends on x86" ("|| COMPILE_TEST"?).
> >
> > The code in question is entirely architecture agnostic, and defaults
> > to 'n', so I am not convinced this is needed. (It came up in the
> > review as well)
>
> "make oldconfig" still asks me the question on e.g. arm64, where it is
> irrelevant, until arm64 variants of the hardware show up.
>
> So IMHO it should have "depends on X86 || COMPILE_TEST".
>

Fair enough. I am going to send out a bunch of EFI fixes this week, so
I'll accept a patch that makes the change above.
