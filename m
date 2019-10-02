Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE7FC10F14
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 20:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEDDD21783
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 20:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570049180;
	bh=kcx2dv/f2bzZ/7CFtrhKgQS8lyZd1xmVuGcGgdVi1BM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=s0outN912OCTwb+H06ywCB1oa42oxqU7QbZmCHdQ+VqHYOy7hvhFE/r3yul6EAUyT
	 jilCJFCPpIH6OhyuiI/KYL8NtfuhkPOUtwlvo4EnU/6YRTywOIhM+51SWfZeTU4Olj
	 12Yg+FrKJ7aR+0HQnuCVy22al0fq9ABzkJnIgxzk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbfJBUqU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 16:46:20 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42335 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727875AbfJBUqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 16:46:19 -0400
Received: by mail-lj1-f194.google.com with SMTP id y23so268175lje.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 13:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CZoX6/kAyBlNzPm3PxVJHHET8XR6oaEdHzpQ1JHxlxk=;
        b=WgH48i53OT8OxyAS10xRgTGen79hUl3stcfXDufRhIUV4G8traFDMLYOcDbmARGtri
         tU39pf48gI+/cvvec8i+m09klNO/DTKi0Xs0KDdSSGqqIUqlnGTnz+5xBoxTqitRtY8f
         KX6a88Kh0m0W4klfZBa6hR0r/gM5QP+f5tEIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CZoX6/kAyBlNzPm3PxVJHHET8XR6oaEdHzpQ1JHxlxk=;
        b=Ueuoz+9gDD7U+W/hdlxBc2VpPCbnYpKprpFqmGDg/FKrArJk1E4tCBqjkoNQy6VJyR
         uhG1t0bZb8zkVDsZKGxFv/tPHZy1u1f1q1vQxN6vIBYOmZQ1LMuoOznD5xJK9dopBbvc
         Zl+SR61rUo1QZlhC+l2JRv9xBRjZc5ulyFKwcCx3fZ0axANV45KpYDGboFgKOpBahZ8p
         UuV8Nr31+DzlmHPrK1KOdVU2NjWw7hf819u+TZt/7au3fe/6psjTlRw9YuQej/OJbuCk
         U9VP/7oDtmt4uPeNS1uzFI6cvOeLhdfMgORiLjcqf6UI6MQpIbQif1hEpraqL0+9Fotm
         ZepA==
X-Gm-Message-State: APjAAAWnAgyiyDPjBBbD14kqctvCZvQQAs8YakOYEBr4srcI5N4H7dU7
        nwL1qgK8OMJCXPNaqv/0rQIGHI/VjRU=
X-Google-Smtp-Source: APXvYqyWRYucdmohIUxBgGSVEGGQ+Bf4KdIeyVRObbB0lGx3o19quydB6d3iMcmHg8eNl6jFXGpt/g==
X-Received: by 2002:a2e:1b5c:: with SMTP id b89mr3756710ljb.182.1570049177615;
        Wed, 02 Oct 2019 13:46:17 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id o15sm34565lff.22.2019.10.02.13.46.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2019 13:46:17 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id d17so97693lfa.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 13:46:17 -0700 (PDT)
X-Received: by 2002:ac2:47f8:: with SMTP id b24mr3502326lfp.134.1570048796885;
 Wed, 02 Oct 2019 13:39:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190930112636.vx2qxo4hdysvxibl@willie-the-truck>
 <CAK7LNASQZ82KSOrQW7+Wq1vFDCg2__maBEAPMLqUDqZMLuj1rA@mail.gmail.com>
 <20190930121803.n34i63scet2ec7ll@willie-the-truck> <CAKwvOdnqn=0LndrX+mUrtSAQqoT1JWRMOJCA5t3e=S=T7zkcCQ@mail.gmail.com>
 <20191001092823.z4zhlbwvtwnlotwc@willie-the-truck> <CAKwvOdk0h2A6=fb7Yepf+oKbZfq_tqwpGq8EBmHVu1j4mo-a-A@mail.gmail.com>
 <20191001170142.x66orounxuln7zs3@willie-the-truck> <CAKwvOdnFJqipp+G5xLDRBcOrQRcvMQmn+n8fufWyzyt2QL_QkA@mail.gmail.com>
 <20191001175512.GK25745@shell.armlinux.org.uk> <CAKwvOdmw_xmTGZLeK8-+Q4nUpjs-UypJjHWks-3jHA670Dxa1A@mail.gmail.com>
 <20191001181438.GL25745@shell.armlinux.org.uk> <CAKwvOdmBnBVU7F-a6DqPU6QM-BRc8LNn6YRmhTsuGLauCWKUOg@mail.gmail.com>
 <CAMuHMdWPhE1nNkmL1nj3vpQhB7fP3uDs2i_ZVi0Gf9qij4W2CA@mail.gmail.com>
In-Reply-To: <CAMuHMdWPhE1nNkmL1nj3vpQhB7fP3uDs2i_ZVi0Gf9qij4W2CA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 2 Oct 2019 13:39:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgFODvdFBHzgVf3JjoBz0z6LZhOm8xvMntsvOr66ASmZQ@mail.gmail.com>
Message-ID: <CAHk-=wgFODvdFBHzgVf3JjoBz0z6LZhOm8xvMntsvOr66ASmZQ@mail.gmail.com>
Subject: Re: [PATCH] compiler: enable CONFIG_OPTIMIZE_INLINING forcibly
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
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

On Wed, Oct 2, 2019 at 5:56 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> >
> > Then use the C preprocessor to force the inlining.  I'm sorry it's not
> > as pretty as static inline functions.
>
> Which makes us lose the baby^H^H^H^Htype checking performed
> on function parameters, requiring to add more ugly checks.

I'm 100% agreed on this.

If the inline change is being pushed by people who say "you should
have used macros instead if you wanted inlining", then I will just
revert that stupid commit that is causing problems.

No, the preprocessor is not the answer.

That said, code that relies on inlining for _correctness_ should use
"__always_inline" and possibly even have a comment about why.

But I am considering just undoing commit 9012d011660e ("compiler:
allow all arches to enable CONFIG_OPTIMIZE_INLINING") entirely. The
advantages are questionable, and when the advantages are balanced
against actual regressions and the arguments are "use macros", that
just shows how badly thought out this was.

                Linus
