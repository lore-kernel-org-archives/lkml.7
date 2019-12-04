Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E97C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 12:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92AF02077B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 12:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VSpWWV6N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbfLDMhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 07:37:10 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53138 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbfLDMhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 07:37:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZzCSk1fVGYsKa4mpW0zBDhBYag2lMaeRmgfUQsjzofc=; b=VSpWWV6N9rXAO9kLKhiJRE3F5
        iNh1HYE80pUy8AL8f7MyKpGWxahVW3jZovgSnjqrsDu5CTJvnzkfTUzcapUndYxtdLHqHL0pektto
        Hg71pS/EaXlZnEXOoTPG/FJkGiEkp8o+wHDAMoHzPIz/avdrp/kqEbAyWcBLB3gNZiR0K/hF7g1JW
        EqbSuLG4eKQwqvd9dUsk8QdoWfZKtIKyGYr1lIrbaHalcQPHyezC7jqTN0zY/AFXKjIuF714XZVr6
        +0Bopg2tiJnCr7YGp9F9OWXAu85mTPRcNXdxGU4zqBzWcwZBKANgXPsV8HYL9AnYv1diEDW+MrEAE
        KmiZ4bCAg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1icTtr-00087U-6I; Wed, 04 Dec 2019 12:36:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3961D3011E0;
        Wed,  4 Dec 2019 13:35:40 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D4BC82024721C; Wed,  4 Dec 2019 13:36:56 +0100 (CET)
Date:   Wed, 4 Dec 2019 13:36:56 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     mingo@redhat.com, acme@kernel.org, tglx@linutronix.de,
        bp@alien8.de, linux-kernel@vger.kernel.org, eranian@google.com,
        alexey.budankov@linux.intel.com, vitaly.slobodskoy@intel.com,
        ak@linux.intel.com
Subject: Re: [RFC PATCH 2/8] perf: Helpers for alloc/init/fini PMU specific
 data
Message-ID: <20191204123656.GU2844@hirez.programming.kicks-ass.net>
References: <1574954071-6321-1-git-send-email-kan.liang@linux.intel.com>
 <1574954071-6321-2-git-send-email-kan.liang@linux.intel.com>
 <20191202131646.GD2827@hirez.programming.kicks-ass.net>
 <2d036aa5-542a-8c01-762c-3b68136887f5@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d036aa5-542a-8c01-762c-3b68136887f5@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 02, 2019 at 03:35:00PM -0500, Liang, Kan wrote:

> Could you please give me an example?

There's a ton of refcounting in perf, none of it follows this pattern.

> I think we do need something to protect the refcount. Are you suggesting
> atomic_*?

refcount_t comes to mind.
