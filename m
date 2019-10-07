Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7235AC4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 08:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4591520679
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 08:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="trfi+lAP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbfJGIJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 04:09:17 -0400
Received: from merlin.infradead.org ([205.233.59.134]:56642 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbfJGIJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 04:09:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dabwxm5vomV9WWpSNJ4FIDOpR0IeyzpWs0EaA1S3EiA=; b=trfi+lAPvWdu8emeBU815dHdQ
        2QF+TogFvMx/2Np7wR/Cyq0n3QAL+LcrjhBEPtsnFVNRk1ewdsXeKXqwLOAAsqa1QMyP3P7sM3SDm
        XSab0yll7C2SBecvBVvT72N7eG6xms1DQH5Rv/yrwakvkdyTacVD4+weEwNH79k+hpUwP2cHLD7UA
        47K00aA77rmP/5UP4Wqf+K/kq201UJtItVoxljr8W5E4gHCKK1aF2yzMfa1aK5jKXNFEhvGGQ9Fen
        vOrRguQgFi1UoJ/OWRIgEVG8qDsqYsT9X4ADts2VJtZoa99tSHvTT6gnJvslljoVYKSiHOC08SgvK
        Eisa+fKYw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHO4a-0008JO-Gi; Mon, 07 Oct 2019 08:08:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1BA93305803;
        Mon,  7 Oct 2019 10:07:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id ED45E20245BB0; Mon,  7 Oct 2019 10:08:47 +0200 (CEST)
Date:   Mon, 7 Oct 2019 10:08:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 3/3] x86/ftrace: Use text_poke()
Message-ID: <20191007080847.GB2311@hirez.programming.kicks-ass.net>
References: <20190827180622.159326993@infradead.org>
 <20190827181147.166658077@infradead.org>
 <aaffb32f-6ca9-f9e3-9b1a-627125c563ed@redhat.com>
 <20191002182106.GC4643@worktop.programming.kicks-ass.net>
 <20191003181045.7fb1a5b3@gandalf.local.home>
 <7b4196a4-b6e1-7e55-c3e1-a02d97c262c7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b4196a4-b6e1-7e55-c3e1-a02d97c262c7@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2019 at 10:10:47AM +0200, Daniel Bristot de Oliveira wrote:
> 1) the enabling/disabling ftrace path
> 2) the int3 path - if a thread/irq is running a kernel function
> 3) the IPI - that affects all CPUs, even those that are not "hitting" trace
> code, e.g., user-space.
> 
> The first one is for sure a cold-path. The second one is a hot-path: any task
> running kernel functions will hit it. But IMHO, the hottest one is the IPIs,
> because it will run on all CPUs, e.g., even isolated CPUs that are running in
> user-space.

Well, we can fix that, just like RCU. In fact, I suspect RCU has all the
bits required to cure this.

For NOHZ_FULL CPUs you can forgo the IPI and delay it until the next kernel
entry, just like RCU.
