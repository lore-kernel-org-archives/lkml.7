Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7251AC04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 10:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4583720820
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 10:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0ykRchr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732154AbfIWKzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 06:55:00 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43993 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732137AbfIWKzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 06:55:00 -0400
Received: by mail-io1-f65.google.com with SMTP id v2so32180805iob.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 03:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zAz98ftW/ay0lQ4bae6Z/Yn3V+3lhWPPD/nVcG/OPtA=;
        b=I0ykRchrp+bZMimYc6rZPefTMgQ+YdysTBMH3/s22l0qgsQLsJ3SO+oaJiMvZCwhdq
         ADeeduJvXcMh1n8ow219/FpT7w2ZKRzjNewpg1ZpV5EZkOotC+BqGRwqHOTz3IzaEEFF
         6sHF5sqR8+hCgvx0lZeo86zpVPi9UQ6BbIiCK9tri205zGqV1kpulixp72dUFrSx08Ua
         3o66E9Z5LsuQbZ73OZ6I/rOXyDZ5wayF/X7Uyd5ldHfH5mQv3MyI1Yg061QrfrQPOwIm
         a1KoMXLe3SqtR8XPvoTivisyfBXkF47+fSjJeEKmcxnZPfhhIc3zG9R4turUdY59JMsb
         AQog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zAz98ftW/ay0lQ4bae6Z/Yn3V+3lhWPPD/nVcG/OPtA=;
        b=N9EJ+Z8RyUzFOGVbwUHCab2vo0KZxHSzphQjBfLRgye3kV2uwv9voMaIR9iGHjA3hB
         IJh9R8CUeav5meKpGL0Ql++D3NytUB9sfOiHnZ73XsqlbSjsXuhjJ/MxuW7bPYeSTimq
         MIymrqwjafqRr5sBgwk1WTXsbjHcsAySWXe2nQACJAr+7Syu5g3D2hBzrdqYyPrOGuY8
         BWADh2qji0/t5Gy2M/9Sn2kF/o18lRDh5PmigjBrKMnD/sfeYlHaGWs0RMMRosK5Wlmy
         OukR/k6LBT/WKFhRcQPC6pPO8ivmzkbYb1NJoAPOAXOVu5JZUS4IvU1s/NM57y9nPlgg
         f67g==
X-Gm-Message-State: APjAAAUrUjD5epAYgpOxBJp+Mel/OU9KCdfXLltrcUF9LOPVPQPVYPTr
        gHlb/hl5rlhzml2MBiqfk8k/FXNW+u67tOkY34w=
X-Google-Smtp-Source: APXvYqxx3OiIzddOwXVAQy4YZ3AyJGN3Vmnt0gHnEYdC3dKp5btKFk6n/ObSK+18FLxtRyAmiDcftj17xqQqdLRJTGc=
X-Received: by 2002:a5d:9a86:: with SMTP id c6mr16301061iom.118.1569236099164;
 Mon, 23 Sep 2019 03:54:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190922083342.GO13569@xsang-OptiPlex-9020> <20190922150328.6722-1-alexander.kapshuk@gmail.com>
 <20190923103139.GD15355@zn.tnic>
In-Reply-To: <20190923103139.GD15355@zn.tnic>
From:   Alexander Kapshuk <alexander.kapshuk@gmail.com>
Date:   Mon, 23 Sep 2019 13:54:22 +0300
Message-ID: <CAJ1xhMX6jssVJgE1BUR1DGfUfcePV5yEihLOgp0Xeump8h3oFA@mail.gmail.com>
Subject: Re: [PATCH RESEND] gen-insn-attr-x86.awk: Fix regexp warnings
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        kbuild test robot <lkp@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 1:31 PM Borislav Petkov <bp@alien8.de> wrote:
>
> + Masami.
>
> On Sun, Sep 22, 2019 at 06:03:28PM +0300, Alexander Kapshuk wrote:
> > This patch fixes the regexp warnings shown below:
>
> Avoid having "This patch" or "This commit" in the commit message. It is
> tautologically useless.
>
> Also, do
>
> $ git grep 'This patch' Documentation/process
>
> for more details.
>
> > GEN      /home/sasha/torvalds/tools/objtool/arch/x86/lib/inat-tables.c
> > awk: ../arch/x86/tools/gen-insn-attr-x86.awk:260: warning: regexp escape sequence `\:' is not a known regexp operator
> > awk: ../arch/x86/tools/gen-insn-attr-x86.awk:350: (FILENAME=../arch/x86/lib/x86-opcode-map.txt FNR=41) warning: regexp escape sequence `\&' is not a known regexp operator
> >
> > The ':' and '&' characters need not escaping when used in string constants
> > as part of regular expressions.
>
> I could use a reasoning here, as in, "gawk manual doesn't have those two
> characters in the list here:
>
> https://www.gnu.org/software/gawk/manual/html_node/Escape-Sequences.html"
>
> or so.
>
> >
> > [Test-run]
> > awk -f arch/x86/tools/gen-insn-attr-x86.awk \
> >       arch/x86/lib/x86-opcode-map.txt >../tmp/inat-tables.c
> >
> > diff arch/x86/lib/inat-tables.c ~/tmp/inat-tables.c; echo $?
> > 0
> >
> > awk -f tools/arch/x86/tools/gen-insn-attr-x86.awk \
> >       tools/arch/x86/lib/x86-opcode-map.txt >../tmp/inat-tables.c
> >
> > diff tools/objtool/arch/x86/lib/inat-tables.c ~/tmp/inat-tables.c; echo $?
> > 0
>
> No need for that - just say that diffing the output before and after
> shows no changes.
>
> > [Debugging output]
> > DBG:ext:(66&F2)
> > DBG:match(ext, ...):(66&F2)
> > DBG:match(..., lprefix3_expr):\((F2|!F3|66&F2)\)
>
> That is supposed to say what exactly? That it still does what it is
> expected to do?

That was the intention.

Thanks for reviewing the patch.
I'll wait to hear from Masami before resending the patch.

>
> Leaving in the rest for Masami.
>
> Thx.
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
