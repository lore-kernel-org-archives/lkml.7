Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C91C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 20:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95D1D217D6
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 20:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564516940;
	bh=Nm6s4NUlCfdIyRyK/SnSj0UUtBVVQa7IEjqzA+b49BI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=tAuzzxcP5tdgyx1WrCanAS+wMxN2Gx9cHeBQOo+7K63lHX4n0HgG5bI+e/8nxwnfI
	 RoSm2KPDWkI12dYqHS5AiT8H03ixW7onUsRbRnOdpHQBhiDtqFA8om0aehfP4zSYvQ
	 /s7Ct72iKgKiPw9fGrjpX7cF0pr04G3KawQ5/+eI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfG3UCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 16:02:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47466 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbfG3UCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 16:02:19 -0400
Received: from X1 (unknown [76.191.170.112])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D2C13333F;
        Tue, 30 Jul 2019 20:02:16 +0000 (UTC)
Date:   Tue, 30 Jul 2019 13:02:15 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Matthew Wilcox <willy@infradead.org>, Qian Cai <cai@lca.pw>
Subject: Re: [PATCH v2] mm: kmemleak: Use mempool allocations for kmemleak
 objects
Message-Id: <20190730130215.919b31c19df935cc5f1483e6@linux-foundation.org>
In-Reply-To: <20190727132334.9184-1-catalin.marinas@arm.com>
References: <20190727132334.9184-1-catalin.marinas@arm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Jul 2019 14:23:33 +0100 Catalin Marinas <catalin.marinas@arm.com> wrote:

> Add mempool allocations for struct kmemleak_object and
> kmemleak_scan_area as slightly more resilient than kmem_cache_alloc()
> under memory pressure. Additionally, mask out all the gfp flags passed
> to kmemleak other than GFP_KERNEL|GFP_ATOMIC.
> 
> A boot-time tuning parameter (kmemleak.mempool) is added to allow a
> different minimum pool size (defaulting to NR_CPUS * 4).

btw, the checkpatch warnings are valid:

WARNING: usage of NR_CPUS is often wrong - consider using cpu_possible(), num_possible_cpus(), for_each_possible_cpu(), etc
#70: FILE: mm/kmemleak.c:197:
+static int min_object_pool = NR_CPUS * 4;

WARNING: usage of NR_CPUS is often wrong - consider using cpu_possible(), num_possible_cpus(), for_each_possible_cpu(), etc
#71: FILE: mm/kmemleak.c:198:
+static int min_scan_area_pool = NR_CPUS * 1;

There can be situations where NR_CPUS is much larger than
num_possible_cpus().  Can we initialize these tunables within
kmemleak_init()?
