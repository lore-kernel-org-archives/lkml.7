Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E50C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 09:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA42420872
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 09:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="CZSjIHEG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391814AbfIJJ4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 05:56:52 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37289 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727557AbfIJJ4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 05:56:51 -0400
Received: by mail-wr1-f68.google.com with SMTP id i1so18268731wro.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 02:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3mnueqhN7Kkwa8MkKe0Ckxy5QE6yv9lhd/uQxARTM74=;
        b=CZSjIHEGio5Scyxy58ejHSD/34oFT3vJzyxbfFG0kjwe/cmnHTIzWUhhCbpjiKyvfm
         rc2BXgizDrNN5aKGj6aSjNdt7DGdPdbd+k+KErsQwst2FYGWk3gwJh7abEZl2CosOA8u
         /DN2IHkIbVx7rlKZNKX+QceItJrOmv21RsJE7o3/iXrqKF/kejtx5kKl4++0M7QBLuus
         gor9HR1IzHLkdjvHZZbV8KFEFmxx4bDtIk6x5QnO+BDiw7t3MUzoy8WMwlnBB79M6F9Y
         0sSTsIyKUvx5zuThviGyd1U1mZQMZAjiIeqsXQoIJsWi854CL70C/t7fctYucbhg9nsb
         ZlUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3mnueqhN7Kkwa8MkKe0Ckxy5QE6yv9lhd/uQxARTM74=;
        b=pNgyApzmJDXrKGw5RrbI2NsEhISqXhbPvzOaLupODo6UxHqEKVuvyhD0epNkod4+zT
         ZZw9t1+iGLNYBjAIo7sZ8HDFmoFFw1TfaHOlrIqmzCEjcYDhbJEVKtKhx7FdIj4mPcus
         ZtHTNf+VmS/t60agDkHFzo9LAXwqeVjT/qaVXFF40utXM6pAXwp5Xozc+FGWPp88uVFq
         mRhkhzgeFRHH5SR7IkYTZ55ZJIiMLPq5yrv2SLNUGemcTlwvI8SuBRSh4A+8PfFj28c2
         tVqQiVQYqUb0m8rio2sDDtdalNgCidDHPMRSJYlm4/nfXPEWlzNUBVGiIboClHZSVjHx
         DmTQ==
X-Gm-Message-State: APjAAAX+ZCerVtiFjnC8hDsh0HzNcNJoTCreEYhVT49aK3cfr3wfh3f9
        OJ7DMIMmhtRkbav9qa/TfadQ6hjDe+06ASo2KYKQzhfp
X-Google-Smtp-Source: APXvYqx9yPh5gbReKColNTXHf9o3yyTP4EAP2yUT7FN5pvrE74RBOKHXxfOwxZKyUImtWNVOP7dfee+/5zxSK/eFOtc=
X-Received: by 2002:a5d:4ac5:: with SMTP id y5mr19528470wrs.179.1568109409582;
 Tue, 10 Sep 2019 02:56:49 -0700 (PDT)
MIME-Version: 1.0
References: <AMJe39pHTcb4gsI-_Dv-wmR8_x9EbCCN9LKI47j34_8vBKRqzFxPrjmZvBtwV5OU_HcOiRkKUG66xVaNQ8VAXw7Ws0CCK74gpA8pKaYN5wM=@hardenedlinux.org>
In-Reply-To: <AMJe39pHTcb4gsI-_Dv-wmR8_x9EbCCN9LKI47j34_8vBKRqzFxPrjmZvBtwV5OU_HcOiRkKUG66xVaNQ8VAXw7Ws0CCK74gpA8pKaYN5wM=@hardenedlinux.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 10 Sep 2019 15:26:39 +0530
Message-ID: <CAAhSdy2kowbo-kULxvAE9M=69wwOE4jJ8wkgoLxOqC2R92eiXw@mail.gmail.com>
Subject: Re: [PATCH] arch/riscv: disable too many harts before pick main boot hart
To:     Xiang Wang <merle@hardenedlinux.org>
Cc:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "citypw@hardenedlinux.org" <citypw@hardenedlinux.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 6, 2019 at 12:26 PM Xiang Wang <merle@hardenedlinux.org> wrote:
>
> From 12300865d1103618c9d4c375f7d7fbe601b6618c Mon Sep 17 00:00:00 2001
> From: Xiang Wang <merle@hardenedlinux.org>
> Date: Fri, 6 Sep 2019 11:56:09 +0800
> Subject: [PATCH] arch/riscv: disable too many harts before pick main boot hart
>
> These harts with id greater than or equal to CONFIG_NR_CPUS need to be disabled.
> But pick the main Hart can choose any one. So, before pick the main hart, you
> need to disable the hart with id greater than or equal to CONFIG_NR_CPUS.
>
> Signed-off-by: Xiang Wang <merle@hardenedlinux.org>
> ---
>  arch/riscv/kernel/head.S | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> index 0f1ba17e476f..cfffea38eb17 100644
> --- a/arch/riscv/kernel/head.S
> +++ b/arch/riscv/kernel/head.S
> @@ -63,6 +63,11 @@ _start_kernel:
>         li t0, SR_FS
>         csrc sstatus, t0
>
> +#ifdef CONFIG_SMP
> +       li t0, CONFIG_NR_CPUS
> +       bgeu a0, t0, .Lsecondary_park
> +#endif
> +
>         /* Pick one hart to run the main boot sequence */
>         la a3, hart_lottery
>         li a2, 1
> @@ -154,9 +159,6 @@ relocate:
>
>  .Lsecondary_start:
>  #ifdef CONFIG_SMP
> -       li a1, CONFIG_NR_CPUS
> -       bgeu a0, a1, .Lsecondary_park
> -
>         /* Set trap vector to spin forever to help debug */
>         la a3, .Lsecondary_park
>         csrw CSR_STVEC, a3
> --
> 2.20.1
>
>
>
>
>
>
>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
