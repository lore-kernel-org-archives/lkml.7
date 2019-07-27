Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB96C76194
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 10:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F66B2087C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 10:16:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbfG0KN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 06:13:59 -0400
Received: from foss.arm.com ([217.140.110.172]:52240 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728407AbfG0KN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 06:13:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CCDD528;
        Sat, 27 Jul 2019 03:13:56 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 76FE83F71A;
        Sat, 27 Jul 2019 03:13:55 -0700 (PDT)
Date:   Sat, 27 Jul 2019 11:13:53 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Qian Cai <cai@lca.pw>
Cc:     Yang Shi <yang.shi@linux.alibaba.com>, mhocko@suse.com,
        dvyukov@google.com, rientjes@google.com, willy@infradead.org,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "kmemleak: allow to coexist with fault injection"
Message-ID: <20190727101352.GA14316@arrakis.emea.arm.com>
References: <1563299431-111710-1-git-send-email-yang.shi@linux.alibaba.com>
 <1563301410.4610.8.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1563301410.4610.8.camel@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2019 at 02:23:30PM -0400, Qian Cai wrote:
> As mentioned in anther thread, the situation for kmemleak under memory pressure
> has already been unhealthy. I don't feel comfortable to make it even worse by
> reverting this commit alone. This could potentially make kmemleak kill itself
> easier and miss some more real memory leak later.
> 
> To make it really a short-term solution before the reverting, I think someone
> needs to follow up with the mempool solution with tunable pool size mentioned
> in,
> 
> https://lore.kernel.org/linux-mm/20190328145917.GC10283@arrakis.emea.arm.com/

Before my little bit of spare time disappears, let's add the tunable to
the mempool size so that I can repost the patch. Are you ok with a
kernel cmdline parameter or you'd rather change it at runtime? The
latter implies a minor extension to mempool to allow it to refill on
demand. I'd personally go for the former.

-- 
Catalin
