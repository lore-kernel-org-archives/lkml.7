Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FAF3C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 12:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ABB5217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 12:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbfFYMOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 08:14:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:19097 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726390AbfFYMOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 08:14:02 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 85026307D983;
        Tue, 25 Jun 2019 12:13:49 +0000 (UTC)
Received: from treble (ovpn-126-66.rdu2.redhat.com [10.10.126.66])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B0A6760BE2;
        Tue, 25 Jun 2019 12:13:37 +0000 (UTC)
Date:   Tue, 25 Jun 2019 07:13:34 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jessica Yu <jeyu@kernel.org>, linux-kernel@vger.kernel.org,
        jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, ast@kernel.org,
        daniel@iogearbox.net, akpm@linux-foundation.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Vasily Averin <vvs@virtuozzo.com>,
        Todd Brandt <todd.e.brandt@linux.intel.com>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/3] notifier: Fix broken error handling pattern
Message-ID: <20190625121334.x3dyvhwsuryxevrz@treble>
References: <20190624091843.859714294@infradead.org>
 <20190624092109.745446564@infradead.org>
 <20190624222107.wrmtww6b2be26wwl@treble>
 <20190625073821.GQ3436@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190625073821.GQ3436@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Tue, 25 Jun 2019 12:14:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 09:38:21AM +0200, Peter Zijlstra wrote:
> > > @@ -156,43 +169,30 @@ int atomic_notifier_chain_unregister(str
> > >  }
> > >  EXPORT_SYMBOL_GPL(atomic_notifier_chain_unregister);
> > >  
> > > -/**
> > > - *	__atomic_notifier_call_chain - Call functions in an atomic notifier chain
> > > - *	@nh: Pointer to head of the atomic notifier chain
> > > - *	@val: Value passed unmodified to notifier function
> > > - *	@v: Pointer passed unmodified to notifier function
> > > - *	@nr_to_call: See the comment for notifier_call_chain.
> > > - *	@nr_calls: See the comment for notifier_call_chain.
> > > - *
> > > - *	Calls each function in a notifier chain in turn.  The functions
> > > - *	run in an atomic context, so they must not block.
> > > - *	This routine uses RCU to synchronize with changes to the chain.
> > > - *
> > > - *	If the return value of the notifier can be and'ed
> > > - *	with %NOTIFY_STOP_MASK then atomic_notifier_call_chain()
> > > - *	will return immediately, with the return value of
> > > - *	the notifier function which halted execution.
> > > - *	Otherwise the return value is the return value
> > > - *	of the last notifier function called.
> > > - */
> > 
> > Why remove the useful comment?
> 
> Because I delete the whole function ?

I viewed it as more of a rename... Regardless would the comment not
still be useful for the non-double-underscore version of the function?

-- 
Josh
