Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FF4C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 14:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 878A7214AE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 14:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0APDjc88"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfCMOY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 10:24:29 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49460 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfCMOY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 10:24:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=a4OyokzJ/PfwKHkjkdPAJOWjXzZnOndTsqzTCOs98hs=; b=0APDjc88M/vhI7ZjIxeccmsxN
        Vg8zVRZ8bV7g0eNpSh2idWD9CtKQGgRfAO0sFVHaEfFmqBJkeGhu+VlIdiq15unpxYUdGJK9MxfIm
        CKhMDOOzKeRNTHNytKQkeevhzfYGp4qBicfVHC3w6GwddGmG7dXGQYi79SpOEOMmyngM9BacjO8sC
        Y5EKweiYy56d2U0Bcs8GsPhYrisdrjCgMEgsFe2dZJSbGjZ3ZtulWGbL2mV+C5GneLWH55qKoD15G
        TWv57LnJBxKSCKJmZRQ+9z39IhcjkVglnUogmlQSly6lkYLsr/1+RTsQAW63wwLckOFtjLSl1bWfA
        kt3VfRp7A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h44nq-0003Qh-OZ; Wed, 13 Mar 2019 14:24:19 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 82B4720298565; Wed, 13 Mar 2019 15:24:17 +0100 (CET)
Date:   Wed, 13 Mar 2019 15:24:17 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Qian Cai <cai@lca.pw>, Jason Gunthorpe <jgg@mellanox.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] mm/debug: add a cast to u64 for atomic64_read()
Message-ID: <20190313142417.GF5996@hirez.programming.kicks-ass.net>
References: <20190310183051.87303-1-cai@lca.pw>
 <20190311035815.kq7ftc6vphy6vwen@linux-r8p5>
 <20190311122100.GF22862@mellanox.com>
 <1552312822.7087.11.camel@lca.pw>
 <CAK8P3a0QB7+oPz4sfbW_g2EGZZmC=LMEnkMNLCW_FD=fEZoQPA@mail.gmail.com>
 <20190313091844.GA24390@hirez.programming.kicks-ass.net>
 <CAK8P3a3_2O7KBKTSD-QC5tcpohy8bkVVHsdAJnanTU1B+H12-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3_2O7KBKTSD-QC5tcpohy8bkVVHsdAJnanTU1B+H12-w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 02:46:55PM +0100, Arnd Bergmann wrote:
> It would be tempting to use scripts/atomic/* to generate more of
> the code in a consistent way, but that is likely to be even more
> work and more error-prone at the start.

Those scripts can't do actual implementations, which is the problem here
I think. The architectures really need to implement a whole bunch of
stuff themselves.
