Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92565C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 08:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7110F20872
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 08:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731322AbfIJIEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 04:04:42 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36376 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfIJIEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 04:04:42 -0400
Received: by mail-qk1-f194.google.com with SMTP id s18so16124085qkj.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 01:04:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GzXrmlpC/CWlmBBx+Mfgp2MIVT6wc9VgoKmM//l5WEM=;
        b=O2i/8iPrx6RirMRyYTfSLLmRMpPyykF2PLIFngT6G7Ly/aVhqg7FLnv7aGaxaJCCAq
         +KSHE9TIi0bHtfBaEP6kN8RuH9AJDYO55G17H3JF6aJZcmClCq3UuhPhy7+OdrTjgh7Y
         DXQQDvIXLYaTGbvjmdnA90I9vxZT5U9gAdsY/9BSyzLIk3B9JctjcCjhIYRfLlsufR3i
         RtqRCmpaBXehI7lC/hOn6HIMh7SVIF2lKanbRf59DL8rZlRQt1aZhfcjmeEi0WjaDQvK
         6OvZsrg3BIHaZjW9OBjNi90TNctfrzetDvvebnMgE2SAyywoHRFpM1Y9nGkscfljIU6x
         t7WA==
X-Gm-Message-State: APjAAAXEZvmB0iZnxl68bLxazNAUttQW8UfS8exEkE+zmdr/iguJIdKq
        GkoecuNQKdimG3s2nN6ox+amb4ckqF1J7lGzwnk=
X-Google-Smtp-Source: APXvYqzLSplLdFdiODSY9yfTz5qDH60T9Dn0ECnz457Q0uMaGHUSG4gHXgLO3t+KJLd8e+iWL8VsXDYM+nFt7bigh6A=
X-Received: by 2002:ae9:ee06:: with SMTP id i6mr7346717qkg.3.1568102680809;
 Tue, 10 Sep 2019 01:04:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190909202153.144970-1-arnd@arndb.de> <20190910074606.45k5m2pkztlpj4nj@willie-the-truck>
In-Reply-To: <20190910074606.45k5m2pkztlpj4nj@willie-the-truck>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 10 Sep 2019 10:04:24 +0200
Message-ID: <CAK8P3a0O8bVLgMzyc9bXb8joy6CZevP4CVn5eEwEPVqAOutDEw@mail.gmail.com>
Subject: Re: [PATCH] arm64: fix unreachable code issue with cmpxchg
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 9:46 AM Will Deacon <will@kernel.org> wrote:
>
> On Mon, Sep 09, 2019 at 10:21:35PM +0200, Arnd Bergmann wrote:
> > On arm64 build with clang, sometimes the __cmpxchg_mb is not inlined
> > when CONFIG_OPTIMIZE_INLINING is set.
>
> Hmm. Given that CONFIG_OPTIMIZE_INLINING has also been shown to break
> assignment of local 'register' variables on GCC, perhaps we should just
> disable that option for arm64 (at least) since we don't have any toolchains
> that seem to like it very much! I'd certainly prefer that over playing
> whack-a-mole with __always_inline.

Right, but I can also see good reasons to keep going:

- In theory, CONFIG_OPTIMIZE_INLINING is the right thing to do -- the compilers
  also make some particularly bad decisions around inlining when each inline
  turns into an __always_inline, as has been the case in Linux for a long time.
  I think in most cases, we get better object code with CONFIG_OPTIMIZE_INLINING
  and in the cases where this is worse, it may be better to fix the compiler.
  The new "asm_inline"  macro should also help with that.

- The x86 folks have apparently whacked most of the moles already, see this
  commit from 2008

   commit 3f9b5cc018566ad9562df0648395649aebdbc5e0
   Author: Ingo Molnar <mingo@elte.hu>
   Date:   Fri Jul 18 16:30:05 2008 +0200

    x86: re-enable OPTIMIZE_INLINING

    re-enable OPTIMIZE_INLINING more widely. Jeff Dike fixed the remaining
    outstanding issue in this commit:

    | commit 4f81c5350b44bcc501ab6f8a089b16d064b4d2f6
    | Author: Jeff Dike <jdike@addtoit.com>
    | Date:   Mon Jul 7 13:36:56 2008 -0400
    |
    |     [UML] fix gcc ICEs and unresolved externs
    [...]
    |    This patch reintroduces unit-at-a-time for gcc >= 4.0,
bringing back the
    |    possibility of Uli's crash.  If that happens, we'll debug it.

    it's still default-off and thus opt-in.

- The inlining decisions of gcc and clang are already very different, and
   the bugs we are finding around that are much more common than
   the difference between CONFIG_OPTIMIZE_INLINING=y/n on a
   given compiler.

             Arnd
