Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF78ECDE20
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 07:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04AED206CD
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 07:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfIKHW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 03:22:56 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38841 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfIKHWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 03:22:55 -0400
Received: by mail-ot1-f68.google.com with SMTP id h17so17769346otn.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 00:22:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RApwx5LDSAMD4iHD35F9JLH9Ye8FG1fZvq9Vj2OH05c=;
        b=cYEkrglDnJkgbSuHeKyIlMyCchR5ohwabVol4z7OaCfTpGLTYKC7ab7f9syjHr2mDE
         Hp59ysWqV0Sc59Zxtahg53bzq9Qsq6aiKKryH+Tnz2CTntFkaZqaYF06I+AN6zbwbV0l
         W/w40OOEhseD6t2xrZt6izwkP86qH9vJiw9s4zdQaOSptMBGlFiEdNcOkJ4a8SsVHODD
         qZfWZSDMipXLWJbodW7pBQXnF0ZIshXeYninM1vxzxsSwJayMxqMrdmI3kLV5EHF2QmY
         P/hOHpksSOi4fvkMi+E//y5u8+EeRduSQY3QQQAgTNaSIASznlf4DDywccziq7N4rSi9
         +OkA==
X-Gm-Message-State: APjAAAU5PEO46pJ/dABYb1Q4bfKFr9IBftLcHiZaVxs5qn+K/hlIkwzg
        GvotxPbUowG0CKMtmhAlztg2tsoIG6azmcT20yg=
X-Google-Smtp-Source: APXvYqzJ0kqmlruLmnYW1QIj2Hu8GhX9jPrW0LH/6teXZ2G+NSopwZNP7ZZ3+RNfu4CiEf2Q9K0h0oNBROYBb360kdE=
X-Received: by 2002:a9d:5a06:: with SMTP id v6mr8353187oth.250.1568186574782;
 Wed, 11 Sep 2019 00:22:54 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.9999.1908141328440.18249@viisi.sifive.com>
 <mhng-4eded486-d381-4822-abc5-4023bf7ba591@palmer-si-x1c4> <87mugbv1ch.fsf@igel.home>
In-Reply-To: <87mugbv1ch.fsf@igel.home>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 11 Sep 2019 09:22:43 +0200
Message-ID: <CAMuHMdX9tDqN4jMwMrUc-0zhYBo5gAHTbjwORCwB=3zVi6kvgQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] riscv: Make __fstate_clean() work correctly.
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        vincent.chen@sifive.com, linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

On Thu, Aug 15, 2019 at 12:37 AM Andreas Schwab <schwab@linux-m68k.org> wrote:
> On Aug 14 2019, Palmer Dabbelt <palmer@sifive.com> wrote:
> > On Wed, 14 Aug 2019 13:32:50 PDT (-0700), Paul Walmsley wrote:
> >> On Wed, 14 Aug 2019, Vincent Chen wrote:
> >>> Make the __fstate_clean() function correctly set the
> >>> state of sstatus.FS in pt_regs to SR_FS_CLEAN.
> >>>
> >>> Fixes: 7db91e5 ("RISC-V: Task implementation")
> >>> Cc: linux-stable <stable@vger.kernel.org>
> >>> Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
> >>> Reviewed-by: Anup Patel <anup@brainfault.org>
> >>> Reviewed-by: Christoph Hellwig <hch@lst.de>
> >>
> >> Thanks, I extended the "Fixes" commit ID to 12 digits, as is the usual
> >> practice here, and have queued the following for v5.3-rc.
> >
> > For reference, something like "git config core.abbrev=12" (or whatever you
> > write to get this in your .gitconfig)
> >
> >    https://github.com/palmer-dabbelt/home/blob/master/.gitconfig.in#L23
> >
> > causes git to do the right thing.
>
> Actually, the right setting is core.abbrev=auto (or leaving it unset).
> It lets git chose the appropriate length depending on the repository
> contents.  For the linux repository it will chose 13 right now.

Does that depend on the git version?
For me (git version 2.17.1), it still uses 12 when using the auto setting.

Should we update Documentation/process/submitting-patches.rst
to increase to e.g. 16 (which is what I've been using for quite a while)?
When can we expect old 12 hexit references to start breaking?

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
