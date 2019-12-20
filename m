Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 782C0C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 16:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B11F20716
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 16:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gFPhTKrY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbfLTQsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 11:48:21 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54326 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727181AbfLTQsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 11:48:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4XBS8twGfIEA22qKdCxJ5jlOvqASpEkGjgMxOfO6nj8=; b=gFPhTKrY1zvEpl525VDPXURkc
        Gpdssy2T5h+eX2tj1uhEL90vJulZNH3bYI64f2SGK7fuVH2zECUL1u5l6mMb89H7+yry/vEbRX171
        9BQEH/UwOo7LEYM8tZp+SOTfphPvjWSQ1uCFhFjeSXkX5D8tsNQRPLk6Q22fMW9G5KzVMpOVpqu4d
        K6dv6lHU/z+UrPIbOoERFrpP51MOak7IG3+YP9m+E5wxphrkg5wxtAZTSzY9mGH0p4qLt7GRNy+2M
        LVW776pTnCsdUibZyKY19PKshLRIOJYyh/j2vsdEDHEhJWTdq4hGT+I5oQIv29nvNHL6JfqFMTuF+
        lDdv5drkw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iiLRi-0002Q1-Bx; Fri, 20 Dec 2019 16:48:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E9879303D9F;
        Fri, 20 Dec 2019 17:46:38 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F345120E07103; Fri, 20 Dec 2019 17:48:02 +0100 (CET)
Date:   Fri, 20 Dec 2019 17:48:02 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH 2/9] perf/core: Add PERF_SAMPLE_CGROUP feature
Message-ID: <20191220164802.GO2827@hirez.programming.kicks-ass.net>
References: <20191220043253.3278951-1-namhyung@kernel.org>
 <20191220043253.3278951-3-namhyung@kernel.org>
 <20191220152324.GG2914998@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191220152324.GG2914998@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2019 at 07:23:24AM -0800, Tejun Heo wrote:
> On Fri, Dec 20, 2019 at 01:32:46PM +0900, Namhyung Kim wrote:
> > The PERF_SAMPLE_CGROUP bit is to save (perf_event) cgroup information
> > in the sample.  It will add a 64-bit id to identify current cgroup and
> > it's the file handle in the cgroup file system.  Userspace should use
> > this information with PERF_RECORD_CGROUP event to match which cgroup
> > it belongs.
> 
> You don't need PERF_RECORD_CGROUP for that.  Something like the
> following should work.
> 
> 	struct {
> 		struct file_handle fh;
> 		char stor[MAX_HANDLE_SZ];
> 	} fh_store;
> 	struct file_handle *fh = &fh_store;
> 
> 	fh->handle_type = 0xfe; // FILEID_KERNFS
> 	fh->handle_bytes = sizeof(u64);
> 	*(u64 *)fh->f_handle = cgrp_id;
> 
> 	mnt_fd = open('/sys/fs/cgroup', O_RDONLY);
> 	fd = open_by_handle_at(mnt_fd, fh, O_RDONLY);
> 
> 	snprintf(proc_path, PATH_MAX, "/proc/self/fd/%d", fd);
> 	readlink(proc_path, cgrp_path, PATH_MAX);

That assumes the cgroup is still in existence, which might not be the
case I presume.
