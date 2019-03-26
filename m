Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 368D3C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE7252070D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LrVcGUiS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731979AbfCZQEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 12:04:46 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:50309 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbfCZQEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 12:04:45 -0400
Received: by mail-it1-f194.google.com with SMTP id m137so20426474ita.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 09:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X/BZkT3sMI6PxNDxJ9wjEwQ9eAe3t2LJp8Ur0SjOJss=;
        b=LrVcGUiSg8tnCnTHe6vEe5FJnjMbUw/izNtOT2u8o80rJiE7DGu1kOIMKlqY5YWotU
         eNhMudK2lwroLdlOsDJpovIOhrwssP0mDj05PmNx7/XxCBnd58UCQjCh4tMoJRxAzOqq
         9NJpPYqCpYEVI2qCJE0ojnbdE5L1W/S7gda0qblWByRdbwkNRirr1iFgY2SoTRwaIK54
         UlmFDyIyD/xXjN6NukIIi8jkvGFMDF67sfZq+EnEaBz8YKiBEpxNp3nIIgshnffgMpl2
         gAwmi1iJP0K8xoPCaubW0lf7OGvdzVXLGdt/iXUbIEISDryMxk0+iOelo5qYLFQb7vZt
         NMMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X/BZkT3sMI6PxNDxJ9wjEwQ9eAe3t2LJp8Ur0SjOJss=;
        b=GRLeCO4myApoyggT0xchAC812TCLnMgFuI3E4QZj07L722hWzgs33hYxLjUu64PERq
         +++/ZuVavmtFriFXFbwCMPvWDkzMlsZdAumvKvdIVkmbH+uqYx2bFriEkbBSHx+i7SUF
         Z1V0HZlq3umK3PLokxUQJMLnT0JkZ5YkIExTy8nm06eNAjD+rJsTVgYcQMNj2+FtmdRK
         8B7fbDxFacZOb04XTpss1ipiuDia7r3cicBbbi5TpHQl3p7BRBd2pinAzoCF8ZUeDTuO
         baS9H9yJEX6nxf+/nIi/EMWXsHzdiAMWzZtz9kFnBaosVqgQLPrwV6G2+zbjgWxD12m0
         shyg==
X-Gm-Message-State: APjAAAUNQMa62M2o0hjXWzAOmyMIGA1XDcsGxTn8VRmjp4O4X5XqrW3/
        7szzgaJXyakShlHaXVugDh/SrlxPpM5CqKxhr4QkKvjPZhU=
X-Google-Smtp-Source: APXvYqxNPtY8CbpkOFXGH421SsjkZi1xIhAfdVL9Vuib8YSaY9jRrFjIQyC0zTvACOC2+iVPSi+WnmwWCA4D2WS0iPI=
X-Received: by 2002:a05:660c:7d1:: with SMTP id e17mr194174itl.158.1553616284774;
 Tue, 26 Mar 2019 09:04:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190301134033.2100-1-tiwai@suse.de> <CAKv+Gu_d7fZuFmu6e5v4WFta11qVRkaKZWdt4X33JRLe3BwHZw@mail.gmail.com>
 <s5ha7ieels3.wl-tiwai@suse.de> <CAKv+Gu91QeeFHXfp4ShM2z1hbypwnoRKzZQQ3Sktk1sASXvR6Q@mail.gmail.com>
 <s5h5zt2el6d.wl-tiwai@suse.de> <CAKv+Gu-gp+Hvd-ZcZC-ZRQOHpinj_mXx-L6fTUkKWSXd0UwC+g@mail.gmail.com>
 <s5hpnrad38j.wl-tiwai@suse.de> <s5himw564l0.wl-tiwai@suse.de>
In-Reply-To: <s5himw564l0.wl-tiwai@suse.de>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 26 Mar 2019 17:04:30 +0100
Message-ID: <CAKv+Gu-C08VWKD8HrGfFMgQ+LxxXKtPEjGyJpwQoSu63zT_ZOQ@mail.gmail.com>
Subject: Re: [PATCH] efi: Downgrade "EFI_MEMMAP is not enabled" message
To:     Takashi Iwai <tiwai@suse.de>
Cc:     "Lee, Chun-Yi" <jlee@suse.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Mar 2019 at 16:25, Takashi Iwai <tiwai@suse.de> wrote:
>
> On Fri, 01 Mar 2019 16:27:24 +0100,
> Takashi Iwai wrote:
> >
> > On Fri, 01 Mar 2019 15:57:03 +0100,
> > Ard Biesheuvel wrote:
> > >
> > > On Fri, 1 Mar 2019 at 15:14, Takashi Iwai <tiwai@suse.de> wrote:
> > > >
> > > > On Fri, 01 Mar 2019 15:02:23 +0100,
> > > > Ard Biesheuvel wrote:
> > > > >
> > > > > On Fri, 1 Mar 2019 at 15:01, Takashi Iwai <tiwai@suse.de> wrote:
> > > > > >
> > > > > > On Fri, 01 Mar 2019 14:53:39 +0100,
> > > > > > Ard Biesheuvel wrote:
> > > > > > >
> > > > > > > On Fri, 1 Mar 2019 at 14:40, Takashi Iwai <tiwai@suse.de> wrote:
> > > > > > > >
> > > > > > > > Since 38ac0287b7f4 ("fbdev/efifb: Honour UEFI memory map attributes
> > > > > > > > when mapping the FB"), efifb_probe() checks its memory range via
> > > > > > > > efi_mem_desc_lookup(), and this leads to a spurious error message
> > > > > > > > "EFI_MEMMAP is not enabled" at every boot on KVM.  This is quite
> > > > > > > > annoying since the error message appears even if you set "quiet" boot
> > > > > > > > option.
> > > > > > > >
> > > > > > > > Actually there are only a few places that call efi_mem_desc_lookup()
> > > > > > > > function, and the other callers do give the explicit error messages
> > > > > > > > when the function returns an error in anyway.  That is, the error
> > > > > > > > message in the function is more or less moot.
> > > > > > > >
> > > > > > > > So let's downgrade the error message for stop annoying users.
> > > > > > > >
> > > > > > > > Fixes: 38ac0287b7f4 ("fbdev/efifb: Honour UEFI memory map attributes when mapping the FB")
> > > > > > > > Bugzilla: https://bugzilla.suse.com/show_bug.cgi?id=1127339
> > > > > > > > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > > > > > > > ---
> > > > > > > >  drivers/firmware/efi/efi.c | 2 +-
> > > > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > > >
> > > > > > > > diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> > > > > > > > index 55b77c576c42..50ac33097458 100644
> > > > > > > > --- a/drivers/firmware/efi/efi.c
> > > > > > > > +++ b/drivers/firmware/efi/efi.c
> > > > > > > > @@ -409,7 +409,7 @@ int efi_mem_desc_lookup(u64 phys_addr, efi_memory_desc_t *out_md)
> > > > > > > >         efi_memory_desc_t *md;
> > > > > > > >
> > > > > > > >         if (!efi_enabled(EFI_MEMMAP)) {
> > > > > > > > -               pr_err_once("EFI_MEMMAP is not enabled.\n");
> > > > > > > > +               pr_debug("EFI_MEMMAP is not enabled.\n");
> > > > > > > >                 return -EINVAL;
> > > > > > > >         }
> > > > > > > >
> > > > > > >
> > > > > > > efifb_probe() only calls efi_mem_desc_lookup() if
> > > > > > > screen_info.orig_video_isVGA == VIDEO_TYPE_EFI, which only gets
> > > > > > > assigned on a EFI boot.
> > > > > > >
> > > > > > > So even though I don't object to the patch as is, I would like to
> > > > > > > understand where this error message is coming from, given that it
> > > > > > > means that you are running on a UEFI system without the EFI memory
> > > > > > > map.
> > > > > > >
> > > > > > > Is this system booting via GRUB in EFI mode?
> > > > > >
> > > > > > No, it's booted in legacy boot mode.  But the primary fb is efifb, and
> > > > > > that's why the message appears.
> > > > > >
> > > > >
> > > > > So how are we ending up with
> > > > >
> > > > > screen_info.orig_video_isVGA == VIDEO_TYPE_EFI
> > > > >
> > > > > ??
> > > >
> > > > Ah, sorry, my description was too ambiguous.
> > > >
> > > > Actually our GRUB2 default setup boots the Linux kernel with linuxefi.
> > > > What I meant was that I invoked qemu-kvm without any -bios option, so
> > > > it's no EFI BIOS.
> > > >
> > >
> > > Some from the link here
> > >
> > > https://openqa.opensuse.org/tests/864184/file/journal_check-full_journal.log
> > >
> > > I got
> > >
> > > Feb 27 13:13:41 linux-e2c3 kernel: efifb: probing for efifb
> > > Feb 27 13:13:41 linux-e2c3 kernel: efi: EFI_MEMMAP is not enabled.
> > > Feb 27 13:13:41 linux-e2c3 kernel: fbcon: Taking over console
> > > Feb 27 13:13:41 linux-e2c3 kernel: efifb: No BGRT, not showing boot graphics
> > > Feb 27 13:13:41 linux-e2c3 kernel: efifb: framebuffer at 0xfc000000,
> > > using 1408k, total 1408k
> > > Feb 27 13:13:41 linux-e2c3 kernel: efifb: mode is 800x600x24,
> > > linelength=2400, pages=1
> > > Feb 27 13:13:41 linux-e2c3 kernel: efifb: scrolling: redraw
> > > Feb 27 13:13:41 linux-e2c3 kernel: efifb: Truecolor: size=0:8:8:8,
> > > shift=0:16:8:0
> > > Feb 27 13:13:41 linux-e2c3 kernel: Console: switching to colour frame
> > > buffer device 100x37
> > > Feb 27 13:13:41 linux-e2c3 kernel: fb0: EFI VGA frame buffer device
> > >
> > > So if we are doing legacy, there is something else that is taking,
> > > GRUB perhaps, that is taking the framebuffer parameters and putting
> > > them in screen_info and marking them as VIDEO_TYPE_EFI.
> > >
> > > If this is a reasonable thing to do, it implies that the efifb driver
> > > may run on otherwise non-EFI systems, and if this is the case, I'd
> > > rather fix it like this:
> > >
> > > diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
> > > index ba906876cc45..9e529cc2b4ff 100644
> > > --- a/drivers/video/fbdev/efifb.c
> > > +++ b/drivers/video/fbdev/efifb.c
> > > @@ -464,7 +464,8 @@ static int efifb_probe(struct platform_device *dev)
> > >         info->apertures->ranges[0].base = efifb_fix.smem_start;
> > >         info->apertures->ranges[0].size = size_remap;
> > >
> > > -       if (!efi_mem_desc_lookup(efifb_fix.smem_start, &md)) {
> > > +       if (efi_enabled(EFI_BOOT) &&
> > > +           !efi_mem_desc_lookup(efifb_fix.smem_start, &md)) {
> > >                 if ((efifb_fix.smem_start + efifb_fix.smem_len) >
> > >                     (md.phys_addr + (md.num_pages << EFI_PAGE_SHIFT))) {
> > >                         pr_err("efifb: video memory @ 0x%lx spans
> > > multiple EFI memory regions\n",
> > >
> > > Could you please confirm whether this works around the issue as well?
> >
> > Yeah, that makes sense, and I confirmed that your patch worked.
> > Both EFI_BOOT and EFI_MEMMAP are 0 on the default boot.
> >
> > Reported-and-tested-by: Takashi Iwai <tiwai@suse.de>
>
> Ard, what is the status of this fix?
>

I will get it queued for v5.2
