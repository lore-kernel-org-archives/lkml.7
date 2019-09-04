Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E691C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8B072053B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="Ncsm1Yid"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387565AbfIDQR4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 12:17:56 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33590 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732580AbfIDQRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 12:17:53 -0400
Received: by mail-wm1-f66.google.com with SMTP id r17so2906501wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 09:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rtzMO9oNYcqZ7xJCU1SqvD7PjblQqbDV29Zyklt+ON0=;
        b=Ncsm1Yid1oE4dNBUtEf93AxZ82UtQoJXxFdx0JoIxtdJEmRAih94AH5ZwIg0s+WCim
         AwYZNcE2ZXCEwyjlpNBFvd4eWLy16pliyRkGzd8PNAwAYTrAFCsTSd4oR+h1O5QNnMQW
         kGJPudKVYmlPaqsgdMx26QCxk9FkD6ft+jCl3F/yHrpccmJzCYpWz1oD2Vxhih6imE3M
         /b3Pu4IZDf3U8jGi3dM3ShEAaISjTKjmJHBIATpOUpkQE1bYfhdAOI8eURLyug8cj1q5
         2OT2bCy7l9JwDwuo/2v2svut0t96JXYsa7UZXE1mr1Imahm0LRqbw997Y6zCI3Yplb2A
         TAAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rtzMO9oNYcqZ7xJCU1SqvD7PjblQqbDV29Zyklt+ON0=;
        b=WO+cK7iah2BfB533TfuNoj+rbe+62Ti3/QBUPgDSX82GOdyY9JYj7bN4UxFNn5mLns
         zivbmGLvuq1Z/GorcbiCpP+rrbivmM9+f8xGPmymqFNSDbmVGj3gfxq5rSUpTvlFUOjJ
         zqJS7hvVM1KrDKu1+IXshojdWgU+vfTFiOXptIpxt3O5OlWdqNlAQUniJj/cxe+O85M+
         qSNVdFmMaWPW+zQ5insP0JtXoXrSv5xVVpExp9fDPBr5a37aGYML9vvvQCbpVcV5kQ1Y
         cQUEDoHGagv5DwtTGqlRIhmLutpRyAMeYmfmL9WsXf+UC8fPftMA3mUyqWWndKQLe4hx
         4HmA==
X-Gm-Message-State: APjAAAUJCI1iRsJfdymL6UBjACT8S+mt+Bt2ctzZzOvjA56mTrjV9rOi
        2SUTiIzkP995Xd8xC7fvfpx0QlFHZ9L9ouxeGX4dSQ==
X-Google-Smtp-Source: APXvYqzX6gugStutxIYe+ILprg2riVCAyjyyZH0V55aDRXJiZFZxndYKFUqntyVHZGA5c108ncLvJ8fFq0NR4omyyd4=
X-Received: by 2002:a1c:c909:: with SMTP id f9mr5262027wmb.52.1567613871859;
 Wed, 04 Sep 2019 09:17:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190904161245.111924-1-anup.patel@wdc.com> <20190904161245.111924-3-anup.patel@wdc.com>
In-Reply-To: <20190904161245.111924-3-anup.patel@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 4 Sep 2019 21:47:40 +0530
Message-ID: <CAAhSdy3G9NOuNRhiYUgxmvNBfs79gAgSWdBrw4s=+SZBEDhVfg@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Enable KVM for RV64 and RV32
To:     Anup Patel <Anup.Patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim K <rkrcmar@redhat.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Graf <graf@amazon.com>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 4, 2019 at 9:43 PM Anup Patel <Anup.Patel@wdc.com> wrote:
>
> DO NOT UPSTREAM !!!!!
>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
>  arch/riscv/configs/defconfig      | 2 ++
>  arch/riscv/configs/rv32_defconfig | 2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index 420a0dbef386..320a7f1da4fc 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -16,6 +16,8 @@ CONFIG_EXPERT=y
>  CONFIG_BPF_SYSCALL=y
>  CONFIG_SOC_SIFIVE=y
>  CONFIG_SMP=y
> +CONFIG_VIRTUALIZATION=y
> +CONFIG_KVM=y
>  CONFIG_MODULES=y
>  CONFIG_MODULE_UNLOAD=y
>  CONFIG_NET=y
> diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv32_defconfig
> index 87ee6e62b64b..6223e47cc5f0 100644
> --- a/arch/riscv/configs/rv32_defconfig
> +++ b/arch/riscv/configs/rv32_defconfig
> @@ -16,6 +16,8 @@ CONFIG_EXPERT=y
>  CONFIG_BPF_SYSCALL=y
>  CONFIG_ARCH_RV32I=y
>  CONFIG_SMP=y
> +CONFIG_VIRTUALIZATION=y
> +CONFIG_KVM=y
>  CONFIG_MODULES=y
>  CONFIG_MODULE_UNLOAD=y
>  CONFIG_NET=y
> --
> 2.17.1
>

Please ignore this patch.

The KVM RISC-V should be disabled by default since it's
experimental currently.

Regards,
Anup
