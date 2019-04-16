Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B2EC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 995842077C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="uAkPAF7d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729292AbfDPLfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 07:35:31 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46847 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbfDPLfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 07:35:30 -0400
Received: by mail-qt1-f196.google.com with SMTP id z17so22749915qts.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 04:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hSpo+70L4YJM4x7lQl+FUrrPu4xrwP39JfmZPu4VWYs=;
        b=uAkPAF7dOR9jOlKZHaZlfPEmIS/RgB3aBfFO5ISaEvVTkkpTDvtkqE2+IQYHm0wHm5
         /JBoItz2UeYc0L3twdTNDOrT5Dd554Zs4I2/01JHZitwI53wuFt+wPWE4zEiuA+3Qr5H
         rIds5Z/hzLd3dkP4kkNvvu2g0wxgF91M/KviRxEqjsDwiw/wRFOCpm7rYVanNETHs5Rb
         Pzb8ZoCM1QC9DbqOBucMusuhjLWbwGd9l4mQv4sjPgA9/6Zy2pkpG/VXW3srkREJE2lv
         GUVSsmJqW9TZJwvLVCVmuXOOWWE/sj2pMwDNwvOWY355/IBgBeAD8FJmLLp+Vdhb9Mi2
         RkqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hSpo+70L4YJM4x7lQl+FUrrPu4xrwP39JfmZPu4VWYs=;
        b=nMMqnEoYdmeJfatiJI/28XOHYGQAEhsa4bZbsK9I19GYAI8HnNBx28ePs+vsc2Qdt5
         gBW0t7lARvxEcFqxymx1mQWchFP6a9J4UmqpRLrjQwD7aB3GDf9Q6mIM7GrzZX8g/b90
         2iTN+ISJIsAH9YhHAM6+oxGJ9Ne3J4Z3xqMsbDqiYErZDAZVWrkUORKDQWyPfZ6JgnYN
         ag5XH+UkPHSf85iPXouwU0hU4GHh1KcPBIm94OINNAhvOaD7sl4Got0WlXni1RE925sL
         yae3SwCsdQqNysGk5g3HefZbtExdo+voP2yvhyUVUoMbFF6KlUDTNS0S0mRcjRv+4oZo
         aUlw==
X-Gm-Message-State: APjAAAWYYp2GpXmyee65g7o8S5t3E8oIe1uCXh7s8GgpAnDdiZMRGgit
        hOS65GrZXB82w3lnjlSgQtPdjIbnpeLtZer/8cGdcg==
X-Google-Smtp-Source: APXvYqzNI5yfa49bSXSBniO2uM3TwMAMktYM04Sc142dyQ9kAJmI7sym+gBLu3fMdqLnJJIPfXaYpyZLnqtpzhPApSA=
X-Received: by 2002:ac8:3789:: with SMTP id d9mr17158568qtc.34.1555414529821;
 Tue, 16 Apr 2019 04:35:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190412080152.3718-1-jian-hong@endlessm.com> <tip-0082517fa4bce073e7cf542633439f26538a14cc@git.kernel.org>
 <20190416082042.GA69717@gmail.com>
In-Reply-To: <20190416082042.GA69717@gmail.com>
From:   Daniel Drake <drake@endlessm.com>
Date:   Tue, 16 Apr 2019 19:35:18 +0800
Message-ID: <CAD8Lp44pQRYdw4cbfMt3uOSO23dzy_mWTt5T-Zjft08WWu_yUA@mail.gmail.com>
Subject: Re: EFI reboot vs. ACPI reboot (was: Re: [tip:x86/urgent] x86/reboot,
 efi: Use EFI reboot for Acer TravelMate X514-51T)
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        matt@codeblueprint.co.uk,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>, hpa@zytor.com,
        linux-efi@vger.kernel.org, Len Brown <len.brown@intel.com>,
        linux-tip-commits@vger.kernel.org,
        Endless Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 4:20 PM Ingo Molnar <mingo@kernel.org> wrote:
> I wanted to get a second opinion from the EFI folks for this whole
> concept. On x86 we default to ACPI reboot on modern systems, and we
> default to EFI reboot on modern EFI systems, via the
> efi_reboot_required() method which keys off on acpi_gbl_reduced_hardware
> to create a barrier for older ACPI systems.

So if acpi_gbl_reduced_hardware is set, we are on a "modern EFI
system", and EFI reboot is used.

> It appears that Acer TravelMate X514-51T systems get marked as
> 'acpi_gbl_reduced_hardware' which enables ACPI-reboot, but they require
> EFI-reboot.

We will double check, but in this case I believe the system is *not*
marked as reduced hardware, which is why ACPI reboot is used.

> Should we perhaps re-think the boundary between EFI-reboot and
> ACPI-reboot systems? I.e. if the EFI runtime is enabled, shouldn't we
> just use the EFI reboot method?

I agree this is a good question.

We also previously hit a similar issue for shutdown on Acer laptops
which is still unresolved.
https://marc.info/?l=linux-acpi&m=148857214431346&w=2

Daniel
