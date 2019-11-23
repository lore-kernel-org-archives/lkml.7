Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11819C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 04:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0D592071B
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 04:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="j36DMn6k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfKWERi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 23:17:38 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33775 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbfKWERi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 23:17:38 -0500
Received: by mail-wr1-f67.google.com with SMTP id w9so11088799wrr.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 20:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gDRBUuKpP+wNpMW5KqaT4gpqA2dKp4hcDwnNDbud2dM=;
        b=j36DMn6kPFHZgWoHUJ2Rtfbs80kPgyE4ukl7Z/tbaY0QZ9OtKNFycqz0fMZu55AkcF
         /D39gAcldhgjmxqVTgHqlSCNKR/xNQVlXcllgqGCLopuykgzrP5j6Dzhszz3WB6nQV5q
         cPMJG4T/ogSHoFj/Ug5dN3sFRqVQ90+niNkW5ewg9du9jKqHJ+tfodeylsuVeOPmtlrf
         8c6JqBSLh+wkywN6TxmX2L3KeapdAALQyrMkHXFQEE4EfcPGlgZN8DMFH3UT+ezdgywN
         Vr7rx8bMYQm9VEnFP22kc2BPOMA3bdcs9EclDuZ2UI9UW2hfuNrtlmWYeAVk5ATiA0aU
         xC7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gDRBUuKpP+wNpMW5KqaT4gpqA2dKp4hcDwnNDbud2dM=;
        b=IKCaPRz8/fhBeKp2txlVTZ66bLfjoq+ZiWEEcuMlQjNfZz76g85E/D7lz9grvokFWa
         Fz0Qu8gs4sh2C6x33fvm/4DJM7eexkiFbkZSgpXCVD5Mzw1atyyjicjZV1osUJycz8DS
         09JvDv5bzwrFzw5gne/7+myF6nS9EfN0owU5yiETf3f5dsvZBiqKMZceLLELDulaATfQ
         9Q33VuyBaPugpwmgb7r7HNPEeGKrR4lQewZ3hVwehmxadXnfgb6CgwiMNahznCxaSBrI
         KsvVaWmd0WpnDa9uT+HjA+NA+U4ZyxpTYsnjuUVauA8LzJTZTCcMOdR8EHNAPjdkrZC3
         P85A==
X-Gm-Message-State: APjAAAVSK1g/fx1DEUuPgw9yI9PEt1/42NSiA6A1Sp9RgcO9xtrtBmRT
        fIuBnrHuhoWV/V/e2hNoSx3sftJ53/plLn6RDwvdXfdJ
X-Google-Smtp-Source: APXvYqyn42ZgGo1p04GcxW1ERelAYu47RWFLPCm36JIsphxBjAF4K6sOatZ6aHZVBoF74GoN9tXlaCnqSBdzZ1hZZwQ=
X-Received: by 2002:a5d:6181:: with SMTP id j1mr20153851wru.251.1574482656172;
 Fri, 22 Nov 2019 20:17:36 -0800 (PST)
MIME-Version: 1.0
References: <20191122225659.21876-1-paul.walmsley@sifive.com> <20191122225659.21876-2-paul.walmsley@sifive.com>
In-Reply-To: <20191122225659.21876-2-paul.walmsley@sifive.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Sat, 23 Nov 2019 09:47:26 +0530
Message-ID: <CAAhSdy3voiLFRVmn-=h9Ltn7=10_FJUGxub063oMuS4znuK+3Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] riscv: defconfigs: enable debugfs
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 23, 2019 at 4:27 AM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>
> debugfs is broadly useful, so enable it in the RISC-V defconfigs.
>
> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> ---
>  arch/riscv/configs/defconfig      | 1 +
>  arch/riscv/configs/rv32_defconfig | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index 420a0dbef386..f0710d8f50cc 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -100,4 +100,5 @@ CONFIG_9P_FS=y
>  CONFIG_CRYPTO_USER_API_HASH=y
>  CONFIG_CRYPTO_DEV_VIRTIO=y
>  CONFIG_PRINTK_TIME=y
> +CONFIG_DEBUG_FS=y
>  # CONFIG_RCU_TRACE is not set
> diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv32_defconfig
> index 87ee6e62b64b..bdec58e6c5f7 100644
> --- a/arch/riscv/configs/rv32_defconfig
> +++ b/arch/riscv/configs/rv32_defconfig
> @@ -97,4 +97,5 @@ CONFIG_9P_FS=y
>  CONFIG_CRYPTO_USER_API_HASH=y
>  CONFIG_CRYPTO_DEV_VIRTIO=y
>  CONFIG_PRINTK_TIME=y
> +CONFIG_DEBUG_FS=y
>  # CONFIG_RCU_TRACE is not set
> --
> 2.24.0.rc0
>

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
