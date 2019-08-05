Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74D7C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 15:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6CAB20B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 15:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nIKF7www"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729345AbfHEPzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 11:55:14 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44505 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728028AbfHEPzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 11:55:14 -0400
Received: by mail-wr1-f68.google.com with SMTP id p17so84924543wrf.11
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 08:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pnsluh819l1ZStKbmfOcG3O4jnLq32HWa/lDwn+83Yg=;
        b=nIKF7wwwI0QPjCu0IOvAfwL8Hr2Lr3IyHpP1+ypF27lI+2iwFL7eal+6vIO+rqw+Mt
         LXAwxw+s2ChlfUXNMEXSxChFPEyBlt2mrI7syMIUMzAKRifN913by3ykVqN0/d6xl7XU
         45yp5Dbam98j3f3E/3LUUY2skj+VRIR6Q8k8Rg31HD71xr5EqDX6gQ6cap/HUwc24hja
         S7D4kueITTfZcQpcEVxOCeYR8beovQfohGrp1HjLWzMgb2ix1D3u4rlYkfqFYgbvAlqx
         BgcR5X7htSE1LfbrPS4WmeTMbUqF3oBy6DHpwH+405NuzlAK/rx/oVE5GFOwT1brTawU
         LZFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pnsluh819l1ZStKbmfOcG3O4jnLq32HWa/lDwn+83Yg=;
        b=XXRxYuptmeKo3C0ge8mw8CM7vGQPAgo+E13gQa7FXWYsjgDKP8Ak9rQOSCMJSUhtVm
         9puJpooWxc7L/Vc04luL3BdavGeSrXybBJd+C8IO5tYY3czWSi7Bm/JNJRPdtSKnLxtO
         OLk2gzu+pWySFFDr7BTJvTGlvIHU22HMbx+Ng79XhdhNvtd0Xz6oZr6535lUVlLHZxaP
         N8jbuE+tGbzj37i+lnFN7SlCzkL/oStsmEv5oMMwHdldCvxGjsM701AVJItt2ObDQfVg
         1R/+6qrW75z5qgAzuveld10vfLxEOxcUrBGAYhRTu9y6Pvu/VhfmffwdF0P01ZT7MO5x
         ulgw==
X-Gm-Message-State: APjAAAUf9KtuZAaCue9A21p5SWbFq/UYu5yf6cq0Wei3crpDDs8TDWwH
        Mu0uMlfiESYB+qR2xwMLA8VOEMIfZBKldxhl/yjrkQ==
X-Google-Smtp-Source: APXvYqzYjhwZn5w5yyV/Vo+58zqgFvAH23OEi6QSh7dNxwvBI9af8UVivxjFT+LneGo0eAeVs1mIu/sfzpI/ECNUVHU=
X-Received: by 2002:a5d:46cf:: with SMTP id g15mr26762663wrs.93.1565020512761;
 Mon, 05 Aug 2019 08:55:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190805083553.GA27708@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20190805083553.GA27708@dhcp-128-65.nay.redhat.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 5 Aug 2019 18:55:03 +0300
Message-ID: <CAKv+Gu-my6EpLfxBnbMn21be62oHrF6PKFu2rt-4Pqk9wG9SXA@mail.gmail.com>
Subject: Re: [PATCH] do not clean dummy variable in kexec path
To:     Dave Young <dyoung@redhat.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Kexec Mailing List <kexec@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        Bhupesh Sharma <bhsharma@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Aug 2019 at 11:36, Dave Young <dyoung@redhat.com> wrote:
>
> kexec reboot fails randomly in UEFI based kvm guest.  The firmware
> just reset while calling efi_delete_dummy_variable();  Unfortunately
> I don't know how to debug the firmware, it is also possible a potential
> problem on real hardware as well although nobody reproduced it.
>
> The intention of efi_delete_dummy_variable is to trigger garbage collection
> when entering virtual mode.  But SetVirtualAddressMap can only run once
> for each physical reboot, thus kexec_enter_virtual_mode is not necessarily
> a good place to clean dummy object.
>

I would argue that this means it is not a good place to *create* the
dummy variable, and if we don't create it, we don't have to delete it
either.

> Drop efi_delete_dummy_variable so that kexec reboot can work.
>

Creating it and not deleting it is bad, so please try and see if we
can omit the creation on this code path instead.


> Signed-off-by: Dave Young <dyoung@redhat.com>
> ---
>  arch/x86/platform/efi/efi.c |    3 ---
>  1 file changed, 3 deletions(-)
>
> --- linux-x86.orig/arch/x86/platform/efi/efi.c
> +++ linux-x86/arch/x86/platform/efi/efi.c
> @@ -894,9 +894,6 @@ static void __init kexec_enter_virtual_m
>
>         if (efi_enabled(EFI_OLD_MEMMAP) && (__supported_pte_mask & _PAGE_NX))
>                 runtime_code_page_mkexec();
> -
> -       /* clean DUMMY object */
> -       efi_delete_dummy_variable();
>  #endif
>  }
>
