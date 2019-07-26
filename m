Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D79DC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 16:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0356F2077C
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 16:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GGSBKs0a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbfGZQU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 12:20:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52114 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbfGZQU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 12:20:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Subject:Cc:To:From:Date:Message-Id:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vs0plZoW9YBvgEuWj8ZX0N8sgCZZcP+k7Xdkb3rZzxY=; b=GGSBKs0aM1sFhRvTPD/9SIfpm
        OPjMZ6gVew/Qy+h66ThbHSRf2pVqFDUsbgQCyvTg/kU6XXUNQSrHq33ViVNMxtdzzzAsvLUYxKBxW
        RhsI+scary6Fi6zHsQr+Hn5Q/qbjXo35i+UU5oW4l1A8ytiat4Hc+HCnwzZZmU7UuqfscmtS611Bf
        nCY5DbXA03HjOXKJWOTaCTxkgY+4IDPByaqTVU9cQeOdA3UxLJ0UvGKtGAXIxHw2vB8bnTqSuZFQC
        fLR17cwB9agPYNKXAt7OYgy05Z/JbMsIdmfDlikd0soqPyIEhIRn/xzkb6rb1tQEh8SnCI53AnQHU
        WLm2THeGA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hr2wx-0006Zl-Fm; Fri, 26 Jul 2019 16:20:07 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 3BA2B2022974C; Fri, 26 Jul 2019 18:20:05 +0200 (CEST)
Message-Id: <20190726145409.947503076@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 26 Jul 2019 16:54:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, juri.lelli@redhat.com
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        luca.abeni@santannapisa.it, bristot@redhat.com,
        balsini@android.com, dvyukov@google.com, tglx@linutronix.de,
        vpillai@digitalocean.com, rostedt@goodmis.org, peterz@infradead.org
Subject: [RFC][PATCH 00/13] SCHED_DEADLINE server infrastructure
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

So recently syzcaller ran into the big deadline/period issue (again), and I
figured I should at least propose a patch that puts limits on that -- see Patch 1.

During that discussion; SCHED_OTHER servers got mentioned (also again), and I
figured I should have a poke at that too. So I took some inspiration from
patches Alessio Balsini send a while back and cobbled something together for
that too.

Included are also a bunch of patches I did for core scheduling (2-8),
which I'm probably going to just merge as they're generic cleanups.
They're included here because they make pick_next_task() simpler and
thereby thinking about the nested pick_next_task() logic inherent in
servers was less of a head-ache. (I think it can work fine without them,
but its easier with them on)

Anyway; after it all compiled it booted a kvm image all the way to userspace on
the first run, so clearly this code isn't to be trusted at all.

There's still lots of missing bits and pieces -- like changelogs and the
fair server isn't configurable or hooked into the bandwidth accounting,
but the foundation is there I think.

Enjoy!

