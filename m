Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F44BC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 12:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D807520643
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 12:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B60hfypX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbfCGMcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 07:32:45 -0500
Received: from merlin.infradead.org ([205.233.59.134]:51354 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbfCGMco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 07:32:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=x3s5JOKP4qCXZzU4hjE9cM90uEEJWbBvF2xoIeQgxGI=; b=B60hfypXvswHvJZt1sYbWI/LM
        5+O2fKYAa5GL9aQfkTowzSD1ixFh18g5FoBe/LdXArTqyUnatIPZlY6/RSvJHpZ9GeJTMOVUowvnd
        qdihvNnRlCzLH3IvCfjo4mh9/qX7RttEqholXtdBkGNyHHiCrIKu2TaMOJBfGStup0qoCBrRrnKzv
        MbpYszB2m5rcft1/2jFq9JabaRadhuCCJLflmzBCbh/Eg5cFYXIYLhn1dUW7o8xv30UGluPgYlse3
        uD+WRLuhqNTm/ZUqJ0P8SZz92YX2OpdeXbwvbpXL3y4XzgDBD32X328tN+ABeukNDJ3SNAbfzR5YV
        A6+dB0vHA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h1sBu-0005dy-Gp; Thu, 07 Mar 2019 12:32:06 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EFA6F20297BC0; Thu,  7 Mar 2019 13:32:00 +0100 (CET)
Date:   Thu, 7 Mar 2019 13:32:00 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, jpoimboe@redhat.com,
        luto@kernel.org, bp@alien8.de, dvlasenk@redhat.com,
        linux-kernel@vger.kernel.org, dvyukov@google.com,
        rostedt@goodmis.org, andrew.cooper3@citrix.com,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: Re: [PATCH 05/20] x86/uaccess/xen: Suppress SMAP warnings
Message-ID: <20190307123200.GE32477@hirez.programming.kicks-ass.net>
References: <20190307114511.870090179@infradead.org>
 <20190307115159.530608243@infradead.org>
 <689d6dc2-77d6-018e-b156-979b2724be7b@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <689d6dc2-77d6-018e-b156-979b2724be7b@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 01:22:52PM +0100, Juergen Gross wrote:
> On 07/03/2019 12:45, Peter Zijlstra wrote:
> > drivers/xen/privcmd.o: warning: objtool: privcmd_ioctl()+0x1414: call to hypercall_page() with UACCESS enabled
> > 
> > Xen needs to do HV calls with AC=1 for hysterical raisins. Make the
> > warning go away.
> 
> No, this is a hypercall with parameters passed through from user land
> (Xen tools). So setting AC=1 is not related to hysterical reasons, but
> to indicate that unprivileged buffers are okay here. So please change
> the commit message to something like:
> 
> Some Xen hypercalls allow parameter buffers in user land, so they need
> to set AC=1. Avoid the warning for those cases.

*yuck* that's gross...

And I understood from Andrew yesterday (but perhaps I misunderstood)
that the whole privcmd thing was a bit of a hack.

But sure, I'll change the message.

> > XXX: arguably we should rename ANNOTATE_NOSPEC_ALTERNATIVE to
> >      ANNOTATE_IGNORE_ALTERNATIVE.
> > 
> > Cc: andrew.cooper3@citrix.com
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> Mind Cc-ing the maintainers of the code you are touching in future
> patches?

Sure; my bad, I forgot to ask get_maintainers about this.
