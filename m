Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850B5C4320D
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 09:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BA67214D9
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 09:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="ljdx59zS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395513AbfIXJvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 05:51:25 -0400
Received: from mail.skyhub.de ([5.9.137.197]:33626 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390921AbfIXJvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 05:51:25 -0400
Received: from zn.tnic (p200300EC2F0DB70045CA8E18EABF8C40.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:b700:45ca:8e18:eabf:8c40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 19F401EC03F6;
        Tue, 24 Sep 2019 11:51:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1569318683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=CLiBj8APfucHnx376AS0quJvXHMKstRAZp2sMymzyI0=;
        b=ljdx59zSyPJ6nMhH3ITKYKXxTI+vYfAGEtqUk+g2gxHpBIa1KB/eHDC9gk6dgQiSOXRpo7
        /ZKMI11kGei/OrcJ8Sk31OFpA1yEsttSchB0eMQ6ncQ2KzbIM3isN/diR7FuUtzFm3n0J8
        sTVmffANuWERrQE7QW4lP2jKL1M7irY=
Date:   Tue, 24 Sep 2019 11:51:27 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     keescook@chromium.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-um@lists.infradead.org,
        luto@kernel.org, oleg@redhat.com, tglx@linutronix.de,
        wad@chromium.org, x86@kernel.org
Subject: Re: [PATCH v1] seccomp: simplify secure_computing()
Message-ID: <20190924095127.GE19317@zn.tnic>
References: <20190920131907.6886-1-christian.brauner@ubuntu.com>
 <20190924064420.6353-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190924064420.6353-1-christian.brauner@ubuntu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 08:44:20AM +0200, Christian Brauner wrote:
> Afaict, the struct seccomp_data argument to secure_computing() is unused
> by all current callers. So let's remove it.
> The argument was added in [1]. It was added because having the arch
> supply the syscall arguments used to be faster than having it done by
> secure_computing() (cf. Andy's comment in [2]). This is not true anymore
> though.
> 
> /* References */
> [1]: 2f275de5d1ed ("seccomp: Add a seccomp_data parameter secure_computing()")
> [2]: https://lore.kernel.org/r/CALCETrU_fs_At-hTpr231kpaAd0z7xJN4ku-DvzhRU6cvcJA_w@mail.gmail.com
> 
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Will Drewry <wad@chromium.org>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-parisc@vger.kernel.org
> Cc: linux-s390@vger.kernel.org
> Cc: linux-um@lists.infradead.org
> Cc: x86@kernel.org
> ---
> /* v1 */
> - Borislav Petkov <bp@alien8.de>:
>   - provide context for the arg addition to secure_computing() in the
>     commit message
> 
> /* v0 */
> Link: https://lore.kernel.org/r/20190920131907.6886-1-christian.brauner@ubuntu.com
> ---
>  arch/arm/kernel/ptrace.c              | 2 +-
>  arch/arm64/kernel/ptrace.c            | 2 +-
>  arch/parisc/kernel/ptrace.c           | 2 +-
>  arch/s390/kernel/ptrace.c             | 4 ++--
>  arch/um/kernel/skas/syscall.c         | 2 +-
>  arch/x86/entry/vsyscall/vsyscall_64.c | 2 +-
>  include/linux/seccomp.h               | 6 +++---
>  7 files changed, 10 insertions(+), 10 deletions(-)

Acked-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
