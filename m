Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC91C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 03:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23AB120828
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 03:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="xGeJ7KCS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729440AbfCYDVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 23:21:44 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37563 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729310AbfCYDVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 23:21:44 -0400
Received: by mail-wm1-f65.google.com with SMTP id v14so7413238wmf.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 20:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PZL5T3XpqPXxaGPXLVF+FDWkhfoO8E1V4Dhl71Xctkg=;
        b=xGeJ7KCSeWkFGa8Z4bFykhqJwVXmpeEsst/o+6N+0nBVzu6n+UE43qpjmrQusjaHcM
         LP0So7k7B4O2u+/WptUiR8w/V0eUJIPSN4VztX4Xeg+roJNlqun7DRVfHD8xqcoroK0/
         LxdWOYk4690SQWSvbqLhctlNFF5q8hobU2grqUMBs+ZoCF1bWZDvVFgRccCpYCaolmNX
         W5A7BxtcQ4E2CD9+/OYAbmhw9daMx/J0zrRgQBJ16kOse3Z9XRveBBGMWD+v5RMoyKMO
         gglROWde8p+mPuOL94xHN06epxIGD8G8t605unp370kFdwiOd+xxUiZsj8vA+jkNvv5f
         viuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PZL5T3XpqPXxaGPXLVF+FDWkhfoO8E1V4Dhl71Xctkg=;
        b=Q2D6NAatSOrhg/Cfmd11ii0Z3OeLvX9xbMxrXC/W/G8HJYiTpZt601zMUEbXZl5nwL
         iBvOteC691ryWBek296kNgZEGhwUKoG8Eh8kfkKZLfDtrkSzg06SbtZfJpQ3mcV9VdAK
         7RI6qBZvexq2w3zBd5vr3iD+Afyn+7+eLDFeE0Jd+8W2STUulqQ4AfrP38oEQ/JL7Wkg
         AEjo1Tfmas0g8mQFe4+kqZFlV15CQ7OL3CuaV3AfEFyvHxyNpVsu0D/oaglif/nmlFHK
         oLl/AarGWq8iBKdvGA48+8WNbRTErdi3R3V70v0ddgT0fXtQe30QHXPxWg4Hi1ghCbjF
         RrMg==
X-Gm-Message-State: APjAAAV26csw1EMX6Jk0M/tsAPNTPcOnewRfX5whOu9lERRbQrPFLLzX
        BPu8GzlgMB/Gy6kF6aLdhGyFKy9Sj62SG6BxllsxyQ==
X-Google-Smtp-Source: APXvYqxZmxjPxGPAlpI+gi006nLnQg0EUNE3Gq1+wEfIbjNHiFg0o1ZW7lmOIPCiqHgMgE7htqIiF2XFHuCuV/Y5La8=
X-Received: by 2002:a1c:b455:: with SMTP id d82mr4241588wmf.153.1553484102425;
 Sun, 24 Mar 2019 20:21:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190324110804.68555-1-anup.patel@wdc.com> <LO2P265MB08478847A45E7617FD906F8CD65D0@LO2P265MB0847.GBRP265.PROD.OUTLOOK.COM>
In-Reply-To: <LO2P265MB08478847A45E7617FD906F8CD65D0@LO2P265MB0847.GBRP265.PROD.OUTLOOK.COM>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 25 Mar 2019 08:51:31 +0530
Message-ID: <CAAhSdy0+9rgJtxjhrYAEt1Tem79ixL7sSKUHp63Hf-5sb+31+Q@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Always compile mm/init.c with cmodel=medany
To:     Gary Guo <gary@garyguo.net>
Cc:     Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 12:44 AM Gary Guo <gary@garyguo.net> wrote:
>
>
>
> > -----Original Message-----
> > From: linux-riscv <linux-riscv-bounces@lists.infradead.org> On Behalf O=
f Anup
> > Patel
> > Sent: Sunday, March 24, 2019 11:08
> > To: Palmer Dabbelt <palmer@sifive.com>; Albert Ou <aou@eecs.berkeley.ed=
u>
> > Cc: Anup Patel <Anup.Patel@wdc.com>; linux-kernel@vger.kernel.org; Mike
> > Rapoport <rppt@linux.ibm.com>; Christoph Hellwig <hch@infradead.org>; A=
tish
> > Patra <Atish.Patra@wdc.com>; Paul Walmsley <paul.walmsley@sifive.com>;
> > linux-riscv@lists.infradead.org; Christoph Hellwig <hch@lst.de>
> > Subject: [PATCH] RISC-V: Always compile mm/init.c with cmodel=3Dmedany
> >
> > diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
> > index eb22ab49b3e0..7307609d405b 100644
> > --- a/arch/riscv/mm/Makefile
> > +++ b/arch/riscv/mm/Makefile
> > @@ -3,3 +3,5 @@ obj-y +=3D fault.o
> >  obj-y +=3D extable.o
> >  obj-y +=3D ioremap.o
> >  obj-y +=3D cacheflush.o
> > +
> > +CFLAGS_init.o :=3D -mcmodel=3Dmedany
>
> I think you should also remove CFLAGS_setup.o from kernel/Makefile, as I =
think it was there solely for the correctness of setup_vm. As setup_vm is n=
ow in mm/init.o, the old CFLAGS probably isn't needed and should be removed=
 in the same patch. Disclaimer: I haven't tested it.

Sure, I will remove it in v2 patch. Thanks for catching.

Regards,
Anup
