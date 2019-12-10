Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C4D8C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 18:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 004D5207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 18:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="JogH2eZ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbfLJS6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 13:58:46 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54627 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727495AbfLJS6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 13:58:46 -0500
Received: by mail-wm1-f66.google.com with SMTP id b11so4439491wmj.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 10:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CvDFARgCT0LsrZ/bz1Y3KZ6G13ajYy+ecdz2Y5wO+o4=;
        b=JogH2eZ4Nhc/g73QDo4a7CNVK2d54Ay5JJclQzZ2XGAoWhHww28c40KZpbDE3OUs5Q
         LxqLakbePfjaWEZtzW9qE+6VQDXz+12h9Gbqxe5ZfzfSK4AhbV5cmsUWIltiNmsHHtcx
         hIg67qr9XGmb/1o5Dd+/k1/D7ovJBZmSfJPdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CvDFARgCT0LsrZ/bz1Y3KZ6G13ajYy+ecdz2Y5wO+o4=;
        b=b9Yt+OTDasUWHd8eEO/mAPXnksR4OP16Wm+yWHlITqzSs9G2FN2MOIHEkWNh6+HH1m
         xxX3VqINGJK17LsY/i9grLF0gWDmB5mKOdEmfPQ/ubR+uljuRH0QrfPrtc+3ofw3agvt
         NyE3AQFzUOUp8uH46BQ4I5b1MVjMYRRQPB6FMgPtyDR9kTZzpIDon367s4IM2Zg/TsTT
         UQ0H1ZJ8D7md8ryPN39z5v8QEaWzDglDJPMotf3t3qKSrpif0K41R7yNEjBCyJNxTGM2
         RBhsYUADVdVvaUSTSsLys3KyVeN/fttY1c8xBIbdtbGgpibCSngXPzNil6qAN8hPMO87
         OdOA==
X-Gm-Message-State: APjAAAVVpakiqS9wNPUMz0RjVk8jYyMI4n0/lU/PhBWuVKBgIYyCVe1j
        BbWhJ1OeavUrQN+xet/R3GcnbOPlwKXWXsFcpDWjtA==
X-Google-Smtp-Source: APXvYqwLybqhBx8RzCoka7tiW2rLLq1azZFzhsoPra5zQN6VCVrvOP6LJddIDsb4Qjv9QFK7+ZPUTVF2I/bJPSMqluE=
X-Received: by 2002:a1c:7310:: with SMTP id d16mr6679056wmb.165.1576004324170;
 Tue, 10 Dec 2019 10:58:44 -0800 (PST)
MIME-Version: 1.0
References: <20191201195728.4161537-1-aurelien@aurel32.net>
 <87zhgbe0ix.fsf@mpe.ellerman.id.au> <20191202093752.GA1535@localhost.localdomain>
In-Reply-To: <20191202093752.GA1535@localhost.localdomain>
From:   Justin Forbes <jmforbes@linuxtx.org>
Date:   Tue, 10 Dec 2019 12:58:33 -0600
Message-ID: <CAFxkdAqg6RaGbRrNN3e_nHfHFR-xxzZgjhi5AnppTxxwdg0VyQ@mail.gmail.com>
Subject: Re: [PATCH] libbpf: fix readelf output parsing on powerpc with recent binutils
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Aurelien Jarno <aurelien@aurel32.net>,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, debian-kernel@lists.debian.org,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        "open list:BPF (Safe dynamic programs and tools)" 
        <netdev@vger.kernel.org>,
        "open list:BPF (Safe dynamic programs and tools)" 
        <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 2, 2019 at 3:37 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On Mon, Dec 02, 2019 at 04:53:26PM +1100, Michael Ellerman wrote:
> > Aurelien Jarno <aurelien@aurel32.net> writes:
> > > On powerpc with recent versions of binutils, readelf outputs an extra
> > > field when dumping the symbols of an object file. For example:
> > >
> > >     35: 0000000000000838    96 FUNC    LOCAL  DEFAULT [<localentry>: 8]     1 btf_is_struct
> > >
> > > The extra "[<localentry>: 8]" prevents the GLOBAL_SYM_COUNT variable to
> > > be computed correctly and causes the checkabi target to fail.
> > >
> > > Fix that by looking for the symbol name in the last field instead of the
> > > 8th one. This way it should also cope with future extra fields.
> > >
> > > Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> > > ---
> > >  tools/lib/bpf/Makefile | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > Thanks for fixing that, it's been on my very long list of test failures
> > for a while.
> >
> > Tested-by: Michael Ellerman <mpe@ellerman.id.au>
>
> Looks good & also continues to work on x86. Applied, thanks!

This actually seems to break horribly on PPC64le with binutils 2.33.1
resulting in:
Warning: Num of global symbols in sharedobjs/libbpf-in.o (32) does NOT
match with num of versioned symbols in libbpf.so (184). Please make
sure all LIBBPF_API symbols are versioned in libbpf.map.

This is the only arch that fails, with x86/arm/aarch64/s390 all
building fine.  Reverting this patch allows successful build across
all arches.

Justin
