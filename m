Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CFB8C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 07:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8D942077C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 07:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia-com.20150623.gappssmtp.com header.i=@nvidia-com.20150623.gappssmtp.com header.b="AbiZQsZF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfDLH1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 03:27:08 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42136 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfDLH1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 03:27:07 -0400
Received: by mail-qt1-f194.google.com with SMTP id p20so10118881qtc.9
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 00:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nvidia-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=30Fo6Clzz8dol1O3VfDDhMVETihzXIADpxAQDp0YU4E=;
        b=AbiZQsZFyqaSjfvP6sErfanPI53Qe7Fwm0srTqmkl/xC10Ojyu23FOAW7ReJzqYu5Y
         ufIRUMJqYvIXY7rXJb9zQH9l135a7D6l86wooTnTBQHDZGQCLn7y3TNEXyn8PfH6zeB8
         VpeL4m3Y5A6a9oQW6C0mJaKxWv0UKOYrXyFDUncQ9o9+lLZ9Ttacd9+f55a9GquWofXm
         0XDX7r4O3myM+rBCylEL64OTU/rliYukcQmY5h1RX8CoP9ValaaQCMPbgyDCUwhx6arX
         4aqkoDjSIdBos6Ac9D4NJ9NLAly4+sxHlv4ydatM8SAC6tdUYta0wafkfWCtnLxjY+5X
         uuWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=30Fo6Clzz8dol1O3VfDDhMVETihzXIADpxAQDp0YU4E=;
        b=Tk0kVCRB+Gyta30A2PB/owiFxf9oq/l9O7+4U7BodNsUPtdYLq47cqxHkroNGo29kI
         zgs7pNCOjH2YkdayetbhyNOUVm5NmEZEln5vBuIqP2Kx+mycmBQNONBprXax73vuO3Ux
         IzIqlm6eVGAxZIpixNJWtW52WqS+JWwJTInSlVkTjVmebPtzY/0IkC6bdjWOQa8smG6p
         JUFFkDXxdnS4KPqLdtGTs2ojUXLJABLgzvwVCvLEwpmmmlNytAzpvX1rKgn7v/iYTcxO
         8cJv16iZCTcXS2YKOPBuw1tXwUj1YdFzUt52yopG/mCqH/k9BnwhKARlgGkNiQIKVPTk
         TDcg==
X-Gm-Message-State: APjAAAWOcq110F+iesf9KtCq0pA39oD2kQCeFgB42Y9Zkt9eXfWL8XMw
        Ub0Gz4tNfA4vK2X7iFWHyss68nNqm//WfARkWA==
X-Google-Smtp-Source: APXvYqwsHLa+CLArgK1/hKsklj+PBvL93Ieg3l7I3D51jEtjc+C9U/rIZgjiSAH48iULZ/w55ASr7maw8Fu4UPB90+A=
X-Received: by 2002:ac8:7653:: with SMTP id i19mr45493911qtr.177.1555054026565;
 Fri, 12 Apr 2019 00:27:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAMfhKb-PNYrEqc6S=AJKRvfwUU61x4La6dM-1EsxoCa69et6eQ@mail.gmail.com>
 <20190409142112.mcvzdxigjfxnzrb4@shell.armlinux.org.uk> <CAMfhKb_xu0BRSACOQXYBEWgr-pEumeY=DYNRqgQViGAQ5atJ5Q@mail.gmail.com>
In-Reply-To: <CAMfhKb_xu0BRSACOQXYBEWgr-pEumeY=DYNRqgQViGAQ5atJ5Q@mail.gmail.com>
From:   Jinyoung Park <jinyoungp@nvidia.com>
Date:   Fri, 12 Apr 2019 16:26:30 +0900
Message-ID: <CAMfhKb8JivdHv6ihgHDtVGuM5ETmc+K6=qd8a0Ap3kwPkHTxSw@mail.gmail.com>
Subject: Fwd: [PATCH 1/1] arch: arm64: process: Unlock console after SMP stopped
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Ketan Patil <ketanp@nvidia.com>,
        Alex Van Brunt <avanbrunt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Re-sending)

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
