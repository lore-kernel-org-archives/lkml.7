Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52821C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 18:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 167E320857
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 18:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cb/34mFo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfDISML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 14:12:11 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45463 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbfDISMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 14:12:10 -0400
Received: by mail-pl1-f196.google.com with SMTP id bf11so9858518plb.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 11:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yK/ReiU68p6yLLDcuH/19uzJguQ8yZsF+lcd3IFSfvU=;
        b=cb/34mFo7iZzHeSQRgeCSitDZ4yKq0IRE3Rjibizns5eFb8kpPmnjHdVkHUVcfLzMn
         Ff6qOaA9t/QGjfl3MH1cNMjF4NgTDFELEQP2qoOvtghPMNo3wIfRZH9UKdSNgM59NDjy
         VtIDo7BTwEidJH9YcpeXnfeZGWsDJdDSo532a+FEPNN8IhkBqDEI5AgosZcDtlNwzMKm
         q1deBzv55o42yShktHx4nELTDxDcDQixQYRflU5oKYjS9nQii4RrAF8Xz0AM5G5zODVK
         1eeBT3kpGRG5wbykQGH7hO6fewRGLWT3kY1tVbi7pkxkpgfEwoZFb3pYVs8nbGfN5xcY
         mqVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yK/ReiU68p6yLLDcuH/19uzJguQ8yZsF+lcd3IFSfvU=;
        b=H8mzSOS20TadxG/9/S0uzIvMzeLa6JwHW0Ukne+RYUeq6riXzCm6ro5RgcG+l68Cst
         5g3hoXYZB68qfpULYsUT/4M+eoN6fpsx+vvijRhjqxra9tXo+53xOaCDH2a8kf+0Mjnb
         CaXsyl26jkLDUUPinCLg3utpEQw8JGuIOgRIJGTTl8fYrCbkTivN69IyzX6jaIw5olwm
         HUBcgRsxyMuGFqXexZAXZBNyB5ic6qOOiqQfAl6auGLQr5IevJ0uER+4/Q9VDYhnqGkr
         Qt1eNvmiEcqU8H5T6wQguOF29q83KhByIhFnD9Hu1NQNqZs+H7R+c0LeXVmT/n0Dobfz
         Xygg==
X-Gm-Message-State: APjAAAWlqHT2KpHazp1lNynSifb2yQC7wWILK7dYsXwhMYzgKSRyHOOR
        0meaDuhdLBgaC3EDQ/MOtXz52ijQ2pPVt5oJiHGpEg==
X-Google-Smtp-Source: APXvYqzWLLD6OW1OU4pegPjaW4PYwS35X8JxsU9yzhgOALGQYEEz2HsySJTLyG8OEuzJ2nxzWu0JGx2sPpvG1Cii060=
X-Received: by 2002:a17:902:8a8b:: with SMTP id p11mr38611843plo.227.1554833529078;
 Tue, 09 Apr 2019 11:12:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190408212648.2407234-1-arnd@arndb.de> <20190408212648.2407234-3-arnd@arndb.de>
 <20190408220312.GA18333@archlinux-i9> <CAK8P3a39NqQOp+0=WYuWh0UmpH=kEFLKyymNYm8DH-0gx9XaaQ@mail.gmail.com>
 <20190409163049.GA2046@archlinux-i9>
In-Reply-To: <20190409163049.GA2046@archlinux-i9>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 9 Apr 2019 11:11:57 -0700
Message-ID: <CAKwvOd=BGeCoRVDQ7WgMZ0rGXfTawm507_JMC7dMM90Vg1Tr7g@mail.gmail.com>
Subject: Re: [PATCH 03/12] s390: purgatory: pass --target option to clang
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        clang-built-linux@googlegroups.com,
        linux-s390 <linux-s390@vger.kernel.org>,
        Philipp Rudo <prudo@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 9, 2019 at 9:30 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
> It did just occur to me that we added the --target and --gcc-toolchain
> flags to a clang specific variable, CLANG_FLAGS, that has already been
> used by powerpc in commit 813af51f5d30 ("powerpc/boot: Set target when
> cross-compiling for clang"). I assume that could be used here?

I think reusing CLANG_FLAGS is a better approach.

-- 
Thanks,
~Nick Desaulniers
