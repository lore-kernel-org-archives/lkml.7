Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CDDAC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F4E6217F4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pDXdKD1K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbfDHPJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 11:09:04 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33421 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbfDHPJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 11:09:03 -0400
Received: by mail-wm1-f68.google.com with SMTP id z6so194656wmi.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 08:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=4GJgGouP+rtaXnxT5WPrrfr1rZ4Lko1AlbLRWI0iLyI=;
        b=pDXdKD1KFWpqjRX74w+CnHTOAOHchzFSlax95JlwnTAQ7+5Sl/qS0bTU3vi7RuN9Y3
         guMJqHlSv5Hp5bMOzfA0fEVhuHXhTQCWYI1y6NxdsOuHu7cXspd3DbHGL0T9+I5FJmCS
         S63//G6oyjavOtNmbCEH34fcfF+mhtR0SCLp9/RVj8zizfqTub7DpPOBBZ+BLqzY1Vwc
         9XwSGO4XsJfMlrhKe963clLas12N2VEmteqwMNbP1i7WPjd7j0ZHp3qP6vYokjqAPQGv
         YrFs+fMt11x6qKtVBxXl6A8Wdyt9ezjVTwHoLLzLW9q7iTjJv/8I9asKUTswTnW19ZJ0
         BSpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=4GJgGouP+rtaXnxT5WPrrfr1rZ4Lko1AlbLRWI0iLyI=;
        b=gHG2X+5S6rs1bRJZ+NXO/ur02UhttpZNDMnNNNQGMexvVX20IZ11BwzqXejmBXYNnx
         ROneHHehMPjKK/Qv+Sql43mMXZ8aYIs8o0PBKdBPRBuAyaNXW+RALk39kavhadDpo6ir
         /WXhcpIyeIEMhnjx92h/LEmgQmTtKJWe3+gQl2V12AshgQdkAeZzPaOxvS9+iF/G8OTV
         HdRVcxfseNHc/vfHcSKC5oQfPr7obgyD0Z2X6LhSjCkkKY6SAzNKzCalKcKQUVhzPjkV
         ZXVcKBSukLo3NJMdeVtZSOKg5Si6WDtgGj0nqYLizcV20UcJsB2R4G6ZOMLvTQnM12t1
         x6cw==
X-Gm-Message-State: APjAAAX11Ya8pgN+GLYzJ+krX7E0CavmE1NG5PgEJtRSXU46iz8Grwzt
        B6TYvshFQKQb/HN/WulHiBFut1Fy4+50FrOAxwqO72/z
X-Google-Smtp-Source: APXvYqwBVLtJji2fiewC/JUSG3zAff2w57we71MWfa0vfEOLgVbMF5qllr+9sQ6Z50yl6at3u2pF42ZemHUZRcSVngw=
X-Received: by 2002:a1c:7611:: with SMTP id r17mr17701751wmc.98.1554736142311;
 Mon, 08 Apr 2019 08:09:02 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUVW2X6G=qukJTrZuUevcnrOiuShJGxnxVaqyONNxv+RYg@mail.gmail.com>
 <e5d3d2fc-874c-a8e3-1320-f9396a3621b5@redhat.com> <99dde862-6aee-65a0-8b39-33b8ac10df45@redhat.com>
 <CA+icZUUw3SgyCdk9fyv+mVUGDepDNGj8Bm7t0WWOE3Q0sHJs4Q@mail.gmail.com>
 <863a33cf-0a1a-17af-0ea8-42e288f8a1fd@redhat.com> <CA+icZUVvtLkNNor+9wQy1_bt=NfRAfJD9f_daqX2Da=EcdjAaA@mail.gmail.com>
 <5c5c169d-3bad-9e34-8c56-bedca3e5ae08@redhat.com> <CA+icZUUk8jhGqsu65A8oHFcqzrqNRon+riPff9aJu2UFLXL7wQ@mail.gmail.com>
 <CA+icZUVy0-F7==ES2ar+0LumE3LTv8jye8LAz=DHAoDZKiyC5A@mail.gmail.com> <ceec77ac-28e5-5d2f-3ea9-ef132a35acc5@redhat.com>
In-Reply-To: <ceec77ac-28e5-5d2f-3ea9-ef132a35acc5@redhat.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 8 Apr 2019 17:08:51 +0200
Message-ID: <CA+icZUVJKOH2Mtmqsgu3LqFmkV=wQiCGFBT9qT4kypkdhq=UGw@mail.gmail.com>
Subject: Re: CBL issue #431: lld: x86_64: sysfs: cannot create duplicate
 filename $module/.rodata.cst{16,32}
To:     Denys Vlasenko <dvlasenk@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 8, 2019 at 5:04 PM Denys Vlasenko <dvlasenk@redhat.com> wrote:
>
> On 4/8/19 4:57 PM, Sedat Dilek wrote:
> > We have arch/x86/crypto/chacha-avx2-x86_64.S and
> > arch/x86/crypto/chacha-avx512vl-x86_64.S:
> >
> > .rodata.cst32.CTR2BL
> > .rodata.cst32.CTR4BL
> > .rodata.cst32.CTR2BL
> > .rodata.cst32.CTR4BL
> >
> > ...and in arch/x86/crypto/sha256-avx2-asm.S and
> > arch/x86/crypto/sha512-avx2-asm.S:
> >
> > .rodata.cst32.PSHUFFLE_BYTE_FLIP_MASK
> >
> > Correct?
>
> You mean, we have duplicate section names.
>
> Well, this brings me to my initial response -
> "Not sure how exactly this causes the error".
>
> Duplicate section names are allowed by the linker.
> There is nothing wrong with that.
>
> The warnings you see come from some other tooling,
> which does not handle correctly object files with more
> than one section with the same name.
>
> (Having unique names is still preferable,
> it helps humans to more easily find where sections come from,
> and for potential future --gc-sections optimization).

So, this is only a warning?

I can check what...

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 64d5a3327030..6df511429c28 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -167,6 +167,7 @@ config X86
        select HAVE_KPROBES_ON_FTRACE
        select HAVE_FUNCTION_ERROR_INJECTION
        select HAVE_KRETPROBES
+       select HAVE_LD_DEAD_CODE_DATA_ELIMINATION if X86_64
        select HAVE_KVM
        select HAVE_LIVEPATCH                   if X86_64
        select HAVE_MEMBLOCK_NODE_MAP

...and CONFIG_LD_DEAD_CODE_DATA_ELIMINATION=y does.

- Sedat -
