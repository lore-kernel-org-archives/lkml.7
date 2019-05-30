Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8A8C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 23:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4854C2168B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 23:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfE3XwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 19:52:22 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:34378 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726029AbfE3XwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 19:52:21 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Thu, 30 May 2019 16:52:01 -0700
Received: from localhost (unknown [10.129.221.179])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 4B4FA4154D;
        Thu, 30 May 2019 16:52:20 -0700 (PDT)
Date:   Thu, 30 May 2019 16:52:19 -0700
From:   Matt Helsley <mhelsley@vmware.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH 00/13] Cleanup recordmcount and begin objtool
 conversion
Message-ID: <20190530235219.GB63275@rlwimi.vmware.com>
Mail-Followup-To: Matt Helsley <mhelsley@vmware.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
References: <cover.1558569448.git.mhelsley@vmware.com>
 <20190528144328.6wygc2ofk5oaggaf@treble>
 <20190529134152.GX2623@hirez.programming.kicks-ass.net>
 <20190529141145.4tycu25a3os3fpgr@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190529141145.4tycu25a3os3fpgr@treble>
User-Agent: Mutt/1.11.3 (2019-02-01)
Received-SPF: None (EX13-EDG-OU-001.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 09:11:45AM -0500, Josh Poimboeuf wrote:
> On Wed, May 29, 2019 at 03:41:52PM +0200, Peter Zijlstra wrote:
> > On Tue, May 28, 2019 at 09:43:28AM -0500, Josh Poimboeuf wrote:
> > > Would it be feasible to eventually combine subcommands so that objtool
> > > could do both ORC and mcount generation in a single invocation?  I
> > > wonder what what the interface would look like.

I think it'll be feasible. I've done a bit of investigation but don't
have patches for it yet.

> > 
> > objtool orc+mcount ?
> > 
> > That is, have '+' be a separator for cmd thingies. That would of course
> > require all other arguments to be shared between all commands, which is
> > currently already so, but I've not checked the mcount patches.
> 
> The problem is that you have to combine "orc generate" with "mcount
> record".  Because even the subcommands have subcommands ;-)
> 
> And also sharing arguments between all subcommands isn't ideal.
> 
> Maybe could do:
> 
>   objtool orc generate [orc options] + mcount record [mcount options]

I think that makes more sense; it'll be easier to construct
Make recipes this way. I was thinking '+' would be something like the
getopt handling of the '--' argument where it stops argument parsing so
someting else can consume the remainder.

The really interesting part is deciding which file to operate on is
specified by the arguments to the first subcommand and subsequent subcmds
would then operate on the same object file. For example:

objtool orc generate [orc opts] foo.o + mcount record [mcount opts]

Would it be clearer what's going on if the object file(s) were specified
first and then the passes to run and their arguments came afterwards?
I'm thinking it'd go somewhat like this:

objtool foo.o [bar.o] -- check [check opts] + \
			 orc generate [orc opts] + \
			 mcount record [mcount opts]

Then objtool would iterate over the object file(s) to open,
hand off the ELF data structures into each successive pass, and
finally write any accumulated changes back.

Cheers,
    -Matt
