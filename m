Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C36FBC74A35
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 22:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 974FF21019
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 22:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tvj7nWZT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbfGJWJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 18:09:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59292 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbfGJWJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 18:09:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YyhdUNqc+1DemkH/mFNcRWRYGtV6ZT58QmHsWfF+fSI=; b=tvj7nWZTgbw4gHPrUgwXWZGXZ
        ooryy+Kv8N/TYO33WSXlxLBltdW0qgv6qSk5M3fBVYumNzMHDyPbZYopJJyI5n8efu/6LfVjKzL+p
        Y/NfGGL/ZXhiJqfxIJU8lk2FcHraOmMPhgw8ulQu9aqqaLfmRZFF+A8O9CHR1tCGuQNiNxs/zBAgY
        BtDEpH7Hsovn993InHZyZ/S/1rLNnq7MTQa+GkVPN6dp9UHUL5+8JKg+RAOH+ndtztgIWbSqqqpoZ
        jc/zNIfduEECVlJkUm2/sv2jm3QEo8MsNeRLpAvgW33LANeh2UKfm+Wg+/H2ZRoma7xS0fri7ylvS
        kD8IBSJPQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hlKmY-00016P-34; Wed, 10 Jul 2019 22:09:46 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CEB57201247EB; Thu, 11 Jul 2019 00:09:43 +0200 (CEST)
Date:   Thu, 11 Jul 2019 00:09:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org,
        syzbot <syzbot+6f39a9deb697359fe520@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com
Subject: Re: BUG: MAX_STACK_TRACE_ENTRIES too low! (2)
Message-ID: <20190710220943.GM3419@hirez.programming.kicks-ass.net>
References: <b378a903-d0fc-a137-e6b9-dec55277cf16@acm.org>
 <20190710170057.GB801@sol.localdomain>
 <20190710172123.GC801@sol.localdomain>
 <f498d8cc-ba82-d3dc-7557-142a1b35976a@acm.org>
 <20190710180242.GA193819@gmail.com>
 <a19779d0-0192-8dc0-d51b-e6938a455f31@acm.org>
 <47a9287d-1f02-95d5-a5cf-55f0c0d38378@gmail.com>
 <cdfeb3f8-8dc5-aa60-2782-7b3c5110edf5@acm.org>
 <ee3bac8d-d061-7d07-5990-59871e7e2a4b@gmail.com>
 <9219c421-0868-f97f-2d84-df48aed9f8a8@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9219c421-0868-f97f-2d84-df48aed9f8a8@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 02:23:39PM -0700, Bart Van Assche wrote:
> As one can see in remove_class_from_lock_chain() there is already code
> present in lockdep for compacting the chain_hlocks[] array. Similar code
> is not yet available for the stack_trace[] array because I had not
> encountered any overflows of that array during my tests.

One thing I mentioned when Thomas did the unwinder API changes was
trying to move lockdep over to something like stackdepot.

We can't directly use stackdepot as is, because it uses locks and memory
allocation, but we could maybe add a lower level API to it and use that
under the graph_lock() on static storage or something.

Otherwise we'll have to (re)implement something like it.

I've not looked at it in detail.
