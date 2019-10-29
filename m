Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E0EDCA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 16:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ACB020679
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 16:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rl/H29SA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390487AbfJ2Q5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 12:57:53 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36160 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbfJ2Q5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 12:57:52 -0400
Received: by mail-wr1-f65.google.com with SMTP id w18so14493507wrt.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 09:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZJbi5YbmKNrHL1XknjXuRo00EQHW5Jt0yVwF2zf2Was=;
        b=Rl/H29SAXQ1Be88q7OjRWQJE8jm9LGdrRQtZI4ah4eyrfLVD0Q4rts86sJzZG5w630
         eIMg9OWCtnqBh/5w21FvZPe8ejb1DGIgOPY4Em8DE9qsJ/frmaJ+t8SziyG6HdQfHDLO
         DB3DTPs+pyzZ2p3k/DAspcBJ/lmNW3MIjvqP+4lVFL8FeLkAVS9Ry97yAQqzRs2TwK+p
         Osiclar5M784jKk6TwLe5bT6x5RcINXiAJHbmziFmoRMRn4E7lMGe8BBAX89kVVZSYOb
         qnXpkFETLXD26VtelqCdbEJ5q83sPU+SXoDk9bSp4IJr7bnNtz6uSn+5Stv5D8KKHN59
         VVuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZJbi5YbmKNrHL1XknjXuRo00EQHW5Jt0yVwF2zf2Was=;
        b=q/0p3fLK2rY0DmXc2C8pAf08djNwt28quyyLzqPv0iaFA1juTz/YLQS9kwWXC1ItjK
         szRNb3YvoCQP/ZHumuU8F8Nl6fzkfBU3sfXKRbmaXkGvRh0lc88u8RdgAEwNEB3TqqLN
         4jMDXazsZsUDgNqO9ppV12Fi9CMkWWud0Fuvw1j5z6TVd1RIxQFxZ/WUtd1IV7y7G76H
         Eg7ajbziOzoPVCpmY6YEZtSObn9Nz6ZQoucvhSZ5OxAd53RoEkTarhGCJlrxTrxD5UTe
         KX7rh2Fs60ZXVnvsEQxkoI7Bv8OXJYP+bCzeqEAAIZ1MGUvGiJFsQ5721HLubbSKDcQY
         hlCw==
X-Gm-Message-State: APjAAAU2U1PA8RbGQJFN0Ww6aIY6yL0KxBAjHocFHDIdR1hUCakxaUI6
        Ov2QeBvq+3RxEaopxAj4LOjEEMuUhQuoPE981cg=
X-Google-Smtp-Source: APXvYqynKTqTinWpsq8pOCI+HpEMdVlt3HdEVanM1rsr2bTGHtMpKiS8ycPgoxJzYazMVXy4X+66ljC9sCtynky2WSk=
X-Received: by 2002:a5d:65cf:: with SMTP id e15mr19945712wrw.391.1572368269062;
 Tue, 29 Oct 2019 09:57:49 -0700 (PDT)
MIME-Version: 1.0
References: <20191024142939.25920-1-andrey.zhizhikin@leica-geosystems.com>
 <20191025075335.GC32742@smile.fi.intel.com> <20191025075540.GD32742@smile.fi.intel.com>
 <166c9855-910d-a70c-ba86-6aebe5f2346d@intel.com> <20191028124554.GF5015@sirena.co.uk>
 <c5faf16d-892e-b36e-b448-9c59c2051b9e@redhat.com> <CAHtQpK5ocb8mqnf2dwcT7hQ9f8rQLtkHJsPppDWgfRPitJk6_Q@mail.gmail.com>
 <75d0e22f-c3fd-245c-c91e-2e3b6134b569@redhat.com>
In-Reply-To: <75d0e22f-c3fd-245c-c91e-2e3b6134b569@redhat.com>
From:   Andrey Zhizhikin <andrey.z@gmail.com>
Date:   Tue, 29 Oct 2019 17:57:45 +0100
Message-ID: <CAHtQpK5-wK-v2fS_cVT6f4evHDafFPv49XDNGO9B+daRR_bOkg@mail.gmail.com>
Subject: Re: [PATCH 0/2] add regulator driver and mfd cell for Intel Cherry
 Trail Whiskey Cove PMIC
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        lgirdwood@gmail.com, Lee Jones <lee.jones@linaro.org>,
        linux-kernel@vger.kernel.org,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans!

On Tue, Oct 29, 2019 at 1:04 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 28-10-2019 16:01, Andrey Zhizhikin wrote:
> > Hi Hans,
> >
> > On Mon, Oct 28, 2019 at 2:26 PM Hans de Goede <hdegoede@redhat.com> wrote:
> >>
> >> Hi,
> >>
> >> On 28-10-2019 13:45, Mark Brown wrote:
> >>> On Mon, Oct 28, 2019 at 02:41:46PM +0200, Adrian Hunter wrote:
> >>>> On 25/10/19 10:55 AM, Andy Shevchenko wrote:
> >>>
> >>>>> Since it's about UHS/SD, Cc to Adrian as well.
> >>>
> >>>> My only concern is that the driver might conflict with ACPI methods trying
> >>>> to do the same thing, e.g. there is one ACPI SDHC instance from GPDWin DSDT
> >>>> with code like this:
> >>
> >> Oh, right that is a very good point.
> >>
> >>> That's certainly what's idiomatic for ACPI (though machine specific
> >>> quirks are too!).  The safe thing to do would be to only register the
> >>> supply on systems where we know there's no ACPI method.
> >>
> >> Right, so as I mentioned before Andrey told me about the evaluation
> >> board he is using I was aware of only 3 Cherry Trail devices using
> >> the Whiskey Cove PMIC. The GPD win, the GPD pocket and the Lenovo
> >> Yoga book. I've checked the DSDT of all 3 and all 3 of them offer
> >> voltage control through the Intel _DSM method for voltage control.
> >>
> >> I've also actually tested this on the GPD win and 1.8V signalling
> >> works fine there without needing Andrey's patch.
> >
> > Thanks a lot for checking this one out! At least this proves now that
> > the only platform affected is in fact Intel Aero board, and the patch
> > as it is might not be necessary to accommodate for all CHT-based
> > products with Whiskey Cove.
> >
> >>
> >> So it seems that Andrey's patch should only be active on his
> >> dev-board, as actual production hardware ships with the _DSM method.
> >>
> >> I believe that the best solution is for the Whiskey Cove MFD driver:
> >> drivers/mfd/intel_soc_pmic_chtwc.c
> >>
> >> To only register the new cell on Andrey's evaluation board model
> >> (based in a DMI match I guess). Another option would be to do
> >> the DMI check in the regulator driver, but that would mean
> >> udev will needlessly modprobe the regulator driver on production
> >> hardware, so doing it in the MFD driver and not registering the cell
> >> seems best,
> >
> > I tend to lean to a solution to perform a DMI check in MFD rather than
> > in the regulator driver, since this would keep the regulator
> > more-or-less agnostic to the where it is running on.
> >
> > Or maybe it would even make more sense to create a board-specific hook
> > (like it was suggested for vqmmc voltage and sdmmc ACPI d of
> > consumer), and then only register a cell for Aero match? This would
> > actually keep the regulator consumer and mfd cell together and would
> > not allow the device-specific code to leak into generic driver
> > implementation. In this case I'd go with mfd_add_cell() if I get a DMI
> > match and register a vqmmc consumer in there.
> >
> > In that case, can you please tell me what you think about it and if
> > the drivers/acpi/acpi_lpss.c would still be an appropriate location to
> > put this code to?
>
> I do not think that drivers/acpi/acpi_lpss.c is a good place.

Thanks a lot for clarifying this point, I was also not sure whether I
would need combine the platform-specific functionality with LPSS
implementation.

>
> Thinking a bit more about this, my preferred solutions would be:
>
> 1. A BIOS update fixing the DSDT, as Andy suggested. Note we can
> lso use an overlay DSDT in the initrd, but that will only help users
> which take manual steps to add this to their initrd...

This I believe would not be an option since the Aero platform has been
phased-out from Intel, and Insyde most probably would not do an update
on the BIOS. I can go with DSDT overlay, but I was not sure whether
this is a good way to solve this.

>
> 2. A new drivers/platform/x86 driver binding to the dmi-ids of the Areo
> board, like e.g. drivers/platform/x86/intel_oaktrail.c is doing,
> unlike that one you do not need to register a platform_device from
> the module_init() function, you can just add the mfd-cell and the
> regulator constraints from the module_init() function.

This would be my preferred solution, since in this case I can contain
all the Aero-specific modifications to it's own board file. If there
would be further modifications needed for it - they would be nicely
contained within that board file.

>
> Assuming 1. is not an option (I do not know if Intel still
> supports the Aero), then 2 will nicely isolate all the Aero
> specific code into a driver which will only auto-load on
> the Aero.

Just as I indicated above, chances that BIOS would receive an update
are between slim and nil. If no one have any objection, I'd prefer to
go with the approach [2] from above.

>
> Regards,
>
> Hans
>


--
Regards,
Andrey.
