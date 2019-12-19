Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1063C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 06:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A09D2222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 06:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="YDfSnniH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfLSGyv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 01:54:51 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35296 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbfLSGyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 01:54:51 -0500
Received: by mail-wm1-f66.google.com with SMTP id p17so4431839wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 22:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2ZYEST654EPj+GcWTNQOV1oMctV/osDgh0tGsFOxh10=;
        b=YDfSnniHMo1ze5p//Ojnq6p+aH51B2xTum5mra74NQ7gI1fYwq8c8SbumlhaxTc5FP
         Hxul15bxq5xJrl4Nz4AXI3oIoZJ3i+E+QWBbcjPCVcFyf0CLhyswHOONKFQIDtNXlm3p
         XHonHMoygIaQj8ugJNmIJVYNIopO11p2TUJS/kx0DGzbSyiTpexkWyWMmhr65dtM+Z1Y
         C5kiwkyCP9WCyr2zvybPcTyVynRLUFTAFzlwjrWglx1CmUzvMxOSzbN2zNFdm1SEZhMf
         RFSs2lpQQ9HnSaAST5m9WXIbDq5XnV77+N3asSWnXc7RRIaBJdOy7jf2TPpf96G1XELc
         zg8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2ZYEST654EPj+GcWTNQOV1oMctV/osDgh0tGsFOxh10=;
        b=Mff7g+jNJGR7Ya4TtP90wIU45/6/JFeR8jp+33UcQyyBHwfOlPxvstDUVeOvxMktNB
         p+Zd2A6NoqKTfGH1Wl+OaxkXr8uGgs92iDzAo9dbmWETRCiayyDfGZNQ0bDihrsvTxbF
         TqSmQSqDfoB2hs0RxsQpZUXHqYREq/gSkx9fmhLmJVF6QlaI5FBudunsGjeV/XJuyCXu
         TpbnAn5mFDrxkFyrvB3h1md9U0YmnSGOITbWhkUsldJ/szllEYjYeAEkf0DNZM848mlr
         dv/oEjhBJSEBpZsGdQOJdF88X7V0J6YO/oXPVLy802jWiZDVwXyYJGFluQt8McXxbSoy
         KmNQ==
X-Gm-Message-State: APjAAAVysEiedTHHE/QSZR4TNkjEFJWcAlw4/jl63flN246KB0GRu9uJ
        HmrrLSTB+FNIF02jlIhK697bQulYtTN8unBT0hqAnw==
X-Google-Smtp-Source: APXvYqx9Izz/vOq2IgwO77jkGILqeBjq3n3wK6m4tpwlJ37kHRwFBLZQo1SDNzyxJjWHNS7oSufxMny7B41SHpvCSMk=
X-Received: by 2002:a1c:66d5:: with SMTP id a204mr7793295wmc.64.1576738488999;
 Wed, 18 Dec 2019 22:54:48 -0800 (PST)
MIME-Version: 1.0
References: <20191219064459.20790-1-greentime.hu@sifive.com>
In-Reply-To: <20191219064459.20790-1-greentime.hu@sifive.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 19 Dec 2019 12:24:37 +0530
Message-ID: <CAAhSdy0mxfA=VbDF0E29sVgHd4cdAvq3G0jeMRCbViaVWpnPsg@mail.gmail.com>
Subject: Re: [PATCH] riscv: fix scratch register clearing in M-mode.
To:     Greentime Hu <greentime.hu@sifive.com>
Cc:     Greentime Hu <green.hu@gmail.com>, greentime@kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 12:15 PM Greentime Hu <greentime.hu@sifive.com> wrote:
>
> This patch fixes that the sscratch register clearing in M-mode. It cleared
> sscratch register in M-mode, but it should clear mscratch register. That will
> cause kernel trap if the CPU core doesn't support S-mode when trying to access
> sscratch.
>
> Fixes: 9e80635619b5 ("riscv: clear the instruction cache and all registers when booting")
> Signed-off-by: Greentime Hu <greentime.hu@sifive.com>

In any case, we should always prefer accessing CSRs using CSR_xyz defines.

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/kernel/head.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> index 84a6f0a4b120..797802c73dee 100644
> --- a/arch/riscv/kernel/head.S
> +++ b/arch/riscv/kernel/head.S
> @@ -246,7 +246,7 @@ ENTRY(reset_regs)
>         li      t4, 0
>         li      t5, 0
>         li      t6, 0
> -       csrw    sscratch, 0
> +       csrw    CSR_SCRATCH, 0
>
>  #ifdef CONFIG_FPU
>         csrr    t0, CSR_MISA
> --
> 2.17.1
>
>
