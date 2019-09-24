Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDF7C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 07:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C72820673
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 07:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569311282;
	bh=Q0dx1bFxaf2xHgxN4/UXveMRnOufT7B40M+lU3oaCI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=d2k0VhwfTzDpqUfhrTXX9zFeNLGCxer1SCNfDKRTqDqlaeujvjD0eOYOfAxLgJPyX
	 vCUCdhvN9gU7M1Lc8GpYWoHqSrH3z9Rh9bDkaTJ6IlDOcEFENiMmpgVZrMiLNcTzwL
	 HP66jrFn4UQLDiNytDF28q3kXPNCXUSnUaAuB7oY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438807AbfIXHsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 03:48:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:52168 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389597AbfIXHsA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 03:48:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C8B0CAFA5;
        Tue, 24 Sep 2019 07:47:56 +0000 (UTC)
Date:   Tue, 24 Sep 2019 09:47:51 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Yunsheng Lin <linyunsheng@huawei.com>, catalin.marinas@arm.com,
        will@kernel.org, mingo@redhat.com, bp@alien8.de, rth@twiddle.net,
        ink@jurassic.park.msu.ru, mattst88@gmail.com,
        benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com, ysato@users.sourceforge.jp,
        dalias@libc.org, davem@davemloft.net, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, jiaxun.yang@flygoat.com,
        chenhc@lemote.com, akpm@linux-foundation.org, rppt@linux.ibm.com,
        anshuman.khandual@arm.com, tglx@linutronix.de, cai@lca.pw,
        robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, x86@kernel.org,
        dave.hansen@linux.intel.com, luto@kernel.org, len.brown@intel.com,
        axboe@kernel.dk, dledford@redhat.com, jeffrey.t.kirsher@intel.com,
        linux-alpha@vger.kernel.org, naveen.n.rao@linux.vnet.ibm.com,
        mwb@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, tbogendoerfer@suse.de,
        linux-mips@vger.kernel.org, rafael@kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v6] numa: make node_to_cpumask_map() NUMA_NO_NODE aware
Message-ID: <20190924074751.GB23050@dhcp22.suse.cz>
References: <1568724534-146242-1-git-send-email-linyunsheng@huawei.com>
 <20190923151519.GE2369@hirez.programming.kicks-ass.net>
 <20190923152856.GB17206@dhcp22.suse.cz>
 <20190923154852.GG2369@hirez.programming.kicks-ass.net>
 <20190923165235.GD17206@dhcp22.suse.cz>
 <20190923203410.GI2369@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923203410.GI2369@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 23-09-19 22:34:10, Peter Zijlstra wrote:
> On Mon, Sep 23, 2019 at 06:52:35PM +0200, Michal Hocko wrote:
[...]
> > I even the
> > ACPI standard is considering this optional. Yunsheng Lin has referred to
> > the specific part of the standard in one of the earlier discussions.
> > Trying to guess the node affinity is worse than providing all CPUs IMHO.
> 
> I'm saying the ACPI standard is wrong.

Even if you were right on this the reality is that a HW is likely to
follow that standard and we cannot rule out NUMA_NO_NODE being
specified. As of now we would access beyond the defined array and that
is clearly a bug.

Let's assume that this is really a bug for a moment. What are you going
to do about that? BUG_ON? I do not really see any solution besides to either
provide something sensible or BUG_ON. If you are worried about a
conditional then this should be pretty easy to solve by starting the
array at -1 index and associate it with the online cpu mask.
-- 
Michal Hocko
SUSE Labs
