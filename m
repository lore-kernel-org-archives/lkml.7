Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D62A7C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF7D420725
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mO2PVhZ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfKNSQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 13:16:12 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:35581 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbfKNSQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 13:16:12 -0500
Received: by mail-vs1-f68.google.com with SMTP id k15so4529087vsp.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 10:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VxmH23UIh9bgluRuYOUap2wtF++JOc1rV8xUaBpEJ7o=;
        b=mO2PVhZ16pDlTlYuVILvi8A75KjsItYV3DeXppoIPq3BwPbsDM/LW+NfkBp7Qk+ax3
         jC42FJ/4QTOWM+agweJCKLTAarRvevGAP+kn1yj3AgK8qbl5zqpNse1lpQSxZLOa8vPK
         LmriK1aIr1Yu4IPoPkCJfA6tn+GqX343TCODAOuTdCTrnSO5apUdtHjQYSL2WZvs6vQ0
         plS2lZ7eC8FbopssHnbg/0ysYBXqdJG1vvakPm9eNgI2fW1zczisBV420GWmv9uq5wri
         8r7K1q+hYCqXDdjNMtVpHMBlhhpI9eX081Y6q9NDpmWpdzMr2SNw3sclCmvXtXzmkRAQ
         T3kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VxmH23UIh9bgluRuYOUap2wtF++JOc1rV8xUaBpEJ7o=;
        b=l/u4qJwdQjWujVKd4SakYWUJ3K9TmWRZqKf9l0YWD5KHJ5N50qT5lJ7BTYYsZf1MxB
         52L6sy31JZ07INhMv6+hu/BPcp9WH15zC5usJlkoEmFkcG01PTy5g4wYpockeLmzfQ0X
         7rbi38yhogkEIJuLx7/GpUVqMczceC1LVs+n+qrKp+esi1K/mFRGMjv+fdHfmw6K15O5
         PFHs2a0LKWRUSQwRA5ZjnXzwPKatUOGdYvqus5I/Id3zC6IsWjxTu05jElAaaoPLyomR
         320P5ZfDN5oo2f8lL4O2bTcc5HvP/Nmq/HiKL1kKWlIATNcb6IW1SYMOALa+2Keo5zDa
         XOgA==
X-Gm-Message-State: APjAAAWbdg0ANBxdwBOqYJolkPcTwUWjVOej4Qn7mAYKA49KVYowvZbN
        XHZBmRQdN+P//aDDhes+qN3qQnUpslQeMpxbOU5bDA==
X-Google-Smtp-Source: APXvYqxRXH/rJzDlko//25OMTKBgGjGCR6O8nuS4Pzy2+D1/twDFtUQrSr+vpmJGm+Wy2gjuADPo9QY7+Ec7wJ2kGjw=
X-Received: by 2002:a05:6102:2041:: with SMTP id q1mr6523378vsr.15.1573755370771;
 Thu, 14 Nov 2019 10:16:10 -0800 (PST)
MIME-Version: 1.0
References: <20191031195705.36916-1-samitolvanen@google.com> <20191114165730.GC5158@willie-the-truck>
In-Reply-To: <20191114165730.GC5158@willie-the-truck>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Thu, 14 Nov 2019 10:15:59 -0800
Message-ID: <CABCJKueJ-J5MPj4-qL230iM3Bu8Qc_4wsViRgt2nJD81_EVJLw@mail.gmail.com>
Subject: Re: [RESEND PATCH v2] arm64: lse: fix LSE atomics with LLVM's
 integrated assembler
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 8:57 AM Will Deacon <will@kernel.org> wrote:
>
> On Thu, Oct 31, 2019 at 12:57:05PM -0700, Sami Tolvanen wrote:
> > Unlike gcc, clang considers each inline assembly block to be independent
> > and therefore, when using the integrated assembler for inline assembly,
> > any preambles that enable features must be repeated in each block.
> >
> > This change defines __LSE_PREAMBLE and adds it to each inline assembly
> > block that has LSE instructions, which allows them to be compiled also
> > with clang's assembler.
>
> Any chance LLVM can be fixed to avoid this bodge in the kernel?

Unfortunately, LLVM developers consider this to be a feature, not a
bug, so it's unlikely that we can change how the integrated assembler
works:

  https://bugs.llvm.org/show_bug.cgi?id=19749

Note that this patch is similar to be604c616ca7 ("arm64: sysreg: Make
mrs_s and msr_s macros work with Clang and LTO"), which worked around
the same issue in the sysreg code.

Sami
