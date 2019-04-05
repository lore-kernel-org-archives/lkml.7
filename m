Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D58BC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30ECD21738
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="If2bqmPe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730554AbfDEMhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 08:37:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45646 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfDEMhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 08:37:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cqaSZ+K93rrnDdKM+dpoAtz2NJApotYf4sBHoFtFOEs=; b=If2bqmPeef2+ZfqZ/OBWdNmNX
        5LsA+suau83D/ZuXavzMK+mtpt8cnUFbn2nWPdNBQOipjVijtMH2QRXZ6cAL/OlcNzD+JB2WK5cQ4
        f5Ga3ImjSTnFJy092oTPV38iIfSAoKU6ySsfaFXFYTBf8Zdn36Bag2/s26NCXIijvMUPwelTTb9pf
        zkjAPVYlRTzoWfzqb2I1EaQFKstTt1+EtKV+aWmzP0nhPHD8/4IyNe0e39wLtp8qzdODH7HdJW0Kf
        LgjuPvIrla1dECa+JnPdJJ5XySqeZbolgyljSs4xhcwUJBx57juwcDHpojhxnSdOmEXDNI3KRdm9N
        NogZ3aKZg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hCO5Q-0002ln-DE; Fri, 05 Apr 2019 12:36:48 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D9E0D23954638; Fri,  5 Apr 2019 14:36:45 +0200 (CEST)
Date:   Fri, 5 Apr 2019 14:36:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     mingo@redhat.com, rostedt@goodmis.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        cgroups@vger.kernel.org
Subject: Re: [PATCH v7 4/7] sched/core: Prevent race condition between cpuset
 and __sched_setscheduler()
Message-ID: <20190405123645.GT12232@hirez.programming.kicks-ass.net>
References: <20190403084650.4414-1-juri.lelli@redhat.com>
 <20190403084650.4414-5-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403084650.4414-5-juri.lelli@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 10:46:47AM +0200, Juri Lelli wrote:
> +static inline void cpuset_read_only_lock(unsigned long *flags)
> +{
> +	local_irq_save(*flags);
> +	preempt_disable();
> +}
> +
> +static inline void cpuset_read_only_unlock(unsigned long *flags)
> +{
> +	local_irq_restore(*flags);
> +	preempt_enable();
> +}

You can ditch the preempt stuff. IRQs disabled already very much implies
!preemptible.
