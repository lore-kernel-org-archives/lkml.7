Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE02CA9ED0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 04:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC181222C3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 04:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="FZdI3WTN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441937AbfJREyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 00:54:52 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41098 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfJREyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 00:54:50 -0400
Received: by mail-wr1-f65.google.com with SMTP id p4so4671372wrm.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 21:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uXjggwOtvkgB5eV9xeSX/TZ7+sMFrMeqr0FsgRhuxC4=;
        b=FZdI3WTN1JpyxqNX9qKx6j7oKXltRzF7eu/3fsDtV8Q0rGY4p2sdyPkZvg52PdRhwp
         nOoYqpsDZfw3KHrEriiEWxtKLQ6SAUYGa6kYI1tATZYEZ3hzOI+WXtHP/CB6zd4WJ4HJ
         vRn/kGXuABtsrVg5ZXxWTNy8obNRd/iww/MvIFMVnAo28n8lJYxKzDp4+zmyCzmMuQP+
         pWWUt9GgpqDmlfHogG+D/XPyA+AEbgQh7P9KowsPlgMvgSZrT7iy+SVkpM7GH88OlEIj
         tZ4JvzKrilqUg90OKGtRaw4POhDnWkV54zEIa2urVGdcGWwhmxLNz6vEE7E4qZ8nGCnF
         ZTIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uXjggwOtvkgB5eV9xeSX/TZ7+sMFrMeqr0FsgRhuxC4=;
        b=LyVi1dNIt3FCa8TZ38uQy+RUGqDKiT5zbdzphnyTKnwtX9lqlP9LD/TP75FkqKEogC
         qyJlb/VzQMRmoowPrr/1OISAtVPEyfqclvrvYVpZ3UhxHERN9oTpkmIwWqJkU/ZqCXPI
         DQtK9eoRocNrRZ83zI2EmVrDHBQV6yPLtAsjZJ9vHTwV3YDuQ67CicIDRLJziXjstoUF
         KpDQxFPn04pV7bNRDhAcnJgOpx068nnjnlNjs0dfDVZcXQGidk04m1vACcdffqwLRhxg
         2yWdJa4Z1zm5Tpu4g9J1BwqBF6JQE4LBvlGC3hXkSG1pg+2wWPSprc4MztGmxluzJjWC
         iqoQ==
X-Gm-Message-State: APjAAAX9O6IbuiTwbritD57BM/EAcICW2DS/JGdzSLP6dYfMXMu1z1sU
        r44C671gP5FO5i3s6ZgBYUZmoaFYcJHKEatH6rsMMLMtuGY=
X-Google-Smtp-Source: APXvYqyGZBSBmdnpbSyKqAjMKY3orVEVODID0lIDRyhOu7Qpdrc2lXpNSEbak9okkymWeGoHNgl/Tw/6sWy5rzTlR0w=
X-Received: by 2002:adf:f145:: with SMTP id y5mr5433738wro.330.1571368024826;
 Thu, 17 Oct 2019 20:07:04 -0700 (PDT)
MIME-Version: 1.0
References: <20191017173743.5430-1-hch@lst.de> <20191017173743.5430-16-hch@lst.de>
In-Reply-To: <20191017173743.5430-16-hch@lst.de>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 18 Oct 2019 08:36:54 +0530
Message-ID: <CAAhSdy2=WnkJV8ANW2v5s2ckDmTEZUuzegQm41-ZaEY==f1Jng@mail.gmail.com>
Subject: Re: [PATCH 15/15] riscv: disable the EFI PECOFF header for M-mode
To:     Christoph Hellwig <hch@lst.de>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 11:08 PM Christoph Hellwig <hch@lst.de> wrote:
>
> No point in bloating the kernel image with a bootloader header if
> we run bare metal.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/riscv/kernel/head.S | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> index 71efbba25ed5..dc21e409cc49 100644
> --- a/arch/riscv/kernel/head.S
> +++ b/arch/riscv/kernel/head.S
> @@ -16,6 +16,7 @@
>
>  __INIT
>  ENTRY(_start)
> +#ifndef CONFIG_RISCV_M_MODE
>         /*
>          * Image header expected by Linux boot-loaders. The image header data
>          * structure is described in asm/image.h.
> @@ -47,6 +48,7 @@ ENTRY(_start)
>
>  .global _start_kernel
>  _start_kernel:
> +#endif /* CONFIG_RISCV_M_MODE */
>         /* Mask all interrupts */
>         csrw CSR_XIE, zero
>         csrw CSR_XIP, zero
> --
> 2.20.1
>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
