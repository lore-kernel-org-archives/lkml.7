Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98097C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BACC21871
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1Dx5bgo/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730769AbfDEMFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 08:05:13 -0400
Received: from merlin.infradead.org ([205.233.59.134]:36468 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbfDEMFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 08:05:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UTOYp7IjDImcxMFESq0cXAQX+6anvFw+H4/1OoPITYU=; b=1Dx5bgo/GSQcI7kkuXN88XpP4
        LJN6aRtV1RSVQUVtZXEcYhWnD55DEmHwezlcYYei7/2mtHqDX+Qvg/wJ3/WEGpmp8TDgn0MFNbPva
        vCRpsbFzeq8Q6HrgwxONEi0SBbSmQCVQ7LNdUpQvg68l3AcMQ9DJ/Ks3z087k3wtDaaJn2FrBLqKL
        Bsc/gA86kyV7lxxSDtF9mLycbGGa4niC5P0+OiDHY82rT9OAuF1713XBi4VAm01LAhM75YVmmf5iA
        DYTB/s4+9oQBAB5UriNvQTvaevLCdjCiFwz2vThrWkTeZthkITEB7QrmvGsEM14v5aV+Zk0MHVBHu
        rWw5HKjBg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hCNaG-0004WO-9m; Fri, 05 Apr 2019 12:04:36 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F2C6A23954621; Fri,  5 Apr 2019 14:04:34 +0200 (CEST)
Date:   Fri, 5 Apr 2019 14:04:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     mingo@redhat.com, rostedt@goodmis.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        cgroups@vger.kernel.org
Subject: Re: [PATCH v7 1/7] sched/topology: Adding function
 partition_sched_domains_locked()
Message-ID: <20190405120434.GS12232@hirez.programming.kicks-ass.net>
References: <20190403084650.4414-1-juri.lelli@redhat.com>
 <20190403084650.4414-2-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403084650.4414-2-juri.lelli@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 10:46:44AM +0200, Juri Lelli wrote:
> +/*
> + * Call with hotplug lock held

Is that spelled like:

	lockdep_assert_cpus_held();

?

> + */
> +void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
> +			     struct sched_domain_attr *dattr_new)
> +{
> +	mutex_lock(&sched_domains_mutex);
> +	partition_sched_domains_locked(ndoms_new, doms_new, dattr_new);
>  	mutex_unlock(&sched_domains_mutex);
>  }
> -- 
> 2.17.2
> 
