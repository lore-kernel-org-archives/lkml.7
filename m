Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2523C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 16:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8291320679
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 16:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tWxzEwHD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387593AbfHFQHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 12:07:51 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33734 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732203AbfHFQHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 12:07:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xJiC/e5rABJrgTD/jh7whQZBj6kjpIJYJ/CLvK+I8Ng=; b=tWxzEwHDoptM9ocqJyQULAScI
        ooBZreellhhtJDQ2OdNMLCeWg2TQcl7WpxCUeWDms6dw9xlyQw/LMgcJXsk69izwshgHTgE0E07rk
        SxZdJOfgtEwsu4DDHwBFqD9M4i0XsPeEeSVBwgVoqFRpw8zWeman9hJ6QKhWfgWPetJXk04yawYxE
        DK48SrJbZ7mIoIpqkz10a9CJbKS/03D8PTry+HqMSJntNdDlLvzdQAXFcVY202G6QoXV93WZe6kuI
        xKbX/1H0mcA+N0NXBOt8fg5B6jFR+z/gERYiZ8d/4dUYfboAz3UbnRofm3F/4u9DT1dd0vSntXdPe
        dPkJupBsg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hv201-0004bQ-VC; Tue, 06 Aug 2019 16:07:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9F2983077ED;
        Tue,  6 Aug 2019 18:07:18 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CFFFD201B39AC; Tue,  6 Aug 2019 18:07:43 +0200 (CEST)
Date:   Tue, 6 Aug 2019 18:07:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com, pauld@redhat.com,
        valentin.schneider@arm.com, srikar@linux.vnet.ibm.com,
        quentin.perret@arm.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com
Subject: Re: [PATCH v2 6/8] sched/fair: use load instead of runnable load
Message-ID: <20190806160743.GW2332@hirez.programming.kicks-ass.net>
References: <1564670424-26023-1-git-send-email-vincent.guittot@linaro.org>
 <1564670424-26023-7-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564670424-26023-7-git-send-email-vincent.guittot@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 04:40:22PM +0200, Vincent Guittot wrote:
> runnable load has been introduced to take into account the case
> where blocked load biases the load balance decision which was selecting
> underutilized group with huge blocked load whereas other groups were
> overloaded.
> 
> The load is now only used when groups are overloaded. In this case,
> it's worth being conservative and taking into account the sleeping
> tasks that might wakeup on the cpu.

This one scares me a little. I have the feeling I'm missing/forgetting
something.

Also; while the regular load-balance (find-busiest) stuff is now all
aware of idle, this change also impacts wake_affine and find_idlest, and
they've not changed.
