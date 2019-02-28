Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A6CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 09:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA45021850
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 09:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V0l/qLtp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732240AbfB1Jrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 04:47:40 -0500
Received: from merlin.infradead.org ([205.233.59.134]:43046 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbfB1Jri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 04:47:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LtMdzsReUUFSdAWcFspo9gkFYAAv1bEvSZQYF3L2Di0=; b=V0l/qLtplGAi2NyWnjZxw1LDD
        W1J4LYjixJvqwupWiLq5HNF5e4WlQvO2vc1lzXSfqk5oeeixWls6di/iqA30ViXlzLSMyp26QQUIf
        Kimq7wo23sKGAeDwvm5TvEDEmSVlsRvErM4NrHR5pbvtH/rde/2DaEJxlZFKzl7eMyY34g6qJUTU4
        xJ396aCBMEmqNs1Mt7YZEeZ0r266BzpNQ0SEKibyJhPmKUZj6nwCfvJAzdDonnqqXpzdFcc6nRK17
        Mce9qw5AWBDvOpUakgYgoMWJt2egkCtcwoXfUApmanclHn1LsXZehPmrCzX/Dq3ayQ41IlkVurhKZ
        gsX74K81A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gzIHu-0000bB-9H; Thu, 28 Feb 2019 09:47:34 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 10238202CF5F8; Thu, 28 Feb 2019 10:47:33 +0100 (CET)
Date:   Thu, 28 Feb 2019 10:47:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ketan Patil <ketanp@nvidia.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, snikam@nvidia.com,
        bnihalani@nvidia.com, byan@nvidia.com, sgurrappadi@nvidia.com,
        treding@nvidia.com, talho@nvidia.com
Subject: Re: [PATCH] sched/cputime: Remove unnecessary assignment statement
Message-ID: <20190228094733.GY32494@hirez.programming.kicks-ass.net>
References: <1551248002-27303-1-git-send-email-ketanp@nvidia.com>
 <20190227103230.GM32494@hirez.programming.kicks-ass.net>
 <9bce6378-2221-f358-dc97-f15ee7ab546b@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9bce6378-2221-f358-dc97-f15ee7ab546b@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

On Thu, Feb 28, 2019 at 03:12:13PM +0530, Ketan Patil wrote:
> The coverity tool has detected this issue as an unused value, since
> the code assigns the value to utime variable and then after the jump, the
> value of utime again gets updated, hence the previous value is not at all
> useful and this patch removes that first assignment.

Not a security issue then; just tell coverity to shut up.
