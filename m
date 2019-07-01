Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DBC9C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 14:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21C0620665
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 14:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ioVP/qgb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729373AbfGAOHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 10:07:18 -0400
Received: from merlin.infradead.org ([205.233.59.134]:35516 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729271AbfGAOHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 10:07:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=URdBZnltUJZp8y8LciA/5TX5//edmZzvDOigSBMpLjU=; b=ioVP/qgb4wgD61BLSMnXNliQI
        TYswZ3tVTVCZooE8UbMDOzTtdXKNZnLk5wzuf5zLi6EudwS0N1LmuCs4tcKeLtT+D+NPCcHoHfyMi
        C2/d0UhIHrNwZxpNtasLWhr8xecSGhgxKv6EDr/zhK5lvJIFEdOCWS0T7gzra5HkhHB6o3GV4ns7E
        ge4jFL4ONu87rJfFms1mQ4v4IaynxXcf/UHVTF/yCKXAZVq5lUQMVcL8s/cc0CTklEDZX7UjaqRFc
        ebfEzvEmVA/YGR9M2zFPvxlnj7yoRPPU2MEZsEyO6BVeFZjIW5s1oAH5Bp9lt60cVh3j6ppAVDUh5
        Y+Uie8DlQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hhwxA-0008Gx-0s; Mon, 01 Jul 2019 14:06:44 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AF220209C957E; Mon,  1 Jul 2019 16:06:42 +0200 (CEST)
Date:   Mon, 1 Jul 2019 16:06:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     subhra mazumdar <subhra.mazumdar@oracle.com>,
        linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        steven.sistare@oracle.com, dhaval.giani@oracle.com,
        daniel.lezcano@linaro.org, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, tim.c.chen@linux.intel.com,
        mgorman@techsingularity.net, Paul Turner <pjt@google.com>,
        riel@surriel.com, morten.rasmussen@arm.com
Subject: Re: [RESEND PATCH v3 0/7] Improve scheduler scalability for fast path
Message-ID: <20190701140642.GX3402@hirez.programming.kicks-ass.net>
References: <20190627012919.4341-1-subhra.mazumdar@oracle.com>
 <20190701090204.GQ3402@hirez.programming.kicks-ass.net>
 <20190701135552.kb4os6bxxhh2lyw6@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701135552.kb4os6bxxhh2lyw6@e110439-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2019 at 02:55:52PM +0100, Patrick Bellasi wrote:
> On 01-Jul 11:02, Peter Zijlstra wrote:

> > Hmmm?
> 
> Just one more requirement I think it's worth to consider since the
> beginning: CGroups support
> 
> That would be very welcome interface. Just because is so much more
> convenient (and safe) to set these bias on a group of tasks depending
> on their role in the system.
> 
> Do you have any idea on how we can expose such a "lantency-nice"
> property via CGroups? It's very similar to cpu.shares but it does not
> represent a resource which can be partitioned.

If the latency_nice idea lives; exactly like the normal nice? That is;
IIRC cgroupv2 has a nice value interface (see cpu_weight_nice_*()).

But yes, this isn't a resource per se; just a shared attribute like
thing.
