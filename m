Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9169DC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61E4B215EA
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="I8IES4vN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbfH2Sm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 14:42:29 -0400
Received: from mail.skyhub.de ([5.9.137.197]:36808 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728061AbfH2Sm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 14:42:29 -0400
Received: from zn.tnic (p200300EC2F0D0C00900D2DBE0F932EDD.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:c00:900d:2dbe:f93:2edd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 006101EC0A9C;
        Thu, 29 Aug 2019 20:42:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1567104147;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=JILc7dKyp7SkywcuYgBtqa757bPtRNzeLCwcvrp1BWE=;
        b=I8IES4vN/ocyX8rwm8qs8F/7m/gGvf8VavvgXe2WHNmvNCOejPGqJYb/MtWnsp63s0F/Zz
        fWCuD+9F8U7MV8QEU+yw6t7Qic2h16ROti+Rt28oSUc3kGMtmkaQ6P1kDwcZZMlYQCQWdQ
        AOSDfroT2zrr6CKgLk6UUvTX4ABvINg=
Date:   Thu, 29 Aug 2019 20:42:22 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Nadav Amit <namit@vmware.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Joe Perches <joe@perches.com>
Subject: Re: [RFC PATCH 0/5] make use of gcc 9's "asm inline()"
Message-ID: <20190829184222.GE1312@zn.tnic>
References: <20190829083233.24162-1-linux@rasmusvillemoes.dk>
 <CAKwvOdnUXiX_cAUTSpqgYJTUERoRF-=3LfaydvwBWC6HtzfEdg@mail.gmail.com>
 <CAHk-=wgZ7Ge8QUkkSZLCfJBsHRsre65DkfTyZ2Kt5VPwa=dkuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgZ7Ge8QUkkSZLCfJBsHRsre65DkfTyZ2Kt5VPwa=dkuA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 11:15:04AM -0700, Linus Torvalds wrote:
> Un-inlining a function because it contains a single inline asm
> instruction is not productive. Yes, it might result in a smaller
> binary over-all (because all those other non-code sections do take up
> some space), but it actually results in a bigger code footprint.

... and also, like one of the gcc guys said at the time, we should be
careful when using this asm inlining, because, well, if we inline it
everywhere just like always_inline functions and the code footprint
grows considerably, then we get what we deserve.

So the onus is on us to keep such sequences small.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
