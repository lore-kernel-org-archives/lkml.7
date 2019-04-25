Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E244C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35681206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VK9BPAw2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbfDYTsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:48:42 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55216 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfDYTsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:48:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gSGV6pj1xTOJsvQqk01AL/unLk9JzTaCItBvbXk2Ytg=; b=VK9BPAw2Zil3nZ4/sJgXS/pWJ
        emi0uLXCg/hPYvDVFdGantn9QxL9TFSjVkC8IbZKgwN06J/B9mDxKnz6dznzKUIwm/LV7qcaQcyML
        c9V2n995g5gpL0/Vy1iXw5jFJgUUbHwmP+48z9RF3IcPcerPssU8moR0xz5AhM0MwhnNzdgwrNx6u
        EdjL0ZCBoJGYLlP58oRzaDHh1KhHMVzAlf/Rj8xgl1BQYK0nNEMhOVEcjFC7GyC/UIZdO+UYDeVv/
        COBai+WWOrhT1WengCeM1fZKLRxa8gWsxsIMrwSwkNijojd/RUg+jhPQszx9zivAU1oFA1xFpgU6f
        N2u10LzFw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJkMC-0001VJ-PL; Thu, 25 Apr 2019 19:48:33 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 85E3729C22B12; Thu, 25 Apr 2019 21:48:31 +0200 (CEST)
Date:   Thu, 25 Apr 2019 21:48:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yuyang Du <duyuyang@gmail.com>
Cc:     will.deacon@arm.com, mingo@kernel.org, bvanassche@acm.org,
        ming.lei@redhat.com, frederic@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 20/28] locking/lockdep: Refactorize check_noncircular and
 check_redundant
Message-ID: <20190425194831.GV12232@hirez.programming.kicks-ass.net>
References: <20190424101934.51535-1-duyuyang@gmail.com>
 <20190424101934.51535-21-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424101934.51535-21-duyuyang@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 06:19:26PM +0800, Yuyang Du wrote:
> These two functions now handle different check results themselves. A new
> check_path function is added to check whether there is a path in the
> dependency graph. No functional change.

This looks good, however I completely forgot we still had the redundant
thing.

It was added for cross-release (which has since been reverted) which
would generate a lot of redundant links (IIRC) but having it makes the
reports more convoluted -- basically, if we had an A-B-C relation, then
A-C will not be added to the graph because it is already covered. This
then means any report will include B, even though a shorter cycle might
have been possible.

Maybe we should make the whole redundant check depend on LOCKDEP_SMALL
for now.
