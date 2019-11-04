Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9058BCA9ECF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 08:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6478B222CA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 08:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QT+iriO4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbfKDIoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 03:44:14 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56746 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727553AbfKDIoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 03:44:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lnIuRdr4CYsrlQgJxc+GH9Enm/uWxg114yr6D6OF8ic=; b=QT+iriO4E/1wFUY4RwRYBB4Tw
        OdaMGxiHmM2NCSCiewk4iESvBle369Lj7ru7q69JoMWgR32C8a3bmeHxx49KVYKFKzqOeF3G0b4N/
        G+OYnywEroYsP69gMOd/n0+iVc0X57r0P9NGjFomM6WUgjYxzbX3jly/93JjmvyEGsM56NYLQQaHx
        0bCrCZCbDXVH41Rhn12ISQEwYsCjI9K+hAyXjkGmgkvPtIPh9imMdfkXUYSDthrwoIpAXsVeK0ZKK
        uV5nZpdRPE6/bDcDlGDIDYc5y2AYC6KPcZ6YQpHKz25rDLk2pOJv6V1hIiMfY2tOGPCkMwNyGgFiW
        mIBNQiQhQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iRXy3-0000nv-16; Mon, 04 Nov 2019 08:44:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B0C0C305EF2;
        Mon,  4 Nov 2019 09:43:01 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D9AEC23CEFEAF; Mon,  4 Nov 2019 09:44:04 +0100 (CET)
Date:   Mon, 4 Nov 2019 09:44:04 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [RFC 08/10] autonuma, memory tiering: Select hotter pages to
 promote to fast memory node
Message-ID: <20191104084404.GA4131@hirez.programming.kicks-ass.net>
References: <20191101075727.26683-1-ying.huang@intel.com>
 <20191101075727.26683-9-ying.huang@intel.com>
 <20191101092404.GS4131@hirez.programming.kicks-ass.net>
 <87k18gcqih.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k18gcqih.fsf@yhuang-dev.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2019 at 10:41:10AM +0800, Huang, Ying wrote:

> >> +#define NUMA_SCAN_NR_HIST	16
> >> +		int numa_scan_idx;
> >> +		unsigned long numa_scan_jiffies[NUMA_SCAN_NR_HIST];
> >> +		unsigned long numa_scan_starts[NUMA_SCAN_NR_HIST];
> >
> > Why 16? This is 4 cachelines.
> 
> We want to keep the NUMA scanning history reasonably long.  From
> task_scan_min(), the minimal interval between task_numa_work() running
> is about 100 ms by default.  So we can keep 1600 ms history by default
> if NUMA_SCAN_NR_HIST is 16.  If user choose to use smaller
> sysctl_numa_balancing_scan_size, then we can only keep shorter history.
> In general, we want to keep no less than 1000 ms history.  So 16 appears
> like a reasonable choice for us.  Any other suggestion?

This is very good information for Changelogs and comments :-)
