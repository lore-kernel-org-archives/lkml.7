Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AFE7C3A5A2
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 03:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EB622077B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 03:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="ngpixdUR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbfIDDjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 23:39:47 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34799 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727722AbfIDDjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 23:39:46 -0400
Received: by mail-wm1-f66.google.com with SMTP id y135so1450720wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 20:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uUvXGKEZoPRwA5Ik3P0dfSDGF8yBJbth8FfpGl8EDP0=;
        b=ngpixdURTCml3W6w0yzV+Rhsvzl0vFP543h/AkMi8pPMOLdXtCsQTfEwUiVSRqLpRg
         ViZIIhvOQe63f80RVhqDlhTCOS3wgE0Oj72X6WYKRSGftAJId8eGdpC6JBAKqm6ZLzCD
         Jj5SSs253BgqPYfMkuxmf1VjvQ2rd9U/vSDHlydFTB6yuR2I594+Eo4/i0zzBp2UoCZZ
         rbcwTM5L1QGThHgSeH9qkLb0dZEWpTP44GQoSJqC12163YLExtnNU8N2Sc5q705qDtDg
         UyanhjDBc42fGoI41lIhgF5jl+jyx3jVe45w6t/zzRw0dH4XAHsJaQVvqtp7d3gw59zs
         DQoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uUvXGKEZoPRwA5Ik3P0dfSDGF8yBJbth8FfpGl8EDP0=;
        b=fwWLgPRJ1bt5bmCZoYO1nmH2QaN6qTgmg9SdMDpw+ale4eZDN0Y9TxNF1txbYhg11r
         dfLupKzSh9D+x0/wlC0p2j0o+p/h2LTNDh/e5vIBJKgxCMQjDccA/sGRMYYCaNXasPVE
         hNeCxxNPsIyNv2RlBqRpFUtvlVaEjXptmQuWYZ2mL4iqkIwJgd4/FxJzZht6WWrNY0x1
         Nb49yGmOCidYzu3yG5ZM03XoqTxW+oCcumCyIss33Swwnlwmz3DO/p88btH/boo/Z7o8
         klSMsTJzn39dMcn0D93RzIt1pMSsnjOCKr9VXZffrh1k+z9YiXcRMw1RITOf5kElL+5O
         wJaA==
X-Gm-Message-State: APjAAAWVbYtKjuAYJOqn24gVZU9npXJuwADIzKTh8i6EIMIyWeLKQqa0
        yRQ9uXI4UMlztwanRXOvwIRZUWOYAj2BenLcwinLGw==
X-Google-Smtp-Source: APXvYqz0n5ioObrdz8U18x0DJ5xS+gtleSKoC8A+H7ZQqzLl9D+NvFGtDBCQUuUQr+XBDPAJjSBLpSXEFqdf7CWjOEA=
X-Received: by 2002:a1c:a697:: with SMTP id p145mr2227587wme.24.1567568384117;
 Tue, 03 Sep 2019 20:39:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190829135427.47808-1-anup.patel@wdc.com> <20190829135427.47808-22-anup.patel@wdc.com>
In-Reply-To: <20190829135427.47808-22-anup.patel@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 4 Sep 2019 09:09:32 +0530
Message-ID: <CAAhSdy3bywQhOdt4ymNwHh=VAH8D0-qK_PRy+J0s1rTe=+d=mg@mail.gmail.com>
Subject: Re: [PATCH v6 21/21] RISC-V: KVM: Add MAINTAINERS entry
To:     Anup Patel <Anup.Patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim K <rkrcmar@redhat.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
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

On Thu, Aug 29, 2019 at 7:27 PM Anup Patel <Anup.Patel@wdc.com> wrote:
>
> Add myself as maintainer for KVM RISC-V as Atish as designated reviewer.
>
> For time being, we use my GitHub repo as KVM RISC-V gitrepo. We will
> update this once we have common KVM RISC-V gitrepo under kernel.org.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> Reviewed-by: Alexander Graf <graf@amazon.com>
> ---
>  MAINTAINERS | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9cbcf167bdd0..b4952516fc32 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8869,6 +8869,16 @@ F:       arch/powerpc/include/asm/kvm*
>  F:     arch/powerpc/kvm/
>  F:     arch/powerpc/kernel/kvm*
>
> +KERNEL VIRTUAL MACHINE FOR RISC-V (KVM/riscv)
> +M:     Anup Patel <anup.patel@wdc.com>
> +R:     Atish Patra <atish.patra@wdc.com>
> +L:     kvm@vger.kernel.org
> +T:     git git://github.com/avpatel/linux.git

We have created a shared tree (between Me and Atish) at:
git://github.com/kvm-riscv/linux.git

I will use this new repo as KVM RISC-V tree in v7 patches.

Regards,
Anup

> +S:     Maintained
> +F:     arch/riscv/include/uapi/asm/kvm*
> +F:     arch/riscv/include/asm/kvm*
> +F:     arch/riscv/kvm/
> +
>  KERNEL VIRTUAL MACHINE for s390 (KVM/s390)
>  M:     Christian Borntraeger <borntraeger@de.ibm.com>
>  M:     Janosch Frank <frankja@linux.ibm.com>
> --
> 2.17.1
>
