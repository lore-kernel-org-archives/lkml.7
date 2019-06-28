Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F27D8C5B579
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 17:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBA5C208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 17:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561743216;
	bh=YxLIbKTsXkeNGBeOgLGxsdbSlVn+lJmPvWdqZxXTY9o=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=WiJm/8zcK2Ll0JzUFlL1N8ZM5CYyzCoQXnk9Gn9J0QCnlugOIPXnQA+5Y8DCJiB62
	 YRiI6PF9JmSgU2wmZ2m/zUUpWnKlOe4LdDWTN9zp/IgshqQQ6IOYnPV7zvUTfPITQw
	 i5vck/CmsEuYmCu5glG1n+cl2HUF3FF4zR5A29gY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfF1Rdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 13:33:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:43608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726408AbfF1Rdf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 13:33:35 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51963205F4;
        Fri, 28 Jun 2019 17:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561743214;
        bh=YxLIbKTsXkeNGBeOgLGxsdbSlVn+lJmPvWdqZxXTY9o=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=lZNM7yCzcrOSyI3/CgtnTokCk4mMR6mCJmdqoLmYGM1WM5otsXUNnnQEp0vRhmrDq
         Be6O2NjBK4O85riWi67JSswsP7XxCWR0O1K3HXuuZBuHKlfc3bHbbL1+oloZqOWHdA
         fDE89s425UzPn+xbOWWKx4qBmOuMM6jiJ7/fUSYE=
Date:   Fri, 28 Jun 2019 19:33:30 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
cc:     Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>,
        Miroslav Benes <mbenes@suse.cz>, Jessica Yu <jeyu@kernel.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
        Johannes Erdfelt <johannes@erdfelt.com>,
        Ingo Molnar <mingo@kernel.org>, mhiramat@kernel.org,
        torvalds@linux-foundation.org
Subject: Re: [PATCH] ftrace: Remove possible deadlock between register_kprobe()
 and ftrace_run_update_code()
In-Reply-To: <20190627231952.nqkbtcculvo2ddif@treble>
Message-ID: <nycvar.YFH.7.76.1906281932360.27227@cbobk.fhfr.pm>
References: <20190627081334.12793-1-pmladek@suse.com> <20190627224729.tshtq4bhzhneq24w@treble> <20190627190457.703a486e@gandalf.local.home> <alpine.DEB.2.21.1906280106360.32342@nanos.tec.linutronix.de> <20190627231952.nqkbtcculvo2ddif@treble>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jun 2019, Josh Poimboeuf wrote:

> > How is that supposed to work?
> > 
> >     ftrace  	     	
> > 	prepare()
> > 	 setrw()
> > 			setro()
> > 	patch <- FAIL
> 
> /me dodges frozen shark
> 
> You are right of course.  My brain has apparently already shut off for
> the day.
> 
> Maybe a comment or two would help though.

I'd actually prefer (perhaps in parallel to the comment) using the 
__acquires() and __releases() anotations, so that sparse and friends don't 
get confused by that either.

-- 
Jiri Kosina
SUSE Labs

