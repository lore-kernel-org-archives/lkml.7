Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CAC2C31E43
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 17:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3E2A207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 17:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387631AbfFJRU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 13:20:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46746 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbfFJRU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 13:20:29 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6EF9067F;
        Mon, 10 Jun 2019 17:19:49 +0000 (UTC)
Received: from treble (ovpn-121-189.rdu2.redhat.com [10.10.121.189])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A521919C59;
        Mon, 10 Jun 2019 17:19:31 +0000 (UTC)
Date:   Mon, 10 Jun 2019 12:19:29 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nadav Amit <namit@vmware.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
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
        "H. Peter Anvin" <hpa@zytor.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH 11/15] static_call: Add inline static call infrastructure
Message-ID: <20190610171929.3xemvsykvkswcvya@treble>
References: <20190605130753.327195108@infradead.org>
 <20190605131945.193241464@infradead.org>
 <37CFAEC1-6D36-4A6D-8C44-F85FCFA053AA@vmware.com>
 <20190607083756.GW3419@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190607083756.GW3419@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Mon, 10 Jun 2019 17:20:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 07, 2019 at 10:37:56AM +0200, Peter Zijlstra wrote:
> > > +}
> > > +
> > > +static int static_call_module_notify(struct notifier_block *nb,
> > > +				     unsigned long val, void *data)
> > > +{
> > > +	struct module *mod = data;
> > > +	int ret = 0;
> > > +
> > > +	cpus_read_lock();
> > > +	static_call_lock();
> > > +
> > > +	switch (val) {
> > > +	case MODULE_STATE_COMING:
> > > +		module_disable_ro(mod);
> > > +		ret = static_call_add_module(mod);
> > > +		module_enable_ro(mod, false);
> > 
> > Doesn’t it cause some pages to be W+X ?

How so?

>> Can it be avoided?
> 
> I don't know why it does this, jump_labels doesn't seem to need this,
> and I'm not seeing what static_call needs differently.

I forgot why I did this, but it's probably for the case where there's a
static call site in module init code.  It deserves a comment.

Theoretically, jump labels need this to.

BTW, there's a change coming that will require the text_mutex before
calling module_{disable,enable}_ro().

-- 
Josh
