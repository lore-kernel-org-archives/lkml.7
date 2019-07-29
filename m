Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE882C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92E57206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0Bdz75ko"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbfG2Q07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 12:26:59 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48306 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbfG2Q07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 12:26:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=UR1nwN2DobERwDBbUiUS2eO5vjDIciCJ3KKzmZdKH0Q=; b=0Bdz75ko9JlIuIV7NBooLQGYXZ
        xKeLkiHp/upUnBeY/3RRAQ0w80wxz5hCRhdmbkGPTGDXX9l34bW83spOgXr7BkgDvyJTpD+nzx5Hk
        f7FHE5z3duaS40ug1H6vAfes/hnn2Ko81P07zJpuFTAL9ysk0mR3cEIhP4kdMn+6LN68BxDqEqg3v
        vkbk9UEmf86iZJLfE3J2DUX4/gv/0Oc6UlSCCyR2JKl/sG/g/FaCWfhkauzVmzAft4OuEWMV9uzqL
        q/iTWXu+CcGDHtSRVDr/0z1kzIMyyfsTEHTStTW5ZEfMyH43HSdf7OqvfzZOKEvTHMaAeCC7x0xSI
        V21kBB3A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hs8UA-00041z-Ot; Mon, 29 Jul 2019 16:26:55 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 75A7C20AFFE9F; Mon, 29 Jul 2019 18:26:53 +0200 (CEST)
Date:   Mon, 29 Jul 2019 18:26:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Phil Auld <pauld@redhat.com>, Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v2] sched/core: Don't use dying mm as active_mm of
 kthreads
Message-ID: <20190729162653.GE31381@hirez.programming.kicks-ass.net>
References: <20190727171047.31610-1-longman@redhat.com>
 <20190729085235.GT31381@hirez.programming.kicks-ass.net>
 <4cd17c3a-428c-37a0-b3a2-04e6195a61d5@redhat.com>
 <20190729150338.GF31398@hirez.programming.kicks-ass.net>
 <25cd74fcee33dfd0b9604a8d1612187734037394.camel@surriel.com>
 <20190729154419.GJ31398@hirez.programming.kicks-ass.net>
 <aba144fbb176666a479420eb75e5d2032a893c83.camel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <aba144fbb176666a479420eb75e5d2032a893c83.camel@surriel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 12:10:12PM -0400, Rik van Riel wrote:
> On Mon, 2019-07-29 at 17:44 +0200, Peter Zijlstra wrote:
> > On Mon, Jul 29, 2019 at 11:28:04AM -0400, Rik van Riel wrote:
> > > On Mon, 2019-07-29 at 17:03 +0200, Peter Zijlstra wrote:
> > >=20
> > > > The 'sad' part is that x86 already switches to init_mm on idle
> > > > and we
> > > > only keep the active_mm around for 'stupid'.
> > >=20
> > > Wait, where do we do that?
> >=20
> > drivers/idle/intel_idle.c:              leave_mm(cpu);
> > drivers/acpi/processor_idle.c:  acpi_unlazy_tlb(smp_processor_id());
>=20
> This is only done for deeper c-states, isn't it?

Not C1 but I forever forget where it starts doing that. IIRC it isn't
too hard to hit it often, and I'm fairly sure we always do it when we
hit NOHZ.

> > > > Rik and Andy were working on getting that 'fixed' a while ago,
> > > > not
> > > > sure
> > > > where that went.
> > >=20
> > > My lazy TLB stuff got merged last year.=20
> >=20
> > Yes, but we never got around to getting rid of active_mm for x86,
> > right?
>=20
> True, we still use active_mm. Getting rid of the
> active_mm refcounting alltogether did not look
> entirely worthwhile the hassle.

OK, clearly I forgot some of the details ;-)
