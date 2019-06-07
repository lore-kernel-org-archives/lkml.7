Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B243C28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 08:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D931208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 08:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y3j/2KLM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfFGIi2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 04:38:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53472 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbfFGIi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 04:38:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=k/hSXiJNYL8ZZMcx5p3mdI6yQL+dQlYirDFwee3TyA8=; b=Y3j/2KLMjClLjbFHxrK61ft9av
        Dhtg566DgBSkgsz90tn/bfe4B0KA0BKuVckCdMV/GbQkM7A2iqVAg1ceL7wMoszxKQ9nuWosMjl44
        SowmZlIEDuWjJVy/7Z9zXxPPoHcjXL97FImAHdGe1oKUxxtMDICmkORZ5QlbtEKylm/b8qBUx2KBU
        eKd8j7Hujy8ZAu3mKKNtW3FHFp6oqNBulBC+nifpCxNr3dXNxqZhdVIJthw04qCEhz5UOnupjXfoM
        ugTSwgUSnv6WwnMVUzRDraOVhcerLQp0InJFwvXap2ZDEi8tYdT924mLjRc2+KOC4jmQ+nzykKUIx
        VrjppsYQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hZANq-0004e8-GJ; Fri, 07 Jun 2019 08:37:58 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B6C0320973578; Fri,  7 Jun 2019 10:37:56 +0200 (CEST)
Date:   Fri, 7 Jun 2019 10:37:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     the arch/x86 maintainers <x86@kernel.org>,
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
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH 11/15] static_call: Add inline static call infrastructure
Message-ID: <20190607083756.GW3419@hirez.programming.kicks-ass.net>
References: <20190605130753.327195108@infradead.org>
 <20190605131945.193241464@infradead.org>
 <37CFAEC1-6D36-4A6D-8C44-F85FCFA053AA@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <37CFAEC1-6D36-4A6D-8C44-F85FCFA053AA@vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2019 at 10:24:17PM +0000, Nadav Amit wrote:

> > +static void static_call_del_module(struct module *mod)
> > +{
> > +	struct static_call_site *start = mod->static_call_sites;
> > +	struct static_call_site *stop = mod->static_call_sites +
> > +					mod->num_static_call_sites;
> > +	struct static_call_site *site;
> > +	struct static_call_key *key, *prev_key = NULL;
> > +	struct static_call_mod *site_mod;
> > +
> > +	for (site = start; site < stop; site++) {
> > +		key = static_call_key(site);
> > +		if (key == prev_key)
> > +			continue;
> > +		prev_key = key;
> > +
> > +		list_for_each_entry(site_mod, &key->site_mods, list) {
> > +			if (site_mod->mod == mod) {
> > +				list_del(&site_mod->list);
> > +				kfree(site_mod);
> > +				break;
> > +			}
> > +		}
> > +	}
> 
> I think that for safety, when a module is removed, all the static-calls
> should be traversed to check that none of them calls any function in the
> removed module. If that happens, perhaps it should be poisoned.

We don't do that for normal indirect calls either.. I suppose we could
here, but meh.

> > +}
> > +
> > +static int static_call_module_notify(struct notifier_block *nb,
> > +				     unsigned long val, void *data)
> > +{
> > +	struct module *mod = data;
> > +	int ret = 0;
> > +
> > +	cpus_read_lock();
> > +	static_call_lock();
> > +
> > +	switch (val) {
> > +	case MODULE_STATE_COMING:
> > +		module_disable_ro(mod);
> > +		ret = static_call_add_module(mod);
> > +		module_enable_ro(mod, false);
> 
> Doesn’t it cause some pages to be W+X ? Can it be avoided?

I don't know why it does this, jump_labels doesn't seem to need this,
and I'm not seeing what static_call needs differently.

> > +		if (ret) {
> > +			WARN(1, "Failed to allocate memory for static calls");
> > +			static_call_del_module(mod);
> 
> If static_call_add_module() succeeded in changing some of the calls, but not
> all, I don’t think that static_call_del_module() will correctly undo
> static_call_add_module(). The code transformations, I think, will remain.

Hurm, jump_labels has the same problem.

I wonder why kernel/module.c:prepare_coming_module() doesn't propagate
the error from the notifier call. If it were to do that, I think we'll
abort the module load and any modifications get lost anyway.
