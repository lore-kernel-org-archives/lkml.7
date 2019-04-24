Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A1C3C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CAE321773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mzKcNJef"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730286AbfDXM7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 08:59:40 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34688 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbfDXM7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 08:59:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7QX33KgC67PDoTzrkrqnfdnUhUCkvPPCxb+Xpw4YLKc=; b=mzKcNJefoMtUENFS+fT8vBw/b
        tMBRZ2HSCIhMFX4cFwOKcY8SqdrqPSa3Ll/tBOMLJiRUOPpO/KyDiAZfWGU2x4fVrfcAFPrhnA/zi
        mAov4DUDwTBKVgTTz502tzocn7w5kJhjhzB7bwqB/Qy+7q8JBGMzWTN6wXIkcRRVqWEqZ/QwDWpgu
        6cKhOG4nyHq3LC+KZoZgFLS4NlsduaoGRFuUPW4NTzSSG9I7LS/RUPdac1tS2Aur2GPP+K6CuFiW+
        jmtdGln8ys5QPk6Kefb+LZY9kWXNMd5Fh2rWDRppku6Pl0gMTQjux4hfpzQ2E3QXHVe+7VgvOwV2C
        w/l6k5E/Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJHUZ-0003LE-71; Wed, 24 Apr 2019 12:59:15 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EEA5729BD4885; Wed, 24 Apr 2019 14:59:13 +0200 (CEST)
Date:   Wed, 24 Apr 2019 14:59:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     stern@rowland.harvard.edu, akiyks@gmail.com,
        andrea.parri@amarulasolutions.com, boqun.feng@gmail.com,
        dlustig@nvidia.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, npiggin@gmail.com, paulmck@linux.ibm.com,
        will.deacon@arm.com
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        Huacai Chen <chenhc@lemote.com>,
        Huang Pei <huangpei@loongson.cn>,
        Paul Burton <paul.burton@mips.com>
Subject: Re: [RFC][PATCH 2/5] mips/atomic: Fix loongson_llsc_mb() wreckage
Message-ID: <20190424125913.GO12232@hirez.programming.kicks-ass.net>
References: <20190424123656.484227701@infradead.org>
 <20190424124421.636767843@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424124421.636767843@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 02:36:58PM +0200, Peter Zijlstra wrote:
> The comment describing the loongson_llsc_mb() reorder case doesn't
> make any sense what so ever. Instruction re-ordering is not an SMP
> artifact, but rather a CPU local phenomenon. This means that _every_
> LL/SC loop needs this barrier right in front to avoid the CPU from
> leaking a memop inside it.
> 
> For the branch speculation case; if futex_atomic_cmpxchg_inatomic()
> needs one at the bne branch target, then surely the normal
> __cmpxch_asmg() implementation does too. We cannot rely on the
> barriers from cmpxchg() because cmpxchg_local() is implemented with
> the same macro, and branch prediction and speculation are, too, CPU
> local.

Also; just doing them all makes for much simpler rules and less
mistakes.
