Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 936FEC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 07:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D0E0206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 07:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iKdgZCvr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730659AbfHAHQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 03:16:54 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39708 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730201AbfHAHQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 03:16:53 -0400
Received: by mail-lj1-f193.google.com with SMTP id v18so68244120ljh.6
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 00:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4FFz/bBVyysFB3KKw1zsUFOn9cjX6r61XwqqAYRgWEw=;
        b=iKdgZCvrJQJIeS+/g945+X55Tei/luMZ4Sc+Lm+E2znXcqp88ynGWLPy13tSntyR8e
         O5LicATEHDYjGw1NW6E/WtaXTQOSYTQwWvm9aM2eBYDJqx+G1oMh53FAc55tmNGrIngK
         PbbB/AVGuOu2GadLaAhka/pdIzfUBqGF6XNacXQ/vro1Nxpgl6zazyjtSzUm7JYOzDZA
         sKUzfzXa1bU0BOipWyQFR4ZkJ7+oT5TQCR4rblxTy9Te69PdJAFtkSq5B/m07K0aMLzR
         yIAloAMM1RKjaq3d68KdctLDYrfHChaNI76Q/vB1szFX8yTKiuF2/1M6DECgyVHp5N1W
         JdAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4FFz/bBVyysFB3KKw1zsUFOn9cjX6r61XwqqAYRgWEw=;
        b=rvHBuRzXx5Rv9mNED0PhblnT0gm7foMmkDRlTY23z0p2kVvbTpa+Fke6E/A8zO6E9n
         Wzk6wSNTC7OFNd8KBPmI1I7tirLVvkHYjD+DcpscvPdtGljG2ZjA3pWSKKXRAxY1IREN
         PhCqGRyUoFeiixJDs5Fvtdskw/b4ZtqxpF6Vss/yTTJmN7GJJaNULZFivHwYR2JLPcAu
         /kJbdIeFpf1L8tKywaMGEEl/qifctEM/PK2OHZmWQwLAXzsk2wXQCLN0BZBGhKVHipCg
         DGyWMImbD8N2IXO/MViwaKnoUi3P9t9RdgL6mKQ2PKGqRoshnl+D2s531Yjzdpkw5hbf
         m3Rw==
X-Gm-Message-State: APjAAAVbIENmL6ht66gWxJWmB09pBdUiSOUZ+POYRs09fIEUtBVZcR2f
        RhQMpv0RF8bswqJKcwZHZea+QwDqEWos0OKxh3Q=
X-Google-Smtp-Source: APXvYqxawk86mFZPh1yYXR3JemJvu7om9uDV3pIgxG5km0lt7vXF06fErFGpfqHF0PbuR9wjdyTbewdJgcQ1kJUQlnk=
X-Received: by 2002:a2e:298a:: with SMTP id p10mr65571927ljp.74.1564643811920;
 Thu, 01 Aug 2019 00:16:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAD8Lp448i7jOk9C5NJtC2wHMaGuRLD4pxVqK17YqRCuMVXhsOA@mail.gmail.com>
In-Reply-To: <CAD8Lp448i7jOk9C5NJtC2wHMaGuRLD4pxVqK17YqRCuMVXhsOA@mail.gmail.com>
From:   Aubrey Li <aubrey.intel@gmail.com>
Date:   Thu, 1 Aug 2019 15:16:40 +0800
Message-ID: <CAERHkruxfBc8DqNUr=fbYuQWrXrHC7cK6HnVR3xp0iLA9QtxiQ@mail.gmail.com>
Subject: Re: setup_boot_APIC_clock() NULL dereference during early boot on
 reduced hardware platforms
To:     Daniel Drake <drake@endlessm.com>
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

On Thu, Aug 1, 2019 at 2:26 PM Daniel Drake <drake@endlessm.com> wrote:
>
> Hi,
>
> Working with a new consumer laptop based on AMD R7-3700U, we are
> seeing a kernel panic during early boot (before the display
> initializes). It's a new product and there is no previous known
> working kernel version (tested 5.0, 5.2 and current linus master).
>
> We may have also seen this problem on a MiniPC based on AMD APU 7010
> from another vendor, but we don't have it in hands right now to
> confirm that it's the exact same crash.
>
> earlycon shows the details: a NULL dereference under
> setup_boot_APIC_clock(), which actually happens in
> calibrate_APIC_clock():
>
>     /* Replace the global interrupt handler */
>     real_handler = global_clock_event->event_handler;
>     global_clock_event->event_handler = lapic_cal_handler;
>
> global_clock_event is NULL here. This is a "reduced hardware" ACPI
> platform so acpi_generic_reduced_hw_init() has set timer_init to NULL,
> avoiding the usual codepaths that would set up global_clock_event.
>
IIRC, acpi_generic_reduced_hw_init() avoids initializing PIT, the status of
this legacy device is unknown in ACPI hw-reduced mode.

> I tried the obvious:
>  if (!global_clock_event)
>     return -1;
>
No, the platform needs a global clock event, can you turn on some other
clock source on your platform, like HPET?

Thanks,
-Aubrey

> However I'm probably missing part of the big picture here, as this
> only makes boot fail later on. It continues til the next point that
> something leads to schedule(), such as a driver calling msleep() or
> mark_readonly() calling rcu_barrier(), etc. Then it hangs.
>
> Is something missing in terms of timer setup here? Suggestions appreciated...
>
> Thanks
> Daniel
