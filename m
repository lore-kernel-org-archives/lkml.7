Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B536EC33C8C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 01:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98529207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 01:13:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbfKZBNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 20:13:23 -0500
Received: from ozlabs.org ([203.11.71.1]:57735 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726947AbfKZBNX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 20:13:23 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 47MQrd1PSrz9sPZ; Tue, 26 Nov 2019 12:13:21 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 465bfd9c44dea6b55962b5788a23ac87a467c923
In-Reply-To: <20191119045712.39633-2-natechancellor@gmail.com>
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, Daniel Axtens <dja@axtens.net>
Subject: Re: [PATCH v5 1/3] powerpc: Don't add -mabi= flags when building with Clang
Message-Id: <47MQrd1PSrz9sPZ@ozlabs.org>
Date:   Tue, 26 Nov 2019 12:13:21 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-11-19 at 04:57:10 UTC, Nathan Chancellor wrote:
> When building pseries_defconfig, building vdso32 errors out:
> 
>   error: unknown target ABI 'elfv1'
> 
> This happens because -m32 in clang changes the target to 32-bit,
> which does not allow the ABI to be changed, as the setABI virtual
> function is not overridden:
> 
> https://github.com/llvm/llvm-project/blob/llvmorg-9.0.0/clang/include/clang/Basic/TargetInfo.h#L1073-L1078
> 
> https://github.com/llvm/llvm-project/blob/llvmorg-9.0.0/clang/lib/Basic/Targets/PPC.h#L327-L365
> 
> Commit 4dc831aa8813 ("powerpc: Fix compiling a BE kernel with a
> powerpc64le toolchain") added these flags to fix building big endian
> kernels with a little endian GCC.
> 
> Clang doesn't need -mabi because the target triple controls the default
> value. -mlittle-endian and -mbig-endian manipulate the triple into
> either powerpc64-* or powerpc64le-*, which properly sets the default
> ABI:
> 
> https://github.com/llvm/llvm-project/blob/llvmorg-9.0.0/clang/lib/Driver/Driver.cpp#L450-L463
> 
> https://github.com/llvm/llvm-project/blob/llvmorg-9.0.0/llvm/lib/Support/Triple.cpp#L1432-L1516
> 
> https://github.com/llvm/llvm-project/blob/llvmorg-9.0.0/clang/lib/Basic/Targets/PPC.h#L377-L383
> 
> Adding a debug print out in the PPC64TargetInfo constructor after line
> 383 above shows this:
> 
> $ echo | ./clang -E --target=powerpc64-linux -mbig-endian -o /dev/null -
> Default ABI: elfv1
> 
> $ echo | ./clang -E --target=powerpc64-linux -mlittle-endian -o /dev/null -
> Default ABI: elfv2
> 
> $ echo | ./clang -E --target=powerpc64le-linux -mbig-endian -o /dev/null -
> Default ABI: elfv1
> 
> $ echo | ./clang -E --target=powerpc64le-linux -mlittle-endian -o /dev/null -
> Default ABI: elfv2
> 
> Don't specify -mabi when building with clang to avoid the build error
> with -m32 and not change any code generation.
> 
> -mcall-aixdesc is not an implemented flag in clang so it can be
> safely excluded as well, see commit 238abecde8ad ("powerpc: Don't
> use gcc specific options on clang").
> 
> pseries_defconfig successfully builds after this patch and
> powernv_defconfig and ppc44x_defconfig don't regress.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/240
> Reviewed-by: Daniel Axtens <dja@axtens.net>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/465bfd9c44dea6b55962b5788a23ac87a467c923

cheers
