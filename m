Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02301C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 18:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB6FE26C46
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 18:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfEaSey (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 14:34:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43518 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726640AbfEaSey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 14:34:54 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4D4B930842A9;
        Fri, 31 May 2019 18:34:54 +0000 (UTC)
Received: from treble (ovpn-124-142.rdu2.redhat.com [10.10.124.142])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 98E1616C6D;
        Fri, 31 May 2019 18:34:53 +0000 (UTC)
Date:   Fri, 31 May 2019 13:34:51 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Matt Helsley <mhelsley@vmware.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH 00/13] Cleanup recordmcount and begin objtool
 conversion
Message-ID: <20190531183451.vncrseq2s7cpevrp@treble>
References: <cover.1558569448.git.mhelsley@vmware.com>
 <20190528144328.6wygc2ofk5oaggaf@treble>
 <20190529134152.GX2623@hirez.programming.kicks-ass.net>
 <20190529141145.4tycu25a3os3fpgr@treble>
 <20190530235219.GB63275@rlwimi.vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190530235219.GB63275@rlwimi.vmware.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Fri, 31 May 2019 18:34:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 04:52:19PM -0700, Matt Helsley wrote:
> > > objtool orc+mcount ?
> > > 
> > > That is, have '+' be a separator for cmd thingies. That would of course
> > > require all other arguments to be shared between all commands, which is
> > > currently already so, but I've not checked the mcount patches.
> > 
> > The problem is that you have to combine "orc generate" with "mcount
> > record".  Because even the subcommands have subcommands ;-)
> > 
> > And also sharing arguments between all subcommands isn't ideal.
> > 
> > Maybe could do:
> > 
> >   objtool orc generate [orc options] + mcount record [mcount options]
> 
> I think that makes more sense; it'll be easier to construct
> Make recipes this way. I was thinking '+' would be something like the
> getopt handling of the '--' argument where it stops argument parsing so
> someting else can consume the remainder.
> 
> The really interesting part is deciding which file to operate on is
> specified by the arguments to the first subcommand and subsequent subcmds
> would then operate on the same object file. For example:
> 
> objtool orc generate [orc opts] foo.o + mcount record [mcount opts]
> 
> Would it be clearer what's going on if the object file(s) were specified
> first and then the passes to run and their arguments came afterwards?
> I'm thinking it'd go somewhat like this:
> 
> objtool foo.o [bar.o] -- check [check opts] + \
> 			 orc generate [orc opts] + \
> 			 mcount record [mcount opts]
> 
> Then objtool would iterate over the object file(s) to open,
> hand off the ELF data structures into each successive pass, and
> finally write any accumulated changes back.

Yeah, I forgot about the .o file.  Something like that would probably
work.  The ordering seems a bit funny to me.  Another possibly more
readable variation would be:

  objtool check [check opts] + orc generate [orc opts] + mcount record [mcount opts] -- foo.o [bar.o]

or, just use '--' as a generic separator which can be used to separate
subcommands or file names.

  objtool check [check opts] -- orc generate [orc opts] -- mcount record [mcount opts] -- foo.o [bar.o]

I kind of like that.  But I think any of these variations would probably
work.

-- 
Josh
