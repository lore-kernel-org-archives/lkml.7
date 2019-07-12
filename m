Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58550C742BA
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2396A2080A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XWiPp5T3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729618AbfGLMhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 08:37:18 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34172 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727762AbfGLMhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 08:37:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PRvJtsiHkVhvqvxWg5gOuLt8FA07mI2n7b2F9lWVt6s=; b=XWiPp5T3wZ07wSFz7SP2NGQsi
        SARqMlSa4wSWOALaD9zIg48cd8FkwtQzlyIqn2H/VG3zk8ew8txJuiyK0bOkKModvW1URTSAtHINQ
        BZfWo+f5pIdJEIj7pAAvGEgTpPGjztlFq+c1d86X1AriCw0HX9pAgtl/T5P5ViqzB3YbIpgpshlHU
        P1J4uQYE12VLgjTpHpbC3L2N8BZKengJ4RvrWQRLvD4ZCTcLEujoFj57iE9i92rblgnnWe2dtnErg
        JISh4LW8iD+LzsB0jFgfRy48PCLVuwRGtiiYaxws8B1vrL+LnY4BgsRnlKs2MI4YxasxwKR7M1GTy
        hU+YmR/Kw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hlunH-0005Rb-23; Fri, 12 Jul 2019 12:36:56 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 65784209772E6; Fri, 12 Jul 2019 14:36:53 +0200 (CEST)
Date:   Fri, 12 Jul 2019 14:36:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexandre Chartre <alexandre.chartre@oracle.com>
Cc:     pbonzini@redhat.com, rkrcmar@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, kvm@vger.kernel.org,
        x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        konrad.wilk@oracle.com, jan.setjeeilers@oracle.com,
        liran.alon@oracle.com, jwadams@google.com, graf@amazon.de,
        rppt@linux.vnet.ibm.com, Paul Turner <pjt@google.com>
Subject: Re: [RFC v2 00/27] Kernel Address Space Isolation
Message-ID: <20190712123653.GO3419@hirez.programming.kicks-ass.net>
References: <1562855138-19507-1-git-send-email-alexandre.chartre@oracle.com>
 <20190712114458.GU3402@hirez.programming.kicks-ass.net>
 <1f97f1d9-d209-f2ab-406d-fac765006f91@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f97f1d9-d209-f2ab-406d-fac765006f91@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 02:17:20PM +0200, Alexandre Chartre wrote:
> On 7/12/19 1:44 PM, Peter Zijlstra wrote:

> > AFAIK3 this wants/needs to be combined with core-scheduling to be
> > useful, but not a single mention of that is anywhere.
> 
> No. This is actually an alternative to core-scheduling. Eventually, ASI
> will kick all sibling hyperthreads when exiting isolation and it needs to
> run with the full kernel page-table (note that's currently not in these
> patches).
> 
> So ASI can be seen as an optimization to disabling hyperthreading: instead
> of just disabling hyperthreading you run with ASI, and when ASI can't preserve
> isolation you will basically run with a single thread.

You can't do that without much of the scheduler changes present in the
core-scheduling patches.
