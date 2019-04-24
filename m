Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B46C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 07:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45AA020685
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 07:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yj7p1f7E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbfDXHTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 03:19:23 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42571 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728927AbfDXHTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 03:19:22 -0400
Received: by mail-ed1-f68.google.com with SMTP id u23so14616431eds.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 00:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Lgf5HoTsHrFGKIuVDTaWuBV3TYN/tmdm9uPDCDh5ZgM=;
        b=Yj7p1f7EY1WDTR8JbAAkWxXZ4YlaIiwgza8hYzOwMnHhJKC4C7MuOpamuAaaAFgsyl
         jS02U1cKwoOk0eZBWLN0PvX79+IYY5w0i9eLbJYp8bwmiRO0vIOslvoCUJWrK9Ydn48j
         4js1CEDPeVwtgWMQ8/doO+tRqZe/gxfegk8F2UfRX4JR17FpN+NXvoo/ncNYZfQok58O
         5VAEquWio+0ZCXoFmapXHZ7AMRXWoTdpy/KY1UtCxSb2SUvOaMmwFM/rNOtXXfwNFvUi
         32DsEolE24zgh6cNa1nQFDHVjMv5x7+iWUW7BiYRUiO4gixKxF9rywRfVTei1/IfMIkD
         Kp3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Lgf5HoTsHrFGKIuVDTaWuBV3TYN/tmdm9uPDCDh5ZgM=;
        b=Fm64Q6dPtXx9MLSoIRGN0BoZUgLiDhGyKcH7Mt6G4rB367gyyM1XrpBuYSjxBqr9/H
         OTbE6lmm4d6ItcODHz/Op64rYTLf1li1rOWz7qXGa6rSQvsxRIaFeT0sjLshphLlLT7w
         e03ZScMsTQzUzAEdZI+RGEfPXskytQMmLnski/Qh4gOprYRSW/OuqKfC9qgQpc3yilRx
         m4gTiS8pbztbEkjkuc9ebmA6fJ3Tw2Rqe6Jq1uWCHnL9+lP5xrIWxfgg9GPnwMESGzz7
         kHEXyPb0x078/ApWva3QxJG7wWpQUvQ0q3t/LgZvtJBZrxU0os431tqu99J6rOWZ13fb
         zKow==
X-Gm-Message-State: APjAAAXsjFFXHpo6d2qUSQNZxuaPsxh0G2cG71UU+hBIUKL1WJs8Z4w/
        y2VQ/SWNoH3nD5+zRArDv1YmuMnHupfhNR6kaDS/WFbIjsQ=
X-Google-Smtp-Source: APXvYqxa1VLKXX5hqNgTeuYWt46r09laLknpYhGsvDUayLLC6oTRNjJ7h4aXzL0GK5BJwKVJRuitGxUK50/Lroaa/vg=
X-Received: by 2002:a50:be01:: with SMTP id a1mr19473760edi.12.1556090361056;
 Wed, 24 Apr 2019 00:19:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190311224752.8337-1-valentin.schneider@arm.com> <20190311224752.8337-8-valentin.schneider@arm.com>
In-Reply-To: <20190311224752.8337-8-valentin.schneider@arm.com>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Wed, 24 Apr 2019 15:18:44 +0800
Message-ID: <CAEbi=3fPnEsF6hUK-p7de=+hyJ5UTF+uhb65QzNgmvNoh2TVPA@mail.gmail.com>
Subject: Re: [PATCH 07/14] nds32: ex-exit: Remove unneeded need_resched() loop
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vincent Chen <deanbo422@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Valentin,

Valentin Schneider <valentin.schneider@arm.com> =E6=96=BC 2019=E5=B9=B43=E6=
=9C=8812=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=886:48=E5=AF=AB=E9=81=
=93=EF=BC=9A
>
> Since the enabling and disabling of IRQs within preempt_schedule_irq()
> is contained in a need_resched() loop, we don't need the outer arch
> code loop.
>
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Greentime Hu <green.hu@gmail.com>
> Cc: Vincent Chen <deanbo422@gmail.com>
> ---
>  arch/nds32/kernel/ex-exit.S | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/nds32/kernel/ex-exit.S b/arch/nds32/kernel/ex-exit.S
> index 97ba15cd4180..1df02a793364 100644
> --- a/arch/nds32/kernel/ex-exit.S
> +++ b/arch/nds32/kernel/ex-exit.S
> @@ -163,7 +163,7 @@ resume_kernel:
>         gie_disable
>         lwi     $t0, [tsk+#TSK_TI_PREEMPT]
>         bnez    $t0, no_work_pending
> -need_resched:
> +
>         lwi     $t0, [tsk+#TSK_TI_FLAGS]
>         andi    $p1, $t0, #_TIF_NEED_RESCHED
>         beqz    $p1, no_work_pending
> @@ -173,7 +173,7 @@ need_resched:
>         beqz    $t0, no_work_pending
>
>         jal     preempt_schedule_irq
> -       b       need_resched
> +       b       no_work_pending
>  #endif
>
>  /*

Thank you. :)
Acked-by: Greentime Hu <greentime@andestech.com>
