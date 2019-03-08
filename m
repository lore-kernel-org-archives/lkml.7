Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6446CC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 22:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25BA120857
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 22:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbfCHW1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 17:27:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45276 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726286AbfCHW1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 17:27:50 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 72AB33082137;
        Fri,  8 Mar 2019 22:27:50 +0000 (UTC)
Received: from treble (ovpn-123-151.rdu2.redhat.com [10.10.123.151])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E3F694141;
        Fri,  8 Mar 2019 22:27:46 +0000 (UTC)
Date:   Fri, 8 Mar 2019 16:27:44 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, luto@kernel.org,
        bp@alien8.de, dvlasenk@redhat.com, linux-kernel@vger.kernel.org,
        dvyukov@google.com, rostedt@goodmis.org
Subject: Re: [PATCH 16/20] objtool: Rewrite alt->skip_orig
Message-ID: <20190308222744.fox35ov75zxi6wis@treble>
References: <20190307114511.870090179@infradead.org>
 <20190307115200.515578829@infradead.org>
 <20190308201510.4luzked52x3sdezg@treble>
 <20190308213418.GF2482@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190308213418.GF2482@worktop.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Fri, 08 Mar 2019 22:27:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 10:34:18PM +0100, Peter Zijlstra wrote:
> On Fri, Mar 08, 2019 at 02:15:56PM -0600, Josh Poimboeuf wrote:
> > On Thu, Mar 07, 2019 at 12:45:27PM +0100, Peter Zijlstra wrote:
> > > Really skip the original instruction flow, instead of letting it
> > > continue with NOPs.
> > > 
> > > Since the alternative code flow already continues after the original
> > > instructions, only the alt-original is skipped.
> > 
> > I like this approach.  I wonder if we can do something similar to get
> > rid of the nasty fake jumps.
> 
> This actually hard relies on those fake jumps. Or am I missing the
> point?

I was just wondering out loud if we could somehow keep the same "fake
jump" functionality, but do it in a cleaner way that doesn't require
creating fake instructions.  I'll might give it a try.

-- 
Josh
