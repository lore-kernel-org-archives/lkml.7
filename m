Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C68CEC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 09:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EC4E2067D
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 09:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564564215;
	bh=yFfnOTa7D8ISkNcPIlUEZ//6sxQKmXSzVWMuinjC8KA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZnEDz8PjoO/GIHwjtKa6Yeue0d9ofhA+pojGXcvdPL6zMLoWJhbn3AluLKXk0ilBo
	 NHmq3IFlr50I5rEad4cpQei6akjAl0LLJb6/SwNoABxSyfNn4v3wA3pFzy43kmTFVj
	 KnPdO+fYPo/zhzqt77oMSq0rXUbdBFnAbPnnvbn8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbfGaJKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 05:10:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:41228 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726759AbfGaJKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 05:10:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0FB9BABE9;
        Wed, 31 Jul 2019 09:10:13 +0000 (UTC)
Date:   Wed, 31 Jul 2019 11:10:12 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, Qian Cai <cai@lca.pw>
Subject: Re: [PATCH v2] mm: kmemleak: Use mempool allocations for kmemleak
 objects
Message-ID: <20190731091012.GE9330@dhcp22.suse.cz>
References: <20190727132334.9184-1-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190727132334.9184-1-catalin.marinas@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 27-07-19 14:23:33, Catalin Marinas wrote:
> Add mempool allocations for struct kmemleak_object and
> kmemleak_scan_area as slightly more resilient than kmem_cache_alloc()
> under memory pressure. Additionally, mask out all the gfp flags passed
> to kmemleak other than GFP_KERNEL|GFP_ATOMIC.
> 
> A boot-time tuning parameter (kmemleak.mempool) is added to allow a
> different minimum pool size (defaulting to NR_CPUS * 4).
> 
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Qian Cai <cai@lca.pw>
> Suggested-by: Michal Hocko <mhocko@kernel.org>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

I am not familiar with the kmemleak code so I cannot really give my ack
but I can give my thumbs up at least. This is definitely an improvement
and step into the right direction. The gfp flags games were just broken.

My only recommendation would be to drop the kernel parameter as
mentioned in other email. We have just too many of them and if the
current auto-tuning is not sufficient we want to hear about that and
find a better one or add a parameter only if we fail.

Thanks!
-- 
Michal Hocko
SUSE Labs
