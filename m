Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C64C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 18:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDA7A222BF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 18:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZEu6MqIW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfKRSb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 13:31:56 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:35437 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfKRSb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 13:31:56 -0500
Received: by mail-pj1-f66.google.com with SMTP id s8so1732594pji.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 10:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A4WMyPwwd33AeWG8Iqc5mgyWoDalMpSQTRsm3rGqwlk=;
        b=ZEu6MqIWF1RGB6jwTdYhgHtxhAATdk1ygV/D13/7aMyuBRUAxpL9gDOKnW1YPM/nX7
         23u6A7lrO4lGUJ27TFnoXF0lqTyFkMa05WMr53EPub91ytz47wsBRy2Cg8xJlmXJ8izw
         BFPtLFmh8TGgmhhfVC4M62Z9fJihEG6wvlR3doCWpGCqfc4YFyMjeQW0+WI0OQOGVJFH
         yol3VAr89WnKHDukq6EJzwO2GWv34IvLeTpiMiwew+8CRmTopaeVu8/tozDTVeiudldZ
         gLk/LVTPoDXoQpARKeLAB7WZme2//ckYXuDhm6shpmQ+YoksNdJYGpL9y7ZAReWpLH9n
         /m4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A4WMyPwwd33AeWG8Iqc5mgyWoDalMpSQTRsm3rGqwlk=;
        b=pGcYb8rrpwNQWpibnkXD3eyZSPaEpmabSHpoiaT2ZMjWyNehNvecYhswW3bidNo0Rd
         ZUoRSXbOWnEU4Fg09nl8SS/4sc74YSPi239Wb0VGhuRdPk7zwrGHUb21/UUQDMt3h2A5
         SbsQdtgTQlmvgazpAox6lvDeL1ovgNm7Qhcx2wVBQjlbWx512bV9PQfGylN5AIXOiHTS
         2AIP4+dUi7bdKdJo9fOgGP8D3bywgE50jxtLM0G88Am5dmsB61LaR1PjIyhmeWHjiyhk
         zFDZS9h4awQLlQM14KIM1nrjBEkyHlsfuImvlcLK/B9UIgx4bCRITYO9fdLa4qrkL9d6
         rkJg==
X-Gm-Message-State: APjAAAWNfCfHrLpbGvtlE3TcuGI3MEm4ye/QhN5QFRVTgOO89mn5uaDw
        rYaokt9pxTuI1RgHuczGPdkSV2JKhui+n9lNgqXMcg==
X-Google-Smtp-Source: APXvYqx8XiO2tBbSITPF018kWtOJPDBA1kHDVcmrihBshjIKcmexjBxYou1Oyuo1WIXr2rOeMVvKtkImAr+5wZvRChk=
X-Received: by 2002:a17:90a:1f4b:: with SMTP id y11mr418957pjy.123.1574101915060;
 Mon, 18 Nov 2019 10:31:55 -0800 (PST)
MIME-Version: 1.0
References: <20191031194652.118427-1-samitolvanen@google.com> <20191114165544.GB5158@willie-the-truck>
In-Reply-To: <20191114165544.GB5158@willie-the-truck>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 18 Nov 2019 10:31:44 -0800
Message-ID: <CAKwvOdnwL8cXGDykq4YAQi4bXYc7Fccqm-ki61-nySP0h+8ZxQ@mail.gmail.com>
Subject: Re: [RESEND PATCH] arm64: fix alternatives with LLVM's integrated assembler
To:     Will Deacon <will@kernel.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Jian Cai <jiancai@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 8:55 AM Will Deacon <will@kernel.org> wrote:
>
> Hi Sami,
>
> Sorry -- I thought I'd already replied to this, but it had actually
> slipped through the cracks.
>
> On Thu, Oct 31, 2019 at 12:46:52PM -0700, Sami Tolvanen wrote:
> > LLVM's integrated assembler fails with the following error when
> > building KVM:
> >
> >   <inline asm>:12:6: error: expected absolute expression
> >    .if kvm_update_va_mask == 0
> >        ^
> >   <inline asm>:21:6: error: expected absolute expression
> >    .if kvm_update_va_mask == 0
> >        ^
> >   <inline asm>:24:2: error: unrecognized instruction mnemonic
> >           NOT_AN_INSTRUCTION
> >           ^
> >   LLVM ERROR: Error parsing inline asm
> >
> > These errors come from ALTERNATIVE_CB and __ALTERNATIVE_CFG,
> > which test for the existence of the callback parameter in inline
> > assembly using the following expression:
> >
> >   " .if " __stringify(cb) " == 0\n"
> >
> > This works with GNU as, but isn't supported by LLVM. This change
> > splits __ALTERNATIVE_CFG and ALTINSTR_ENTRY into separate macros
> > to fix the LLVM build.
>
> Please could you explain a bit more about the failure and why LLVM's
> integrated assembler rejects this?

There are currently more than one issue with `.if` assembler
directives we're tracking against Clang's integrated assembler
currently, particularly around the handling of special cases related
to "fragments."
Recommended reading:
https://eli.thegreenplace.net/2013/01/03/assembler-relaxation
This particular case looks like the error is related to referring to
section before it has been seen.  My current understanding is that
Clang's integrated assembler is one pass, unlike GAS, so it chokes on
references to symbols it has not yet seen.

> Could we use something like .ifb or
> .ifeqs instead?
>
> Thanks,
>
> Will



-- 
Thanks,
~Nick Desaulniers
