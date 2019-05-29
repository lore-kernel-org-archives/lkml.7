Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC236C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 14:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98BAA23956
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 14:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbfE2OLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 10:11:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53824 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726897AbfE2OLs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 10:11:48 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 297BD3003E4F;
        Wed, 29 May 2019 14:11:48 +0000 (UTC)
Received: from treble (ovpn-123-24.rdu2.redhat.com [10.10.123.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 699BB5B681;
        Wed, 29 May 2019 14:11:47 +0000 (UTC)
Date:   Wed, 29 May 2019 09:11:45 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Matt Helsley <mhelsley@vmware.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH 00/13] Cleanup recordmcount and begin objtool
 conversion
Message-ID: <20190529141145.4tycu25a3os3fpgr@treble>
References: <cover.1558569448.git.mhelsley@vmware.com>
 <20190528144328.6wygc2ofk5oaggaf@treble>
 <20190529134152.GX2623@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190529134152.GX2623@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Wed, 29 May 2019 14:11:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 03:41:52PM +0200, Peter Zijlstra wrote:
> On Tue, May 28, 2019 at 09:43:28AM -0500, Josh Poimboeuf wrote:
> > Would it be feasible to eventually combine subcommands so that objtool
> > could do both ORC and mcount generation in a single invocation?  I
> > wonder what what the interface would look like.
> 
> objtool orc+mcount ?
> 
> That is, have '+' be a separator for cmd thingies. That would of course
> require all other arguments to be shared between all commands, which is
> currently already so, but I've not checked the mcount patches.

The problem is that you have to combine "orc generate" with "mcount
record".  Because even the subcommands have subcommands ;-)

And also sharing arguments between all subcommands isn't ideal.

Maybe could do:

  objtool orc generate [orc options] + mcount record [mcount options]

> Alternatively, we ditch the command thing entirely and live off of pure
> flags:
> 
>  'o', "orc", "Generate ORC data"
>  'c', "mcount', "Generate mcount() location data"

-- 
Josh
