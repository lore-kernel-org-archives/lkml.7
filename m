Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833B9C072A4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58CE4216E3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="aN7TKzsw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730894AbfETIFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 04:05:38 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38249 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbfETIFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 04:05:36 -0400
Received: by mail-wm1-f67.google.com with SMTP id t5so10603428wmh.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 01:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N5i7/XDpfm3fWH4Ml9uuxM88EMAgEyCkLNLDzAUDSZ0=;
        b=aN7TKzswvueSwWlYr5KtwQEUDm4FwOzq19jE5z3pv8sUvOak2w8NcLvYczOR7mVdEC
         P2S3uIzCkjtQ2aotwBcpbuqNF8Cw3Da3lTLAWb0zExra8L3o2umg7W9woO6Xc55C0ZcB
         dQoN0Lb5efbJMs5Qne9S1n6yybhaXFZy5FvGFUeQ0PUlIm27zEYRMTTFWxf8hhSnqryF
         9ceGvzS6/zQ0OevUJKDf/3nlg4O9TkUuEl4tQukvHwYnP5ncA78N8Ci4Z+1kJdbTYECf
         8C5g//rspnOOH0eaE9czErhjwXHfKaf1FO3A6PMEj4quNFYDKeK9rEge9cGMmzlLLtBE
         +8tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N5i7/XDpfm3fWH4Ml9uuxM88EMAgEyCkLNLDzAUDSZ0=;
        b=Q3RYsQWciPlNoHMlclOGEpMk81jj5S3/Mzg+NSbCLrqTyXQROjV4NGIV5sBhcWRYsz
         aCuEynS+0IZu954WR4aV6FxatxpYl9/xubWYG5ZpXrlTffMdVxcC8Feq5ocW037R2RcB
         7r7cJp4B/NOvKBwHnj+zlNt2TPUeBYPkVtoREWfy8FZkeVuE9/ME42cvypnCXrWVerGA
         +45OnKBZ3+bdQgQ/2c4Dqrd4QrS5GH6ELq4x+Zx9K1B/XcdM6pcQSKHxzB1AkZ3kmd6j
         /O6pdZk73MLlT6lZi+/RBfZhkgmVaku+IdAqkJ/mqwrlkXzvNMtnmbdZi4mB1wJgLEzg
         wiFQ==
X-Gm-Message-State: APjAAAWyIcZRe/ZiF3Z38ShLgX8pylXJ1LFGZwPKGV/16HYKGBged/Rd
        1ZCDGXMGcXE3onRbKFFHH8yCOYL0EyyLW2swqGstoA==
X-Google-Smtp-Source: APXvYqz/x+wplnWtWRAm2caTMk28mJLp0zciA4G0yf9XqQh45uE9rk6iwDlg1+yyxEcWuqSPKpaVVr0N3xBRPIdMPI4=
X-Received: by 2002:a7b:ce10:: with SMTP id m16mr1909247wmc.10.1558339533772;
 Mon, 20 May 2019 01:05:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190515063004.3466-1-anup.patel@wdc.com>
In-Reply-To: <20190515063004.3466-1-anup.patel@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 20 May 2019 13:35:22 +0530
Message-ID: <CAAhSdy3GqjS06QxCtY6OUkBZds4gygQsAkaoaa+sMj3z6qgUBQ@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: defconfig: Enable NO_HZ_IDLE and HIGH_RES_TIMERS
To:     Anup Patel <Anup.Patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 12:00 PM Anup Patel <Anup.Patel@wdc.com> wrote:
>
> This patch enables NO_HZ_IDLE (idle dynamic ticks) and HIGH_RES_TIMERS
> (hrtimers) in RV32 and RV64 defconfigs.
>
> Both of the above options are enabled by default for architectures
> such as x86, ARM, and ARM64.
>
> The idle dynamic ticks helps use save power by stopping timer ticks
> when the system is idle whereas hrtimers is a much improved timer
> subsystem compared to the old "timer wheel" based system.
>
> This patch is tested on SiFive Unleashed board and QEMU Virt machine.
>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
>  arch/riscv/configs/defconfig      | 2 ++
>  arch/riscv/configs/rv32_defconfig | 2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index 2fd3461e50ab..f254c352ec57 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -1,5 +1,7 @@
>  CONFIG_SYSVIPC=y
>  CONFIG_POSIX_MQUEUE=y
> +CONFIG_NO_HZ_IDLE=y
> +CONFIG_HIGH_RES_TIMERS=y
>  CONFIG_IKCONFIG=y
>  CONFIG_IKCONFIG_PROC=y
>  CONFIG_CGROUPS=y
> diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv32_defconfig
> index 1a911ed8e772..d5449ef805a3 100644
> --- a/arch/riscv/configs/rv32_defconfig
> +++ b/arch/riscv/configs/rv32_defconfig
> @@ -1,5 +1,7 @@
>  CONFIG_SYSVIPC=y
>  CONFIG_POSIX_MQUEUE=y
> +CONFIG_NO_HZ_IDLE=y
> +CONFIG_HIGH_RES_TIMERS=y
>  CONFIG_IKCONFIG=y
>  CONFIG_IKCONFIG_PROC=y
>  CONFIG_CGROUPS=y
> --
> 2.17.1
>

Hi All,

Any comments on this one?

@Palmer, It would be nice to have this in Linux-5.2

Regards,
Anup
