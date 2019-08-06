Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179D6C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 12:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9C0E214C6
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 12:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731629AbfHFM7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 08:59:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58324 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731132AbfHFM7g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 08:59:36 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F133F50F4D;
        Tue,  6 Aug 2019 12:59:35 +0000 (UTC)
Received: from treble (ovpn-121-192.rdu2.redhat.com [10.10.121.192])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DC1291001284;
        Tue,  6 Aug 2019 12:59:33 +0000 (UTC)
Date:   Tue, 6 Aug 2019 07:59:31 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] drm/i915: Remove redundant user_access_end() from
 __copy_from_user() error path
Message-ID: <20190806125931.oqeqateyzqikusku@treble>
References: <51a4155c5bc2ca847a9cbe85c1c11918bb193141.1564086017.git.jpoimboe@redhat.com>
 <alpine.DEB.2.21.1907252355150.1791@nanos.tec.linutronix.de>
 <156416793450.30723.5556760526480191131@skylake-alporthouse-com>
 <alpine.DEB.2.21.1907262116530.1791@nanos.tec.linutronix.de>
 <156416944205.21451.12269136304831943624@skylake-alporthouse-com>
 <CA+icZUXwBFS-6e+Qp4e3PhnRzEHvwdzWtS6OfVsgy85R5YNGOg@mail.gmail.com>
 <CA+icZUWA6e0Zsio6sthRUC=Ehb2-mw_9U76UnvwGc_tOnOqt7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+icZUWA6e0Zsio6sthRUC=Ehb2-mw_9U76UnvwGc_tOnOqt7w@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 06 Aug 2019 12:59:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2019 at 09:29:53PM +0200, Sedat Dilek wrote:
> On Wed, Jul 31, 2019 at 2:25 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > On Fri, Jul 26, 2019 at 9:30 PM Chris Wilson <chris@chris-wilson.co.uk> wrote:
> > >
> > > Quoting Thomas Gleixner (2019-07-26 20:18:32)
> > > > On Fri, 26 Jul 2019, Chris Wilson wrote:
> > > > > Quoting Thomas Gleixner (2019-07-25 22:55:45)
> > > > > > On Thu, 25 Jul 2019, Josh Poimboeuf wrote:
> > > > > >
> > > > > > > Objtool reports:
> > > > > > >
> > > > > > >   drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool: .altinstr_replacement+0x36: redundant UACCESS disable
> > > > > > >
> > > > > > > __copy_from_user() already does both STAC and CLAC, so the
> > > > > > > user_access_end() in its error path adds an extra unnecessary CLAC.
> > > > > > >
> > > > > > > Fixes: 0b2c8f8b6b0c ("i915: fix missing user_access_end() in page fault exception case")
> > > > > > > Reported-by: Thomas Gleixner <tglx@linutronix.de>
> > > > > > > Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> > > > > > > Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > > > > > Tested-by: Nick Desaulniers <ndesaulniers@google.com>
> > > > > > > Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
> > > > > > > Link: https://github.com/ClangBuiltLinux/linux/issues/617
> > > > > > > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > > > > >
> > > > > > Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> > > > >
> > > > > Which tree do you plan to apply it to? I can put in drm-intel, and with
> > > > > the fixes tag it will percolate through to 5.3 and beyond, but if you
> > > > > want to apply it directly to squash the build warnings, feel free.
> > > >
> > > > It would be nice to get it into 5.3. I can route it linuxwards if you give
> > > > an Acked-by, but I'm happy to hand it to you :)
> > >
> > > Acked-by: Chris Wilson <chris@chris-wilson.co.uk>
> >
> > Thomas did you take this through tip tree after Chris' ACK?
> >
> 
> Hi,
> 
> Gentle ping...
> Thomas and Chris: Will someone of you pick this up?
> As "objtool: Improve UACCESS coverage" [1] went trough tip tree I
> highly appreciate to do so with this one.

I think Thomas has gone on holiday, so hopefully Chris can pick it up
after all.

-- 
Josh
