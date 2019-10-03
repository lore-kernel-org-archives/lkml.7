Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF19C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EA2E20830
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570122515;
	bh=CBJzPvyt1+zrY3RnJCyFAcmCfv/Az6AnUlEgasJMdyY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Ovx6VdOgzXKMvOzfxH1QrEuwv4o+ZEWT3zmyIBGu7bdvlR7VBrz6Vl60OjwEJaWoh
	 Y/ZRiR0U0mUq9Mij9TyVIVDs//XsqI/3meLhMBKps8w8fuokztrzTFKPiB27vwYaUR
	 X+YrPdojGx5TH8RPCC++y2ha0DSM2MBr4q7EyGgU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393463AbfJCRIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 13:08:34 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33398 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393437AbfJCRIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 13:08:32 -0400
Received: by mail-lj1-f195.google.com with SMTP id a22so3643395ljd.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 10:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xGPNBFqVYtxez447o7VfzpEEdWGUXuNgcxnMZZtHxhw=;
        b=JQlxhcyH0jHwarYabbpi6wNpJW+TQGKZ3Q/o2mSONQp+edqEcUDbfc+bZRMV+49X8b
         6iqsJ6W2xVarc2Qbqm9lYLbIQOaubfS2b2d2RR4HW+NziK3KAuGvVuwqS5GOwXs3hULK
         jTZNUAkzsyFNJMvYZMy8abMpYXNOFhEkahnBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xGPNBFqVYtxez447o7VfzpEEdWGUXuNgcxnMZZtHxhw=;
        b=oYfeS1MOJvU0l7wacN3BzVdxj//AJwgyhCDy1xddHhvbdL9ThV2VFwtyeGKRxMWGBD
         aCt8ub9Ivuk7/wsBif3iIFS7Vcl66Wctp8vY5ypNesSB8jlfui5nJwWds2TTo5ZUX48Z
         Gz+vK8l1sY7+neYucPpftln7zGEvPZxbTcYC5yzAaLM1KsvjRUKcLRjwxDHEu62OXoOm
         Pr5GUW0WHU7eNhVBgPnszhJF9T4YyEHICyCCmHLCZW/8o9zyB7EMUPZ3F5JIb1Ogj0/k
         xVgq92v342emlgxHnbztP8NzqNxPvKl2Qc+wP8wKon1zC8l4OtaFSAjE8LNyRnyyZSpD
         jAxQ==
X-Gm-Message-State: APjAAAW/9v3Z4smIzWYpdmKvy8xRjI0t+GQ1qgK0JnoKWyX+wduItw9J
        wsbqXVe/Ne9EDO89l9h2tUIged/juKM=
X-Google-Smtp-Source: APXvYqzqMY8b60y4cEPN1JW3g4aYGF4KZ6oD9pfYiP1GZAnS7Z25Y3BXKMiS030byZ5sAwZWyIdS7Q==
X-Received: by 2002:a2e:8199:: with SMTP id e25mr3993242ljg.246.1570122509079;
        Thu, 03 Oct 2019 10:08:29 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id g27sm658951lja.33.2019.10.03.10.08.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2019 10:08:27 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id n14so3579022ljj.10
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 10:08:26 -0700 (PDT)
X-Received: by 2002:a2e:86d5:: with SMTP id n21mr6759265ljj.1.1570122505822;
 Thu, 03 Oct 2019 10:08:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190930112636.vx2qxo4hdysvxibl@willie-the-truck>
 <CAK7LNASQZ82KSOrQW7+Wq1vFDCg2__maBEAPMLqUDqZMLuj1rA@mail.gmail.com>
 <20190930121803.n34i63scet2ec7ll@willie-the-truck> <CAKwvOdnqn=0LndrX+mUrtSAQqoT1JWRMOJCA5t3e=S=T7zkcCQ@mail.gmail.com>
 <20191001092823.z4zhlbwvtwnlotwc@willie-the-truck> <CAKwvOdk0h2A6=fb7Yepf+oKbZfq_tqwpGq8EBmHVu1j4mo-a-A@mail.gmail.com>
 <20191001170142.x66orounxuln7zs3@willie-the-truck> <CAKwvOdnFJqipp+G5xLDRBcOrQRcvMQmn+n8fufWyzyt2QL_QkA@mail.gmail.com>
 <20191001175512.GK25745@shell.armlinux.org.uk> <CAKwvOdmw_xmTGZLeK8-+Q4nUpjs-UypJjHWks-3jHA670Dxa1A@mail.gmail.com>
 <20191001181438.GL25745@shell.armlinux.org.uk> <CAKwvOdmBnBVU7F-a6DqPU6QM-BRc8LNn6YRmhTsuGLauCWKUOg@mail.gmail.com>
 <CAMuHMdWPhE1nNkmL1nj3vpQhB7fP3uDs2i_ZVi0Gf9qij4W2CA@mail.gmail.com>
 <CAHk-=wgFODvdFBHzgVf3JjoBz0z6LZhOm8xvMntsvOr66ASmZQ@mail.gmail.com>
 <CAK7LNARM2jVSdgCDJWDbvVxYLiUR_CFgTPg0nxzbCszSKcx+pg@mail.gmail.com> <CAHk-=wiMm3rN15WmiAqMHjC-pakL_b8qgWsPPri0+YLFORT-ZA@mail.gmail.com>
In-Reply-To: <CAHk-=wiMm3rN15WmiAqMHjC-pakL_b8qgWsPPri0+YLFORT-ZA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 3 Oct 2019 10:08:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=whkB+g0R0JqLB+Y4piUZf9A8P1ugi5T92LjFLNY+epBeg@mail.gmail.com>
Message-ID: <CAHk-=whkB+g0R0JqLB+Y4piUZf9A8P1ugi5T92LjFLNY+epBeg@mail.gmail.com>
Subject: Re: [PATCH] compiler: enable CONFIG_OPTIMIZE_INLINING forcibly
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Stefan Wahren <wahrenst@gmx.net>,
        Kees Cook <keescook@google.com>, Arnd Bergmann <arnd@arndb.de>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 3, 2019 at 10:01 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> If this is purely about the fact that x86 is different from other
> architectures, then let's remove the "compiler can do stupid things"
> option on x86 too. It was never clear that it was a huge advantage.

Side note: what might be an actual advantage would be to have a mode
where you see when the compiler would choose to not inline things.

Maybe we have things that are marked "inline" that simply shouldn't
be. We do tend to have this history of adding small helper functions
to header files, and then they grow and grow and grow. And now they
shouldn't be in a header file any more, but they still are.

So having a "compiler doesn't want to inline this" flag might be
useful for finding those, but it might also be useful for people
looking for what triggers bugs.

But honestly, the last time I saw somebody argue for "I don't want
inlining", it was the broken "I want to compiler the kernel with no
optimizations so that it's easier to look at the resulting code". That
was just a _bad_ bad patch. And if it is concerns like that that are
driving this "compiler doesn't have to inline", then we should stop it
immediately.

             Linus
