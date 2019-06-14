Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B3CC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 18:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEA4E217D6
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 18:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbfFNSXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 14:23:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52226 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725814AbfFNSXw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 14:23:52 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9760F6696C;
        Fri, 14 Jun 2019 18:23:46 +0000 (UTC)
Received: from treble (ovpn-121-232.rdu2.redhat.com [10.10.121.232])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 417006402F;
        Fri, 14 Jun 2019 18:23:43 +0000 (UTC)
Date:   Fri, 14 Jun 2019 13:23:41 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Jessica Yu <jeyu@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
        Johannes Erdfelt <johannes@erdfelt.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 3/3] module: Improve module __ro_after_init handling
Message-ID: <20190614182341.sq4yngzmoobsyinq@treble>
References: <cover.1560474114.git.jpoimboe@redhat.com>
 <1b72f40d863a1444f687b3e1b958bdc6925882ed.1560474114.git.jpoimboe@redhat.com>
 <20190614141453.fjtvk7uvux6vcmlp@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190614141453.fjtvk7uvux6vcmlp@pathway.suse.cz>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 14 Jun 2019 18:23:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 04:14:53PM +0200, Petr Mladek wrote:
> > -void __module_enable_ro(const struct module *mod, bool after_init)
> > +static void __module_enable_ro(const struct module *mod)
> >  {
> >  	if (!rodata_enabled)
> >  		return;
> > @@ -1973,15 +1973,15 @@ void __module_enable_ro(const struct module *mod, bool after_init)
> >  
> >  	frob_rodata(&mod->init_layout, set_memory_ro);
> >  
> > -	if (after_init)
> > +	if (mod->state == MODULE_STATE_LIVE)
> >  		frob_ro_after_init(&mod->core_layout, set_memory_ro);
> 
> This works only now because __module_enable_ro() is called only from
> three locations (klp_init_object_loaded(),  complete_formation(),
> and do_init_module(). And they all are called in a well defined order
> from load_module().
> 
> Only the final call in do_init_module() should touch the after_init
> section.
> 
> IMHO, the most clean solutiuon would be to call frob_ro_after_init()
> from extra __module_after_init_enable_ro() or so. This should be
> called only from the single place.

Agreed, that would be better.  I'll be gone for a week but I'll make
these changes when I get back.  Thanks.

-- 
Josh
