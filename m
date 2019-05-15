Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A63C04E84
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 16:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB0D520818
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 16:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kjWJ4gIg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbfEOQao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 12:30:44 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48680 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbfEOQan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 12:30:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=iqC6CeL/gxHhvp7zGCJh7Pt4372ukcVo1rwpC9g39hs=; b=kjWJ4gIgFz5Fl3ZzlM6FqJ2/r
        uZRk2dmvid4fb4D/tIyu6ucpkaNqlkaSOtrXXhnBF/CEc3lyeLJARiCj/jSV8bnIY8lp2UWPkdadw
        f9HRvx+o55tTH3+JJBt1aSFo584dSdoMQieGu/lww/Vw2crAV9rvrGxs1z2bhGFWyIhJyDTMqdGax
        Crjvat00lpwdaZXBUBFJ583CLTe2wIDNcnSWDmIpHufNqebH85DDml4PaAKGxOlP9J0GvIeQFkJnv
        VxO5A52zJeeb/XV7y+d3j6kJGFMWUrKmhGb9UH3GNN+KhcRH3Mk4v7jRTsWWaP78w+O4pcIwsdpsy
        mNuYGekaw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hQwna-0001C3-3c; Wed, 15 May 2019 16:30:34 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5D0642029906B; Wed, 15 May 2019 18:30:32 +0200 (CEST)
Date:   Wed, 15 May 2019 18:30:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Parth Shah <parth@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        mingo@redhat.com, dietmar.eggemann@arm.com, dsmythies@telus.net
Subject: Re: [RFCv2 2/6] sched: Introduce switch to enable TurboSched mode
Message-ID: <20190515163032.GU2589@hirez.programming.kicks-ass.net>
References: <20190515135322.19393-1-parth@linux.ibm.com>
 <20190515135322.19393-3-parth@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515135322.19393-3-parth@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 07:23:18PM +0530, Parth Shah wrote:
> +void turbo_sched_get(void)
> +{
> +	spin_lock(&turbo_sched_lock);
> +	if (!turbo_sched_count++)
> +		static_branch_enable(&__turbo_sched_enabled);
> +	spin_unlock(&turbo_sched_lock);
> +}

Muwhahaha, you didn't test this code, did you?
