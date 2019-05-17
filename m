Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE37C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 07:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1D9C20873
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 07:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="j/4yVJSH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbfEQHK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 03:10:28 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34414 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbfEQHK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 03:10:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HxUFN7ImIherhziAwE4B0zMLXT1M0ngsvbs97gyVEkE=; b=j/4yVJSH4JiFFugtuMOtwB4uo
        78y9tzESi7HMzHX+wUzTEMVSYVKslEfJ6H8nXugzN1VipITSGlrQuXBMgNEEnYkaQhr/UhTfm2Ejl
        dIL/1/zxXPGhWOfioAkX91ZIXv46+8o3PVtSoVJSf44rKSWOwO7vCIgpToAECIXCgS8LQvHnLw2NO
        Pmhi9uJb0PK4BQJP3fjY123u+cdfxjV4nTpRCvL+oN12r4nKs6c8gOa4e1l2+afp1OYbf1WGsNndF
        yjMkl9tFuUnLwzpUH/3ekvZc3g/5ojgqQ2le3qK5UjvcsGxc6lLh1tMFN0cS3gcCJNbZFfvPBqu5E
        pXwh+QQjw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hRX0X-00075i-Do; Fri, 17 May 2019 07:10:21 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9ED092029906B; Fri, 17 May 2019 09:10:18 +0200 (CEST)
Date:   Fri, 17 May 2019 09:10:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Raphael Gault <raphael.gault@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, catalin.marinas@arm.com, will.deacon@arm.com,
        acme@kernel.org, mark.rutland@arm.com
Subject: Re: [PATCH 4/6] arm64: pmu: Add hook to handle pmu-related undefined
 instructions
Message-ID: <20190517071018.GH2623@hirez.programming.kicks-ass.net>
References: <20190516132148.10085-1-raphael.gault@arm.com>
 <20190516132148.10085-5-raphael.gault@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516132148.10085-5-raphael.gault@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 02:21:46PM +0100, Raphael Gault wrote:
> In order to prevent the userspace processes which are trying to access
> the registers from the pmu registers on a big.LITTLE environment we
> introduce a hook to handle undefined instructions.
> 
> The goal here is to prevent the process to be interrupted by a signal
> when the error is caused by the task being scheduled while accessing
> a counter, causing the counter access to be invalid. As we are not able
> to know efficiently the number of counters available physically on both
> pmu in that context we consider that any faulting access to a counter
> which is architecturally correct should not cause a SIGILL signal if
> the permissions are set accordingly.

The other approach is using rseq for this; with that you can guarantee
it will never issue the instruction on a wrong CPU.

That said; emulating the thing isn't horrible either.

> +	/*
> +	 * We put 0 in the target register if we
> +	 * are reading from pmu register. If we are
> +	 * writing, we do nothing.
> +	 */

Wait _what_ ?!? userspace can _WRITE_ to these registers?
