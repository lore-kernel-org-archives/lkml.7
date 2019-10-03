Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 669BBC32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B37E20673
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570122140;
	bh=iqDXiraqN3oESA3HJHj3Drnb3VMZmLoZKiJ7DzLQ8xI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=fR0RFXGVuywhMWbK57mEg4uNdkSrse2GiJN2QJBUpqnGV6mXJskJ+TpxdAxEgZj/u
	 0/X0J71gIAlIB8BsNRBM3yY40E6mJeQdETTe8ppGBKA+fyxZHm8uJUh6zS/UW+L2AT
	 D4iAu3yHD9R6RvvywzCVeZZhdljr0jlQ0DtayKRc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405408AbfJCRCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 13:02:19 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38743 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388566AbfJCRCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 13:02:13 -0400
Received: by mail-lj1-f196.google.com with SMTP id b20so3594882ljj.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 10:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P5wXaF5ZltCgXSM34TOegFWPjTBpFPmOgUeBNVihY4w=;
        b=JKo8Sv2iFH9OWcLRj6EJ0lrBcfCtSlXqHG89kD5Ub09Y0owCLMwh7kGpo40D50FLmA
         8m3gZBLSebpsDzFqxjkVhUIsZ/avu9EVjhD2P/PgJ2J9Q889cf+ojytn85UfifR0QFdJ
         pJM51Bd87EjuNB8rn2bC+8WGyPlYd0s1aUgKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P5wXaF5ZltCgXSM34TOegFWPjTBpFPmOgUeBNVihY4w=;
        b=aVznyWCtF3XWRVCiSNEZtrtQZ4hkDM7jtTaopLQlaXJk+LInk1W0TcNs1os4rc2naI
         IYO/lFFwxD+EXN3pmCHBybvVFeLKGI0GJJ7N+kA2dn6TYWFdWDKzQzOONKrcr6R7XRLt
         Lee631b4zwDXXaWtfJECTo3JkcQRz8EGb6FlxsTErLVS8klk6CmP43V1FG5z/F6WCv3/
         6vpkYVyFWjUIXs8MdyJj5wcpDtrpNUMxUiJ/i0sgw/LjXXy3KTLWfOiNFTfnP+DoQtoa
         kKs4gRd+uh/TLW/nsfKfxtVyn8t9cHYDiT6UMiz1I9qslZ4l8n/PExt881bQjMXCsU1D
         3G2A==
X-Gm-Message-State: APjAAAXSonTHxmQFxUsZX30ntydaZirmPIArAHlJBAlUvBnfVl36F+eO
        IYBgftcwb7SdnC6KdDqwl4I33xfsL0Y=
X-Google-Smtp-Source: APXvYqzzCQGQ+au3QzKIdZVaQziYjEqoPYUhlXYQgatCaEOlkx52JBiQ0HXAJEobESXvRmbd7Mf5Ig==
X-Received: by 2002:a2e:6e0c:: with SMTP id j12mr6574879ljc.55.1570122130967;
        Thu, 03 Oct 2019 10:02:10 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id m15sm644247ljh.50.2019.10.03.10.02.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2019 10:02:10 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id y127so2436801lfc.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 10:02:10 -0700 (PDT)
X-Received: by 2002:a19:2489:: with SMTP id k131mr6216154lfk.52.1570122129934;
 Thu, 03 Oct 2019 10:02:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190930112636.vx2qxo4hdysvxibl@willie-the-truck>
 <CAK7LNASQZ82KSOrQW7+Wq1vFDCg2__maBEAPMLqUDqZMLuj1rA@mail.gmail.com>
 <20190930121803.n34i63scet2ec7ll@willie-the-truck> <CAKwvOdnqn=0LndrX+mUrtSAQqoT1JWRMOJCA5t3e=S=T7zkcCQ@mail.gmail.com>
 <20191001092823.z4zhlbwvtwnlotwc@willie-the-truck> <CAKwvOdk0h2A6=fb7Yepf+oKbZfq_tqwpGq8EBmHVu1j4mo-a-A@mail.gmail.com>
 <20191001170142.x66orounxuln7zs3@willie-the-truck> <CAKwvOdnFJqipp+G5xLDRBcOrQRcvMQmn+n8fufWyzyt2QL_QkA@mail.gmail.com>
 <20191001175512.GK25745@shell.armlinux.org.uk> <CAKwvOdmw_xmTGZLeK8-+Q4nUpjs-UypJjHWks-3jHA670Dxa1A@mail.gmail.com>
 <20191001181438.GL25745@shell.armlinux.org.uk> <CAKwvOdmBnBVU7F-a6DqPU6QM-BRc8LNn6YRmhTsuGLauCWKUOg@mail.gmail.com>
 <CAMuHMdWPhE1nNkmL1nj3vpQhB7fP3uDs2i_ZVi0Gf9qij4W2CA@mail.gmail.com>
 <CAHk-=wgFODvdFBHzgVf3JjoBz0z6LZhOm8xvMntsvOr66ASmZQ@mail.gmail.com> <CAK7LNARM2jVSdgCDJWDbvVxYLiUR_CFgTPg0nxzbCszSKcx+pg@mail.gmail.com>
In-Reply-To: <CAK7LNARM2jVSdgCDJWDbvVxYLiUR_CFgTPg0nxzbCszSKcx+pg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 3 Oct 2019 10:01:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiMm3rN15WmiAqMHjC-pakL_b8qgWsPPri0+YLFORT-ZA@mail.gmail.com>
Message-ID: <CAHk-=wiMm3rN15WmiAqMHjC-pakL_b8qgWsPPri0+YLFORT-ZA@mail.gmail.com>
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

On Wed, Oct 2, 2019 at 7:11 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Macrofying the 'inline' is a horrid mistake that makes incorrect code work.
> It would eternally prevent people from writing portable, correct code.
> Please do not encourage to hide problems.

Honestly, if the alternative to hiding problems is "use a macro", then
I'd rather hide the problems and just make "inline" means "inline".

If "inline" means "it's just a hint, use macros", then inline is useless.

If "inline" means "using this means that there are known compiler
bugs, but we don't know where they trigger", then inline is _worse_
than useless.

I do not see the big advantage of letting the compiler say "yeah, I'm
not going to do that, Dave".

And I see a *huge* disadvantage when people are ignoring compiler
bugs, and are saying "use a macro". Seriously.

Right now we see the obvious compiler bugs that cause build breakages.
How many non-obvious compiler bugs do we have? And how sure are you
that our code is "correct" after fixing a couple of obvious cases?

As to "portable", nobody cares. We're a kernel. We aren't portable,
and never were.

If this is purely about the fact that x86 is different from other
architectures, then let's remove the "compiler can do stupid things"
option on x86 too. It was never clear that it was a huge advantage.

               Linus
