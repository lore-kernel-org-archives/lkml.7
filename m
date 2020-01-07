Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B5BC33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 14:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD3862087F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 14:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578405881;
	bh=WbXvdHgqnV+cXCXBLT7+GTR8fvfquCsJE+H5WyIk82Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=idyxk7dFDjyMmjsoQVUldsFxp643Um4GF98xOoclP5QCdsn58OALhdUwnII7P5FWT
	 gFLd3TsQV/UBvpjSY8g7mywCxT69EkBrotLunwyNlJFkUkuOko+neLyX7i7PBV3shY
	 3kzS/T+f/r7M2LDKM+rPcAFHqFP47Lg/iIgItnlI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbgAGOEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 09:04:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:43798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727658AbgAGOEk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 09:04:40 -0500
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA1392087F;
        Tue,  7 Jan 2020 14:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578405880;
        bh=WbXvdHgqnV+cXCXBLT7+GTR8fvfquCsJE+H5WyIk82Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=C8FwesqQM35vO/fuy1Vdu35HrJxErbxxKzDrMZesc56j8K4Q6o/nnbHc3A8mnfPP8
         d7/VxtsVqzMSfzr0CGeOD3d9yXuwgQvn2vcl4dapxxLk7jLcErDXRf8OArBMDCY5/g
         6s5R7F6Viv7H6HWYNM24tClPBQaclHb4BoxZpeqU=
Received: by mail-lj1-f171.google.com with SMTP id o13so43426704ljg.4;
        Tue, 07 Jan 2020 06:04:39 -0800 (PST)
X-Gm-Message-State: APjAAAU8DuDViQnHDH1IrouzebBQlcM9wq9SldjAOpx2o/i0FR8t/5Eu
        llbh3ojLBkWi3h1KrvjI0DZ26ylNLcmm1oN/3xg=
X-Google-Smtp-Source: APXvYqwuJpaB1avY+d4LhVtj7v7ivw+vB84Myh9msCLGMb64KAukYZoEfMG+ooLDisdz0o2sGALGNg8sDL+TuMT2Rao=
X-Received: by 2002:a2e:96c4:: with SMTP id d4mr56228969ljj.225.1578405878159;
 Tue, 07 Jan 2020 06:04:38 -0800 (PST)
MIME-Version: 1.0
References: <1578399963-2229-1-git-send-email-krzk@kernel.org>
 <CAMuHMdULcBE1inRzTRFJeRDToT1wW+nrMEfiUs7DxMLR0tqb3w@mail.gmail.com>
 <CAJKOXPcbUfUcmU2O50M5Hs2y6ggg-m5qU-AJ6HjSL9dFTCp64A@mail.gmail.com>
 <20200107133256.GA648@pi3> <CAK8P3a1EiHCVo0aJzwsv_kbT9ENMScnxfWM7Zoc08fd7bL=D1g@mail.gmail.com>
In-Reply-To: <CAK8P3a1EiHCVo0aJzwsv_kbT9ENMScnxfWM7Zoc08fd7bL=D1g@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 7 Jan 2020 15:04:26 +0100
X-Gmail-Original-Message-ID: <CAJKOXPcwtju8w4Oub1cnW88u30=KJL=JqYsfUfUkwt++TGj_vg@mail.gmail.com>
Message-ID: <CAJKOXPcwtju8w4Oub1cnW88u30=KJL=JqYsfUfUkwt++TGj_vg@mail.gmail.com>
Subject: Re: [PATCH] sh: clk: Fix discarding const qualifier warning
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jan 2020 at 14:54, Arnd Bergmann <arnd@arndb.de> wrote:
>
> arch/powerpc/kernel/iomap.cOn Tue, Jan 7, 2020 at 2:33 PM Krzysztof
> Kozlowski <krzk@kernel.org> wrote:
> > On Tue, Jan 07, 2020 at 02:05:14PM +0100, Krzysztof Kozlowski wrote:
> > > On Tue, 7 Jan 2020 at 14:00, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > >
> > > Since this is a SuperH driver, I adjusted it to the SuperH
> > > implementation - lack of const. However iIndeed it makes sense to have
> > > them all taking "const"... Let me check, if I can fix it (without the
> > > real HW).
> >
> > That will be non-trivial because many platforms define ioreadX() with
> > non-const. For example entire alpha with many its implementations of
> > ioread(). Even include/asm-generic/iomap.h defines them as non-const...
>
> I found these instances:
>
> arch/alpha/include/asm/io.h
> arch/alpha/kernel/io.c
> arch/parisc/include/asm/io.h
> arch/parisc/lib/iomap.c
> arch/sh/kernel/iomap.c
> arch/powerpc/kernel/iomap.c
> lib/iomap.c
> include/asm-generic/iomap.h
>
> At least the last four file would have to be done at the same time as
> the header is shared, but the actual conversion should be trivial.

Yes, assuming that I did not screw up some specific
arch-implementation, it seems easy.

I have patchset ready - just need to build test it and I'll share for
kbuild & company to test.

Best regards,
Krzysztof
