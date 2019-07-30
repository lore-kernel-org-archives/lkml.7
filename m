Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D236FC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 05:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A23D2206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 05:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="qyEzDSXc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729331AbfG3Fb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 01:31:26 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:58516 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728656AbfG3Fb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 01:31:26 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 45yQCH3NcVzB09ZT;
        Tue, 30 Jul 2019 07:31:23 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=qyEzDSXc; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id rd-v7jPqQJgu; Tue, 30 Jul 2019 07:31:23 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 45yQCH2HdXzB09ZN;
        Tue, 30 Jul 2019 07:31:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1564464683; bh=ePSetGxy2Hgvqtd+MAQAGKMxy2rhqR0kq9ZlpTUXHps=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=qyEzDSXcnwLMN8hHx717ZrDE0Jv3hY6oYqpm8o29LeHg0T2Nl8V/kNdFsQgoV6CQT
         LbYMXDw+LGfxTyJliNgft9h1Jv2zGxQ6PnhCVndsAxlVYD749/0E2dNnzcY3frc2uu
         /hVX8u33apZRbxJSLbuTXC1ChrxEpO0T22sRdr/w=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 27A588B7F1;
        Tue, 30 Jul 2019 07:31:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 8Lk1aYWXxBaY; Tue, 30 Jul 2019 07:31:24 +0200 (CEST)
Received: from [172.25.230.101] (po15451.idsi0.si.c-s.fr [172.25.230.101])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id F1AFC8B74F;
        Tue, 30 Jul 2019 07:31:23 +0200 (CEST)
Subject: Re: [PATCH] powerpc: workaround clang codegen bug in dcbz
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     mpe@ellerman.id.au, segher@kernel.crashing.org, arnd@arndb.de,
        kbuild test robot <lkp@intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
References: <20190729202542.205309-1-ndesaulniers@google.com>
 <20190729203246.GA117371@archlinux-threadripper>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <8f2331db-151f-a481-23e0-ec6dd9ba6f1c@c-s.fr>
Date:   Tue, 30 Jul 2019 07:31:23 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190729203246.GA117371@archlinux-threadripper>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 29/07/2019 à 22:32, Nathan Chancellor a écrit :
> On Mon, Jul 29, 2019 at 01:25:41PM -0700, Nick Desaulniers wrote:
>> Commit 6c5875843b87 ("powerpc: slightly improve cache helpers") exposed
>> what looks like a codegen bug in Clang's handling of `%y` output
>> template with `Z` constraint. This is resulting in panics during boot
>> for 32b powerpc builds w/ Clang, as reported by our CI.
>>
>> Add back the original code that worked behind a preprocessor check for
>> __clang__ until we can fix LLVM.
>>
>> Further, it seems that clang allnoconfig builds are unhappy with `Z`, as
>> reported by 0day bot. This is likely because Clang warns about inline
>> asm constraints when the constraint requires inlining to be semantically
>> valid.
>>
>> Link: https://bugs.llvm.org/show_bug.cgi?id=42762
>> Link: https://github.com/ClangBuiltLinux/linux/issues/593
>> Link: https://lore.kernel.org/lkml/20190721075846.GA97701@archlinux-threadripper/
>> Debugged-by: Nathan Chancellor <natechancellor@gmail.com>
>> Reported-by: Nathan Chancellor <natechancellor@gmail.com>
>> Reported-by: kbuild test robot <lkp@intel.com>
>> Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
>> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
>> ---
>> Alternatively, we could just revert 6c5875843b87. It seems that GCC
>> generates the same code for these functions for out of line versions.
>> But I'm not sure how the inlined code generated would be affected.
> 
> For the record:
> 
> https://godbolt.org/z/z57VU7
> 
> This seems consistent with what Michael found so I don't think a revert
> is entirely unreasonable.

Your example functions are too simple to show anything. The functions 
takes only one parameter so of course GCC won't use two registers 
allthough given the opportunity.

Christophe

> 
> Either way:
> 
> Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
> 
