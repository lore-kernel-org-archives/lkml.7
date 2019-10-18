Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC9B8CA9ECB
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD5192067B
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="bP0txo6K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504112AbfJRFc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 01:32:28 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56100 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727399AbfJRFc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 01:32:28 -0400
Received: by mail-wm1-f67.google.com with SMTP id a6so4722677wma.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 22:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vu77sOEgLk4hgL40syTM0FGRnGNgVOWc5ZddD0STylA=;
        b=bP0txo6KUPJhsbrp1evgxikGXpmxRRBsxwvXOfWxyVwVHrFi0N9AwXrkV6GrFpjuSt
         eHZUlVJCzEA8AsKXn3x83pefq7YQbAxz0wSDuYpwSHC+jdEqQ/y0ed9swRJ9apvco+tq
         Rzm7V8XTWzw76Z8tw928+Z9IX7g4kgXf+TZwssgC/DWmDAyAqLmF1K+2MD1mRT3QQL/1
         FtS1rxZdEZ2XzLXpVG7TKzavLCTpRteUY9RIAS/0aiA/Ye8s0Nh1LyrTbuWbqD8yxRTy
         YQD8EozMsKueRf+2SiUX0iDzl8BybGbCB9nQUG4/xNdxXMIOHWrW2Bsqsi3HHeMhVt1P
         0nyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vu77sOEgLk4hgL40syTM0FGRnGNgVOWc5ZddD0STylA=;
        b=G75Y8FtKmmtKUyDA4joCupGUlT9mA0GEyhsKfOyvbEy1HjIrRtQIWVSaUuhTYHkp7R
         EcmP6TUKMS1V5zAVDoBpt3tlpccH4xTqLUSir5gOEKd824J98I+7ytNOLh9uyv2XFShM
         KpS78uNoP0wmSfMIwmULdYZt6GITr5zzr2TeO5IMNEK9syrMo5x6ZXuXWD9XfqFz6sS0
         bpUll4R+niz0uW6poP+Cbq9EPl1NXrjekWLAodrDT1WW1JVneESfvrfQ9eq1UAUIZql1
         XsDgt62L5vRwPuk+vyuwClf6mdsur8dL+4ZDQaG/Vksy+rC/dFqjxXcbBkyO9HwEGSMt
         3iCQ==
X-Gm-Message-State: APjAAAW4vj+72XBLYIY/ho7iFjDPXALz9BQrZ1e6fOY1FVokXRV4d5Ic
        O+D/2aHeC/1AvJms3j7h04gv6CRT7ZbxJCxJBHc8niJkzHU=
X-Google-Smtp-Source: APXvYqxwpSMBKy0XeXO7zYB3T/WGjdM1/WkV95Bytp+CJYFA/TJLm9WLD6aXl22dULfFoj56AIwQkhQ22smUpGrLZvA=
X-Received: by 2002:a05:600c:2291:: with SMTP id 17mr5045041wmf.171.1571367692099;
 Thu, 17 Oct 2019 20:01:32 -0700 (PDT)
MIME-Version: 1.0
References: <20191017173743.5430-1-hch@lst.de> <20191017173743.5430-12-hch@lst.de>
In-Reply-To: <20191017173743.5430-12-hch@lst.de>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 18 Oct 2019 08:31:21 +0530
Message-ID: <CAAhSdy2R4iJ6XYytTcvt005HS4bv1Sy-3VfHZaC5QxA6S=fzsQ@mail.gmail.com>
Subject: Re: [PATCH 11/15] riscv: use the correct interrupt levels for M-mode
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
> The numerical levels for External/Timer/Software interrupts differ
> between S-mode and M-mode.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/riscv/kernel/irq.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c
> index 804ff70bb853..dbd1fd7c22e4 100644
> --- a/arch/riscv/kernel/irq.c
> +++ b/arch/riscv/kernel/irq.c
> @@ -14,9 +14,15 @@
>  /*
>   * Possible interrupt causes:
>   */
> -#define INTERRUPT_CAUSE_SOFTWARE       IRQ_S_SOFT
> -#define INTERRUPT_CAUSE_TIMER          IRQ_S_TIMER
> -#define INTERRUPT_CAUSE_EXTERNAL       IRQ_S_EXT
> +#ifdef CONFIG_RISCV_M_MODE
> +# define INTERRUPT_CAUSE_SOFTWARE      IRQ_M_SOFT
> +# define INTERRUPT_CAUSE_TIMER         IRQ_M_TIMER
> +# define INTERRUPT_CAUSE_EXTERNAL      IRQ_M_EXT
> +#else
> +# define INTERRUPT_CAUSE_SOFTWARE      IRQ_S_SOFT
> +# define INTERRUPT_CAUSE_TIMER         IRQ_S_TIMER
> +# define INTERRUPT_CAUSE_EXTERNAL      IRQ_S_EXT
> +#endif /* CONFIG_RISCV_M_MODE */
>
>  int arch_show_interrupts(struct seq_file *p, int prec)
>  {
> --
> 2.20.1
>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
