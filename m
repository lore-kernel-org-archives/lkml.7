Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE36C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 18:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F5FC2077C
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 18:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388126AbfGZSnP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 14:43:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:35452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388035AbfGZSnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 14:43:13 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AE252077C;
        Fri, 26 Jul 2019 18:43:12 +0000 (UTC)
Date:   Fri, 26 Jul 2019 14:43:10 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Matt Helsley <mhelsley@vmware.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 04/13] recordmcount: Rewrite error/success handling
Message-ID: <20190726144310.5c62925b@gandalf.local.home>
In-Reply-To: <4F0912A7-345E-46EE-B58F-CF7E8EE2AB65@vmware.com>
References: <cover.1563992889.git.mhelsley@vmware.com>
        <316706a0e2727af0a2639b8e90366746d7a3a84a.1563992889.git.mhelsley@vmware.com>
        <20190726134523.4e7afd55@gandalf.local.home>
        <4F0912A7-345E-46EE-B58F-CF7E8EE2AB65@vmware.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jul 2019 18:37:11 +0000
Matt Helsley <mhelsley@vmware.com> wrote:
 
> >> diff --git a/scripts/recordmcount.h b/scripts/recordmcount.h
> >> index c1e1b04b4871..909a3e4775c2 100644
> >> --- a/scripts/recordmcount.h
> >> +++ b/scripts/recordmcount.h
> >> @@ -24,7 +24,9 @@
> >> #undef mcount_adjust
> >> #undef sift_rel_mcount
> >> #undef nop_mcount
> >> +#undef missing_sym
> >> #undef find_secsym_ndx
> >> +#undef already_has_rel_mcount  
> > 
> > Why do we need these as defines? Can't you just have a single:
> > 
> > const char *already_has_mcount = "success";
> > 
> > in recordmcount.c before recordmcount.h is included?
> > 
> > And same for missing_sym.  
> 
> Yes, that’s a good point. I’ve been trying to separate the changes to
> the functions from moving parts out but in this case it would make
> just as much sense to add them to recordmcount.c in the first place.
> 
> Ultimately, this ugliness gets removed as the next series removes
> recordmcount.h entirely and one of the steps is moving
> find_secsym_ndx() out while eliminating these redundant pieces.

Yeah, this code will be cleaned up later, but let's have the steps in
between look fine as well.


> 
> > 
> > Another, probably more robust way of doing this, is change
> > find_secsym_ndx() to return 0 on success and -1 on missing symbol,
> > and just pass a pointer by reference to fill the recsym (which
> > doesn't have to be a constant).  
> 
> That’s easy enough to do  and  I do like separating the error/success
> return from returning  the index. I can send that out now or tack it
> onto the next RFC series I’m about to send which completes the
> conversion if that’s preferable.
> 
> Yeah, the original code applies “const” in lots of places -- I
> presume it’s an attempt to eek out every last bit of performance from
> the compiler.

As I said before, I've applied patches 1-3, so you don't need to resend
them. I finished looking at the rest, and only this patch needs to be
fixed, and since you are resending, could you fix the "upside-down
x-mas" tree declaration I mentioned in patch 8.

Thanks Matt,

-- Steve
