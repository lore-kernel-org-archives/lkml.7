Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C8EC10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 13:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D6C92087C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 13:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfCMNtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 09:49:09 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45792 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbfCMNtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 09:49:08 -0400
Received: by mail-qt1-f193.google.com with SMTP id v20so1885249qtv.12;
        Wed, 13 Mar 2019 06:49:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C3CKkB/7KlH0ZdcOwL1bvW5xkfXgNYTIAL9rR1eKEEc=;
        b=f+1CjLYZgABM/Ya908laagsjwsXAoQTJU5Ty/O0FjDPvPbeF0rvK0gdgevUceuGtM+
         zJSKJR0MG9NUuREsl1ZXp5ETX0LVcE1ZPdQklf+e8NyGZGxDOIom4NIGDmCSdigB3Ud5
         1efv149BNz23mUj28R4Bmoh5jMelhbJugKpZvS99fFONwdnh4o1F5JuMAsAmhEJYEBn1
         p7kjJcoQ2UAgZhK+nCrnFDGCmVfIjDtBT3A4HThlf08GerI2B3Su6WYWeH1zjuHJsSLe
         RVUikr74l9eRnkdGZBmmNcRJ+v1Yqod0tYwQUBNqADXWSxFOheTPaPC3QweHOiDFhoRR
         fuTw==
X-Gm-Message-State: APjAAAU0mUVv6SZbmLjDTCjXvW7P91Jfbdy5T0avmx4OUOTxcY3ygu9F
        0UlqiiSRJ69halk0BAM5tCnLcyAfZX3rugXto3MrpACY
X-Google-Smtp-Source: APXvYqzVU8yksv0rJ++L4sJHQ0TCeBwnJwuFC607WzzWriTyZx+I4U7OJz7OITCjW4mdtXsE3ZE5sWjTY6Rtq2WZP7A=
X-Received: by 2002:ac8:445a:: with SMTP id m26mr34013603qtn.212.1552484947562;
 Wed, 13 Mar 2019 06:49:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190312215203.27643-1-natechancellor@gmail.com>
 <80fb5b7f-42f9-4fd1-00cf-bfa7965ff8f7@rasmusvillemoes.dk> <20190313134447.GA19066@archlinux-ryzen>
In-Reply-To: <20190313134447.GA19066@archlinux-ryzen>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 13 Mar 2019 14:48:49 +0100
Message-ID: <CAK8P3a344k=MDAX-d21U4+H+mv7Vcd9YhAN4NPEJm1CXv76tkw@mail.gmail.com>
Subject: Re: [PATCH] Makefile: Add '-fno-builtin-bcmp' to CLANG_FLAGS
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        James Y Knight <jyknight@google.com>,
        clang-built-linux@googlegroups.com,
        "# 3.4.x" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 2:44 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
> On Wed, Mar 13, 2019 at 09:13:11AM +0100, Rasmus Villemoes wrote:
> > Wouldn't it be better to just define bcmp as an alias for memcmp? They
> > seem to have compatible prototypes, and then somebody might someday sit
> > down and implement some word-at-a-time version of bcmp making use of the
> > weaker guarantees about the return value to gain some performance. But I
> > suppose that can also be done later.
>
> Thank you much for the review, I didn't even realize this was possible :)
>
> I'd certainly like to explore it as that is what glibc does. How would
> you suggest going about it here?

I suggested a possible implementation (likely contains bugs) and
an alias for architectures that require strict alignment, see
https://bugs.llvm.org/show_bug.cgi?id=41035#c11

We could start out with just the alias.

       Arnd
