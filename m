Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C251C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84664206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pGEkRoLH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730899AbfDYUDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 16:03:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51760 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727873AbfDYUDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 16:03:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OXcAVsdqOGUXkbYQOEo7XQ6GAUCp7NVsTJfv5Z9H1oE=; b=pGEkRoLHHf7WCOTpebU1p5Tkb
        fQg5VvGVH6d7flq0ybt9WkZLhw/HaQlJ35a3WedPfxTZJe6y3NzszxcRmVJPB/DaWHxcxKcm6pCw9
        rFtH75r1jeKPenS440w/KA19A/e8V1lEwZcviJwxMxzZtvRLFr9+9YxzvwYlVf41mqM7ihCibI5U0
        2UkBSeODIl8H6rYbsaYJ6OOwrrO8VUPbh59bz0ZOvTb1+HgeCQkariuYtauik9VMKGfyqBJB3DNc2
        AhwMXEzjkjvn7H5Uvap0N1IRdhU2+QIjbOnC/cJj211AWRQ1B39ztLNKlgAcTM/09dCAINhVUPjEB
        pzhwdMbYw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJkao-0001r0-4d; Thu, 25 Apr 2019 20:03:38 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9DF3F29CB5DC9; Thu, 25 Apr 2019 22:03:36 +0200 (CEST)
Date:   Thu, 25 Apr 2019 22:03:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yuyang Du <duyuyang@gmail.com>
Cc:     will.deacon@arm.com, mingo@kernel.org, bvanassche@acm.org,
        ming.lei@redhat.com, frederic@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH 24/28] locking/lockdep: Remove !dir in lock irq usage
 check
Message-ID: <20190425200336.GY12232@hirez.programming.kicks-ass.net>
References: <20190424101934.51535-1-duyuyang@gmail.com>
 <20190424101934.51535-25-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424101934.51535-25-duyuyang@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 06:19:30PM +0800, Yuyang Du wrote:
> In mark_lock_irq(), the following checks are performed:
> 
>    ----------------------------------
>   |   ->      | unsafe | read unsafe |
>   |----------------------------------|
>   | safe      |  F  B  |    F* B*    |
>   |----------------------------------|
>   | read safe |  F? B* |      -      |
>    ----------------------------------
> 
> Where:
> F: check_usage_forwards
> B: check_usage_backwards
> *: check enabled by STRICT_READ_CHECKS
> ?: check enabled by the !dir condition
> 
> From checking point of view, the special F? case does not make sense,
> whereas it perhaps is made for peroformance concern. As later patch will
> address this issue, remove this exception, which makes the checks
> consistent later.
> 
> With STRICT_READ_CHECKS = 1 which is default, there is no functional
> change.

Oh man.. thinking required and it is way late.. anyway this whole read
stuff made me remember we had a patch set on readlocks last year.

  https://lkml.kernel.org/r/20180411135110.9217-1-boqun.feng@gmail.com

I remember reviewing that a few times and then it dropped on the floor,
probably because Spectre crap or something sucked up all my time again :/

Sorry Boqun!


