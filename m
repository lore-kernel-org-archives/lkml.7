Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E4AC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 13:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A38B220842
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 13:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hu0t9YO/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388248AbfCANxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 08:53:52 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:37799 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387863AbfCANxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 08:53:51 -0500
Received: by mail-it1-f195.google.com with SMTP id z124so21404397itc.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 05:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lHIdPMoAwFiMEDBpSNIEOAU/QIzOnenQUIAEP8aLUSA=;
        b=Hu0t9YO/7seu4AKV8DUZkjVlnre8GmnUGHSke38mlz/23z4zgu1kIU2k/q82YI2WEH
         0E+yGqXFLKsX2jK29qfxZrq2bRmX8SlmBN83qX7OXdeSlA97aTP4KaKsPRMB1Sjy2Trz
         2dHdtx2RrBfGyznvO/FiQpZWSo21A7dNyMBh9LNr+KD3M4uRKeMwvMyBHXBXtlxT8R/V
         met1LTisP2TORwvNZbBVt1Mve3d+NUF5nZ95OQeBohliKkgEFG+PjsJpMTBD434lwrjm
         G5IMfDCwjHKyLFJZOS0wR/N/vKd4NZij8fm0Z77sfCK5cUZSbu2OVoO8XiVq2cDMlm80
         jLqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lHIdPMoAwFiMEDBpSNIEOAU/QIzOnenQUIAEP8aLUSA=;
        b=gBVsGsLVjyfZSOUFn9BinEEOHajX4q+Xmw05bVnPfE77BLpIV1iWx9Qw6vulRiH5uZ
         IvwCLIj27LBVzgXO1vt+bmCQozKWKlENkTo1qEXOvU+nWOLO80S/DRxYz+ciZBSAKBc6
         wdY6qjacUrKRETITMZnA+NqasFyvDDasgifqj2FrnluHb/F/dry++noyhXDgjoT3Fo4a
         6ticnRtwJtnD+phV33VdFJru1lBRW2/7mpcgKmOkC0poxAKCfMOMfU1v4GUCimu3Istm
         2VCJ2PbeGRQml86/w5FC+sZMKR2BL8om2Qc4qr++IKFX0ZClNDDG6WKjjUcNG4zBclPT
         U6IA==
X-Gm-Message-State: APjAAAWTVSJZO1IaH4znu9+cFAS2aW8egAF3o/g58KeD3giWE69Cl5jX
        CeuF46ZHK4+amL4UFyqj6aCItaZEQZVs8lU3YDQx1QGBZkk=
X-Google-Smtp-Source: AHgI3IYrr+ANGHAPWqW5s+45J9gkidn+mkvEAt5yNYx2hVFoQZdSBAA6vtGHBYcVy2syuWV79TVIRrSAhn/f3mbPDRU=
X-Received: by 2002:a24:45dd:: with SMTP id c90mr3249267itd.71.1551448430715;
 Fri, 01 Mar 2019 05:53:50 -0800 (PST)
MIME-Version: 1.0
References: <20190301134033.2100-1-tiwai@suse.de>
In-Reply-To: <20190301134033.2100-1-tiwai@suse.de>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 1 Mar 2019 14:53:39 +0100
Message-ID: <CAKv+Gu_d7fZuFmu6e5v4WFta11qVRkaKZWdt4X33JRLe3BwHZw@mail.gmail.com>
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

On Fri, 1 Mar 2019 at 14:40, Takashi Iwai <tiwai@suse.de> wrote:
>
> Since 38ac0287b7f4 ("fbdev/efifb: Honour UEFI memory map attributes
> when mapping the FB"), efifb_probe() checks its memory range via
> efi_mem_desc_lookup(), and this leads to a spurious error message
> "EFI_MEMMAP is not enabled" at every boot on KVM.  This is quite
> annoying since the error message appears even if you set "quiet" boot
> option.
>
> Actually there are only a few places that call efi_mem_desc_lookup()
> function, and the other callers do give the explicit error messages
> when the function returns an error in anyway.  That is, the error
> message in the function is more or less moot.
>
> So let's downgrade the error message for stop annoying users.
>
> Fixes: 38ac0287b7f4 ("fbdev/efifb: Honour UEFI memory map attributes when mapping the FB")
> Bugzilla: https://bugzilla.suse.com/show_bug.cgi?id=1127339
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  drivers/firmware/efi/efi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 55b77c576c42..50ac33097458 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -409,7 +409,7 @@ int efi_mem_desc_lookup(u64 phys_addr, efi_memory_desc_t *out_md)
>         efi_memory_desc_t *md;
>
>         if (!efi_enabled(EFI_MEMMAP)) {
> -               pr_err_once("EFI_MEMMAP is not enabled.\n");
> +               pr_debug("EFI_MEMMAP is not enabled.\n");
>                 return -EINVAL;
>         }
>

efifb_probe() only calls efi_mem_desc_lookup() if
screen_info.orig_video_isVGA == VIDEO_TYPE_EFI, which only gets
assigned on a EFI boot.

So even though I don't object to the patch as is, I would like to
understand where this error message is coming from, given that it
means that you are running on a UEFI system without the EFI memory
map.

Is this system booting via GRUB in EFI mode?
