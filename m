Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24DDC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 20:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9339A20659
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 20:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564519183;
	bh=vQ0yXgsk5R7VRRm/u9DR3xe8ZYV0cmB6Ik506qa+PHI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=M/9/PKxLGgIGAReG1IGJIbMjJ8cc0Vt5eMyY9HM5WSpzHWsuJWD52cpPOptE8liyH
	 39+n/nryndEfMbmceaMAycbAEQ+sCIQExyz4V4dVBsDEdBjRVjAc06Ij3dDCmcYCbd
	 FwYc0YuSvxLCBYQ5GB7ClkgkKH8wkI5JHMx5meVQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbfG3Ujm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 16:39:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52034 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728305AbfG3Ujl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 16:39:41 -0400
Received: from X1 (unknown [76.191.170.112])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id AB48A311D;
        Tue, 30 Jul 2019 20:39:40 +0000 (UTC)
Date:   Tue, 30 Jul 2019 13:39:39 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Catalin Marinas <catalin.marinas@arm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2] mm: kmemleak: Use mempool allocations for kmemleak
 objects
Message-Id: <20190730133939.2840b742408336e2a0a9f573@linux-foundation.org>
In-Reply-To: <1564518157.11067.34.camel@lca.pw>
References: <20190727132334.9184-1-catalin.marinas@arm.com>
        <20190730125743.113e59a9c449847d7f6ae7c3@linux-foundation.org>
        <1564518157.11067.34.camel@lca.pw>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jul 2019 16:22:37 -0400 Qian Cai <cai@lca.pw> wrote:

> On Tue, 2019-07-30 at 12:57 -0700, Andrew Morton wrote:
> > On Sat, 27 Jul 2019 14:23:33 +0100 Catalin Marinas <catalin.marinas@arm.com>
> > wrote:
> > 
> > > Add mempool allocations for struct kmemleak_object and
> > > kmemleak_scan_area as slightly more resilient than kmem_cache_alloc()
> > > under memory pressure. Additionally, mask out all the gfp flags passed
> > > to kmemleak other than GFP_KERNEL|GFP_ATOMIC.
> > > 
> > > A boot-time tuning parameter (kmemleak.mempool) is added to allow a
> > > different minimum pool size (defaulting to NR_CPUS * 4).
> > 
> > Why would anyone ever want to alter this?  Is there some particular
> > misbehaviour which this will improve?  If so, what is it?
> 
> So it can tolerant different systems and workloads. For example, there are some
> machines with slow disk and fast CPUs. When they are under memory pressure, it
> could take a long time to swap before the OOM kicks in to free up some memory.
> As the results, it needs a large mempool for kmemleak or suffering from higher
> chance of a kmemleak metadata allocation failure.

This sort of thing should be in the changelog and in the user-facing
documentation please.  Also, we should document the user-visible
effects of this failure so that users can determine whether this tunable
will help them.

