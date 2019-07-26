Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1EC6C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 19:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BEE322CD0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 19:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388385AbfGZTF4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 15:05:56 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:53925 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388306AbfGZTFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 15:05:55 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 17638005-1500050 
        for multiple; Fri, 26 Jul 2019 20:05:36 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <alpine.DEB.2.21.1907252355150.1791@nanos.tec.linutronix.de>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
References: <51a4155c5bc2ca847a9cbe85c1c11918bb193141.1564086017.git.jpoimboe@redhat.com>
 <alpine.DEB.2.21.1907252355150.1791@nanos.tec.linutronix.de>
Message-ID: <156416793450.30723.5556760526480191131@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH] drm/i915: Remove redundant user_access_end() from
 __copy_from_user() error path
Date:   Fri, 26 Jul 2019 20:05:34 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Thomas Gleixner (2019-07-25 22:55:45)
> On Thu, 25 Jul 2019, Josh Poimboeuf wrote:
> 
> > Objtool reports:
> > 
> >   drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool: .altinstr_replacement+0x36: redundant UACCESS disable
> > 
> > __copy_from_user() already does both STAC and CLAC, so the
> > user_access_end() in its error path adds an extra unnecessary CLAC.
> > 
> > Fixes: 0b2c8f8b6b0c ("i915: fix missing user_access_end() in page fault exception case")
> > Reported-by: Thomas Gleixner <tglx@linutronix.de>
> > Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> > Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Tested-by: Nick Desaulniers <ndesaulniers@google.com>
> > Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
> > Link: https://github.com/ClangBuiltLinux/linux/issues/617
> > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> 
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Which tree do you plan to apply it to? I can put in drm-intel, and with
the fixes tag it will percolate through to 5.3 and beyond, but if you
want to apply it directly to squash the build warnings, feel free.
-Chris
