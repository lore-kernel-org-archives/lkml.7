Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5CAC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 06:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E1DA2080C
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 06:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556607072;
	bh=tULc1JZsb3/RTJlYGTzGL/zZaGbVQSAk/MThZupBMkk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=gnP1D2dLDzXawbgmpYWIrYxh8q7RGlbFCjMk6pd0SQEj5TCjJfVnNOvfpOpdZ3/B0
	 fyBZB0gSaC8dmj75qRACze/TvVMUTor/0tK4lAUAPPD/D3JkRwUB5E4vgKpD9fx1mb
	 +X+DReRV2eSlFJ0QdvXnl0mzjb+mt7x2Vjty4cZQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfD3GvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 02:51:11 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40089 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbfD3GvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 02:51:11 -0400
Received: by mail-ed1-f68.google.com with SMTP id e56so4984441ede.7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 23:51:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qN3VerpaqOdIGuUXTR5dt2XO1wBt2HwygQaOykPSnWA=;
        b=L/j0tH7Zm//Y2Tetki2qKe9GcQNMINWkRSyftcITh17V6x3ZewHGo1jNj0TckUlBKs
         8iFfx53bB9ZqwH9Z4Gd8B5y1mjDR6YXRWYbylY3yKM7mc56O1F6dk7t0QQeKrw5Nhey+
         9nFvpmqxBXICG3wzCy9aidYtMUxH2YDnkI8NDWAQSjc3VSQDru+2CmTUg4ax41ch0+Xi
         zeckrKTXEfoOI0RqNR4GHuZlyd7K8vMpDtQR+Y7NV94Iv9T/96VmrHYd6I3TF5oiuUhJ
         VXQkzJsx0ty7nnmQDASOpIKcNh29uaCnLXipWjOCGmwUOfoC8ECOqkoOLpDkwKPpjLfb
         BYSQ==
X-Gm-Message-State: APjAAAWnaDnytUXdbc5uxBAsRcDp1kbAbNyO2lW7vxuzI2tK6y96DKFj
        9xgJsV7iogy9hGaGwzMbGCJu5SrzoQXrt2wfCA0=
X-Google-Smtp-Source: APXvYqy7IHrFf5cO9MwCM3ULkpQ+lYR72AOeZL73CTeC67+M93PR+Ok//ypK1bnMCaAGlX2bazs3zTog1FBO63/Fa/0=
X-Received: by 2002:a50:b513:: with SMTP id y19mr19629692edd.100.1556607069701;
 Mon, 29 Apr 2019 23:51:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190226062012.23746-1-lenb@kernel.org> <20190226190512.GR2861@worktop.programming.kicks-ass.net>
In-Reply-To: <20190226190512.GR2861@worktop.programming.kicks-ass.net>
From:   Len Brown <lenb@kernel.org>
Date:   Tue, 30 Apr 2019 02:50:58 -0400
Message-ID: <CAJvTdK=SGZy+vbTcCKAmBeQSkeuAW0UxEpKXY2YNvmUofFXNUQ@mail.gmail.com>
Subject: Re: [PATCH 0/14] v2 multi-die/package topology support
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     X86 ML <x86@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 2:05 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Feb 26, 2019 at 01:19:58AM -0500, Len Brown wrote:
> >  Documentation/cputopology.txt                | 72 ++++++++++++++---------
> >  Documentation/x86/topology.txt               |  6 +-
> >  arch/x86/include/asm/processor.h             |  5 +-
> >  arch/x86/include/asm/smp.h                   |  1 +
> >  arch/x86/include/asm/topology.h              |  5 ++
> >  arch/x86/kernel/cpu/topology.c               | 85 +++++++++++++++++++++-------
> >  arch/x86/kernel/smpboot.c                    | 73 +++++++++++++++++++++++-
> >  arch/x86/xen/smp_pv.c                        |  1 +
> >  drivers/base/topology.c                      | 22 +++++++
> >  drivers/hwmon/coretemp.c                     |  9 +--
> >  drivers/powercap/intel_rapl.c                | 75 +++++++++++++-----------
> >  drivers/thermal/intel/x86_pkg_temp_thermal.c |  9 +--
> >  include/linux/topology.h                     |  6 ++
> >  13 files changed, 276 insertions(+), 93 deletions(-)
>
> Should we not also have changes to
> arch/x86/kernel/cpu/proc.c:show_cpuinfo_cores() ?

Good question.
I was thinking that /proc/cpuinfo was sort of the legacy API, and
adding a field might break something.
While adding an attribute to sysfs topology directory was the
compatible/safe way to make additions.

/proc/cpuinfo has these fields today:

physical id : 0
    this is the physical package id
siblings : 8
    this is the count of cpus in the same package
core id : 3
    this is cpu_core_id
cpu cores : 4
    this is booted_cores

If one were to make a change here, I'd consider adding the (physical) die_id,
though it is already in sysfs topology as an attribute.

Not sure if it would then make sense to print the count of cpus in the die.
Not sure what I'd name it, and this info is already in sysfs as a map and list.


Len Brown, Intel Open Source Technology Center
