Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A1E2C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 12:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79368218B8
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 12:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfGXMz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 08:55:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53240 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbfGXMz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 08:55:28 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 56E84300C72E;
        Wed, 24 Jul 2019 12:55:28 +0000 (UTC)
Received: from treble (ovpn-122-90.rdu2.redhat.com [10.10.122.90])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 490975D9DE;
        Wed, 24 Jul 2019 12:55:27 +0000 (UTC)
Date:   Wed, 24 Jul 2019 07:55:25 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        x86@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: x86 - clang / objtool status
Message-ID: <20190724125525.kgybu3nnpvwlcz2c@treble>
References: <alpine.DEB.2.21.1907182223560.1785@nanos.tec.linutronix.de>
 <20190724023946.yxsz5im22fz4zxrn@treble>
 <20190724074732.GJ3402@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190724074732.GJ3402@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 24 Jul 2019 12:55:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 09:47:32AM +0200, Peter Zijlstra wrote:
> On Tue, Jul 23, 2019 at 09:43:24PM -0500, Josh Poimboeuf wrote:
> > On Thu, Jul 18, 2019 at 10:40:09PM +0200, Thomas Gleixner wrote:
> > 
> > >   drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool: .altinstr_replacement+0x86: redundant UACCESS disable
> > 
> > Looking at this one, I think I agree with objtool.
> > 
> > PeterZ, Linus, I know y'all discussed this code a few months ago.
> > 
> > __copy_from_user() already does a CLAC in its error path.  So isn't the
> > user_access_end() redundant for the __copy_from_user() error path?
> 
> Hmm, is this a result of your c705cecc8431 ("objtool: Track original function across branches") ?
> 
> I'm thinking it might've 'overlooked' the CLAC in the error path before
> (because it didn't have a related function) and now it sees it and
> worries about it.
> 
> Then again, I'm not seeing this warning on my GCC builds; so what's
> happening?

According to the github issue[1] my patch doesn't fix the warning with
Clang.  So questions remain:

a) what is objtool actually warning about?

b) why doesn't objtool detect the case I found?


I can look at it later, post-meetings.


[1] https://github.com/ClangBuiltLinux/linux/issues/617

-- 
Josh
