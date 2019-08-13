Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98217C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 09:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7344C20679
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 09:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbfHMJhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 05:37:09 -0400
Received: from foss.arm.com ([217.140.110.172]:60860 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726890AbfHMJhI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 05:37:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 512FA337;
        Tue, 13 Aug 2019 02:37:08 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4F0233F706;
        Tue, 13 Aug 2019 02:37:07 -0700 (PDT)
Date:   Tue, 13 Aug 2019 10:37:05 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Matthew Wilcox <willy@infradead.org>, Qian Cai <cai@lca.pw>
Subject: Re: [PATCH v3 2/3] mm: kmemleak: Simple memory allocation pool for
 kmemleak objects
Message-ID: <20190813093705.GF62772@arrakis.emea.arm.com>
References: <20190812160642.52134-1-catalin.marinas@arm.com>
 <20190812160642.52134-3-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812160642.52134-3-catalin.marinas@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 05:06:41PM +0100, Catalin Marinas wrote:
> Add a memory pool for struct kmemleak_object in case the normal
> kmem_cache_alloc() fails under the gfp constraints passed by the caller.
> The mem_pool[] array size is currently fixed at 16000.

Following Andrew's comment, I'd add this paragraph here:

-----------8<------------------------
We are not using the existing mempool kernel API since this requires the
slab allocator to be available (for pool->elements allocation). A
subsequent kmemleak patch will replace the static early log buffer with
the pool allocation introduced here and this functionality is required
to be available before the slab was initialised.
-----------8<------------------------

(patch updated locally)

-- 
Catalin
