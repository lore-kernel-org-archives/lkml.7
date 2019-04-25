Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F2DC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1108020578
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pWzyznDP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbfDYJVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 05:21:39 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48740 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbfDYJVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 05:21:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qZyRFHbuZukZmfmnwgyc+C4vF/QY+Jjhr3Rd5Mvry0c=; b=pWzyznDPgZIBF3o1BefRXUPhw
        fZPG8zYZfiYskW1Lcbtp/+cisjT9GIsGDSIfvQwTwbknmvdUOPGrqegfxiTiBm9vg1pLwUS8yz+q1
        Xx7HByMp+ez/8Zlf8U27JwxAh17cBqbWLiIdTqLWy0xLG1zKBpY0bSqRysA974DZB+5xTBb87VTcx
        +Vz9Efig4D4iP6Nf9DF6sBzmBmQYNJA+ymD5CBNF8Ib1n2aso3ik3OiY2TTe36/3l3AGMKCV0SihE
        GwgahuWQt7LSLIG8ep8nzKxa7LuYxr+iZBfbdu4PUCd32eKV7fMtXzQTSbe5L3ncksLhyMj3b4b6L
        +ywMCm7WQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJaZR-0001op-6z; Thu, 25 Apr 2019 09:21:33 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C6D1629BC31D9; Thu, 25 Apr 2019 11:21:31 +0200 (CEST)
Date:   Thu, 25 Apr 2019 11:21:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Juergen Gross <jgross@suse.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] x86/paravirt: Detect oversized patching bugs as they
 happen and BUG_ON() to avoid later crashes
Message-ID: <20190425092131.GL4038@hirez.programming.kicks-ass.net>
References: <20190424134115.091452807@linutronix.de>
 <20190424134223.690835713@linutronix.de>
 <20190425065209.GA89582@gmail.com>
 <alpine.DEB.2.21.1904250921010.1762@nanos.tec.linutronix.de>
 <20190425081012.GA115378@gmail.com>
 <20190425091717.GA72229@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190425091717.GA72229@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 11:17:17AM +0200, Ingo Molnar wrote:
> It basically means that we silently won't do any patching and the kernel 
> will crash later on in mysterious ways, because paravirt patching is 
> usually relied on.

That's OK. The compiler emits an indirect CALL/JMP to the pv_ops
structure contents. That _should_ stay valid and function correctly at
all times.

Not patching should at the very least cause a WARN with RETPOLINE
kernels though, we hard rely on the patching actually working and
writing at least a direct call.
