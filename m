Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A717C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F321C206BA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oTjBkYIp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbfCDSKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 13:10:17 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33052 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfCDSKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 13:10:16 -0500
Received: by mail-pg1-f193.google.com with SMTP id h11so3645123pgl.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 10:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lkoxNTZDcsFMaDTSvIUmNcE2tFbmczPzpSYXcIp7qV0=;
        b=oTjBkYIpmbfkPGeQ57WHi7qZ3ZYDjqP3ktujllxjIR4Bdo31IpHkyID0BnACkxPDkF
         SCYJgaCQbJLGafqe3jix+KWEXspDIg2KLH60oas3p+atMqdRQRs2o0JVosEDoB16zLXj
         UgVnHa2kjCacB74Ik5HqW13NLLlU3Urc3fKaLWqT9eqREg3Bv7HDfORcSEDDVk2UAaEj
         35euhzHpXdUla7b8kurkS46ZYFYysieVTp/9wVIIm827gM3tu0FWgA9vF2PYxOhkKfyy
         LIkYf/PbkShHb712bhUkQ5kd4mS4PL1pPcTK9pz46gu2f4lJnTxt8ptt9J2UZWqSREoQ
         DPIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lkoxNTZDcsFMaDTSvIUmNcE2tFbmczPzpSYXcIp7qV0=;
        b=bp6Xe34rwl6tKBKbuEWhPHn3oGJUTgD1+2UHULXA1aLqY6K2iKlE38pgUIDLN0bvMX
         exCe2ED+6TTMa9H3t03LC3Hqu6oXVA2zkcKfnC8YLlBtuXnIH6nYNxKq0YtBj1NpNR3o
         2/nJ9w+/sdpDaEfbMjHba9iURqAt4E1Mzqyimt2u5EATsrhoJdZjwujpZALs+98THGJ2
         NRJwRSm10pBKT5jAxEWZfom3dTcIB6oR2jHTs0ELwmnw2RqEP1rfQDEDovPXe6yxmzV8
         ULa+Vq00BDmWNAbkv0saKsCCZZSGESYAib0vgXVnKuOXT5tZAOAVmdCqoBCVTHPjc/n0
         gC2g==
X-Gm-Message-State: APjAAAVStbttgVn2LoeOxlI7tuXyzUlUNJhmgGbbojXpRKVmgANK0DBJ
        VE75wSNTE41mfJo4YEMWY6QvlemEdvAfIXfdZQ5FtQ==
X-Google-Smtp-Source: APXvYqxzPOQ5O4Q3ezxcwewK1BUDn52WZHpw+GRIko8JkIHV+4W+cCH488IIy5ZcSrcGk41j0FkeT1FkHTJncysk8ac=
X-Received: by 2002:a63:5506:: with SMTP id j6mr19674498pgb.202.1551723015909;
 Mon, 04 Mar 2019 10:10:15 -0800 (PST)
MIME-Version: 1.0
References: <20190302184929.28971-1-louis@kragniz.eu>
In-Reply-To: <20190302184929.28971-1-louis@kragniz.eu>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 4 Mar 2019 10:10:04 -0800
Message-ID: <CAKwvOdnwX=bDivzO6bsj8jtqB39VVvUAPc4cofmVJOQ_OE8=9g@mail.gmail.com>
Subject: Re: [PATCH] x86/KASLR: always return a value from process_mem_region
To:     Louis Taylor <louis@kragniz.eu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        hpa@zytor.com, x86@kernel.org, fanc.fnst@cn.fujitsu.com,
        bhe@redhat.com,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com,
        Jon Flatley <jflat@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 2, 2019 at 10:53 AM Louis Taylor <louis@kragniz.eu> wrote:
>
> When compiling with -Wreturn-type, clang warns:
>
> arch/x86/boot/compressed/kaslr.c:704:1: warning: control may reach end of
>       non-void function [-Wreturn-type]
>
> This function's return statement should probably have been placed
> outside the #endif, so move it there
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/360
> Signed-off-by: Louis Taylor <louis@kragniz.eu>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

-- 
Thanks,
~Nick Desaulniers
