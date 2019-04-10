Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED88C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 548C720830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731781AbfDJQOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:14:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:48230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729048AbfDJQOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 12:14:24 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E07762082E;
        Wed, 10 Apr 2019 16:14:22 +0000 (UTC)
Date:   Wed, 10 Apr 2019 12:14:21 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/12] s390: avoid __builtin_return_address(n) on clang
Message-ID: <20190410121421.1414e179@gandalf.local.home>
In-Reply-To: <20190410180357.3290d24f@mschwideX1>
References: <20190408212648.2407234-1-arnd@arndb.de>
        <20190408212648.2407234-10-arnd@arndb.de>
        <20190410180357.3290d24f@mschwideX1>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Apr 2019 18:03:57 +0200
Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:

> > --- a/arch/s390/include/asm/ftrace.h
> > +++ b/arch/s390/include/asm/ftrace.h
> > @@ -13,7 +13,12 @@
> > 
> >  #ifndef __ASSEMBLY__
> > 
> > +#ifdef CONFIG_CC_IS_CLANG
> > +/* https://bugs.llvm.org/show_bug.cgi?id=41424 */
> > +#define ftrace_return_address(n) __builtin_return_address(0)
> > +#else
> >  #define ftrace_return_address(n) __builtin_return_address(n)
> > +#endif
> > 
> >  void _mcount(void);
> >  void ftrace_caller(void);  
> 
> I can say I like this one. If the compiler can not do __builtin_return_address(n)
> it feels wrong to just use __builtin_return_address(0).

I agree. The proper return value is 0UL, see include/linux/ftrace.h

/* Archs may use other ways for ADDR1 and beyond */
#ifndef ftrace_return_address
# ifdef CONFIG_FRAME_POINTER
#  define ftrace_return_address(n) __builtin_return_address(n)
# else
#  define ftrace_return_address(n) 0UL
# endif
#endif

This is why we treat zero differently:

#define CALLER_ADDR0 ((unsigned long)ftrace_return_address0)
#define CALLER_ADDR1 ((unsigned long)ftrace_return_address(1))
#define CALLER_ADDR2 ((unsigned long)ftrace_return_address(2))
#define CALLER_ADDR3 ((unsigned long)ftrace_return_address(3))
#define CALLER_ADDR4 ((unsigned long)ftrace_return_address(4))
#define CALLER_ADDR5 ((unsigned long)ftrace_return_address(5))
#define CALLER_ADDR6 ((unsigned long)ftrace_return_address(6))


-- Steve
