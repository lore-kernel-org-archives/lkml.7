Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14CB7C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E87BB2073F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfH2Idz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 04:33:55 -0400
Received: from gate.crashing.org ([63.228.1.57]:37820 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727994AbfH2IdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 04:33:19 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x7T8X083006230;
        Thu, 29 Aug 2019 03:33:00 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id x7T8WxRj006229;
        Thu, 29 Aug 2019 03:32:59 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Thu, 29 Aug 2019 03:32:59 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "# 3.4.x" <stable@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] powerpc: Avoid clang warnings around setjmp and longjmp
Message-ID: <20190829083259.GI31406@gate.crashing.org>
References: <20190812023214.107817-1-natechancellor@gmail.com> <878srdv206.fsf@mpe.ellerman.id.au> <20190828175322.GA121833@archlinux-threadripper> <CAKwvOdmXbYrR6n-cxKt3XxkE4Lmj0sSoZBUtHVb0V2LTUFHmug@mail.gmail.com> <20190828184529.GC127646@archlinux-threadripper> <CAKwvOd=wdscd7smcKZk40zD_n1OUVkhYYd7ZnoK8r1Y+pkvYVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=wdscd7smcKZk40zD_n1OUVkhYYd7ZnoK8r1Y+pkvYVg@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 03:16:19PM -0700, Nick Desaulniers wrote:
> That's a good reason IMO.  IIRC, the -fno-builtin-* flags don't warn
> if * is some unrecognized value, so -fno-builtin-setjmp may not
> actually do anything, and you may need to scan the source (of clang or
> llvm).

-fno-builtin-foo makes the compiler not handle "foo" the same as it
handles "__builtin_foo".  If the compiler has no idea about "foo", well,
that is exactly what it does then anyhow, so why would it warn :-)


Segher
