Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1B7C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 19:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1AD1218B8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 19:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388518AbfGZTSj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 15:18:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50173 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387455AbfGZTSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 15:18:39 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hr5jc-00018V-Sk; Fri, 26 Jul 2019 21:18:33 +0200
Date:   Fri, 26 Jul 2019 21:18:32 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Chris Wilson <chris@chris-wilson.co.uk>
cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] drm/i915: Remove redundant user_access_end() from
 __copy_from_user() error path
In-Reply-To: <156416793450.30723.5556760526480191131@skylake-alporthouse-com>
Message-ID: <alpine.DEB.2.21.1907262116530.1791@nanos.tec.linutronix.de>
References: <51a4155c5bc2ca847a9cbe85c1c11918bb193141.1564086017.git.jpoimboe@redhat.com> <alpine.DEB.2.21.1907252355150.1791@nanos.tec.linutronix.de> <156416793450.30723.5556760526480191131@skylake-alporthouse-com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jul 2019, Chris Wilson wrote:
> Quoting Thomas Gleixner (2019-07-25 22:55:45)
> > On Thu, 25 Jul 2019, Josh Poimboeuf wrote:
> > 
> > > Objtool reports:
> > > 
> > >   drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool: .altinstr_replacement+0x36: redundant UACCESS disable
> > > 
> > > __copy_from_user() already does both STAC and CLAC, so the
> > > user_access_end() in its error path adds an extra unnecessary CLAC.
> > > 
> > > Fixes: 0b2c8f8b6b0c ("i915: fix missing user_access_end() in page fault exception case")
> > > Reported-by: Thomas Gleixner <tglx@linutronix.de>
> > > Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> > > Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > Tested-by: Nick Desaulniers <ndesaulniers@google.com>
> > > Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
> > > Link: https://github.com/ClangBuiltLinux/linux/issues/617
> > > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > 
> > Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> 
> Which tree do you plan to apply it to? I can put in drm-intel, and with
> the fixes tag it will percolate through to 5.3 and beyond, but if you
> want to apply it directly to squash the build warnings, feel free.

It would be nice to get it into 5.3. I can route it linuxwards if you give
an Acked-by, but I'm happy to hand it to you :)

Thanks,

	tglx
