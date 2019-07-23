Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 645FCC76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 19:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A1AD218F0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 19:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OEzb7gGP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391725AbfGWTqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 15:46:16 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43936 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730061AbfGWTqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 15:46:15 -0400
Received: by mail-pg1-f196.google.com with SMTP id f25so19912389pgv.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 12:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yLR1IEUF9smKIXSeqsJgIaoPu1I/Qbict5TqpOq0grk=;
        b=OEzb7gGPyUr2tDUQtfVCGAZi9F2LZXjFJw93TexBhe2LNhuHxXKlQbHVxpvtHjusRT
         /mOFZGjntgxQY2mvjZNl795aI/HxWw0emAmYBzXGkLksN9Y44HZR4pJKCkt735N4AqlX
         9+EYfF850i8kBjcid6qXpC0+ejnrYfZKEEBbjcgDiCy6fpF4m0xIjKBzrXOYOXxHAL5u
         f4OMG8XxExEG0EsrEdIwX7cUFe02saw9UoJxrCuzbOh+wpjH1F7Ohv42AU2HS8OM9bgr
         ZLuSWiWMdJKzy0akic6LrjNk+cszKIrDvPYTAW97UPAUxTXM8bep/yIZrRNgRp855sL3
         sJPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yLR1IEUF9smKIXSeqsJgIaoPu1I/Qbict5TqpOq0grk=;
        b=p277/WCSVbG9qiAIlgwnNXtLE70n3f6tV3+pFtay/UM8rgnEz7hd8t6P6B3b1cLTvN
         i/ZZOJthIY2C/IIC+UnibAbdn8K9guT+4JRcZ8FDabrJECyT4x21F3lUYnzy3wlo2T3+
         CUY6oHf+YIWx5qc+gXnv5ilmJG/UXqQRVGdB29rc9Q63WJ3RHgcd7+95E2UqRwOnnf1J
         L4RcCBQPVfkn3/Knl5VpVIWpYkxCximIaYotcmQxFLoZSYzxM5gwM6mNTEmgNUDO6zzB
         OFxZHqgC2Lio0onheyPQz+AHfsjdAqzTBIjso9Sbb5oK/dK98e4vdISIMX5vv9OKT29q
         PQ/A==
X-Gm-Message-State: APjAAAVA9JPazzT8l7VHJ5hhDH4RmkCQ0i0lIJwHNwOz6weIGhpGm33J
        hQZvbPdRayHcj2sKgTVZGm/YK1YgppFxrPGlc6/p3Q==
X-Google-Smtp-Source: APXvYqzZEU5Hin+LbqN9DGjb93oPJLDuMr7X4qPiSEeSqFSKuCN2l7BflS43/2Px64EkKThdfW02uEW/JQB2vTngufc=
X-Received: by 2002:a17:90a:2488:: with SMTP id i8mr82316935pje.123.1563911174307;
 Tue, 23 Jul 2019 12:46:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190721085409.24499-1-k0ma@utam0k.jp> <CAK7LNARBjkYHkmv1michYYMd-2_70d+-Gvg1Kv4FyPeeBShvdw@mail.gmail.com>
 <20190723162840.GA7110@gmail.com>
In-Reply-To: <20190723162840.GA7110@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 23 Jul 2019 12:46:02 -0700
Message-ID: <CAKwvOdkGH3nrgszJktzbe5NYYx21QuTUSh_7re4oWPhabnyLRQ@mail.gmail.com>
Subject: Re: [PATCH] .gitignore: Add compilation database files
To:     Toru Komatsu <k0ma@utam0k.jp>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 9:28 AM Toru Komatsu <k0ma@utam0k.jp> wrote:
>  I'm begginer because this patch is my first time,
>  What should I do next?

https://nickdesaulniers.github.io/blog/2017/05/16/submitting-your-first-patch-to-the-linux-kernel-and-responding-to-feedback/

TL;DR
<edit file>
$ git commit <file> --amend
$ git format-patch -v2
<resend>
-- 
Thanks,
~Nick Desaulniers
