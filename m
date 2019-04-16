Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19942C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D62932075B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d4iAVZZZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729887AbfDPS2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 14:28:43 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48944 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbfDPS2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 14:28:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FGAlWlRTOVmvwmqM+hUxLa/1vH+3hq7pUWAUUwCnH0g=; b=d4iAVZZZnlRAdytTea5az0d9i
        67DlGQ+fv67YTuUYExlbmTo8Olm1TnFp6GQwhEdns2i6xoReTzSuqW1STWRRcgw6DUfygQdNkEG+g
        r8zO6jf7cFOGTdQCC6yqBmd4or7BK+x9evNzkBcSNII83tMpKX5cDutqqesV0O5+DTirF5cGanlwz
        LR6CkF5u6/1VT0e8+eUbOTP29I/O5NbNVSGf10I5REtisbJH/MK53QNT1tHh27CclSxMfBLKAWuYS
        9Nug3XLoZIqYP6oGsPYZeihssLnLrAzx/WIOHpQbY5Rya6YDJTUfzWakOjrnV5IhU6CFtjMfB4mcv
        hN4j/+cMw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGSor-0005Mz-Hx; Tue, 16 Apr 2019 18:28:33 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B76D4238A887D; Tue, 16 Apr 2019 20:28:31 +0200 (CEST)
Date:   Tue, 16 Apr 2019 20:28:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Nadav Amit <namit@vmware.com>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH] x86/tlb: Revert: Align TLB invalidation info
Message-ID: <20190416182831.GU4038@hirez.programming.kicks-ass.net>
References: <20190416080335.GM7905@worktop.programming.kicks-ass.net>
 <CAHk-=whgXyXCy9vHY2hKJ9Pa8PnwdwKo9eOQ3jDbCs_FkdDvkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whgXyXCy9vHY2hKJ9Pa8PnwdwKo9eOQ3jDbCs_FkdDvkQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 10:45:05AM -0700, Linus Torvalds wrote:
> So very much Ack on that patch, but maybe we could do a bit more cleanup here?

Yeah, Nadav was going to try and clean that up. But I figured we should
get this revert in and backported while it's hot :-)
