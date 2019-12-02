Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA17C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 16:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA7ED2071F
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 16:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OED4IyTy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbfLBQnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 11:43:32 -0500
Received: from merlin.infradead.org ([205.233.59.134]:45768 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727459AbfLBQnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 11:43:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=o7z4AAJInIfL4gKaAcpTvAYmbfUd91xXg4CQ5NXh6Hg=; b=OED4IyTy85CwKHHNf0I7M/htk
        ZcAmjZQ2PN8ctAtF5U3bxprBSyCP1/Ws5Sd8k0RBVgnjH8CNJ+tJfCw1qL7Q2lLwumHxG7znkiJS0
        jrz40dFgvwUhsxDK2lfVpE7NtFFAetEy7i4mO4jc0VwvvhXBFnmnFYsHzqA/FEB6LB0i7VNAn8y/V
        0ibtIKPh3Kz+SUCQhEt/bm7GBLKj3uj5/9D7JkaRk6xvPEwvZNG52wA2H/uCfyraGrlch3xNJg9tM
        izxfVqqAuBibVLb6OtrUf0hDjACxt/sBvLp3hltyVxoaKAvMbuR7/rX//nWENHnpApRa/6rJ0X3n8
        akQQTqmcA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ibon7-0001jT-B7; Mon, 02 Dec 2019 16:43:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0A9F83011DD;
        Mon,  2 Dec 2019 17:41:58 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EC849201DD686; Mon,  2 Dec 2019 17:43:13 +0100 (CET)
Date:   Mon, 2 Dec 2019 17:43:13 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>, kan.liang@linux.intel.com,
        mingo@redhat.com, acme@kernel.org, tglx@linutronix.de,
        bp@alien8.de, linux-kernel@vger.kernel.org, eranian@google.com,
        vitaly.slobodskoy@intel.com
Subject: Re: [RFC PATCH 3/8] perf: Init/fini PMU specific data
Message-ID: <20191202164313.GM2844@hirez.programming.kicks-ass.net>
References: <1574954071-6321-1-git-send-email-kan.liang@linux.intel.com>
 <1574954071-6321-3-git-send-email-kan.liang@linux.intel.com>
 <20191202124055.GC2827@hirez.programming.kicks-ass.net>
 <20191202145957.GM84886@tassilo.jf.intel.com>
 <79138ea7-2249-b7e0-3541-8569e593c6e8@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79138ea7-2249-b7e0-3541-8569e593c6e8@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 02, 2019 at 07:38:00PM +0300, Alexey Budankov wrote:
> 
> On 02.12.2019 17:59, Andi Kleen wrote:
> >>
> >> This is atricous crap. Also it is completely broken for -RT.
> > 
> > Well can you please suggest how you would implement it instead?
> 
> FWIW,
> An alternative could probably be to make task_ctx_data allocations
> on the nearest context switch in, and obvious drawback is slowdown on
> this critical path, but it could be amortized by static branches.

Context switch is under a raw_spinlock_t too.
