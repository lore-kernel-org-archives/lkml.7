Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63508C32753
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 02:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E98E2084F
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 02:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="WAY8orSq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbfHOCxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 22:53:50 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37445 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbfHOCxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 22:53:49 -0400
Received: by mail-ot1-f67.google.com with SMTP id f17so3010529otq.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 19:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hdb0nH13oEr6nRIXzGT4/+HAUBVeTsgqLpq+7aKP03Y=;
        b=WAY8orSqrakMS/XtmJpC2hS3YEV9zeu+kWvcto/2HdUAbGMKfH8/Ea81r2vzPlglB0
         HVVTUM/mMunfKiuGsu9W/C7CcdEUhiMiOv3aGIvO7VjNz5HeeRFDI5JGhxHjcapluMeS
         SbMADSrANmNhcedz/64VntyqWFL1nKrRHTEmY5BNQxA1GappLw1sVV9zjBefCn8s9uqd
         E/WC0mhGDjAxQ9LhVXY1k50D9/urECCnfGgHb6/EoDnj4nzrNueTPQQCg7z0Ao2kuScv
         REFKuuRP7jdohRgqAm8hgg2+biS+kdVEr+idLx/TvaYe6LxPr2+eBde1SClOh6Z/37k0
         z2Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hdb0nH13oEr6nRIXzGT4/+HAUBVeTsgqLpq+7aKP03Y=;
        b=WyjYKSZmRehJiavNgF6dS35Gc8BLnlkana2HAcG2/d/cFf8Tg8/dMM0iBBRfLH7VVs
         j0+1EaVXGjg9Scy4h6ONOMzMvT5dJW36bi2g+R6jrX+LPcTXpTVT2CfFKpa46ELRU7W+
         zKUlbRTuSiLUIODLUhGcUqy4SDxjESJy4KHaGbvH3jNTANEDchNeF8VcKMPPU2gzXglk
         QaP/UAhjBls3PHE7fL58wLBfWdw/CxX2S8pPuCFZwEqW5zhB0tBaHDvdbzuzjT7r+kAi
         1jA3Oe/iojKELqyFzsSjSfBTuzy5i9NWzoSI+M6A2+5Yun/Vye7LztlCp57pX98xMmyZ
         8PwA==
X-Gm-Message-State: APjAAAUNfLT4Wj2wdimlT//WBqaCF3SBzlpf+GDFhT5QftAN2LmYWkYn
        USRVcAnBZjs5CiqxouxYdUhRayEX4B63FvIwCY0sgw==
X-Google-Smtp-Source: APXvYqw/iFDJnYcGgE5J8uAV0NYHZbpRwRf5evy2jBuuR9WT/cCD4jA2QAF4eEWu/w6jnSFkqwKZMlEFZHtBtq+Tgho=
X-Received: by 2002:a05:6602:219a:: with SMTP id b26mr2811877iob.55.1565837628423;
 Wed, 14 Aug 2019 19:53:48 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.9999.1908141328440.18249@viisi.sifive.com>
 <mhng-4eded486-d381-4822-abc5-4023bf7ba591@palmer-si-x1c4> <87mugbv1ch.fsf@igel.home>
In-Reply-To: <87mugbv1ch.fsf@igel.home>
From:   Vincent Chen <vincent.chen@sifive.com>
Date:   Thu, 15 Aug 2019 10:53:37 +0800
Message-ID: <CABvJ_xgfuXzO0-vDB6LYggNchjP=vUvnreLEYuV=w=eb+bhVXw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] riscv: Make __fstate_clean() work correctly.
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 6:17 AM Andreas Schwab <schwab@linux-m68k.org> wrote:
>
> On Aug 14 2019, Palmer Dabbelt <palmer@sifive.com> wrote:
>
> > On Wed, 14 Aug 2019 13:32:50 PDT (-0700), Paul Walmsley wrote:
> >> On Wed, 14 Aug 2019, Vincent Chen wrote:
> >>
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
Thank Paul for correcting my mistake.

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
>
> Andreas.
>
Thanks to Palmer and Andreas for sharing this useful information.

> --
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
> "And now for something completely different."
