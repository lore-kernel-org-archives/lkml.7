Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA7DC04E87
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 09:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F9F02082E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 09:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kp1Z2DT/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbfEQJYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 05:24:41 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:39500 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728394AbfEQJYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 05:24:40 -0400
Received: by mail-it1-f195.google.com with SMTP id 9so10883436itf.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 02:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q1hRjgKSwHweZk8dB5JUfhPlYFrMWm3LL+UTvBdMO2U=;
        b=Kp1Z2DT/3W0yLQXVVl4ufLxOAJJlrRiv4Dqcu//FVib0bsRORina1Clxh30Mhe66cK
         E5D53/P6TIz3VL3qLtK7u8U7Kx1QUWl37ynrZajaq7Eh3j1IwXPKiU0rPNXswc+oXUGB
         gFPo6rIuBqhwMsQYdXALxUEi23N82f1NPxqLONoccpUJBJw9Uh+o9QbJ6HVEiIKm1ORT
         cysucRwvJTDop1Z4tDuuUrORv24g/sInMFpyfo73MmJhyg2YUeKkdmY2hlyjjw01BTm7
         PVQjYzmZ6ZavAB8o9/m6U9tdt5zXRf65pxGnumjGTeVsZaI4TYyPNSJ50JuldP6pGUVV
         LSNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q1hRjgKSwHweZk8dB5JUfhPlYFrMWm3LL+UTvBdMO2U=;
        b=RxDJa3sgtR1IbFbgM+/y+53OO2YcabmoZoGvLnBhnaCa/mmDv0abwO3rU6zpJR56Rm
         Tyq+mAseNsIBZ3GuMDHkXmmyW44k347PcPomMhJB+IDmuiZST+WE0Q93K+Dr/Uqsq1xI
         ckZwi6D9ClCl/qxKUbKHOWULIUot3t7dCV2zYohaAiPifY6Hd8uC7FDXP1rX3R1g5bMh
         2npn+StfKyPV9xL4TiN6xZzLME4pT5hk+ayhgE9ZeN3hW5P3n3MDlNruFq3lzDbzkW1v
         WUn+rxNue3HRP8H76x+/enxms1FxOPsgAAaKX6tj8qmSHKk32SWmGJbhVfvgeUgWzHMS
         4ZaA==
X-Gm-Message-State: APjAAAWFtBpugPjpIsI1YX9yQsW7mIUdzNWUluEv+j2dh6Y1gnr9vg36
        9puBqrIVo11rR/Cl2Me5bhT8N0IDIF26oiPDtlxrmQ==
X-Google-Smtp-Source: APXvYqytJXMSh0eWfFOe5vOtUBeNAjTIoGoPnGO7MgQT6P5toncYqfiXlKrthASKsuyH6YeXZy+sb6ra9HCrreFdOdc=
X-Received: by 2002:a24:d00e:: with SMTP id m14mr15838673itg.153.1558085080212;
 Fri, 17 May 2019 02:24:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190517082633.GA3890@zhanggen-UX430UQ> <CAKv+Gu98JNK34Q6MNOe3aq0W5rbv6hUFiuc7cHxHJat5aTk_gg@mail.gmail.com>
 <20190517090628.GA4162@zhanggen-UX430UQ>
In-Reply-To: <20190517090628.GA4162@zhanggen-UX430UQ>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 17 May 2019 11:24:27 +0200
Message-ID: <CAKv+Gu_mwFpdtNZm9QMFn69+vOMTOpv9gvuhnBL2NBXvwkhXqg@mail.gmail.com>
Subject: Re: [PATCH] efi_64: Fix a missing-check bug in arch/x86/platform/efi/efi_64.c
 of Linux 5.1
To:     Gen Zhang <blackgod016574@gmail.com>,
        linux-efi <linux-efi@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 May 2019 at 11:06, Gen Zhang <blackgod016574@gmail.com> wrote:
>
> On Fri, May 17, 2019 at 10:41:28AM +0200, Ard Biesheuvel wrote:
> > Returning an error here is not going to make much difference, given
> > that the caller of efi_call_phys_prolog() does not bother to check it,
> > and passes the result straight into efi_call_phys_epilog(), which
> > happily attempts to dereference it.
> >
> > So if you want to fix this properly, please fix it at the call site as
> > well. I'd prefer to avoid ERR_PTR() and just return NULL for a failed
> > allocation though.
> Hi Ard,
> Thanks for your timely reply!
> I think returning NULL in efi_call_phys_prolog() and checking in
> efi_call_phys_epilog() is much better. But I am confused what to return
> in efi_call_phys_epilog() if save_pgd is NULL. Definitely not return
> -ENOMEM, because efi_call_phys_epilog() returns unsigned long. Could
> please light on me to fix this problem?


If efi_call_phys_prolog() returns NULL, the calling function should
abort and never call efi_call_phys_epilog().
