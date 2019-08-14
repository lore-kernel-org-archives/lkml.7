Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F49C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 12:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 503C0206C1
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 12:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565787219;
	bh=W9OtCjGltUQI7kXQ3dJ0eGTHDsnfFj1/weI0QSrCxfQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BnCeviQAwRGEFLtcge1qqel0p0ygW/k9LPK7eGpG3eyaI/HkbFWGFmc9GSqb1lwPJ
	 anmRczuJeEnam4vBclWDX29D301kVyqyTIgu9tR+SXuOGqbNxy6+A95MJJFlTlZRYe
	 Uh7vVljTzN2ala4lN4OgjNHg5KQdYi7KaFyarX9Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbfHNMxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 08:53:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:33888 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727651AbfHNMxg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 08:53:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D8FEEAEE9;
        Wed, 14 Aug 2019 12:53:34 +0000 (UTC)
Date:   Wed, 14 Aug 2019 14:53:34 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Yang Shi <yang.shi@linux.alibaba.com>,
        kirill.shutemov@linux.intel.com, hannes@cmpxchg.org,
        rientjes@google.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Linux API <linux-api@vger.kernel.org>
Subject: Re: [RESEND PATCH 1/2 -mm] mm: account lazy free pages separately
Message-ID: <20190814125334.GX17933@dhcp22.suse.cz>
References: <1565308665-24747-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190809083216.GM18351@dhcp22.suse.cz>
 <1a3c4185-c7ab-8d6f-8191-77dce02025a7@linux.alibaba.com>
 <20190809180238.GS18351@dhcp22.suse.cz>
 <79c90f6b-fcac-02e1-015a-0eaa4eafdf7d@linux.alibaba.com>
 <564a0860-94f1-6301-5527-5c2272931d8b@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <564a0860-94f1-6301-5527-5c2272931d8b@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 14-08-19 14:49:18, Vlastimil Babka wrote:
> On 8/9/19 8:26 PM, Yang Shi wrote:
> > Here the new counter is introduced for patch 2/2 to account deferred 
> > split THPs into available memory since NR_ANON_THPS may contain 
> > non-deferred split THPs.
> > 
> > I could use an internal counter for deferred split THPs, but if it is 
> > accounted by mod_node_page_state, why not just show it in /proc/meminfo? 
> 
> The answer to "Why not" is that it becomes part of userspace API (btw this
> patchset should have CC'd linux-api@ - please do for further iterations) and
> even if the implementation detail of deferred splitting might change in the
> future, we'll basically have to keep the counter (even with 0 value) in
> /proc/meminfo forever.
> 
> Also, quite recently we have added the following counter:
> 
> KReclaimable: Kernel allocations that the kernel will attempt to reclaim
>               under memory pressure. Includes SReclaimable (below), and other
>               direct allocations with a shrinker.
> 
> Although THP allocations are not exactly "kernel allocations", once they are
> unmapped, they are in fact kernel-only, so IMHO it wouldn't be a big stretch to
> add the lazy THP pages there?

That would indeed fit in much better than a dedicated counter.
-- 
Michal Hocko
SUSE Labs
