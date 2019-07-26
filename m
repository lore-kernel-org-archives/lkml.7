Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7F1C76190
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 11:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E04E229F3
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 11:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="pETxnGiW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbfGZLpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 07:45:32 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38451 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbfGZLpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 07:45:31 -0400
Received: by mail-lj1-f196.google.com with SMTP id r9so51188139ljg.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 04:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IIyzRbatR38ttllEYMMotwwVkanyqchmaJcpYBpIki0=;
        b=pETxnGiWkSphfi8/+4c4u+22brSho8PFLYphcLagT7bB4i3SZD16fRKJ1ZGb4qp9QL
         XlEsF8oKodWUi4PTu9/XdlUG9gA1pNqyjoA1KsmDLbgysBzBCd4nQcFsDELuCIbpAPhL
         21AoZAsF7HFuXv/4+6Ros9QR2I6qyBtvICViA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IIyzRbatR38ttllEYMMotwwVkanyqchmaJcpYBpIki0=;
        b=QKYxmsiyqQ+2HHaZw77ysnM+Xi3p/obREgf1YqUxOyMzi92Yz3LpiqJDgwhs3CsGMk
         AQxE8IPevQnljWPC27m/jH0pYJmd0MajmeLZpaZORUu29gAz0RTj4+o+lI/5w2zTg6Lw
         yqpBN9m9iH2vUdfHNOrIwVt/t1fqEXpaJEL/UBooh6B3j0Sbr0zLNrnz4aYUwgWNl+N+
         ddFPy9UUtaz3ctxHtOsXe/EjN5flMx8d7wWUGHpgbrAdQAkq1EoDVTyDnqcH4U1mlaKt
         DhtJBamm+kUPgfnqtOEqXsToCuW+OsW61KhePpuo+PX7f/g+/Bc9S09YUzQIUpAKm8Rj
         rmQg==
X-Gm-Message-State: APjAAAX+/kkRMQHKjYZispwFbrWiBqdUNCG88yvpx6K5Rq9sKuJsPrHR
        Hw8VlLpbVuS2OkQuUCFG9rXFrvd2Yociw9X0lg8=
X-Google-Smtp-Source: APXvYqy1v+K91LR9Uqf7ttTOrc82KHvHW4Tm7nxGruwvykh6mSwzjj9McmHGuJKaCGbsiBx37LheJaMcKc4BiMCDW/c=
X-Received: by 2002:a2e:3602:: with SMTP id d2mr13542107lja.112.1564141528767;
 Fri, 26 Jul 2019 04:45:28 -0700 (PDT)
MIME-Version: 1.0
References: <3b922aa4-c6d4-e4a4-766d-f324ff77f7b5@linux.com>
 <40f8b7d8-fafa-ad99-34fb-9c63e34917e2@redhat.com> <CALAqxLU199ATrMFa2ARmHOZ3K6ZnOuDLSAqNrTfwOWJaYiW7Yg@mail.gmail.com>
 <CALAqxLU0VUp=PGx5=JuVp6c5gwLqpSZJxs7ieL631QhdzNQTyA@mail.gmail.com>
In-Reply-To: <CALAqxLU0VUp=PGx5=JuVp6c5gwLqpSZJxs7ieL631QhdzNQTyA@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 26 Jul 2019 07:45:17 -0400
Message-ID: <CAEXW_YQFKhfS=2-LkkDkSg_1XzWh9WUa__nWjqxL0Uts9yyDdg@mail.gmail.com>
Subject: Re: Limits for ION Memory Allocator
To:     John Stultz <john.stultz@linaro.org>
Cc:     Laura Abbott <labbott@redhat.com>, alex.popov@linux.com,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Christian Brauner <christian@brauner.io>,
        Riley Andrews <riandrews@android.com>,
        driverdevel <devel@driverdev.osuosl.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Brian Starkey <brian.starkey@arm.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Linux-MM <linux-mm@kvack.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        syzkaller <syzkaller@googlegroups.com>,
        Hridya Valsaraju <hridya@google.com>,
        Alistair Delva <adelva@google.com>,
        Chenbo Feng <fengc@google.com>,
        Erick Reyes <erickreyes@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 4:24 PM John Stultz <john.stultz@linaro.org> wrote:
>
> On Wed, Jul 24, 2019 at 1:18 PM John Stultz <john.stultz@linaro.org> wrote:
> >
> > On Wed, Jul 24, 2019 at 12:36 PM Laura Abbott <labbott@redhat.com> wrote:
> > >
> > > On 7/17/19 12:31 PM, Alexander Popov wrote:
> > > > Hello!
> > > >
> > > > The syzkaller [1] has a trouble with fuzzing the Linux kernel with ION Memory
> > > > Allocator.
> > > >
> > > > Syzkaller uses several methods [2] to limit memory consumption of the userspace
> > > > processes calling the syscalls for testing the kernel:
> > > >   - setrlimit(),
> > > >   - cgroups,
> > > >   - various sysctl.
> > > > But these methods don't work for ION Memory Allocator, so any userspace process
> > > > that has access to /dev/ion can bring the system to the out-of-memory state.
> > > >
> > > > An example of a program doing that:
> > > >
> > > >
> > > > #include <sys/types.h>
> > > > #include <sys/stat.h>
> > > > #include <fcntl.h>
> > > > #include <stdio.h>
> > > > #include <linux/types.h>
> > > > #include <sys/ioctl.h>
> > > >
> > > > #define ION_IOC_MAGIC         'I'
> > > > #define ION_IOC_ALLOC         _IOWR(ION_IOC_MAGIC, 0, \
> > > >                                     struct ion_allocation_data)
> > > >
> > > > struct ion_allocation_data {
> > > >       __u64 len;
> > > >       __u32 heap_id_mask;
> > > >       __u32 flags;
> > > >       __u32 fd;
> > > >       __u32 unused;
> > > > };
> > > >
> > > > int main(void)
> > > > {
> > > >       unsigned long i = 0;
> > > >       int fd = -1;
> > > >       struct ion_allocation_data data = {
> > > >               .len = 0x13f65d8c,
> > > >               .heap_id_mask = 1,
> > > >               .flags = 0,
> > > >               .fd = -1,
> > > >               .unused = 0
> > > >       };
> > > >
> > > >       fd = open("/dev/ion", 0);
> > > >       if (fd == -1) {
> > > >               perror("[-] open /dev/ion");
> > > >               return 1;
> > > >       }
> > > >
> > > >       while (1) {
> > > >               printf("iter %lu\n", i);
> > > >               ioctl(fd, ION_IOC_ALLOC, &data);
> > > >               i++;
> > > >       }
> > > >
> > > >       return 0;
> > > > }
> > > >
> > > >
> > > > I looked through the code of ion_alloc() and didn't find any limit checks.
> > > > Is it currently possible to limit ION kernel allocations for some process?
> > > >
> > > > If not, is it a right idea to do that?
> > > > Thanks!
> > > >
> > >
> > > Yes, I do think that's the right approach. We're working on moving Ion
> > > out of staging and this is something I mentioned to John Stultz. I don't
> > > think we've thought too hard about how to do the actual limiting so
> > > suggestions are welcome.
> >
> > In part the dmabuf heaps allow for separate heap devices, so we can
> > have finer grained permissions to the specific heaps.  But that
> > doesn't provide any controls on how much memory one process could
> > allocate using the device if it has permission.
> >
> > I suspect the same issue is present with any of the dmabuf exporters
> > (gpu/display drivers, etc), so this is less of an ION/dmabuf heap
> > issue and more of a dmabuf core accounting issue.
> >
>
> Also, do unmapped memfd buffers have similar accounting issues?
>

The syzcaller bot didn't complain about this for memfd yet, so I suspect not ;-)

With memfd since it uses shmem underneath, __vm_enough_memory() is
called during shmem_acct_block() which should take per-process memory
into account already and fail if there is not enough memory.

Should ION be doing something similar to fail if there's not enough memory?

thanks,

- Joel
