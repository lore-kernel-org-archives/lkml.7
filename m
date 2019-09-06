Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0C4C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 10:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 536F020674
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 10:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="yxDHBsT+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732187AbfIFKTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 06:19:42 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37723 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbfIFKTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 06:19:42 -0400
Received: by mail-wm1-f65.google.com with SMTP id r195so6457076wme.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 03:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9+3W/oqdP+82I1MrFFrfRhGsJJP0+EU6DFkCg6JlOeo=;
        b=yxDHBsT+qmgNqxLHwi7P7pAREpOgV9VvoWzCky4JhmBoRf0mKbhX5IgBSNqt7BLHgE
         Pl1R/rnZ2h6Qc9ScIY9Ap6fSyW066dyiAt66rhiR58kJbKzg1KM2opSVmNPisc4ES+aF
         mcVO1d5Hi9B7LnNv6EonPvOkAeyAL9zrxgz/zNahbOKbGGMzzrzQxPI+XdC21JxrhBt5
         7xvebwM4mFwOAnlbN0l63Uud8iTaQ0ezxFMshn9LWXB5RN0BQz3fvzeleilU102gbUfQ
         0H6Nk9Lm++bMLDj1xxMCA8NFNAd9uJAcsNe0pwoGdCPQ8lQi/vAbfuAqpgxCuhSfvdiK
         iZRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9+3W/oqdP+82I1MrFFrfRhGsJJP0+EU6DFkCg6JlOeo=;
        b=AYQrJ0uE/kwoxvitKIr/Li3qgRXe9JQvCI0wRRdjncEFc05PAs1PI5T88xPVWd5+7D
         6OxH+sOHiPi4ncrtHL1y2O1COkYnc+eOdS0ZyfE8TJS4JO7DxxfUpK/emMcjH+uFNusK
         iphzp24TOl0t+X2f018E1gstyqPclrYH2JKjyhHS6XY0HTNiOM7Xw/3aEIqHcplXTq/j
         qn6TayecIs2iApqCS2TyZ53jO4NSzDPbXsPyPa2X6RNeu8nCJpapwjPiw1rUyqEvysgK
         Ao4TRSDi3SNEvb9uDB7AmeCQ9t/LWJ0r41mdLY1J1IIMQ2JRR+1Rjbu6ItajiyUkIv/x
         3YIQ==
X-Gm-Message-State: APjAAAU44ucr7JecZRUC7N1hfMCBZIhG77/yefh3trL+6IMBKyNC6+CQ
        pHn8UhA6Faa+YfcltvRhmn39Zh1a6M2ksK6PdKIRLQ==
X-Google-Smtp-Source: APXvYqzBM6RUeUi+OedZEF56G5h+FUamsZBarTawvRUOOBu83bU3z9209/SFRV6pfZFGMDa36fO90GPhFU3aVlEBxsM=
X-Received: by 2002:a1c:a697:: with SMTP id p145mr5950796wme.24.1567765178623;
 Fri, 06 Sep 2019 03:19:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190906071631.23695-1-clin@suse.com> <CAAhSdy3dyw_VsmP_x9NoWKhpmen6zC5EhTjxPRPHS-OizYgL-Q@mail.gmail.com>
 <20190906091151.GA311@linux-8mug>
In-Reply-To: <20190906091151.GA311@linux-8mug>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 6 Sep 2019 15:49:27 +0530
Message-ID: <CAAhSdy0Z_wa12xFN23UK4XuweCPytMrXU-+Yr5ePVGwO+JkSzg@mail.gmail.com>
Subject: Re: [PATCH] riscv: save space on the magic number field of image header
To:     Chester Lin <clin@suse.com>
Cc:     "rick@andestech.com" <rick@andestech.com>,
        "merker@debian.org" <merker@debian.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Anup.Patel@wdc.com" <Anup.Patel@wdc.com>,
        "atish.patra@wdc.com" <atish.patra@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 6, 2019 at 2:46 PM Chester Lin <clin@suse.com> wrote:
>
> Hi Anup,
>
> On Fri, Sep 06, 2019 at 01:50:37PM +0530, Anup Patel wrote:
> > On Fri, Sep 6, 2019 at 12:50 PM Chester Lin <clin@suse.com> wrote:
> > >
> > > Change the symbol from "RISCV" to "RSCV" so the magic number can be 32-bit
> > > long, which is consistent with other architectures.
> > >
> > > Signed-off-by: Chester Lin <clin@suse.com>
> > > ---
> > >  arch/riscv/include/asm/image.h | 9 +++++----
> > >  arch/riscv/kernel/head.S       | 5 ++---
> > >  2 files changed, 7 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/arch/riscv/include/asm/image.h b/arch/riscv/include/asm/image.h
> > > index ef28e106f247..ec8bbfe86dde 100644
> > > --- a/arch/riscv/include/asm/image.h
> > > +++ b/arch/riscv/include/asm/image.h
> > > @@ -3,7 +3,8 @@
> > >  #ifndef __ASM_IMAGE_H
> > >  #define __ASM_IMAGE_H
> > >
> > > -#define RISCV_IMAGE_MAGIC      "RISCV"
> > > +#define RISCV_IMAGE_MAGIC      "RSCV"
> > > +
> > >
> > >  #define RISCV_IMAGE_FLAG_BE_SHIFT      0
> > >  #define RISCV_IMAGE_FLAG_BE_MASK       0x1
> > > @@ -39,9 +40,9 @@
> > >   * @version:           version
> > >   * @res1:              reserved
> > >   * @res2:              reserved
> > > - * @magic:             Magic number
> > >   * @res3:              reserved (will be used for additional RISC-V specific
> > >   *                     header)
> > > + * @magic:             Magic number
> > >   * @res4:              reserved (will be used for PE COFF offset)
> > >   *
> > >   * The intention is for this header format to be shared between multiple
> > > @@ -57,8 +58,8 @@ struct riscv_image_header {
> > >         u32 version;
> > >         u32 res1;
> > >         u64 res2;
> > > -       u64 magic;
> > > -       u32 res3;
> > > +       u64 res3;
> > > +       u32 magic;
> > >         u32 res4;
> > >  };
> > >  #endif /* __ASSEMBLY__ */
> > > diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> > > index 0f1ba17e476f..1f8fffbecf68 100644
> > > --- a/arch/riscv/kernel/head.S
> > > +++ b/arch/riscv/kernel/head.S
> > > @@ -39,9 +39,8 @@ ENTRY(_start)
> > >         .word RISCV_HEADER_VERSION
> > >         .word 0
> > >         .dword 0
> > > -       .asciz RISCV_IMAGE_MAGIC
> > > -       .word 0
> > > -       .balign 4
> > > +       .dword 0
> > > +       .ascii RISCV_IMAGE_MAGIC
> > >         .word 0
> > >
> > >  .global _start_kernel
> > > --
> > > 2.22.0
> > >
> >
> > This change is not at all backward compatible with
> > existing booti implementation in U-Boot.
> >
> > It changes:
> > 1. Magic offset
> > 2. Magic value itself
> >
>
> Thank you for the reminder. I have submitted a patch to U-Boot as well. Since
> my email post to the uboot mailing list is still under review by the list
> moderator, here I just list my code change of uboot:

I think you missed my point.

First of all, the space saving in image header is not of much use
because most of the required fields are already in-place. Only
res4 will become PE COFF offset when we add PE header.

To ensure that image header changes are backward compatible,
we cannot change magic location and value. Also, all changes
to image header should accompany with corresponding version
value change.

The Linux-5.3 merge window is already over. Now we will have
Linux-5.3 release with a image header different than proposed by
this patch. Let's say your patch is merged in Linux-5.4 then it will
not work with U-Boot-2019.07.

Further, if your U-Boot patch is merged in next release then
U-Boot-2019.10 onwards booti will fail for Linux-5.3.

After a long time, Linux-5.3 will be first golden release having all
required changes for SiFive Unleashed and it works perfectly
fine with U-Boot-2019.10 (or higher). Going forward we would
like to see that any Linux-5.3 (or higher) kernel always boots
with U-Boot-2019.10 (or higher) on SiFive Unleashed.

I don't approve this patch and your U-Boot patch as well.

Regards,
Anup

>
> diff --git a/arch/riscv/lib/image.c b/arch/riscv/lib/image.c
> index d063beb7df..e8a8cb7190 100644
> --- a/arch/riscv/lib/image.c
> +++ b/arch/riscv/lib/image.c
> @@ -14,8 +14,8 @@
>
>  DECLARE_GLOBAL_DATA_PTR;
>
> -/* ASCII version of "RISCV" defined in Linux kernel */
> -#define LINUX_RISCV_IMAGE_MAGIC 0x5643534952
> +/* ASCII version of "RSCV" defined in Linux kernel */
> +#define LINUX_RISCV_IMAGE_MAGIC 0x56435352
>
>  struct linux_image_h {
>         uint32_t        code0;          /* Executable code */
> @@ -25,8 +25,8 @@ struct linux_image_h {
>         uint64_t        res1;           /* reserved */
>         uint64_t        res2;           /* reserved */
>         uint64_t        res3;           /* reserved */
> -       uint64_t        magic;          /* Magic number */
> -       uint32_t        res4;           /* reserved */
> +       uint64_t        res4;           /* reserved */
> +       uint32_t        magic;          /* Magic number */
>         uint32_t        res5;           /* reserved */
>  };
>
>
> > We don't see this header changing much apart from
> > res1/res2 becoming flags in-future. The PE COFF header
> > will be append to this header in-future and it will have lot
> > more information.
> >
>
> I think a smaller magic field will let res4 have more room [32bit->64bit], which
> could offer more options for RISC-V's boot-flow development in the future. This
> change also synchronizes with arm64's image header.
>
> > Regards,
> > Anup
> >
