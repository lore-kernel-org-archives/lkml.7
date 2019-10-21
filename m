Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C551CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 15:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45BFD20873
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 15:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PgS+yulk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729716AbfJUPpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 11:45:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49476 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbfJUPpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 11:45:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YrFW1YMTPl/wrnDJySJQ+JOuKL1K3rZmHZwX+i8FXSI=; b=PgS+yulkfeobT2Z/x1yvEwCfU
        81deRteafh6Z/H/5j/sDQeJujyGYFKxgQJiHxzRP0hx3OvlojNDRMUjwCF2Qu6rqD2Gs7EtmoTkJc
        9IMLltvF8AvzHUztRRxSX9MVlHSiiHd4xoC9EtHNugA6PNwlQpPuliQReMGGqCE1HYJEfYBwcF3Im
        Xdxmfwsku0h4zSflTkDk7blpPhwtIJnAx0eeJJIUzitKJJ+KZeqhnJb5YAmqBOahzWG2mGDzfk1q4
        +Hx2QNbltiQZNBxIGrmgiuU4LL+3++yoKKpa+s8JdCs4TRe8FOk/xqJEqLKUr6K+v/QzGm1886t/C
        eMrn8bt6A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iMZra-0004gV-3Y; Mon, 21 Oct 2019 15:44:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4BCD8300EBF;
        Mon, 21 Oct 2019 17:43:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7567D201BAD9A; Mon, 21 Oct 2019 17:44:52 +0200 (CEST)
Date:   Mon, 21 Oct 2019 17:44:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jeyu@kernel.org
Subject: Re: [PATCH v4 15/16] module: Move where we mark modules RO,X
Message-ID: <20191021154452.GC19358@hirez.programming.kicks-ass.net>
References: <20191018073525.768931536@infradead.org>
 <20191018074634.801435443@infradead.org>
 <20191021135312.jbbxsuipxldocdjk@treble>
 <20191021141402.GI1817@hirez.programming.kicks-ass.net>
 <20191021153425.GB19358@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021153425.GB19358@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 05:34:25PM +0200, Peter Zijlstra wrote:
> So On IRC Josh suggested we use text_poke() for RELA. Since KLP is only
> available on Power and x86, and Power does not have STRICT_MODULE_RWX,
> the below should be sufficient.

And... s390 also has HAVE_LIVEPATCH and STRICT_MODULE_RWX, so let me
poke at that.
