Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE823C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF672218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="v+SbGxvr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730316AbfDXMsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 08:48:08 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34546 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730073AbfDXMsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 08:48:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Subject:Cc:To:From:Date:Message-Id:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HOXaa+GrX97Crnzs458tfb3mCzyClzAfwc8nPDoHtOI=; b=v+SbGxvr7HhZqAgMN62h4ZCFQ
        bqExN+3AWFcLIZhRGN59ETQSL0FQLRVUweu/DX2e6jPWgoPaHi9utox6FZLcRIybHK3sbKHsFglMe
        O6GXJA/0GL1Nl2zb5LRt3D4j1OSVSn9GhyqDVcROjTZGiBAgKEQpxKG8m4XHlsYPlQf6PpbgIktP/
        y+VMT7FpJI05nsfqYAFhfzb4HKfc3ftfkUXfY791hbVBPBy1Xca5fFD+aNnOXyqzxHNCvYMbC+xXh
        Pltqy9382+4yV5EpOZ1sPGzY3FDf7KGS3+c2Rsh+uA2HEkJKWvLcJwBi1VsjeBBtib8C31Td1M9W0
        a3fBQJy3w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJHJS-0003HM-0F; Wed, 24 Apr 2019 12:47:46 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 612B12038D7B0; Wed, 24 Apr 2019 14:47:43 +0200 (CEST)
Message-Id: <20190424123656.484227701@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 24 Apr 2019 14:36:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     stern@rowland.harvard.edu, akiyks@gmail.com,
        andrea.parri@amarulasolutions.com, boqun.feng@gmail.com,
        dlustig@nvidia.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, npiggin@gmail.com, paulmck@linux.ibm.com,
        peterz@infradead.org, will.deacon@arm.com
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
Subject: [RFC][PATCH 0/5] atomic: Fixes to smp_mb__{before,after}_atomic() and mips...
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

Only the x86 patch is actually compile tested, the MIPS things are fresh from
the keyboard.

