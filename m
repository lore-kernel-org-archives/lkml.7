Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42BEC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1EEB214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551364450;
	bh=wDUnl8WEwQwdHMTswHhz+Vty5uYv1VE3vYbmNrOQ8Bs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WnO5ctqyagLPYpquUv1jr/B+erBuEi7NvO2YZnGIytpkOs1EPq0tLAuOd8N09WHjE
	 dQcz0Wwh11FL5WCA89a8mDjOT7EyfWyG9tAaURPnUV/tRbbny60mm8uZivjeGwwaQ2
	 2yjtqPd/TFjmJauHxIrCX7/JZUoFOF11JnHyGGm4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733065AbfB1OeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 09:34:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:51608 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725918AbfB1OeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 09:34:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DCD5EAFF6;
        Thu, 28 Feb 2019 14:34:06 +0000 (UTC)
Date:   Thu, 28 Feb 2019 15:34:05 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        akpm@linux-foundation.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
        David Gibson <david@gibson.dropbear.id.au>,
        Andrea Arcangeli <aarcange@redhat.com>, mpe@ellerman.id.au,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v8 1/4] mm/cma: Add PF flag to force non cma alloc
Message-ID: <20190228143405.GF10588@dhcp22.suse.cz>
References: <20190227144736.5872-1-aneesh.kumar@linux.ibm.com>
 <20190227144736.5872-2-aneesh.kumar@linux.ibm.com>
 <1d083bf9-0beb-0c49-9aab-c6bc14da46ea@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d083bf9-0beb-0c49-9aab-c6bc14da46ea@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 28-02-19 13:20:03, Vlastimil Babka wrote:
> On 2/27/19 3:47 PM, Aneesh Kumar K.V wrote:
> > This patch adds PF_MEMALLOC_NOCMA which make sure any allocation in that context
> > is marked non-movable and hence cannot be satisfied by CMA region.
> > 
> > This is useful with get_user_pages_longterm where we want to take a page pin by
> > migrating pages from CMA region. Marking the section PF_MEMALLOC_NOCMA ensures
> > that we avoid unnecessary page migration later.
> > 
> > Suggested-by: Andrea Arcangeli <aarcange@redhat.com>
> > Reviewed-by: Andrea Arcangeli <aarcange@redhat.com>
> > Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> 
> +CC scheduler guys
> 
> Do we really take the last available PF flag just so that "we avoid
> unnecessary page migration later"?
> If yes, that's a third PF_MEMALLOC flag, should we get separate variable
> for gfp context at this point?

Yes, that sounds like a reasonable thing to do. Just note that xfs still
uses current_{set,restore}* api to handle PF_MEMALLOC_NOFS so that would
have to be moved over to the memalloc_nofs_{save,restore} API.

-- 
Michal Hocko
