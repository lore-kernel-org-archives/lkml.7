Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 504E7C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 18:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22CAB20830
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 18:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbfEFSKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 14:10:53 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58378 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbfEFSKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 14:10:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8A08A78;
        Mon,  6 May 2019 11:10:52 -0700 (PDT)
Received: from brain-police (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 10A6C3F5AF;
        Mon,  6 May 2019 11:10:50 -0700 (PDT)
Date:   Mon, 6 May 2019 19:10:40 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Jayachandran Chandrasekharan Nair <jnair@marvell.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Glauber <jglauber@marvell.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXT] Re: [RFC] Disable lockref on arm64
Message-ID: <20190506181039.GA2875@brain-police>
References: <20190429145159.GA29076@hc>
 <CAHk-=wjPqcPYkiWKFc=R3+18DXqEhV+Nfbo=JWa32Xp8Nze67g@mail.gmail.com>
 <20190502082741.GE13955@hc>
 <CAHk-=wjmtMrxC1nSEHarBn8bW+hNXGv=2YeAWmTw1o54V8GKWA@mail.gmail.com>
 <20190502231858.GB13168@dc5-eodlnx05.marvell.com>
 <CAHk-=wiEahkwDXpoy=-SzJHNMRXKVSjPa870+eKKenufhO_Hgw@mail.gmail.com>
 <20190506061100.GA8465@dc5-eodlnx05.marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190506061100.GA8465@dc5-eodlnx05.marvell.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 06, 2019 at 06:13:12AM +0000, Jayachandran Chandrasekharan Nair wrote:
> Perhaps someone from ARM can chime in here how the cas/yield combo
> is expected to work when there is contention. ThunderX2 does not
> do much with the yield, but I don't expect any ARM implementation
> to treat YIELD as a hint not to yield, but to get/keep exclusive
> access to the last failed CAS location.

Just picking up on this as "someone from ARM".

The yield instruction in our implementation of cpu_relax() is *only* there
as a scheduling hint to QEMU so that it can treat it as an internal
scheduling hint and run some other thread; see 1baa82f48030 ("arm64:
Implement cpu_relax as yield"). We can't use WFE or WFI blindly here, as it
could be a long time before we see a wake-up event such as an interrupt. Our
implementation of smp_cond_load_acquire() is much better for that kind of
thing, but doesn't help at all for a contended CAS loop where the variable
is actually changing constantly.

Implementing yield in the CPU may generally be beneficial for SMT designs so
that the hardware resources aren't wasted when spinning round a busy loop.
For this particular discussion (i.e. lockref), however, it seems as though
the cpu_relax() call is questionable to start with.

Will
