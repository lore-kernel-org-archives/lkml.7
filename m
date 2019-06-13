Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E264C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7703420896
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Dyedfdz8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387594AbfFMPKp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:10:45 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49582 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732306AbfFMNvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 09:51:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Subject:Cc:To:From:Date:Message-Id:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=l04+nuc8FItMhrlUdke+dDyeO4FcnJ4DLhxtL7h4uWw=; b=Dyedfdz8cqa1qtwMp4kxTOjis
        yz6nEYshl3JJmNB6VXPpJNo560qsMGykCHEhUrEl7UPK5q7gjLymIqN7dbMKW/6p6oiEZXDRetq9L
        BppDMIVPaY/ATTg4tP2vaIFm1d/pSCPSwX9JpZO5Fvzth8PbuQomyeC6xv+yn7yARxVU7LTnaWwqZ
        WcCeaOQlpgze1p3Qi/vrSeYF9FfL8gE/U/l8jsxtuGp+MK1aOdqaGcZzvQJgOmYzOPpdqjvVisGny
        iGzfeLgu2nOeGsTY6xQ0oCN0JJGNn8sr1MrsG918wFRehWQjHgCSMHkOksRUXU8G0ZAzVd9OKhsBj
        nYMSOBLPw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbQ7z-0004Bn-KB; Thu, 13 Jun 2019 13:50:55 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id EE15520316592; Thu, 13 Jun 2019 15:50:53 +0200 (CEST)
Message-Id: <20190613134317.734881240@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 13 Jun 2019 15:43:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     stern@rowland.harvard.edu, akiyks@gmail.com,
        andrea.parri@amarulasolutions.com, boqun.feng@gmail.com,
        dlustig@nvidia.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, npiggin@gmail.com, paulmck@linux.ibm.com,
        peterz@infradead.org, will.deacon@arm.com, paul.burton@mips.com
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
Subject: [PATCH v2 0/4] atomic: Fixes to smp_mb__{before,after}_atomic() and mips.
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This all started when Andrea Parri found a 'surprising' behaviour for x86:

  http://lkml.kernel.org/r/20190418125412.GA10817@andrea

Basically we fail for:

	*x = 1;
	atomic_inc(u);
	smp_mb__after_atomic();
	r0 = *y;

Because, while the atomic_inc() implies memory order, it
(surprisingly) does not provide a compiler barrier. This then allows
the compiler to re-order like so:

	atomic_inc(u);
	*x = 1;
	smp_mb__after_atomic();
	r0 = *y;

Which the CPU is then allowed to re-order (under TSO rules) like:

	atomic_inc(u);
	r0 = *y;
	*x = 1;

And this very much was not intended.

This had me audit all the (strong) architectures that had weak
smp_mb__{before,after}_atomic: ia64, mips, sparc, s390, x86, xtensa.

Of those, only x86 and mips were affected. Looking at MIPS to solve this, led
to the other MIPS patches.

All these patches have been through 0day for quite a while.

Paul, how do you want to route the MIPS bits?

