Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57FDC00523
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 03:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE0E12075A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 03:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="coiwODIR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgAHDgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 22:36:53 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43972 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgAHDgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 22:36:52 -0500
Received: by mail-wr1-f67.google.com with SMTP id d16so1786073wre.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 19:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ySbkX+4r5a6zzWgSuzqB+vjv/GamaAVWkn0vznIPTa4=;
        b=coiwODIRqSIDkJCbI5ezwrW7yd5BZTJJju0W/SVfgKIapZG5FEoUrpHuV89f9c8UVL
         vzjVJCnAa4hhXxBnHmvVUsgyk9NxiTdBpuJykKNSNawkAa1WbF9a7XlUSziREksjZnDv
         PHcnwBktmROK/gtIkV8Rw9FgkNXn6GnwwJ3b3M+4HHlOS/5ZZI0tZK1eCXLD0TSWt2vX
         7xSnBO1VuPi+pQz9peXHYrkcndjxykktnFdkFecKIY9DUjSj6mn7GIbYY7uCnG0yz+xW
         E3q8chVkBY1R5CXRreYWmMMkJKhx+xPtmHOxvarMxHaSus/OS8uqgct3RFkGgrFkp+ox
         n0Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ySbkX+4r5a6zzWgSuzqB+vjv/GamaAVWkn0vznIPTa4=;
        b=e+MZKxv4/y3PnbtLJ2EGPH5SiuE9JuNKxmyxr5WBDOXasCXfbrH0gEUGBMJKcF8Pjy
         Vp5llkqBMO3aJs/Z8gqGfjrygLCzs13chsA8pZC6Nu5iUfoM34whG6Uq7fT+4y+rDqF3
         Q5uDbwg8mhMrGxvF0RPuBVuf7uHOw9qtE/mAEmQc54DFrX1yxTxQLSK1qaeYGQcNTWH8
         dmSu3DPv9fRvgETcWcnGfTtaHedbGjYco+N9XMo89WzerQQMeFcoGeQmEVAYSE/MEpVV
         9k55w4qgAKVHBuLg2Jg8dxND9TJCpLjEQZDMZsrd5GqVv6hrfs5IJ8eUZ7jV1bMD+M+5
         rkKg==
X-Gm-Message-State: APjAAAW520I9AXPBGc2A7+RrHkHOLbrL9L15i/pU9HAKoWaBtM59XHoR
        A/DPuU5guxt0sBIYfTHtWQTWj3r9jnH+Qrww0Nft0Q==
X-Google-Smtp-Source: APXvYqyMYPh12V0kzjDt4WN4m4Lgpd4h24RikS83ZEMRJAjaizKqsZyTpaR8f8EHKyh5AmcWRtjPh47xhNpKbRhBxy8=
X-Received: by 2002:adf:d850:: with SMTP id k16mr1938797wrl.96.1578454610421;
 Tue, 07 Jan 2020 19:36:50 -0800 (PST)
MIME-Version: 1.0
References: <20200108024035.17524-1-greentime.hu@sifive.com>
In-Reply-To: <20200108024035.17524-1-greentime.hu@sifive.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 8 Jan 2020 09:06:38 +0530
Message-ID: <CAAhSdy1LBo4QOCGBbCG8HxaK9Q8MWtx-istBn_5btkhaQPi3FA@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: to make sure the cores in .Lsecondary_park
To:     Greentime Hu <greentime.hu@sifive.com>
Cc:     Greentime Hu <green.hu@gmail.com>, greentime@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 8, 2020 at 8:10 AM Greentime Hu <greentime.hu@sifive.com> wrote:
>
> The code in secondary_park is currently placed in the .init section.  The
> kernel reclaims and clears this code when it finishes booting.  That
> causes the cores parked in it to go to somewhere unpredictable, so we
> move this function out of init to make sure the cores stay looping there.
>
> Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> ---
>  arch/riscv/kernel/head.S | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> index f8f996916c5b..276b98f9d0bd 100644
> --- a/arch/riscv/kernel/head.S
> +++ b/arch/riscv/kernel/head.S
> @@ -217,11 +217,6 @@ relocate:
>         tail smp_callin
>  #endif
>
> -.align 2
> -.Lsecondary_park:
> -       /* We lack SMP support or have too many harts, so park this hart */
> -       wfi
> -       j .Lsecondary_park
>  END(_start)
>
>  #ifdef CONFIG_RISCV_M_MODE
> @@ -303,6 +298,13 @@ ENTRY(reset_regs)
>  END(reset_regs)
>  #endif /* CONFIG_RISCV_M_MODE */
>
> +.section ".text", "ax",@progbits
> +.align 2
> +.Lsecondary_park:
> +       /* We lack SMP support or have too many harts, so park this hart */
> +       wfi
> +       j .Lsecondary_park
> +
>  __PAGE_ALIGNED_BSS
>         /* Empty zero page */
>         .balign PAGE_SIZE
> --
> 2.17.1
>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
