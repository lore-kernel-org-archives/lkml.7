Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FBAC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 09:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FA2620449
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 09:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="UQqr+QnD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729561AbfHAJAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 05:00:36 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37137 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbfHAJAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 05:00:35 -0400
Received: by mail-qk1-f196.google.com with SMTP id d15so51369940qkl.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 02:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5b7IX24q7TktlSYgCt2gjNJ7EhCRc6l/ODk9oaxl5ZY=;
        b=UQqr+QnDpzpU+LfYLXsCQi6KmKayfm0JGfi7FLDk/g5i/+KMS83US2Pj+wWYwBmyCb
         U5TlKmnctaAJqUjTRYHu1CpjwiBSZ8gs5lk8gfVtiZeKxEUdqepRwxJNH+o492G6sU/k
         Eij7atIwrkkpPt4e6T1Y9u4dbRlbTiGxO9bxhONLXZR8s/NMNG/eiUiuhw1Cjto0XwLe
         N4sCRt+02d5TDQd35PJ6S2kH2BOx3kL+s37ZpRcKm2Whx4ajrenw2wAA223auee5QKS0
         AeDD7fbe4q1M7XlXNn1q7/+AuVnHvi45pOieoPgJ91x8kvtZKfhwByDcOxpEV3MVldTv
         NYQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5b7IX24q7TktlSYgCt2gjNJ7EhCRc6l/ODk9oaxl5ZY=;
        b=JcOQxJlcWaNe3lZ6ywAKGT82bvgdL6exRvz9CNJ4mo7b8dEIVRwstLtu3OMS5qoeP+
         Ez4xmUX8B6flY7U0r1sUKV0z/zSsRUQVccE3bjpNc39bzjYkjHUD4Snpylup3iggpeJv
         bgLwWkIrTWZ/BkFhBaIoLd3o7xTQ+6wwaPwlRsO8mjG0XupqOtzJQDFhb1KUfTjXMgD4
         O/TZ8yGnVDXY2n2ytY2sZSDwb7prbRNjIP6nWmwxwJ/HTV9DE+VKmjkmXCHJ0+RTUOJY
         RBApLCXPU5Dggbq41A88MSKV3XINZvGYLiX33THQLS3Q21HLT3Yi6RZEH/NpjTOO5RGB
         bA3Q==
X-Gm-Message-State: APjAAAWcEA33eDv0S2DEhXr7P/CyUOMdlUbX9n2MIx5QFls+/mOjwIRI
        kBJxrLll8+C+X8ERlitRFMDJ6EvrSpb8YsegyW4aKw==
X-Google-Smtp-Source: APXvYqxEEQEHhlBNeS9HjuaZsVMH2aqPKJb5AwTD60/tY5vKGuO6UInESbGlcEoV7JB7ewO+Vu6TQM5uE9S6mJdKQ70=
X-Received: by 2002:ae9:e64d:: with SMTP id x13mr79671110qkl.445.1564650034512;
 Thu, 01 Aug 2019 02:00:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAD8Lp448i7jOk9C5NJtC2wHMaGuRLD4pxVqK17YqRCuMVXhsOA@mail.gmail.com>
 <CAERHkruxfBc8DqNUr=fbYuQWrXrHC7cK6HnVR3xp0iLA9QtxiQ@mail.gmail.com>
In-Reply-To: <CAERHkruxfBc8DqNUr=fbYuQWrXrHC7cK6HnVR3xp0iLA9QtxiQ@mail.gmail.com>
From:   Daniel Drake <drake@endlessm.com>
Date:   Thu, 1 Aug 2019 17:00:23 +0800
Message-ID: <CAD8Lp452GdoL-Bt7rSP=u3RKEZ2H3qm3LvKfe=cCsjP0biG_sQ@mail.gmail.com>
Subject: Re: setup_boot_APIC_clock() NULL dereference during early boot on
 reduced hardware platforms
To:     Aubrey Li <aubrey.intel@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Endless Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 1, 2019 at 3:16 PM Aubrey Li <aubrey.intel@gmail.com> wrote:
> No, the platform needs a global clock event, can you turn on some other
> clock source on your platform, like HPET?

Thanks Audrey and Thomas for the quick hints!

I double checked under Windows - it seems to be using a HPET there.
Also there is the HPET ACPI table. So I think this is the right angle
to look at.

Under Linux, hpet_legacy_clockevent_register() is the function where
global_clock_event can be set to HPET.

However, the only way this can be called is from hpet_enable().

hpet_enable() is called from 2 places:
 1. From hpet_time_init(). This is the default x86 timer_init that
acpi_generic_reduced_hw_init() took out of action here.
 2. From hpet_late_init(). However that function is only called late,
after calibrate_APIC_clock() has already crashed the kernel. Also,
even if moved earlier it would also not call hpet_enable() here
because the ACPI HPET table parsing has already populated
hpet_address.

I tried slotting in a call to hpet_enable() at an earlier point
regardless, but I still end up with the kernel hanging later during
boot, probably because irq0 fails to be setup and this error is hit:
    if (setup_irq(0, &irq0))
        pr_info("Failed to register legacy timer interrupt\n");

I'll go deeper into that; further hints welcome too.

Thanks
Daniel
