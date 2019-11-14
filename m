Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9919FC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 16:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BF8820724
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 16:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573749596;
	bh=PTKkYOF538f1BfiJH54rPCCMJM9wzIDTNfQcUOB9nNw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WTCFVsNqbyaFF8Mr3vcoKvYY7rUEtJVim3Gim/y4W4XlcHgKwKaDlHUUF46RIemiJ
	 eeI8CQgxOyvr6z+OTDUDZgae2O2kWaguhX13P+MjjFWAT8C6ipJ9xtgBXrC0oeh99Y
	 9O4p31bkJv7ncNrwfIaGXUAYWHnJ6vM2roStkWSw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbfKNQjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 11:39:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:57724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbfKNQjz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 11:39:55 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5897206DB;
        Thu, 14 Nov 2019 16:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573749594;
        bh=PTKkYOF538f1BfiJH54rPCCMJM9wzIDTNfQcUOB9nNw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MWTFt5Rq2pveMB+L+QaMgeH7P0sOa0jN+pG8Sex7+EBw0TCWC/nLN039QkzIyPn9v
         2RVcmksBs7o0gsK52BDP5B3cFFqcVNOq2zwCpb01eo4jIZ0oysPLtiYvTlX80Oo70g
         e6EadHc1yFckWb5SJH+lyuf2CqICuueq555dKpD8=
Date:   Thu, 14 Nov 2019 16:39:48 +0000
From:   Will Deacon <will@kernel.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        james.morse@arm.com, catalin.marinas@arm.com, mark.rutland@arm.com,
        maz@kernel.org
Subject: Re: [PATCH 0/5] arm64: Add workaround for Cortex-A77 erratum 1542418
Message-ID: <20191114163948.GA5158@willie-the-truck>
References: <20191114145918.235339-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191114145918.235339-1-suzuki.poulose@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On Thu, Nov 14, 2019 at 02:59:13PM +0000, Suzuki K Poulose wrote:
> This series adds workaround for Arm erratum 1542418 which affects

Searching for that erratum number doesn't find me a description :(

> Cortex-A77 cores (r0p0 - r1p0). Affected cores may execute stale
> instructions from the L0 macro-op cache violating the
> prefetch-speculation-protection guaranteed by the architecture.
> This happens when the when the branch predictor bases its predictions
> on a branch at this address on the stale history due to ASID or VMID
> reuse.

Two immediate questions:

 1. Can we disable the L0 MOP cache?
 2. Can we invalidate the branch predictor? If Spectre-v2 taught us
    anything it's that removing those instructions was a mistake!

Moving on...

Have you reproduced this at top-level? If I recall the
prefetch-speculation-protection, it's designed to protect against the
case where you have a direct branch:

addr:	B	foo

and another CPU writes out a new function:

bar:
	insn0
	...
	insnN

before doing any necessary maintenance and then patches the original
branch to:

addr:	B	bar

The idea is that a concurrently executing CPU could mispredict the original
branch to point at 'bar', fetch the instructions before they've been written
out and then confirm the prediction by looking at the newly written branch
instruction. Even without the prefetch-speculation-protection, that's
fairly difficult to achieve in practice: you'd need to be doing something
like reusing memory to hold the instructions so that the initial
misprediction occurs.

How does A77 stop this from occurring when the ASID is not reallocated (e.g.
the example above)? Is the MOP cache flushed somehow?

With this erratum, it sounds like you have to end up reusing an ASID from
a task that had a branch at 'addr' in its address space that branched to
the address of 'bar' (again. in its address space). Is that right? That
sounds super rare to me, particularly with ASLR: not only does the aliasing
branch need to exist, but it needs to be held in the branch predictor while
we cycle through 64k ASIDs *and* the race with the writer needs to happen
so that we get stale instructions from the MOP cache.

Is there something I'm missing that makes this remotely plausible?

Will
