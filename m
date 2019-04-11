Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5825C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 06:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96DBB20850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 06:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia-com.20150623.gappssmtp.com header.i=@nvidia-com.20150623.gappssmtp.com header.b="E/Vi8fwT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfDKG2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 02:28:52 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45744 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbfDKG2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 02:28:51 -0400
Received: by mail-qk1-f195.google.com with SMTP id z76so2779366qkb.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 23:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nvidia-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QhQfWR7UxtaKGXy8qwnFddraCdWK02DD7UMojESGnds=;
        b=E/Vi8fwTs8qBA1Zk/lmttfuvBwhIlJyYoYb80dN93P6reL8W4mduCWDzKd7MX8Ugaj
         dWXxpA/mc9/oqOkrWXKzyFy7bThFSM4YNQtA54M0Bo29vyESmJj6yE7ncGFo0jaOnttD
         hNYiedZXXbb8a0B1OuSxrvhQGL20+k5uLo/xa2DmYsA4q1stuzQOhqMTnMiAUDKoZVQO
         izgmrQL7L0sI6Xp5VZ9+HEX6KLfb5R8YB3rP09QWXiSc1/ItTl6peHmqFpw7v+GtikZQ
         chiOicE5hM1l1asB5xfW6dV6UyMuIjzlEIr4DghU1M5+rCLq/oZfTFbaI3MO81c9s9BL
         K+cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QhQfWR7UxtaKGXy8qwnFddraCdWK02DD7UMojESGnds=;
        b=U5QaymHjE79BhIihLBVfqy4szG5xq+8LA5p2Hg8XJ5oiyvcErQC5HTGoIq2UkTGRBg
         kVq5GPShRnMsxefPxZoditBWC3DHO+Hf/ujwAoDdoGbrI1ZQIyD+1uQoP8TJewVFLwma
         3r2LQuu9Duwz9IJvuKpeBUfhuFQhFdVUDCEbCPdVUFKiT40A20KvSX9tbpLa3XYHOz+p
         KC7Xqqy+8zCdVXHoZYXzacPbeEGiIr6TBAiSQadt5m1bPK5fVqlla1NUSnrtMUeEZp9O
         THYlLgy1CG8JvNazLGtesv4iuOcl9bqxYQnwHgBNDebPC238/UY0Szu9cgvjXtbxwXdy
         +PMQ==
X-Gm-Message-State: APjAAAXlH0DtRwGe6UB/yHDG+3WHBxW8Pju7iAvtonffnWAXlYtUzQRu
        VqRJcLP23TeCCGK4g1AExIydZvtKoy+T/wUBMw==
X-Google-Smtp-Source: APXvYqySLX1BlzVO57KRvV025gFq35/8tUpBi4ivl7ILYNPyQGK6EEkqu3era89XF5DAUIkXWjrrjGpm9J4xo00qyec=
X-Received: by 2002:a05:620a:108f:: with SMTP id g15mr36926309qkk.61.1554964130719;
 Wed, 10 Apr 2019 23:28:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAMfhKb-PNYrEqc6S=AJKRvfwUU61x4La6dM-1EsxoCa69et6eQ@mail.gmail.com>
 <20190409142112.mcvzdxigjfxnzrb4@shell.armlinux.org.uk>
In-Reply-To: <20190409142112.mcvzdxigjfxnzrb4@shell.armlinux.org.uk>
From:   Jinyoung Park <jinyoungp@nvidia.com>
Date:   Thu, 11 Apr 2019 15:28:14 +0900
Message-ID: <CAMfhKb_xu0BRSACOQXYBEWgr-pEumeY=DYNRqgQViGAQ5atJ5Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] arch: arm64: process: Unlock console after SMP stopped
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Alex Van Brunt <avanbrunt@nvidia.com>,
        Ketan Patil <ketanp@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have observed this problem during reboot stress test on my ARM64
architecture board which is NVIDIA Tegra ARM64 CPU reference board.
The reboot stress test is to restart the system repeatedly for a long
time. The system is set with Kernel log level 8 for logging all kernel
messages during the tests.
I could see that sometimes latter part of the Kernel messages were
broken(or omitted).
So I have debugged this issue and made this patch.

The console_unlock() function emits all buffered messages in printk
log buffer prior to release the console lock.
This patch calls the console_unlock() after SMP stopped before
performing machine/architecture specific pm(reboot/power off) code.
This is to ensure no more additional messages from other process and
flush out all messages buffered in printk log buffer before the system
is restarted or power off.

> why this is only an ARM64 problem (or why you are only fixing this on ARM=
64 and not any of the other architectures.)
Honestly I am not sure that this issue is existing on other architectures.
Because my platform is ARM64 architecture and I have observed/verified
this problem with my patch on ARM64 only.

Thanks,
Jinyoung.

2019=EB=85=84 4=EC=9B=94 9=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 11:21, R=
ussell King - ARM Linux admin
<linux@armlinux.org.uk>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:

>
> On Tue, Apr 09, 2019 at 11:17:14PM +0900, Jinyoung Park wrote:
> > If the console lock is held by other CPU running while the system is
> > restarting or shutting down, the Kernel messages in the printk log buff=
er
> > can not be printed out to the console drivers. The Kernel messages can =
be
> > lost or messed up.
> > This change calls console_unlock after SMP stopped to flush the kernel
> > messages in the printk log buffer to the console drivers.
>
> I think you need to explain how we can get to each of these points
> while the current CPU is holding the console lock - and why this is
> only an ARM64 problem (or why you are only fixing this on ARM64 and
> not any of the other architectures.)
>
> >
> > Signed-off-by: Jinyoung Park <jinyoungp@nvidia.com>
> > ---
> >  arch/arm64/kernel/process.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> > index 3767fb21a5b8..d629a75c7602 100644
> > --- a/arch/arm64/kernel/process.c
> > +++ b/arch/arm64/kernel/process.c
> > @@ -49,6 +49,7 @@
> >  #include <trace/events/power.h>
> >  #include <linux/percpu.h>
> >  #include <linux/thread_info.h>
> > +#include <linux/console.h>
> >
> >  #include <asm/alternative.h>
> >  #include <asm/arch_gicv3.h>
> > @@ -164,6 +165,7 @@ void machine_halt(void)
> >  {
> >   local_irq_disable();
> >   smp_send_stop();
> > + console_unlock();
> >   while (1);
> >  }
> >
> > @@ -177,6 +179,7 @@ void machine_power_off(void)
> >  {
> >   local_irq_disable();
> >   smp_send_stop();
> > + console_unlock();
> >   if (pm_power_off)
> >   pm_power_off();
> >  }
> > @@ -195,6 +198,7 @@ void machine_restart(char *cmd)
> >   /* Disable interrupts first */
> >   local_irq_disable();
> >   smp_send_stop();
> > + console_unlock();
> >
> >   /*
> >   * UpdateCapsule() depends on the system being reset via
> > --
> > 2.19.0
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> >
>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbp=
s up
> According to speedtest.net: 11.9Mbps down 500kbps up
