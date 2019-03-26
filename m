Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D70C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E67B2070D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731717AbfCZQGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 12:06:25 -0400
Received: from foss.arm.com ([217.140.101.70]:39140 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726258AbfCZQGZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 12:06:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 876E51596;
        Tue, 26 Mar 2019 09:06:22 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA4B33F614;
        Tue, 26 Mar 2019 09:06:20 -0700 (PDT)
Date:   Tue, 26 Mar 2019 16:06:18 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, mhocko@kernel.org, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] kmemleaak: survive in a low-memory situation
Message-ID: <20190326160617.GG33308@arrakis.emea.arm.com>
References: <20190326154338.20594-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326154338.20594-1-cai@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 11:43:38AM -0400, Qian Cai wrote:
> Kmemleak could quickly fail to allocate an object structure and then
> disable itself in a low-memory situation. For example, running a mmap()
> workload triggering swapping and OOM. This is especially problematic for
> running things like LTP testsuite where one OOM test case would disable
> the whole kmemleak and render the rest of test cases without kmemleak
> watching for leaking.
> 
> Kmemleak allocation could fail even though the tracked memory is
> succeeded. Hence, it could still try to start a direct reclaim if it is
> not executed in an atomic context (spinlock, irq-handler etc), or a
> high-priority allocation in an atomic context as a last-ditch effort.
> Since kmemleak is a debug feature, it is unlikely to be used in
> production that memory resources is scarce where direct reclaim or
> high-priority atomic allocations should not be granted lightly.
> 
> Unless there is a brave soul to reimplement the kmemleak to embed it's
> metadata into the tracked memory itself in a foreseeable future, this
> provides a good balance between enabling kmemleak in a low-memory
> situation and not introducing too much hackiness into the existing
> code for now.

Embedding the metadata would help with the slab allocations (though not
with vmalloc) but it comes with its own potential issues. There are some
bits of kmemleak that rely on deferred freeing of metadata for RCU
traversal, so this wouldn't go well with embedding it.

I wonder whether we'd be better off to replace the metadata allocator
with gen_pool. This way we'd also get rid of early logging/replaying of
the memory allocations since we can populate the gen_pool early with a
static buffer.

-- 
Catalin
