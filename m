Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 755D7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4850A218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="foREaUFV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbfCUSnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 14:43:02 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38164 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728057AbfCUSnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 14:43:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uttlB9voS92ZxALrRx0JnyjxxffLvGSv6XphhQ9EYZQ=; b=foREaUFVYKsoBWeAZ8KV3iBri
        8458jXg+aocUtbu0OBtlrQLQdvTw35enNrtX4GAXGG/5lK8brD/z2pfLXJzETWGrL/uTkPEZH9uhC
        RjRyoIC1ucUv76BFsUbJIDtsn7IQta9kNQQd67W5bEWY7WRpQDHozlVuK8Md7OwCbVzbrqUeM8Rdn
        hsHu/7BCg0aLmvMTmYFiN7bTwu0QhcewpgB0au1FisIs1Xgi+FlVCImSVIK/lilbHEqWjYibzZSo+
        HPkPLNwWQKKd8bZ17spG0klEaltw/GEG2r31xNO4tzJqWOjtzqP6CaqJxJpFBVhlL1gAM9IHmenLD
        fveaQDUbA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h72e8-0001fV-LB; Thu, 21 Mar 2019 18:42:32 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 661CE21BEC724; Thu, 21 Mar 2019 19:42:31 +0100 (CET)
Date:   Thu, 21 Mar 2019 19:42:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Jan Beulich <jbeulich@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        He Zhe <zhe.he@windriver.com>
Subject: Re: [RFC][PATCH] tracing/x86: Save CR2 before tracing irqsoff on
 error_entry
Message-ID: <20190321184231.GR6058@hirez.programming.kicks-ass.net>
References: <20190321083317.GL6058@hirez.programming.kicks-ass.net>
 <20190321090241.GL6521@hirez.programming.kicks-ass.net>
 <20190321104517.GM6521@hirez.programming.kicks-ass.net>
 <20190321093242.4a948198@gandalf.local.home>
 <20190321172203.GS5996@hirez.programming.kicks-ass.net>
 <CALCETrXqmjJt7azNoEtxs2eBkDd-vjUAYvrjNh_RD30DAvksBw@mail.gmail.com>
 <CAHk-=whSeiDXVvhie_bBPqDw99JNJMdTuX8ef82BhNanyo7zRw@mail.gmail.com>
 <CALCETrVaCZKjXj9ZqtvQgLk2DqXwNCh7b5DHvSnNAORsqJXCcQ@mail.gmail.com>
 <CAHk-=wjEHqY1+DxJ-_oNWTuTNQwMPtJKJh_HE=e1F60V+TwUfQ@mail.gmail.com>
 <CALCETrVUUbSv_pQyVXUSmKV5Jw9DN1y2ib4zGix5Y-9DXw2nGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrVUUbSv_pQyVXUSmKV5Jw9DN1y2ib4zGix5Y-9DXw2nGg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 11:38:25AM -0700, Andy Lutomirski wrote:

> I suspect we'll want PV spinlocks and other goodies like PV TLB
> shootdown for a long time.  The stuff I'd like to kill eventually is
> the PV "I'm not actually at CPL 0 so I'm faking it" part.

Right, and it's exactly those bits that are PARAVIRT_XXL AFAIU.
