Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C605DC43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 910FC206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="t/OLj3zj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730879AbfDYUHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 16:07:11 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55884 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbfDYUHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 16:07:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ueRXEtfpZg9t4t4hgeQPvipdsk+8ox4hNJ3Shv68ndQ=; b=t/OLj3zjFuEvkbA+/WhfDkKag
        6SSYgSV7Ql13c724aLYZvw5zw9UKdUQTaCAP1ur+ApYFZW9LQ8/RAOLzaC4Ji0mUsjQ+vkWL0F5Wh
        qrc869mBGq6sWLFtfbH3FSdfzzU3IXKmFjd/sQalXg2AhNUtYJtVfh0uKvdA4Lw5/XLleVZdfvEUq
        pf/YFnIAfiw9NCcRsDfA3CiPQAkYrVuuLevSoguYJSD35mAXOIgmhyOmj+wz3ijXWXj5SaT1d5O8G
        jUXG2IkU6J9Eh7dVbbe+zRyXuGnQA+qMerqX0a8AcSelSC//LdgWBuVCM1h9QMSEZdYbgl07/ic4w
        cKiA930Ew==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJke4-0001yT-BG; Thu, 25 Apr 2019 20:07:00 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C91F129CB5DCB; Thu, 25 Apr 2019 22:06:58 +0200 (CEST)
Date:   Thu, 25 Apr 2019 22:06:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yuyang Du <duyuyang@gmail.com>
Cc:     will.deacon@arm.com, mingo@kernel.org, bvanassche@acm.org,
        ming.lei@redhat.com, frederic@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 26/28] locking/lockdep: Remove __bfs
Message-ID: <20190425200658.GZ12232@hirez.programming.kicks-ass.net>
References: <20190424101934.51535-1-duyuyang@gmail.com>
 <20190424101934.51535-27-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424101934.51535-27-duyuyang@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 06:19:32PM +0800, Yuyang Du wrote:
> Since there is no need for backward dependecy searching, remove this
> extra function layer.

OK, so $subject confused the heck out of me, I thought you were going to
remove the whole bfs machinery. May I suggest retaining
__bfs_backwards() in the previous patch (which I'm _waay_ to tired for
to look at now) and calling this patch: "Remove __bfs_backwards()".

