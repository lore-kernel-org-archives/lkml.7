Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A994C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 13:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBF1720896
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 13:03:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389874AbfFKNDJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 09:03:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59550 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388131AbfFKNDI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 09:03:08 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3632FC05B03F;
        Tue, 11 Jun 2019 13:02:58 +0000 (UTC)
Received: from treble (ovpn-121-161.rdu2.redhat.com [10.10.121.161])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C403611CA;
        Tue, 11 Jun 2019 13:02:48 +0000 (UTC)
Date:   Tue, 11 Jun 2019 08:02:41 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@ACULAB.COM>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Nadav Amit <namit@vmware.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH 14/15] static_call: Simple self-test module
Message-ID: <20190611130241.3zxftm3xscorr7ys@treble>
References: <20190605130753.327195108@infradead.org>
 <20190605131945.373256296@infradead.org>
 <20190610172428.3t6laheazlz2y3br@treble>
 <20190611082931.GR3436@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190611082931.GR3436@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 11 Jun 2019 13:03:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 10:29:31AM +0200, Peter Zijlstra wrote:
> On Mon, Jun 10, 2019 at 12:24:28PM -0500, Josh Poimboeuf wrote:
> > On Wed, Jun 05, 2019 at 03:08:07PM +0200, Peter Zijlstra wrote:
> > > 
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > ---
> > >  lib/Kconfig.debug      |    8 ++++++++
> > >  lib/Makefile           |    1 +
> > >  lib/test_static_call.c |   41 +++++++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 50 insertions(+)
> > > 
> > > --- a/lib/Kconfig.debug
> > > +++ b/lib/Kconfig.debug
> > > @@ -1955,6 +1955,14 @@ config TEST_STATIC_KEYS
> > >  
> > >  	  If unsure, say N.
> > >  
> > > +config TEST_STATIC_CALL
> > > +	tristate "Test static call"
> > > +	depends on m
> > > +	help
> > > +	  Test the static call interfaces.
> > > +
> > > +	  If unsure, say N.
> > > +
> > 
> > Any reason why we wouldn't just make this a built-in boot time test?
> 
> None what so ever; but I did copy paste from the static_key stuff and
> that has it for some rasin.

Their functionality is pretty crucial, and I doubt anybody is manually
building and loading these tests?  Seems like built-in tests would be
wiser for both static calls/keys.

-- 
Josh
