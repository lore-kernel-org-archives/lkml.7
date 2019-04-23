Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F2C3C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 20:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17B2621773
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 20:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o4FPYx8b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbfDWU2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 16:28:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34302 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfDWU2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 16:28:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KiKACmn7u8Ne4EWVwN4kuGuFiyqg1S1G81UJ96PS45Q=; b=o4FPYx8by33iKGa6/AW475dRj
        J/fe4YYodgtl5b8jau2XTMWfERZ0Q0e9biO9gErcs5VdoNrcdl/2kPlBJKqrina5X1y/Tl5HGrjx/
        B0NnUT+6zB3ke3GnvIHhlrvOIzx1HMzcaJORMdgNf5u1bvnZ5T75OK/SEJznobqj0Gph6g06I0tqd
        gv1wRpkl9r9zQH5quGxwGjemBdl3ViV0WG5rOFprDHD8T3Y2uiUEZiSmANlQIZMuPA3qKzH6FlinA
        N7L0JX7ySm/600orb6DxdBuZ+tkp4OaZ/RB+hBX+BZnqYcEZ08c9qWupNrDzX53vNbW18dXW9lQF6
        Rz5rQK++Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJ21p-00050r-0z; Tue, 23 Apr 2019 20:28:33 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8810129C3F1EB; Tue, 23 Apr 2019 22:28:31 +0200 (CEST)
Date:   Tue, 23 Apr 2019 22:28:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        Luc Maranget <luc.maranget@inria.fr>,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] Documentation: atomic_t.txt: Explain ordering provided
 by smp_mb__{before,after}_atomic()
Message-ID: <20190423202831.GA4038@hirez.programming.kicks-ass.net>
References: <Pine.LNX.4.44L0.1904191312200.1406-100000@iolanthe.rowland.org>
 <20190419180017.GP4038@hirez.programming.kicks-ass.net>
 <20190419182620.GF14111@linux.ibm.com>
 <1555719429.t9n8gkf70y.astroid@bobo.none>
 <20190420085440.GK14111@linux.ibm.com>
 <20190423121715.GQ4038@hirez.programming.kicks-ass.net>
 <20190423132116.GJ3923@linux.ibm.com>
 <20190423132620.GU4038@hirez.programming.kicks-ass.net>
 <20190423201637.GW3923@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423201637.GW3923@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 01:16:37PM -0700, Paul E. McKenney wrote:

> Agreed, but I thought that one of the ideas going forward was to get
> rid of smp_mb__{before,after}_atomic().

It's not one I had considered.. I just wanted to get rid of this
'surprise' behaviour.
