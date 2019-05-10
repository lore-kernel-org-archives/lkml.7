Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A8FFC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 06:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E743D217D6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 06:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfEJGlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 02:41:31 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:38563 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726816AbfEJGla (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 02:41:30 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 450gbT04kgz9sBr;
        Fri, 10 May 2019 16:41:24 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>, Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Russell Currey <ruscur@russell.cc>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Stephen Rothwell <sfr@ozlabs.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] vsprintf: Do not break early boot with probing addresses
In-Reply-To: <20190510050709.GA1831@jagdpanzerIV>
References: <20190509121923.8339-1-pmladek@suse.com> <20190510043200.GC15652@jagdpanzerIV> <CAHk-=wiP+hwSqEW0dM6AYNWUR7jXDkeueq69et6ahfUgV7hC3w@mail.gmail.com> <20190510050709.GA1831@jagdpanzerIV>
Date:   Fri, 10 May 2019 16:41:24 +1000
Message-ID: <87h8a2vmjv.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> writes:
> On (05/09/19 21:47), Linus Torvalds wrote:
>>    [ Sorry about html and mobile crud, I'm not at the computer right now ]
>>    How about we just undo the whole misguided probe_kernel_address() thing?
>
> But the problem will remain - %pS/%pF on PPC (and some other arch-s)
> do dereference_function_descriptor(), which calls probe_kernel_address().

(Only on 64-bit big endian, and we may even change that one day)

> So if probe_kernel_address() starts to dump_stack(), then we are heading
> towards stack overflow. Unless I'm totally missing something.

We only ended up calling dump_stack() from probe_kernel_address() due to
a combination of things:
  1. probe_kernel_address() actually uses __copy_from_user_inatomic()
     which is silly because it's not doing a user access.
  2. our user access code uses mmu_has_feature() which uses jump labels,
     and so isn't safe to call until we've initialised those jump labels.
     This is unnecessarily fragile, we can easily make the user access
     code safe to call before the jump labels are initialised.
  3. we had extra debug code enabled in mmu_has_feature() which calls
     dump_stack().

I've fixed 2, and plan to fix 1 as well at some point. And 3 is behind a
CONFIG option that no one except me is going to have enabled in
practice.

So in future we shouldn't be calling dump_stack() in that path.

cheers
