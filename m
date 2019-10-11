Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF8CDC47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 10:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 863D42084C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 10:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ut4+Z8nv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbfJKK54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 06:57:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35084 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbfJKK54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 06:57:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OCP5lhDCSBpeO5Vh7HhxpRJB7tB8MYPetbw1XJik9JM=; b=ut4+Z8nvRj2QKkHDgyZb8vChp
        gGHdGnQ37YSZiaiaxadpetd4H/F+V6rDUn4vSWi+FKGOjMDDEdyXYBKr7+yuZqb5btAvQZs4j4z5i
        GN3FC/HwoX4uW6vhLkY8HZIaL6TojrTJHHmnekJH90EYM/OjVH3GqPdvsCy34DOqBVMm9E6iHk+YV
        znRagxExipiPbhfYriXkN+eLzkIqJ1+w6lMufS/B2NdSkMI6sGmRPXkuoT1RPRiDX96otpv1zD8iP
        Ps8P1Ih9i1l1JVIggEbYxvX2phGcO4mt3xZ1C0qU1yVwE76TfYHmE5Vn5TTblLYAWD857LYNt2G+r
        jh16CNeyA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iIscE-00051A-PV; Fri, 11 Oct 2019 10:57:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4855B305BD3;
        Fri, 11 Oct 2019 12:56:52 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DCD5520230368; Fri, 11 Oct 2019 12:57:44 +0200 (CEST)
Date:   Fri, 11 Oct 2019 12:57:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 3/3] x86/ftrace: Use text_poke()
Message-ID: <20191011105744.GW2311@hirez.programming.kicks-ass.net>
References: <20190827180622.159326993@infradead.org>
 <20190827181147.166658077@infradead.org>
 <aaffb32f-6ca9-f9e3-9b1a-627125c563ed@redhat.com>
 <20191002182106.GC4643@worktop.programming.kicks-ass.net>
 <20191003181045.7fb1a5b3@gandalf.local.home>
 <7b4196a4-b6e1-7e55-c3e1-a02d97c262c7@redhat.com>
 <20191011070126.GU2328@hirez.programming.kicks-ass.net>
 <c482a958-e1f5-d39a-21e2-ade5cd41798e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c482a958-e1f5-d39a-21e2-ade5cd41798e@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 09:37:10AM +0200, Daniel Bristot de Oliveira wrote:
> On 11/10/2019 09:01, Peter Zijlstra wrote:
> > On Fri, Oct 04, 2019 at 10:10:47AM +0200, Daniel Bristot de Oliveira wrote:
> >> Currently, ftrace_rec entries are ordered inside the group of functions, but
> >> "groups of function" are not ordered. So, the current int3 handler does a (*):
> > We can insert a sort() of the vector right before doing
> > text_poke_bp_batch() of course...
> 
> I agree!
> 
> What I tried to do earlier this week was to order the ftrace_pages in the
> insertion [1], and so, while sequentially reading the pages with
> do_for_each_ftrace_rec() we would already see the "ip"s in order.
> 
> As ftrace_pages are inserted only at boot and during a load of a module, this
> would push the ordering for a very very slow path.
> 
> It works! But under the assumption that the address of functions in a module
> does not intersect with the address of other modules/kernel, e.g.:
> 
> kernel:          module A:      module B:
> [ 1, 2, 3, 4 ]   [ 7, 8, 9 ]    [ 15, 16, 19 ]
> 
> But this does not happen in practice, as I saw things like:
> 
> kernel:          module A:      module B:
> [ 1, 2, 3, 4 ]   [ 7, 8, 18 ]   [ 15, 16, 19 ]
>                          ^^ <--- greater than the first of the next
> 
> Is this expected?

Expected is I think a big word. That is, I would certainly not expect
that, but I think I can see how it can happen.

Suppose that init sections are placed at the end (didn't verify, but
makes sense), then suppose that A's 18 is in an init section, which gets
freed once the module load is completed. We then proceed to load B,
which then overlaps with what used to be A's init.

If this were the case, then while we could retain the pach location for
A's 18, we would never actually modify it, because it's gotten marked
freed or something (that's how jump_labels work, I didn't check what
ftrace actually does here).

So while the above contains some assumptions, it is a semi plausable
explanation for what you've described.
