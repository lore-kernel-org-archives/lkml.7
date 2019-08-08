Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA80EC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 12:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A67B214C6
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 12:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TtZVW9S3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732316AbfHHMTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 08:19:07 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39708 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727522AbfHHMTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 08:19:06 -0400
Received: by mail-lj1-f195.google.com with SMTP id v18so88621006ljh.6
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 05:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WM5R1w6ZezI/U8oeoimaxsFIAEeSSoKIeGsMNKCHrOU=;
        b=TtZVW9S3NzftSIyl46edaBOsxhYUU/PJIt3TV5e/GJUECtRdRaD2cs9B7G0qAEnOHS
         zSUpkH471fkaogRmFu8LreJyZEjTk8jBQ7cUGhiZs+MnFimMUf10YYwLG6CTX6SRA/fO
         335JeQdgMuliSyhVeo242x46hP7T+tfeXhEJUzm7l5Fw6M8RyJB65bB2HFDI9A1XUvdh
         aNhCKcduCr4il74S/575Zd4cUkflUIqohzFq5nBbXtQQUdIpDg8XLgVGoAjUZXYQ+X/o
         Yb1QvPjrBmbzhaj1LBOpIcQoj83MXoWAolPfb17JpMRdrV/x13u+jZ1kx4bCWqfQISmQ
         7GWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WM5R1w6ZezI/U8oeoimaxsFIAEeSSoKIeGsMNKCHrOU=;
        b=F4Z8nwEywiWr9Z1TEGeBk0uXCZdZF8ehPM148ha0MXr2CWURbYpWd6F1hxLQBRavdY
         Ypu9Xt0CxSIJ5P9s2OoRiS53TkDQNRSZGv3Wyln5OF9l7Q8u6i4DTkKpUzDjAtXOQwMG
         0TNCLjrzsQyNquzTXTlKWFYk4ySRkgormHKFp1XdmWoVQLQEIogVhDtu2+NxgPIDOcfo
         X5Ni7QdVVcETkkop4zwON0gnZaY5BJMTdA1+hFUIvkY8YjiRK/YQRIbZ0XZhzGsh4u9O
         MHqjD+n1TB3zPp6R8aMvkanz+fh6e41GwUh+YxBaL2Z8OdzJjWXNIDnrg1JF4z7VvaVA
         u6Xg==
X-Gm-Message-State: APjAAAWDWBoIgtUAIbkUFVRpLjdGweQ5Hg/OvbZLunWqQc+T0z3P3RBg
        d3SseQbNBOtaR/bWTVbuM3yilb7ZcPEIqygved8=
X-Google-Smtp-Source: APXvYqxaF6HN4Qke9gmz3jYRh+w8mmBxBNf6ZxmxMIqo3nQ5zpxPLpKGvTx8Va1CrAD4fJ6XJ5TLEzX+iOAKCqrnz5A=
X-Received: by 2002:a2e:8696:: with SMTP id l22mr7985367lji.201.1565266744317;
 Thu, 08 Aug 2019 05:19:04 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.9999.1908061929230.19468@viisi.sifive.com> <CAEUhbmVTM2OUnX-gnBZw5oqU+1MwdYkErrOnA3NGJKh5gxULng@mail.gmail.com>
In-Reply-To: <CAEUhbmVTM2OUnX-gnBZw5oqU+1MwdYkErrOnA3NGJKh5gxULng@mail.gmail.com>
From:   Charles Papon <charles.papon.90@gmail.com>
Date:   Thu, 8 Aug 2019 14:18:53 +0200
Message-ID: <CAMabmMJ3beMcs38Boe11qcsQvqY+9u=2OqA0vCSKdL=n-cK9GQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: kbuild: drop CONFIG_RISCV_ISA_C
To:     Bin Meng <bmeng.cn@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Atish Patra <atish.patra@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please do not drop it.

Compressed instruction extension has some specific overhead in small
RISC-V FPGA softcore, especialy in the ones which can't implement the
register file read in a asynchronous manner because of the FPGA
technology.
What are reasons to enforce RVC ?

On Wed, Aug 7, 2019 at 2:29 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> On Wed, Aug 7, 2019 at 10:30 AM Paul Walmsley <paul.walmsley@sifive.com> wrote:
> >
> >
> > The baseline ISA support requirement for the RISC-V Linux kernel
> > mandates compressed instructions, so it doesn't make sense for
> > compressed instruction support to be configurable.
> >
> > Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> > Cc: Atish Patra <atish.patra@wdc.com>
> >
> > ---
> >  arch/riscv/Kconfig  | 10 ----------
> >  arch/riscv/Makefile |  2 +-
> >  2 files changed, 1 insertion(+), 11 deletions(-)
> >
>
> Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
