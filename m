Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82ABCC4CED1
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5608020830
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570123786;
	bh=QGeozehB18NxcCkyfYqnxXbStaIMKUEBAeYjYYNc+NM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1QndydU957/M9+v7Nde+8LIJ3zlX+yVRpmXK0J8vC6UL3+pg2vJmiin4rhko2DsUH
	 Pp1ggZK98IRfzYBDcPdq/v+cNxeRJUQgl4Aa7h12UTh62O/orzDyYp1FWKDUl5+YhX
	 +3zFGMDeLfp0XzGh3F3FNX4+lexUguiU4eGwVgXY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730736AbfJCR3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 13:29:45 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33842 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730558AbfJCR3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 13:29:43 -0400
Received: by mail-lf1-f67.google.com with SMTP id r22so2488973lfm.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 10:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8ZVEazC37+BdYsUUwYDYhErEg09v7WhRGEkqCbHO0ks=;
        b=RPXZgCaexY2Zm6d9kF62WZV2HjWT9s5h167SaV6Ngphi1rMoYR5sDMd7JP8nFxcvYF
         Eh4EV5kyIIxb7dH3ZX7onDXYIrgX6swFRJoYDqwN7BI9I/QqzG6azoIIoIa4evdilqxu
         0mEQ0+Fig1AOcYuhpzqpY17x0W0NtiJ8K/bx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8ZVEazC37+BdYsUUwYDYhErEg09v7WhRGEkqCbHO0ks=;
        b=bOysl/DHEiH1u1jePUyIlB3kasliDO8RxlRBbMc80Pxn7eISduLzZ1PUsgaOZb8e7Y
         TznNMO7b1i+6hOFNvn2uED3QnZTRJjJwxxgveUUSn0dmEbBhzFRkL80uNkMDWZzH1ziK
         7Ju5bqX3qmB7gMU9YL7k7sBFP8bPxGK7H2G3F0swsXdmX+aBCI9mioCo/LN5cCd7rTGr
         UU9S0/lv8Nk1rDcBiV+LR0bKrQurzyCgvqGcLJ4hKN6U7ArFEI/zEXgShelpKduEbABb
         mD7SSnw7AvJ2ZN0LB8oIYXj+M6uZjb2K5qolZVnpKfrDyz3vFrVexc6bBvcmEnlJpO5q
         Nc/Q==
X-Gm-Message-State: APjAAAWH2K8P3BaWZVq+pvF9UB6Czj268SXfER2E2md4IgMaxtr2QOaX
        TJJ8agZVCqqZtmRWZSg1hNz5QBTFYis=
X-Google-Smtp-Source: APXvYqySGpa9YqXEGaXK4qiQBELLkq3ar6hDwxIs/hBA07QUzW2/CE89VajNWRNkmbVt42641u/AQA==
X-Received: by 2002:ac2:4a8f:: with SMTP id l15mr6501282lfp.21.1570123780236;
        Thu, 03 Oct 2019 10:29:40 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id z20sm781495ljk.63.2019.10.03.10.29.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2019 10:29:38 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id q64so3644617ljb.12
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 10:29:38 -0700 (PDT)
X-Received: by 2002:a2e:86d5:: with SMTP id n21mr6811909ljj.1.1570123777769;
 Thu, 03 Oct 2019 10:29:37 -0700 (PDT)
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
 <CAK7LNARM2jVSdgCDJWDbvVxYLiUR_CFgTPg0nxzbCszSKcx+pg@mail.gmail.com>
 <CAHk-=wiMm3rN15WmiAqMHjC-pakL_b8qgWsPPri0+YLFORT-ZA@mail.gmail.com> <CAK7LNATSoOD0g=Aarui6Y26E_YB035NsaPpHxqtBNyw0K0UXVw@mail.gmail.com>
In-Reply-To: <CAK7LNATSoOD0g=Aarui6Y26E_YB035NsaPpHxqtBNyw0K0UXVw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 3 Oct 2019 10:29:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj9Dbom1x7qDfrXgNbjdFa_84bAUMdGigs4sELQQW28wg@mail.gmail.com>
Message-ID: <CAHk-=wj9Dbom1x7qDfrXgNbjdFa_84bAUMdGigs4sELQQW28wg@mail.gmail.com>
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

On Thu, Oct 3, 2019 at 10:24 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> I just want to annotate __always_inline for the case
> "2. code that if not inlined is somehow not correct."

Oh, I support that entirely - if only for documentation.

But I do *not* support the dismissal of the architecture maintainers
concerns about "does it work?" and apparently known compiler bugs.

> Again, not saying "use a macro".

Other people did, though.

And there seemed to be little balancing of the pain vs the gain. The
gain really isn't that obvious. If the code shrinks by a couple of kB,
is that good or bad? Maybe it is smaller, but is it _better_?

            Linus
