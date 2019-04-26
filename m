Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5640C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 13:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F79D2067D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 13:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bECapwQA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbfDZNAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 09:00:21 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33213 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfDZNAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 09:00:20 -0400
Received: by mail-ed1-f66.google.com with SMTP id d55so1249074ede.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 06:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Tv8k1IVq/bX2qC7pmlkXFVlPj0xCG5NKC7lZ4m2BLq8=;
        b=bECapwQApPKcPhJL9GJXfilDKWtVLuZXVHOLzL/u/PjH258XPaJ71Hy8yfICZndGtr
         DiSXGiOAzXwSliq9a5k+L8fRfGLniIDz5JvNk29HgXChs3LvAdatSwU25BOe3N4dqRg6
         u1A7kodCe4w7nfAgDDEGWoem46hp6hQ9dpEo3mwLcjgHMYtGs0Wv3p1PtIeQLC92+do4
         5ZzjYc09Zn3HR69LnsE52Kf4A4TSoe/JIZsu/6ur7TW9RG+qIakhBxM7e1hGpiPm3FcI
         F9QmlmxTJDEk3xefe+cAG4uhtRej4uneUc22+/9ydZ3/idrih2SWs/DZddZzGIKmmrqH
         Wk7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Tv8k1IVq/bX2qC7pmlkXFVlPj0xCG5NKC7lZ4m2BLq8=;
        b=n8vC8dmxEZ4sRlrUQlGA9VwCRUTUfRJ0qOVYS67i8wY1LlDhSvmAeCNTm15zjxsdyU
         a04s41H4v/IZVnzfnfELTTcYJa7p81703WkTsNNma+NBvfLCcB0Gahr+7p6OLRePNqFO
         p9ru1AztZub+6Vj9KQvRv3z/DDdiTodcSPXrX73BJ4CcaI/7FIG7SQvihbAHRK5GDD0y
         d0Ouynvl+sMq/VcUQTkBqPIpTpVlcOYmt+cH5HemwZOU9wj/5HplCwX0R3e0pjS4zclx
         SKkBpIMV3USegwdrbj9FIdrniIvC1lfuV1ti0BWWqcpb5xRItQsyZSm4XbIPdaLv2FMd
         gCKA==
X-Gm-Message-State: APjAAAWkCXnjSvF/ZmNxTRxMCQcsIsmOIRs7kiGyB8QN3y5M9R4m7TiT
        UBKK/BSFZr8wYMZPb8AvHhE=
X-Google-Smtp-Source: APXvYqwRy1eph5ZK/zVsF8C+hIBBBKlKu8slDTMOoC+bh0BAPuhQ2vTzNQB70JubpAByNlo2VxXe1g==
X-Received: by 2002:a50:ad11:: with SMTP id y17mr28135238edc.184.1556283618973;
        Fri, 26 Apr 2019 06:00:18 -0700 (PDT)
Received: from archlinux-i9 ([2a01:4f9:2b:2b84::2])
        by smtp.gmail.com with ESMTPSA id v9sm7058960ede.32.2019.04.26.06.00.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Apr 2019 06:00:17 -0700 (PDT)
Date:   Fri, 26 Apr 2019 06:00:15 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Jason Baron <jbaron@akamai.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH 09/10] arm64: select DYNAMIC_DEBUG_RELATIVE_POINTERS
Message-ID: <20190426130015.GA12483@archlinux-i9>
References: <20190409212517.7321-1-linux@rasmusvillemoes.dk>
 <20190409212517.7321-10-linux@rasmusvillemoes.dk>
 <CAK8P3a1by1-ZF2NoTdGbxv+AJu92d3Sp5L08BhLCA+0PNS8s2Q@mail.gmail.com>
 <94b816aa-ad36-75e6-8782-d141dec2e803@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94b816aa-ad36-75e6-8782-d141dec2e803@rasmusvillemoes.dk>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 12:05:57PM +0200, Rasmus Villemoes wrote:
> On 26/04/2019 11.39, Arnd Bergmann wrote:
> > On Tue, Apr 9, 2019 at 11:26 PM Rasmus Villemoes
> > <linux@rasmusvillemoes.dk> wrote:
> >>
> >> Similar to GENERIC_BUG_RELATIVE_POINTERS, one can now relativize the
> >> four const char* members of struct _ddebug, thus saving 16 bytes per
> >> instance (one for each pr_debug(), dev_debug() etc. in a
> >> CONFIG_DYNAMIC_DEBUG kernel). The asm-generic implementation seems to
> >> work out-of-the-box, though this is only compile-tested.
> >>
> >> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > 
> > This causes a build regression when compiling with clang,
> > see http://staging-storage.kernelci.org/next-clang/master/next-20190424/arm64/allmodconfig/clang-8/build.log
> 
> Yes, see also https://github.com/ClangBuiltLinux/linux/issues/456 .
> 
> The quickest short-term fix is to append "if CC_IS_GCC" to the select
> statements. Then when a fix lands in clang one can change that to "if
> CC_IS_GCC || CLANG_VERSION >= something". It's probably best if we fix
> -next builds ASAP instead of waiting for knowing the proper value of
> "something". Nathan, Nick, WDYT?

Those select statements have to be added regardless, we might as well do
it now. It should unbreak the auto builders because they use the latest
clang stable version, which is 8.0.0.

For the record, the fix in Clang is https://reviews.llvm.org/D60887 and
should land shortly unless there are any further objections, meaning
this will be fixed in the 9.0.0 release.

'if CC_IS_GCC || CLANG_VERSION >= 90000' should do it on the arm64 and
powerpc select statements (x86 works fine because %c support has always
been present).

> 
> I had 0day verify my patches before sending them out officially, and
> thought it also did clang builds. But apparently not, or not with enough
> arch/.config combinations?

They do not do clang builds unfortunately. Nick was in contact with them
before forced asm-goto on x86 happened and derailed that.

We try to do our own tests and let people know when stuff breaks but
that is usually after it hits -next, rather than the mailing list.

> 
> Rasmus

Cheers,
Nathan
