Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68ECFCA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 08:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ED3820862
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 08:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i6fHLUXi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfJaIYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 04:24:44 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38610 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbfJaIYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 04:24:43 -0400
Received: by mail-wr1-f68.google.com with SMTP id v9so5187761wrq.5
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 01:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hwRXo6F4Q49q2OBaCjuHQqtxPHes3aTNLtF4lURqyMo=;
        b=i6fHLUXiRR5UkIqqSBjC6ztqMNazpDg62eCa0ff6GP9Qt5QQfz5iTquXhd4F39+mYc
         u1w9ohGsXZTSFrmXZV6/t/aluc2s5O1YZR2OpmhbMo2jsqjpSMb2/66A2g+JifTzoWE3
         Q0U8MkIew1zeHP2NuQrdsltJKUM2HMJP0yldaOBI7VUOC/+PmSRWABGmktjluGExCps/
         ypYMgDU7N6/GAQko9k31Zq0KzFvsxXajclFLYpf8v/rSAVBKnuEvvNCt6BhVMghMGIaV
         7wkFzrvIh4WaQgXVREi4TGhFHEm8Mu9kuLoSuEtO4GwXu378GyLeaJq9/gELsV//5nFn
         1bAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hwRXo6F4Q49q2OBaCjuHQqtxPHes3aTNLtF4lURqyMo=;
        b=LsIyBqJIzUEqieSoXrL40KIWbw/5FpEfVLTj3ElfHJQHQ+kBXkl232LVysHzfkzwib
         pdOorbQTjZ7uSgkEGXp/8//0q0NlmRl6J0YdOzunR42fmvL4I/Uxz8sVsTWacHA87TzV
         7q23XPs1MYDhX2RnzyrEVnAh5hFGKyTPxJSiHM5DLi9/SEg4rcUdCOm9wjGgHm2Cu/SK
         qISquvlukDBADzNZ5AaDY71JcXAl+Ozo0Efw46PxHUellXVk6rsW5YjuXbV/yAexQaAs
         JTz2ScUt5AHCYzrLqWHU1olwacjho+u6A8JSWTwWxNCymj1g0DBb3iEdVClA9/HQWKi+
         AJlg==
X-Gm-Message-State: APjAAAWM7IQEnA6a0BqeMogkjM2R8Uxhvmz5Q6k4hA9P5Ze/e5tr5NoH
        LACObZaOZnyT4CCBZlvJW3aYOL4f6fF/PB5q4e6wWg==
X-Google-Smtp-Source: APXvYqzcs5anAptA40KO2f/DjMvYh1MjL0Q8+V3IIgHojFe37raK8oYokFb0klEN4SUxJbbhlaj9FJFoP0hfP8H0A4Y=
X-Received: by 2002:adf:8289:: with SMTP id 9mr4551139wrc.0.1572510280859;
 Thu, 31 Oct 2019 01:24:40 -0700 (PDT)
MIME-Version: 1.0
References: <20191029173755.27149-1-ardb@kernel.org> <20191029173755.27149-4-ardb@kernel.org>
 <CACi5LpMAagnn_yEmqRBGfxJFZcAUzohU30NACeGvdXaHFZwAMA@mail.gmail.com>
In-Reply-To: <CACi5LpMAagnn_yEmqRBGfxJFZcAUzohU30NACeGvdXaHFZwAMA@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 31 Oct 2019 09:24:29 +0100
Message-ID: <CAKv+Gu_zMMeRSBYk_tBX4UA+v1r+Kntrxe3xurLd1Q2_+HkbWw@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] efi/random: treat EFI_RNG_PROTOCOL output as
 bootloader randomness
To:     Bhupesh Sharma <bhsharma@redhat.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Oct 2019 at 20:14, Bhupesh Sharma <bhsharma@redhat.com> wrote:
>
> Hi Ard,
>
> On Tue, Oct 29, 2019 at 11:10 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > From: Dominik Brodowski <linux@dominikbrodowski.net>
> >
> > Commit 428826f5358c ("fdt: add support for rng-seed") introduced
> > add_bootloader_randomness(), permitting randomness provided by the
> > bootloader or firmware to be credited as entropy. However, the fact
> > that the UEFI support code was already wired into the RNG subsystem
> > via a call to add_device_randomness() was overlooked, and so it was
> > not converted at the same time.
> >
> > Note that this UEFI (v2.4 or newer) feature is currently only
> > implemented for EFI stub booting on ARM, and further note that
> > CONFIG_RANDOM_TRUST_BOOTLOADER must be enabled, and this should be
> > done only if there indeed is sufficient trust in the bootloader
> > _and_ its source of randomness.
> >
> > Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
> > [ardb: update commit log]
> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>
> Seems my Tested-by was dropped which I provide for the RFC version of
> this patch.
> See <https://www.mail-archive.com/linux-efi@vger.kernel.org/msg12281.html>
> for details.
>
> I can provide a similar Tested-by for this version as well.
>

Thanks Bhupesh
