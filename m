Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3321C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 09:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC5B2218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 09:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731468AbfB1JVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 04:21:13 -0500
Received: from ozlabs.org ([203.11.71.1]:50535 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731161AbfB1JVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 04:21:13 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4496VZ4JGRz9s9L; Thu, 28 Feb 2019 20:21:10 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: e7140639b1de65bba435a6bd772d134901141f86
X-Patchwork-Hint: ignore
In-Reply-To: <20190226053855.7020-1-natechancellor@gmail.com>
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Joel Stanley <joel@jms.id.au>
Subject: Re: powerpc/xmon: Fix opcode being uninitialized in print_insn_powerpc
Message-Id: <4496VZ4JGRz9s9L@ozlabs.org>
Date:   Thu, 28 Feb 2019 20:21:10 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-02-26 at 05:38:55 UTC, Nathan Chancellor wrote:
> When building with -Wsometimes-uninitialized, Clang warns:
> 
> arch/powerpc/xmon/ppc-dis.c:157:7: warning: variable 'opcode' is used
> uninitialized whenever 'if' condition is false
> [-Wsometimes-uninitialized]
>   if (cpu_has_feature(CPU_FTRS_POWER9))
>       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/xmon/ppc-dis.c:167:7: note: uninitialized use occurs here
>   if (opcode == NULL)
>       ^~~~~~
> arch/powerpc/xmon/ppc-dis.c:157:3: note: remove the 'if' if its
> condition is always true
>   if (cpu_has_feature(CPU_FTRS_POWER9))
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/xmon/ppc-dis.c:132:38: note: initialize the variable
> 'opcode' to silence this warning
>   const struct powerpc_opcode *opcode;
>                                      ^
>                                       = NULL
> 1 warning generated.
> 
> This warning seems to make no sense on the surface because opcode is set
> to NULL right below this statement. However, there is a comma instead of
> semicolon to end the dialect assignment, meaning that the opcode
> assignment only happens in the if statement. Properly terminate that
> line so that Clang no longer warns.
> 
> Fixes: 5b102782c7f4 ("powerpc/xmon: Enable disassembly files (compilation changes)")
> Link: https://github.com/ClangBuiltLinux/linux/issues/390
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/e7140639b1de65bba435a6bd772d1349

cheers
