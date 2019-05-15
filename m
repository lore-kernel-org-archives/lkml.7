Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A983FC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 13:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81B952070D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 13:38:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbfEONiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 09:38:10 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:32768 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbfEONiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 09:38:10 -0400
Received: by mail-oi1-f196.google.com with SMTP id m204so1856264oib.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 06:38:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pAA+Nt/HZhHjbsP0fXWoqjBm7blz6engXy9d/4XTJ0c=;
        b=uBOutVABHDW5MVWopumn/1kf5KW8VOCKhdZUr6fE0jV4BeVCoNxbz35mLvCcq/3vgv
         9rTNXZr61Y6YFOOK60pPFB7bbFyZ6rzuAI2cG+HHLge6eKTcxtaqIVJWmXR9bpMYV1ZD
         vq+OtR/79sPR3Vq8eixKRVrVMXUJ1/wfPx36N1WREevCKTU9E1HVaqz6ZCGi2BCJFYYY
         z/R9jTYCBH74KiNDIrUIJIkwCf6+0P4McvO0gGiARShf2jZpMHJyWx9XNqFHE8lwZODp
         W0R3GZZrL4V33GYjhabGm6ixmuSaSHotaD2CZI2k71J4CpJubG4TlZwXg1cBqasYbxm0
         OmQg==
X-Gm-Message-State: APjAAAVcVGuZRGCn/0SL3K/CarurhonSUD8RJkxHFuqR/CdqgcqI2/kD
        R9hmfOhupjPGNLwkMHUIlltWFvqheTj2MByPBaU=
X-Google-Smtp-Source: APXvYqwCEdN7GTQNIX94hSRLtxI8aePnG+JjdeXJgZzJjL5ZYSCn1KBJ/I+jHCLAJHDM+QWD8XDRgnl13GgYNfyv/tM=
X-Received: by 2002:aca:cd85:: with SMTP id d127mr7034417oig.96.1557927489291;
 Wed, 15 May 2019 06:38:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190515120942.3812-1-malat@debian.org> <20190515131441.GA3072@infradead.org>
In-Reply-To: <20190515131441.GA3072@infradead.org>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Wed, 15 May 2019 15:37:57 +0200
Message-ID: <CA+7wUswMoeFdCBqnvMV6ZEbZShY2w23P5CMPktVavwYNL87_wQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc: silence a -Wcast-function-type warning in dawr_write_file_bool
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Michael Neuling <mikey@neuling.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Wed, May 15, 2019 at 3:14 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Wed, May 15, 2019 at 02:09:42PM +0200, Mathieu Malaterre wrote:
> > In commit c1fe190c0672 ("powerpc: Add force enable of DAWR on P9
> > option") the following piece of code was added:
> >
> >    smp_call_function((smp_call_func_t)set_dawr, &null_brk, 0);
> >
> > Since GCC 8 this trigger the following warning about incompatible
> > function types:
>
> And the warning is there for a reason, and should not be hidden
> behind a cast.  This should instead be fixed by something like this:

<meme: I have no idea what I am doing>
OK, thanks for the quick feedback, will send a v2 asap.

> diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
> index da307dd93ee3..a26b67a1be83 100644
> --- a/arch/powerpc/kernel/hw_breakpoint.c
> +++ b/arch/powerpc/kernel/hw_breakpoint.c
> @@ -384,6 +384,12 @@ void hw_breakpoint_pmu_read(struct perf_event *bp)
>  bool dawr_force_enable;
>  EXPORT_SYMBOL_GPL(dawr_force_enable);
>
> +
> +static void set_dawr_cb(void *info)
> +{
> +       set_dawr(info);
> +}
> +
>  static ssize_t dawr_write_file_bool(struct file *file,
>                                     const char __user *user_buf,
>                                     size_t count, loff_t *ppos)
> @@ -403,7 +409,7 @@ static ssize_t dawr_write_file_bool(struct file *file,
>
>         /* If we are clearing, make sure all CPUs have the DAWR cleared */
>         if (!dawr_force_enable)
> -               smp_call_function((smp_call_func_t)set_dawr, &null_brk, 0);
> +               smp_call_function(set_dawr_cb, &null_brk, 0);
>
>         return rc;
>  }
