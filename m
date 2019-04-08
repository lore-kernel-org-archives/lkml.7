Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A31F7C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6403A2148E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/6pMuKa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbfDHPRB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 11:17:01 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35280 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbfDHPRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 11:17:00 -0400
Received: by mail-wm1-f68.google.com with SMTP id y197so15189100wmd.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 08:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=IfnOO1+SEUKyKQDFwMTXRvfcI+8sw2PMhyHbHUfe+b0=;
        b=Y/6pMuKaiR+nYqJhjTD76wlvEZXaeGwkUVT93Kq5w2xkc+4/iRgSlwCPb/LhFapqsZ
         tH/TEA1OpdxIfS10SFCRByJ/21WH+jJufX6Plxz+y9Z4lEKPtlZvreRoTRzesvJWqVUI
         UxtxxYLg6Wcg1RI24tzFRT8Jd0LaPY0kV62aWGNaitTfaB/XJL2oUYOQviDIO+pjTaoJ
         PTJwkqdfMRLxufDWGVdVIaJ0FN1t6QAXERHgH3c+guWQCpXK9/1jOlEiSP6sNaI1F/GU
         5GrXZqIayEOD4xJf/ajpjYxjBttRBnQx6BL+94HxlRn62gREHMcaYKvSYw3jlOLSnb0S
         wrPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=IfnOO1+SEUKyKQDFwMTXRvfcI+8sw2PMhyHbHUfe+b0=;
        b=Uk6S6ZD+QOiqO+ZAGr3mSV76aYyfWuP0fF/TTbF3AvfMuoil2N+XmriOfEGhiMalpv
         HlU4U+nqhQDvOtN4TQYWGUK6c6jmFK/vHMcmhNvlR5uCuvIOOoqrsqFTuApmnkPS8DPJ
         74vNVu97CcAJT8gfE1bWZXzh1LxKyXFwdVEqfWXtjJpNgEZNmRy8SuJL/pMw9psNX+4g
         yeCRuYU2BMGLrpI9SZUYC1xVTmJaaIi6Wu03N7SGBbV32diKtCwyLjQDyFvo15KXZuUq
         z4W0RLxaMdhNU7CdLfNmFMLN6x/X6RhiD8LfRw6nDVJDk9uD8kZzBC2h2aNXv8cQFYRR
         gSJw==
X-Gm-Message-State: APjAAAWlyK/FYXOT/uC+FJ6lUBO6FV/2/KP+74K8c3RMkw4qTNW8TOqS
        Y76Lq+Cgc7rouzmrkK0fiqNOGgi79CLMB8L8N2E=
X-Google-Smtp-Source: APXvYqz6VLXDFz7lDG/shhTU3YSU5u4Xat8dp1+0nYrzV5cW/niIYw67GPgQkpHnvTM1eZdq+ZuMoyUbY0SVOVJutWk=
X-Received: by 2002:a1c:7211:: with SMTP id n17mr17295842wmc.32.1554736619094;
 Mon, 08 Apr 2019 08:16:59 -0700 (PDT)
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
Date:   Mon, 8 Apr 2019 17:16:47 +0200
Message-ID: <CA+icZUXHx8WXQeZkoCf9cwgdXXZE8AqrFLOvtZMaf8nzGLTMaw@mail.gmail.com>
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

LLD offers these options:

  --check-sections        Check section addresses for overlaps (default)

  --ignore-data-address-equality
                          lld can break the address equality of data

  --ignore-function-address-equality
                          lld can break the address equality of functions

- Sedat -
