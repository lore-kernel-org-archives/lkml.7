Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D797DC76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 20:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3CA2218F0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 20:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfGYUVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 16:21:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:19700 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726166AbfGYUVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 16:21:17 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8A9D73086262;
        Thu, 25 Jul 2019 20:21:17 +0000 (UTC)
Received: from treble (ovpn-122-90.rdu2.redhat.com [10.10.122.90])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 53BCB6712C;
        Thu, 25 Jul 2019 20:21:16 +0000 (UTC)
Date:   Thu, 25 Jul 2019 15:21:14 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/2] drm/i915: Remove redundant user_access_end() from
 __copy_from_user() error path
Message-ID: <20190725202114.hxwnnu4sihus53ci@treble>
References: <cover.1564007838.git.jpoimboe@redhat.com>
 <523b910e41a5cf856ee338b78ee36941034be142.1564007838.git.jpoimboe@redhat.com>
 <CA+icZUUb0XVhYq6Y590UyKxEyvzP7_LWU6WZW6bi7tEu6=RzuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+icZUUb0XVhYq6Y590UyKxEyvzP7_LWU6WZW6bi7tEu6=RzuQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 25 Jul 2019 20:21:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 08:10:49AM +0200, Sedat Dilek wrote:
> On Thu, Jul 25, 2019 at 12:48 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
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
> > Link: https://github.com/ClangBuiltLinux/linux/issues/617
> > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> 
> Just for the records and ensuing ages:
> 
> Tested-by: Sedat Dilek <sedat.dilek@gmail.com>

Thanks Sedat.  Since the objtool fix already got merged separately I'll
resend this patch to the drm folks.

-- 
Josh
