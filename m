Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3666C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 08:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B29C7214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 08:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VY1fSL/r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbfLKInL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 03:43:11 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:42178 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfLKInL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 03:43:11 -0500
Received: by mail-qv1-f68.google.com with SMTP id q19so5388402qvy.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 00:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kQeuS19F3KEdXprKaRD06DcqpTfUguGJp+E8RkyDNtI=;
        b=VY1fSL/r1auTchjXjG0GETcmGWwfB6GldDBRZEGQMdCt01QI+QDkI5MX4VcXg7L7wO
         66TA7vnLMgNXMvyBNu2p7xpoM5a1z0pNR9tqxuMfwdJS01Q2hoGyGEhqwhX/5Ad0GFbw
         ULfKzKKfXzAtKfcrL+k3sOKWghQew0fgrir9DFyL8L0dyWjJADv4wo0bB+LQmh+IfYjc
         Prc7AYw3r9RECIRa0RpTe1NWrtp52LD7UGVwNT5fdFDr4GXlQmwnyQDghOVnPwPFDHEc
         TrrhNe281AuSSH6gWug9aKmokDALzvt8A84ynyoX27sQS+4FoaAtjzxC7nvUOM8m9lKO
         GFYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kQeuS19F3KEdXprKaRD06DcqpTfUguGJp+E8RkyDNtI=;
        b=fvuvbeAW7DeX9KRNX+DsOvcWY9RPA4MivRpX+UKpXFytOs8wtWdEkMHA+FYT0QsXO3
         rt1Yl3vqM68z8JLlAqjZQQ6nnuBf0GNTeS2LonNdb1ITXA7DhzPYPeckNaH3Pvo0QmrA
         m3b0FOpECxpQbJ7uXE1xFg86f7aP2KW+tNZiEyqrE17U9hbQoJfmTclKykqnYy+OSN0F
         IYpzbVWgVCJI2GdImW4X6CEeeRC2qHhXnQ7V1Suki+XB2zjptiAkI0L15hF2RTbinp5b
         4bTWn/HltCOyoBsPMcxwiEvmMMuvfW+OGAlqHSNaWVbTszXpgHrXwPUj5nugJ5YaHd3z
         hZmg==
X-Gm-Message-State: APjAAAXmIaVcSBq8uoJyhxzzbCtkLZ6zmhITcu4m/sS9aV0sMeoK3BUz
        3af2ZHbj7BJswwTz7AK8zqo1wghUnisddMptKIQ=
X-Google-Smtp-Source: APXvYqweaMiD2ZiXWYey5K6krVHrwXhWFdg3f53tPr8UKp9ZC0L6v7VCyZwhxpxHXFGNXWM7pLmO5OrULXovRSxi0gI=
X-Received: by 2002:a05:6214:108a:: with SMTP id o10mr1831132qvr.246.1576053790054;
 Wed, 11 Dec 2019 00:43:10 -0800 (PST)
MIME-Version: 1.0
References: <20191028121043.22934-1-hch@lst.de> <alpine.DEB.2.21.9999.1910301311240.6452@viisi.sifive.com>
 <20191031155222.GA7270@lst.de> <alpine.DEB.2.21.9999.1911221817010.14532@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1911221817010.14532@viisi.sifive.com>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Wed, 11 Dec 2019 16:42:33 +0800
Message-ID: <CAEbi=3e4dzDex=zU2Bwvi+b=Jwz2NsT4fZPcT_o8umnJaub3Mg@mail.gmail.com>
Subject: Re: RISC-V nommu support v6
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Christoph Hellwig <hch@lst.de>, Palmer Dabbelt <palmer@sifive.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Walmsley <paul.walmsley@sifive.com> =E6=96=BC 2019=E5=B9=B411=E6=9C=88=
23=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=8810:24=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> On Thu, 31 Oct 2019, Christoph Hellwig wrote:
>
> > On Wed, Oct 30, 2019 at 01:21:21PM -0700, Paul Walmsley wrote:
> > > I tried building this series from your git branch mentioned above, an=
d
> > > booted it with a buildroot userspace built from your custom buildroot
> > > tree.  Am seeing some segmentation faults from userspace (below).
> > >
> > > Am still planning to merge your patches.
> > >
> > > But I'm wondering whether you are seeing these segmentation faults al=
so?
> > > Or is it something that might be specific to my test setup?
> >
> > I just built a fresh image using make -j4 with that report and it works
> > perfectly fine with my tree.
>
> Another colleague just gave this a quick test, following your instruction=
s
> as I did.  He encountered the same segmentation faulting issue.  Might be
> worth taking a look at this once v5.5-rc1 is released.  Could be a
> userspace issue, though.

Hi Christoph,

I think it should be replaced with this macro for cores without S-mode.

diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index 9bca97ffb67a..5c8b24bf4e4e 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -248,7 +248,7 @@ ENTRY(reset_regs)
        li      t4, 0
        li      t5, 0
        li      t6, 0
-       csrw    sscratch, 0
+       csrw    CSR_SCRATCH, 0

 #ifdef CONFIG_FPU
        csrr    t0, CSR_MISA
