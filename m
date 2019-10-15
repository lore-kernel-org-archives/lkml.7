Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D628DECE58C
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 00:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A940A21848
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 00:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571099593;
	bh=nYrK21GeVc5xsEyJKl+SvsDt6ZpiZIrIh97bmdSaL6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=X0FNqYCPECH6+cWnoGQPU1CHlqnD1zxF/fbS471fH9jyC1l/PZ1x8T95pqUu3HQeY
	 d6lOs6yCpApDufLqDWrCKxv5fGwUfhdLFdMqTy3N1A7uUZMPYNX6QuNAw+WzobsO0r
	 uJ2f98yWSQyBYVhbsmVnjcMTFXjBxZolQ+fOmi90=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfJOAdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 20:33:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:33930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726576AbfJOAdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 20:33:11 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 938B5217F9;
        Tue, 15 Oct 2019 00:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571099591;
        bh=nYrK21GeVc5xsEyJKl+SvsDt6ZpiZIrIh97bmdSaL6s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ysPml0GTd/oA8c10doXcSZIUYBMozVc6myLMUPOglbye/b8nVNBy6fgS6kwd6ilyG
         Hu854SsVrqWYl2cUvowkv9qgHAU6OjraS6LIoZsetH4b9AF0oNGNszqq4/wb3rZwNU
         //mCjhX9WWQ7pkMKsLF8FOj3iP3BJ3IJ4c60WDkU=
Date:   Tue, 15 Oct 2019 01:33:06 +0100
From:   Will Deacon <will@kernel.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH v2] arm64: lse: fix LSE atomics with LLVM's integrated
 assembler
Message-ID: <20191015003306.gdmnu2qdte32guc5@willie-the-truck>
References: <20191007201452.208067-1-samitolvanen@google.com>
 <20191008212730.185532-1-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008212730.185532-1-samitolvanen@google.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 02:27:30PM -0700, Sami Tolvanen wrote:
> Unlike gcc, clang considers each inline assembly block to be independent
> and therefore, when using the integrated assembler for inline assembly,
> any preambles that enable features must be repeated in each block.
> 
> This change defines __LSE_PREAMBLE and adds it to each inline assembly
> block that has LSE instructions, which allows them to be compiled also
> with clang's assembler.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/671
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
> v2:
>  - Add a preamble to inline assembly blocks that use LSE instead
>    of allowing the compiler to emit LSE instructions everywhere.
> 
> ---
>  arch/arm64/include/asm/atomic_lse.h | 19 +++++++++++++++++++
>  arch/arm64/include/asm/lse.h        |  6 +++---
>  2 files changed, 22 insertions(+), 3 deletions(-)

One thing I've always wanted from binutils is the ability to pass a flag to
the assembler which means that it accepts all of the instructions that it
knows about for a given major architecture (a bit like the '-cpu max' option
to qemu). Even better would be the ability to supply a file at build time
specifying the encodings, so that we could ship that with the kernel and
avoid some of the mess we have in places like sysreg.h were we end up
fighting against the assembler when trying to define new system register
accessors.

The latter suggestion is a bit "pie in the sky", but do you think there is
any scope for the former with clang?

Will
