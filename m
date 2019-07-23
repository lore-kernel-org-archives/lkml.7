Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73729C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 10:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C5BD2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 10:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F3dkwvek"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733059AbfGWKuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 06:50:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46862 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728856AbfGWKuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 06:50:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=r8pKJvTBYjQmA6xTW4SL+CVHf8xD1EdzIVVKROq07g0=; b=F3dkwvekQOj0BURpaHhiZAWhe
        nKECJ8K5l/SXfNzSKObLubCNxcf+1eSEv1sQ7ldrVN2U+LDFAZRIVDrkJ/Cg+6VQekTiSssh1rjIs
        5BOFxYnz/izr9ryMelPm7pDNVyNEFRyG/ZIU5/w5ZkW0qJh0jOZG0MQxkmkR1v2YBOhtJDrWpS+3t
        4MkVXXZUX/L3ytyZszCGnfVSoUkYBg3gfypyqgHcLXtSsrPoXwjuUK80Yd8syNpKGWI24htT0bURN
        8cgelbGtYRw8d4mry8PknQ5nGrj1wdE4rewfjbsgw3ZF4FhYfi5YpJlu7FkSvHOkpVxzCtSI1CnG+
        gVScYG/3Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hpsNb-0003mE-QQ; Tue, 23 Jul 2019 10:50:47 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3E6B2201A9429; Tue, 23 Jul 2019 12:50:46 +0200 (CEST)
Date:   Tue, 23 Jul 2019 12:50:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] [v2] waitqueue: shut up clang -Wuninitialized warnings
Message-ID: <20190723105046.GD3402@hirez.programming.kicks-ass.net>
References: <20190719113638.4189771-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190719113638.4189771-1-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 01:36:00PM +0200, Arnd Bergmann wrote:
> When CONFIG_LOCKDEP is set, every use of DECLARE_WAIT_QUEUE_HEAD_ONSTACK()
> produces an bogus warning from clang, which is particularly annoying
> for allmodconfig builds:
> 
> fs/namei.c:1646:34: error: variable 'wq' is uninitialized when used within its own initialization [-Werror,-Wuninitialized]
>         DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
>                                         ^~
> include/linux/wait.h:74:63: note: expanded from macro 'DECLARE_WAIT_QUEUE_HEAD_ONSTACK'
>         struct wait_queue_head name = __WAIT_QUEUE_HEAD_INIT_ONSTACK(name)
>                                ~~~~                                  ^~~~
> include/linux/wait.h:72:33: note: expanded from macro '__WAIT_QUEUE_HEAD_INIT_ONSTACK'
>         ({ init_waitqueue_head(&name); name; })
>                                        ^~~~
> 
> A patch for clang has already been proposed and should soon be
> merged for clang-9, but for now all clang versions produce the
> warning in an otherwise (almost) clean allmodconfig build.
> 
> Link: https://bugs.llvm.org/show_bug.cgi?id=31829
> Link: https://bugs.llvm.org/show_bug.cgi?id=42604
> Link: https://lore.kernel.org/lkml/20190703081119.209976-1-arnd@arndb.de/
> Link: https://reviews.llvm.org/D64678
> Link: https://storage.kernelci.org/next/master/next-20190717/arm64/allmodconfig/clang-8/build-warnings.log
> Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: given that kernelci is getting close to reporting a clean build for
>     clang, I'm trying again with a less invasive approach after my
>     first version was not too popular.
> ---
>  include/linux/wait.h | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/wait.h b/include/linux/wait.h
> index ddb959641709..276499ae1a3e 100644
> --- a/include/linux/wait.h
> +++ b/include/linux/wait.h
> @@ -70,8 +70,17 @@ extern void __init_waitqueue_head(struct wait_queue_head *wq_head, const char *n
>  #ifdef CONFIG_LOCKDEP
>  # define __WAIT_QUEUE_HEAD_INIT_ONSTACK(name) \
>  	({ init_waitqueue_head(&name); name; })
> -# define DECLARE_WAIT_QUEUE_HEAD_ONSTACK(name) \
> +# if defined(__clang__) && __clang_major__ <= 9
> +/* work around https://bugs.llvm.org/show_bug.cgi?id=42604 */
> +#  define DECLARE_WAIT_QUEUE_HEAD_ONSTACK(name)					\
> +	_Pragma("clang diagnostic push")					\
> +	_Pragma("clang diagnostic ignored \"-Wuninitialized\"")			\
> +	struct wait_queue_head name = __WAIT_QUEUE_HEAD_INIT_ONSTACK(name)	\
> +	_Pragma("clang diagnostic pop")
> +# else
> +#  define DECLARE_WAIT_QUEUE_HEAD_ONSTACK(name) \
>  	struct wait_queue_head name = __WAIT_QUEUE_HEAD_INIT_ONSTACK(name)
> +# endif

While this is indeed much better than before; do we really want to do
this? That is, since clang-9 release will not need this, we're basically
doing the above for pre-release compilers only.

