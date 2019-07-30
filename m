Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E8FC41514
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45B75206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:07:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729111AbfG3RHw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 13:07:52 -0400
Received: from gate.crashing.org ([63.228.1.57]:41566 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728647AbfG3RHv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 13:07:51 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x6UH7TlS016550;
        Tue, 30 Jul 2019 12:07:29 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id x6UH7SxN016549;
        Tue, 30 Jul 2019 12:07:28 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Tue, 30 Jul 2019 12:07:28 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild test robot <lkp@intel.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Paul Mackerras <paulus@samba.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] powerpc: workaround clang codegen bug in dcbz
Message-ID: <20190730170728.GQ31406@gate.crashing.org>
References: <20190729202542.205309-1-ndesaulniers@google.com> <20190729203246.GA117371@archlinux-threadripper> <20190729215200.GN31406@gate.crashing.org> <CAK8P3a1GQSyCj1L8fFG4Pah8dr5Lanw=1yuimX1o+53ARzOX+Q@mail.gmail.com> <20190730134856.GO31406@gate.crashing.org> <CAK8P3a2755_6xq453C2AePLW8BeQk_Jg=HfjB_F-zyVMnQDfdg@mail.gmail.com> <20190730161637.GP31406@gate.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730161637.GP31406@gate.crashing.org>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 11:16:37AM -0500, Segher Boessenkool wrote:
> in_le32 and friends?  Yeah, huh.  If LLVM copies that to the stack as
> well, its (not byte reversing) read will be atomic just fine, so things
> will still work correctly.
> 
> The things defined with DEF_MMIO_IN_D (instead of DEF_MMIO_IN_X) do not
> look like they will work correctly if an update form address is chosen,
> but that won't happen because the constraint is "m" instead of "m<>",
> making the %Un pretty useless (it will always be the empty string).

Btw, this is true since GCC 4.8; before 4.8, plain "m" *could* have an
automodify (autoinc, autodec, etc.) side effect.  What is the minimum
GCC version required, these days?

https://gcc.gnu.org/PR44492
https://gcc.gnu.org/r161328


Segher
