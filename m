Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7687C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 11:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A675F207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 11:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="uiHGsBGP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbfLQLnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 06:43:50 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36384 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbfLQLnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 06:43:49 -0500
Received: by mail-wm1-f68.google.com with SMTP id p17so2787106wma.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 03:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X/S+8zEUBS7YPWXh0mAqGVkUFdobNHA//t57aWOlO+4=;
        b=uiHGsBGPY4Zn8I5fXuBLbY+pNHLuauUCd09bD4LQS3nnDHbm25XUp7gCaqTjdf4u9I
         l1rU/BmE4qvIQ+mFxd4OIHc/OnEy5NSfcLDbrGGcGOzK8VH1OlBcCovlvZwP08FPCiwE
         YK2rqumlhVXbX6kn+M/85Gy/j3cTkI43avbbWeq5vS45ImCN3DCBIdLFSqBe+4yMYdt1
         4TF1v3ejSh5qjtAVlI//sw72d+aLLDEQH53ldEDTiycoLvJW2Lq9e2gDuHF184+xBpZX
         xZ7+g/oa8DbSiaAUFiLcWFejHJ/w4mDd+cAT+1SCfvXgeUrDMFtrP3t3OZ6oQ1oF2sYI
         /zaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X/S+8zEUBS7YPWXh0mAqGVkUFdobNHA//t57aWOlO+4=;
        b=fcKi/TKVz6bqTVv2Mp513Q3UNbp12ul2xdaZa0LEuSCA1iydtp/K5nCMcUnGkGKmbB
         3SxCGEfa4/xtGfRaWyb3pPkE4Ce+RZGyxh1wcI+8fmGDV/f/fex+ki9SZ6Tla+ttahF8
         s/itFDEgWmsPOCdvLdTGXWKg8KMt6RE3StRGfASXba3JfliDbFIe7IoSC2kLRAobB380
         61bRM4G2GoZ/MAc3/vMr0bMmsGVb+l9LwGG8AxGvjUazQdCrXY/bKFjXSn8B/m8lTi6i
         +9Empm/sMizRe7mQrpbXbAxZ207YRic7/LMHTYAZJY9tQyM4DRYEEG04aBVL+y4z6d1/
         Crfw==
X-Gm-Message-State: APjAAAXBspR5xHG8mtCK1DP6MpsFaV9ErLt8SNO+b1ecHKYYhN6dsehP
        sBgEiuC/egFfYX/WF5/tkVt35RTwzL6fI4WaG8OdSw==
X-Google-Smtp-Source: APXvYqznkISjUcXtLp+VkfjA6pxHi4B1lny+rN+Akp/yO+kT7twW3hkaC0kEiE9XwLmGt3T5jChCJ0NAh9DVMIZAEd4=
X-Received: by 2002:a7b:c5d8:: with SMTP id n24mr4897335wmk.124.1576583027108;
 Tue, 17 Dec 2019 03:43:47 -0800 (PST)
MIME-Version: 1.0
References: <20191217040704.91995-1-olof@lixom.net>
In-Reply-To: <20191217040704.91995-1-olof@lixom.net>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 17 Dec 2019 17:13:35 +0530
Message-ID: <CAAhSdy03Y7Xj5K-c2-ubBxb2Z=UXnifCSPaUDpAiLewMo6s43w@mail.gmail.com>
Subject: Re: [PATCH] riscv: export flush_icache_all to modules
To:     Olof Johansson <olof@lixom.net>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 9:37 AM Olof Johansson <olof@lixom.net> wrote:
>
> This is needed by LKDTM (crash dump test module), it calls
> flush_icache_range(), which on RISC-V turns into flush_icache_all(). On
> other architectures, the actual implementation is exported, so follow
> that precedence and export it here too.
>
> Fixes build of CONFIG_LKDTM that fails with:
> ERROR: "flush_icache_all" [drivers/misc/lkdtm/lkdtm.ko] undefined!
>
> Signed-off-by: Olof Johansson <olof@lixom.net>
> ---
>  arch/riscv/mm/cacheflush.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
> index 8f19006866405..8930ab7278e6d 100644
> --- a/arch/riscv/mm/cacheflush.c
> +++ b/arch/riscv/mm/cacheflush.c
> @@ -22,6 +22,7 @@ void flush_icache_all(void)
>         else
>                 on_each_cpu(ipi_remote_fence_i, NULL, 1);
>  }
> +EXPORT_SYMBOL(flush_icache_all);
>
>  /*
>   * Performs an icache flush for the given MM context.  RISC-V has no direct
> --
> 2.11.0
>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
