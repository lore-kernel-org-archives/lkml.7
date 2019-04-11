Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A82BC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A9DD2184B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="U9vfwt42"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbfDKJNg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 05:13:36 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33360 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfDKJNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 05:13:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CQFYrD8VWl5Gfv+Cb3DnJ71MhRi7HJxQOWx6pkykjnw=; b=U9vfwt42lm0LL9vkIW2TLFsA+
        80uGYX5ACF1yjNM8XaK3oryw06zMBtffAqXc37YchaNjr7j86p2DIK/baiDUFRtr3U//RRy/KEOqp
        ij3LLcE2rYrQT7rV2g7kqWrQvIbSK5OHKG3kOaj0X6F8Wb6t8bKWbegAPEZGFgZF70OTbte0CJBb4
        BtTAwzzS408c3cKVx7z98vSeRq2syXLM12NxrGlI1EjwTNwPLyoRQX4LQqQtn1IxbkQDI4gP9+6qr
        1NZSZIehUw6gwmdpdnh4whgP51xtdyiNWhI3dlVfbFOCvtfCXFITPQqt2+foWLdBqmSI8cwrjERB7
        X7hioJPxg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hEVlv-0000MN-Bk; Thu, 11 Apr 2019 09:13:27 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C18712029E070; Thu, 11 Apr 2019 11:13:24 +0200 (CEST)
Date:   Thu, 11 Apr 2019 11:13:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexander Potapenko <glider@google.com>
Subject: Re: [RFC patch 40/41] stacktrace: Remove obsolete functions
Message-ID: <20190411091324.GE4038@hirez.programming.kicks-ass.net>
References: <20190410102754.387743324@linutronix.de>
 <20190410103647.205989744@linutronix.de>
 <20190411033320.64zafrthhsm2ohdm@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411033320.64zafrthhsm2ohdm@treble>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 10:33:20PM -0500, Josh Poimboeuf wrote:
> On Wed, Apr 10, 2019 at 12:28:34PM +0200, Thomas Gleixner wrote:

> > +struct stack_trace {
> > +	unsigned int nr_entries, max_entries;
> > +	unsigned long *entries;
> > +	int skip;	/* input argument: How many entries to skip */
> > +};
> 
> I was a bit surprised to see struct stack_trace still standing at the
> end of the patch set, but I guess 41 patches is enough :-)  Do we want
> to eventually remove the struct altogether?
> 
> I was also hoping to see the fragile "skipnr" go away in favor of
> something less dependent on compiler optimizations, but I'm not sure how
> feasible that would be.

It will die, but that only takes another nr_arch+1 patches.
