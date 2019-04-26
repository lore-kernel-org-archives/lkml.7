Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E3FC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 07:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29B9F206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 07:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zCHgoeMm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbfDZHyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 03:54:02 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59428 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfDZHyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 03:54:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uAvx3d3/cKphohPsiu9DZOfBv9cjOPg+wsnLLb2OzZY=; b=zCHgoeMmJS8YKiw61Ctj0c29e
        utnZMwCXhDat9KusX/Yd1pmweJ4Q9mXttDRpSMT04TKRYMjpKLUb9F3gWZlVqnYsfhAgfzp0RPhrE
        X0heD6EeRs7FWLeWRk4IY5TBf3pbn2iZd7tBNxPlypHhLq8L0Ilb88DQZsigKYbJNfvMbdkBN4OF/
        OX/FhNPHdQn8eZF5AjJj5nrWuPqOtpto1xMzWuS7qHxTlBHtqlkyS38x/xRX5eHTwp+iR59WpUplR
        wVOOSrHu9egBC7rmH7T+mUaLHyCzlaRnKMRkwXHnZiIczA9BPBTzfX89mU+sD04qmqjVeIWirz4Nw
        GLuaocetg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJvg8-0004bF-MI; Fri, 26 Apr 2019 07:53:53 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0281629D1A322; Fri, 26 Apr 2019 09:53:49 +0200 (CEST)
Date:   Fri, 26 Apr 2019 09:53:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v2] x86/mm/tlb: Remove flush_tlb_info from the stack
Message-ID: <20190426075349.GA4038@hirez.programming.kicks-ass.net>
References: <20190425180828.24959-1-namit@vmware.com>
 <20190425192930.GA91578@gmail.com>
 <82E44F4A-E52D-4666-95B5-C6248A14A442@vmware.com>
 <20190425194837.GB58719@gmail.com>
 <FA82D7BD-5657-4681-B76E-3452A71171B6@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FA82D7BD-5657-4681-B76E-3452A71171B6@vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 09:20:24PM +0000, Nadav Amit wrote:

> > I think that's a bug and PeterZ is fixing those.
> 
> This would be quite surprising.

I need to get back to that percpu series .... :/

> Even atomic_dec() does not imply a compilers
> barrier. I think I should leave it as is for now, and let Peter change it
> later if he decides to do so. Let me know if you disagree.

https://lkml.kernel.org/r/20190424124421.808471451@infradead.org
