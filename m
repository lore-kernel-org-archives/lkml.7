Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC70C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 419A32075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbfCKSAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:00:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52196 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726864AbfCKSAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:00:16 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2C6AB88304;
        Mon, 11 Mar 2019 18:00:16 +0000 (UTC)
Received: from treble (ovpn-123-151.rdu2.redhat.com [10.10.123.151])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 95830608E2;
        Mon, 11 Mar 2019 18:00:11 +0000 (UTC)
Date:   Mon, 11 Mar 2019 13:00:09 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, luto@kernel.org,
        bp@alien8.de, dvlasenk@redhat.com, linux-kernel@vger.kernel.org,
        dvyukov@google.com, rostedt@goodmis.org
Subject: Re: [PATCH 20/20] objtool: Add Direction Flag validation
Message-ID: <20190311180009.7dpvwevuufz7jdxm@treble>
References: <20190307114511.870090179@infradead.org>
 <20190307115200.878625203@infradead.org>
 <20190308211603.fpjbd5avcuoox6xf@treble>
 <20190308213343.GE2482@worktop.programming.kicks-ass.net>
 <20190308215602.txm4bv2eg2tyubuj@treble>
 <20190310131331.GK2482@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190310131331.GK2482@worktop.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Mon, 11 Mar 2019 18:00:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 10, 2019 at 02:13:31PM +0100, Peter Zijlstra wrote:
> On Fri, Mar 08, 2019 at 03:56:02PM -0600, Josh Poimboeuf wrote:
> > On Fri, Mar 08, 2019 at 10:33:43PM +0100, Peter Zijlstra wrote:
> > > On Fri, Mar 08, 2019 at 03:16:03PM -0600, Josh Poimboeuf wrote:
> 
> > > > Can you elaborate on why (in the patch description)?  Did this actually
> > > > find any occurrences?
> > > 
> > > Nope, didn't find anything. Also, all DF users are in asm so I didn't
> > > really expect any. Having it escape would probably result in fairly
> > > instant wreckage though.
> > > 
> > > DF=1 results in things like rep mov going _backwards_.
> > 
> > Ok, I wonder if we really need to add this then.
> 
> Well, Linus asked for it, and it was a fairly trivial add-on :-)

If it doesn't matter much either way, I'd rather err on the side of less
code.  Your call though.

-- 
Josh
