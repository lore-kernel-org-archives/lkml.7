Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F75C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 16:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6658021852
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 16:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D16wjhk1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731369AbfDEQL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 12:11:56 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:41130 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfDEQLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 12:11:55 -0400
Received: by mail-vk1-f193.google.com with SMTP id d15so1563944vka.8
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 09:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GOJprSWArwF75lQLSAzQSsIcgxxq7UG+R9S9DkRS3IM=;
        b=D16wjhk1TyIXtEn6++oug9RkB+TDG+Hg2MrVIHdZPLXAv1ij5N8Ng5n2zR/xksroYT
         M425lFW0+58S5PcsYKvq8WRVSJEK5ba2mzO9E6aRY9Ugy5vw6ImkX/ZkDb3xqWa5/0Lm
         QnOm0K/ov9UdBhfoa3KUqTduGhuULSrOmwde4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GOJprSWArwF75lQLSAzQSsIcgxxq7UG+R9S9DkRS3IM=;
        b=CdaoLBU6rKpu/HOUNlVtDYCg93EzBaYpt1ILp+zg7S94KRfVfYw+tpRaU+i7F1i+sy
         ZCkEThikWQatoHZmyEXnX+Tx1pjjuOkGb1H0VA3RC/0/RcAG+GdMYVyn4X49Usxw7EoV
         bLOtgHUd61R9o4rajwIY/H6UKq8tZ/T6LUQcIRWXc5x2bTi/8ZTBDGymqqagoktW+eK7
         jaaaH08SgGbQC/p1ynA7wgSCexx6TKwnxhVezgTDf75TQwUPr7n4BEz5+NS1Kni+Wsgh
         VHec3VQnURTK9yQVzxceUm37ciQUG6CKu2E5p4U1ASJzEaEky+rMVG6jVlKtiPxNN59k
         DTVQ==
X-Gm-Message-State: APjAAAX6XTLcpp5r1qOSWMp6A0xeFnCq1LYBnKCQi6RntTAWCZ/WWPDt
        3Bvfryk65INYTgGJsG6OsZ6cAkWrUcU=
X-Google-Smtp-Source: APXvYqwkXb+kEOaliwarYdg+KZQ/hupwIJOjbS6mkhSQ/QmJKAs6a+GhqDqMLoqeTLCG0XLhPuqHxg==
X-Received: by 2002:a1f:8c94:: with SMTP id o142mr8281164vkd.61.1554480712970;
        Fri, 05 Apr 2019 09:11:52 -0700 (PDT)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id u10sm10537065vku.34.2019.04.05.09.11.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 09:11:51 -0700 (PDT)
Received: by mail-vs1-f44.google.com with SMTP id o10so1212628vsp.12
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 09:11:51 -0700 (PDT)
X-Received: by 2002:a67:76c7:: with SMTP id r190mr8887333vsc.196.1554480710895;
 Fri, 05 Apr 2019 09:11:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNAQw7nPwykOEV5i+yWjkxzgf1gPa5ewFhDxbbn8XXjwFUA@mail.gmail.com>
 <20190402070858.49597-1-ndesaulniers@google.com> <CAK7LNAQGUe0h2ti6_u5=y9KUrNStESdd=D=8K3NOiE08tt022w@mail.gmail.com>
In-Reply-To: <CAK7LNAQGUe0h2ti6_u5=y9KUrNStESdd=D=8K3NOiE08tt022w@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 5 Apr 2019 09:11:39 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKZUP33Kz=nDPkUSj0Ksz5FOYTuuKAxv4N6xGEtFT645A@mail.gmail.com>
Message-ID: <CAGXu5jKZUP33Kz=nDPkUSj0Ksz5FOYTuuKAxv4N6xGEtFT645A@mail.gmail.com>
Subject: Re: [PATCH v3] Makefile: lld: tell clang to use lld
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nathan Lynch <nathan_lynch@mentor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 5, 2019 at 3:17 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> I want to propose alternative solution.
> Please check the attached patches.

In both patches:
> I changed the Makefile to use $(LD) rahter than $(CC). I confirmed
> the same vdso.so.raw was still produced.

typo: rahter -> rather

In the 0001 patch of arch/arm/vdso/Makefile:
> ...
> -VDSO_LDFLAGS += $(call cc-ldoption, -fuse-ld=bfd)
> +ldflags-y = -Bsymbolic --no-undefined -soname=linux-vdso.so.1 \
> +           -z max-page-size=4096 -z common-page-size=4096 \
> +           -nostdlib -shared \
> +           $(call ld-option, --hash-style=sysv) \
> +           $(call ld-option, --build-id) \
> +           -T

I see that "-fuse-ld=bfd" is explicitly dropped here, which could
reintroduce the problem fixed in d2b30cd4b722 ("ARM: 8384/1: VDSO:
force use of BFD linker") (and 3473f26592c1c). Does ld.gold still
exhibit this problem? If so, we'll need to detect gold and force bfd
still maybe?

-- 
Kees Cook
