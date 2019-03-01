Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6314FC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 14:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D4A120850
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 14:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xe4cRc+W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388286AbfCAOCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 09:02:36 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:46560 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727492AbfCAOCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 09:02:35 -0500
Received: by mail-io1-f66.google.com with SMTP id k21so19562660ior.13
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 06:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Si2N+fVBYM4/BHGMUkLHFP+GFNaG1OwqgG6uAYPO+ok=;
        b=xe4cRc+Wq45wRcZa+V7pq9bXWE6gzypCJPWbD9nrO9sLb+Gm97flD8hN+BdTSs+v66
         H9cVo3oDt+5O7KVpZ1JQInPxY+3hddZOStP91c1b7XVWg9kpzawXqPMExWPp7PHoVW30
         DPlSmzWGqrMWQgAVm9nwp2FvhXySgjFPGo9EBtzcdkvmirc01k/QWHqv7tgvoBZMBBX/
         93kXkzhsoSUpwFgd57A5J4egUMB6J+JN9NT/2QV4dwkpRBYt++vttv/W+liPr1rWlWJV
         +k/1uJzjS9UUoBgSZ1Gcq2Aj93mncJQ2ba78u8LLkPQOhFbpuCCMDJ4lI468TDnyuU75
         4NtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Si2N+fVBYM4/BHGMUkLHFP+GFNaG1OwqgG6uAYPO+ok=;
        b=eTe3mUcskznTH2/VrrIFqqPzWXRAwHC6tYF2KAIv/uej6A2PqkmQKD0EF40t7XIeGL
         z+rUdn48h+bzuAzXD8I/uh7rr1hmGjPxvdTstknQ+iu6vjbnoMZAqM1pjVSYLAEjMFO5
         xPCX+6yZgSi91YzKDsPSEoEi+h2qXpmCt6oEX03ian/MTsxSzs4yp6JZhXhUe4neAWU7
         U25XjAAaA0UWre9WrmLyCQnJlLdNcPyTzV1w9hBfwTAjaGW2enb+re/r6yZhnkq5tilA
         lMhN5FFZhWUYUfqadT4Jb9qWkBJzUFnE57R3R9mq+KjPef6vZbXcqFhONam7IVy7Boc1
         YqHA==
X-Gm-Message-State: APjAAAXHkP4j8pp1FrSG4y3I3psyVT1B3okBOBMlufdA8rz4XDXTVX+m
        beq1XzrgpALHTx+HzFBoQaspJXIHhf1ALlV7moLJTQ==
X-Google-Smtp-Source: APXvYqyrajRM2C7bNwls1cZtp9rt3+5OtoPi42pH+jdNocCNySeCnRlH6iFopGrZHyqmw1NXC8Zj6hncAnU5HwJA768=
X-Received: by 2002:a6b:7b02:: with SMTP id l2mr2832246iop.60.1551448954629;
 Fri, 01 Mar 2019 06:02:34 -0800 (PST)
MIME-Version: 1.0
References: <20190301134033.2100-1-tiwai@suse.de> <CAKv+Gu_d7fZuFmu6e5v4WFta11qVRkaKZWdt4X33JRLe3BwHZw@mail.gmail.com>
 <s5ha7ieels3.wl-tiwai@suse.de>
In-Reply-To: <s5ha7ieels3.wl-tiwai@suse.de>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 1 Mar 2019 15:02:23 +0100
Message-ID: <CAKv+Gu91QeeFHXfp4ShM2z1hbypwnoRKzZQQ3Sktk1sASXvR6Q@mail.gmail.com>
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

On Fri, 1 Mar 2019 at 15:01, Takashi Iwai <tiwai@suse.de> wrote:
>
> On Fri, 01 Mar 2019 14:53:39 +0100,
> Ard Biesheuvel wrote:
> >
> > On Fri, 1 Mar 2019 at 14:40, Takashi Iwai <tiwai@suse.de> wrote:
> > >
> > > Since 38ac0287b7f4 ("fbdev/efifb: Honour UEFI memory map attributes
> > > when mapping the FB"), efifb_probe() checks its memory range via
> > > efi_mem_desc_lookup(), and this leads to a spurious error message
> > > "EFI_MEMMAP is not enabled" at every boot on KVM.  This is quite
> > > annoying since the error message appears even if you set "quiet" boot
> > > option.
> > >
> > > Actually there are only a few places that call efi_mem_desc_lookup()
> > > function, and the other callers do give the explicit error messages
> > > when the function returns an error in anyway.  That is, the error
> > > message in the function is more or less moot.
> > >
> > > So let's downgrade the error message for stop annoying users.
> > >
> > > Fixes: 38ac0287b7f4 ("fbdev/efifb: Honour UEFI memory map attributes when mapping the FB")
> > > Bugzilla: https://bugzilla.suse.com/show_bug.cgi?id=1127339
> > > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > > ---
> > >  drivers/firmware/efi/efi.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> > > index 55b77c576c42..50ac33097458 100644
> > > --- a/drivers/firmware/efi/efi.c
> > > +++ b/drivers/firmware/efi/efi.c
> > > @@ -409,7 +409,7 @@ int efi_mem_desc_lookup(u64 phys_addr, efi_memory_desc_t *out_md)
> > >         efi_memory_desc_t *md;
> > >
> > >         if (!efi_enabled(EFI_MEMMAP)) {
> > > -               pr_err_once("EFI_MEMMAP is not enabled.\n");
> > > +               pr_debug("EFI_MEMMAP is not enabled.\n");
> > >                 return -EINVAL;
> > >         }
> > >
> >
> > efifb_probe() only calls efi_mem_desc_lookup() if
> > screen_info.orig_video_isVGA == VIDEO_TYPE_EFI, which only gets
> > assigned on a EFI boot.
> >
> > So even though I don't object to the patch as is, I would like to
> > understand where this error message is coming from, given that it
> > means that you are running on a UEFI system without the EFI memory
> > map.
> >
> > Is this system booting via GRUB in EFI mode?
>
> No, it's booted in legacy boot mode.  But the primary fb is efifb, and
> that's why the message appears.
>

So how are we ending up with

screen_info.orig_video_isVGA == VIDEO_TYPE_EFI

??
