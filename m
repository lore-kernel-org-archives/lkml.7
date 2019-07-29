Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5002C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 15:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 928222070D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 15:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xtfjplAv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388172AbfG2Po1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 11:44:27 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47850 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387476AbfG2Po1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 11:44:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=qErB5hAyr+6D1ok8s8gYAwp7NlEM0ZUbJetryLu9lfI=; b=xtfjplAvplgj8E7ZbGTMOZ/Xfe
        X7BDyj9GfttyYNCU9AOypvshDqSYZTru04BNEExlfrvPcdD+e7aDw/83uj3n1uL0IuBhszUN3Hv49
        7qjpvBxQKjlsU4TWhIRJqBjU8MFYrhHW58v0gf6gFRNqd6foy/7NCCxUMYtCbgFndhUpfR3JLo9fF
        gt+Arzhzdkuu3ajbMxLZXv7xisD5kPPPqbJyM6A/eU639MecKRngik0KgdHmrd/GlusUrN4JeHkiD
        OcbpYBeg+bDKZKPPAWXkhERkBsUe3pAHjVvwkhGjEVGGN0uqFIJNPy3mU8B2X2mpzpN+F3H6RzX26
        7g5MHmfA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hs7p0-0003fc-8q; Mon, 29 Jul 2019 15:44:22 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CD26120AF2C00; Mon, 29 Jul 2019 17:44:19 +0200 (CEST)
Date:   Mon, 29 Jul 2019 17:44:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Phil Auld <pauld@redhat.com>, Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v2] sched/core: Don't use dying mm as active_mm of
 kthreads
Message-ID: <20190729154419.GJ31398@hirez.programming.kicks-ass.net>
References: <20190727171047.31610-1-longman@redhat.com>
 <20190729085235.GT31381@hirez.programming.kicks-ass.net>
 <4cd17c3a-428c-37a0-b3a2-04e6195a61d5@redhat.com>
 <20190729150338.GF31398@hirez.programming.kicks-ass.net>
 <25cd74fcee33dfd0b9604a8d1612187734037394.camel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <25cd74fcee33dfd0b9604a8d1612187734037394.camel@surriel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 11:28:04AM -0400, Rik van Riel wrote:
> On Mon, 2019-07-29 at 17:03 +0200, Peter Zijlstra wrote:
>=20
> > The 'sad' part is that x86 already switches to init_mm on idle and we
> > only keep the active_mm around for 'stupid'.
>=20
> Wait, where do we do that?

drivers/idle/intel_idle.c:              leave_mm(cpu);
drivers/acpi/processor_idle.c:  acpi_unlazy_tlb(smp_processor_id());

> > Rik and Andy were working on getting that 'fixed' a while ago, not
> > sure
> > where that went.
>=20
> My lazy TLB stuff got merged last year.=20

Yes, but we never got around to getting rid of active_mm for x86, right?
