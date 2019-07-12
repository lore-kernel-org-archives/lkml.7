Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18388C742AB
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 07:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB5B921530
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 07:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562915643;
	bh=IhK7UHorsS/w91hyncoSx75iV8jGcrqv4pDhWeYyBs8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ABU3c9nmH3+n0E4SDVOk36E2ucqggAYafXOA01SZ8zgiswzK51fg49RxYqkNrkQAI
	 Cu2tdTFncoCpvGYJ9rFuSDQIx0/6S97Zi5GpoRuWsCp1tVZbhGxQDRZRHimDbiqOCm
	 W6FJiSEaftTF7Snu7/CJofsrLuG+n8Ej36fNEYz8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfGLHOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 03:14:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:49180 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726033AbfGLHOB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 03:14:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 38EF9AC2D;
        Fri, 12 Jul 2019 07:14:00 +0000 (UTC)
Date:   Fri, 12 Jul 2019 09:13:59 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Kuo-Hsin Yang <vovoy@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Minchan Kim <minchan@kernel.org>,
        Sonny Rao <sonnyrao@chromium.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] mm: vmscan: scan anonymous pages on file refaults
Message-ID: <20190712071359.GN29483@dhcp22.suse.cz>
References: <20190628111627.GA107040@google.com>
 <20190701081038.GA83398@google.com>
 <20190703143057.GQ978@dhcp22.suse.cz>
 <20190704094716.GA245276@google.com>
 <20190704110425.GD5620@dhcp22.suse.cz>
 <20190705124505.GA173726@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190705124505.GA173726@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 05-07-19 20:45:05, Kuo-Hsin Yang wrote:
> With 4 processes accessing non-overlapping parts of a large file, 30316
> pages swapped out with this patch, 5152 pages swapped out without this
> patch. The swapout number is small comparing to pgpgin.

which is 5 times more swapout. This may be seen to be a lot for
workloads that prefer no swapping (e.g. large in memory databases) with
an occasional heavy IO (e.g. backup). And I am worried those would
regress. I do agree that the current behavior is far from optimal
because the trashing is real. I believe that we really need a different
approach. Johannes has brought this up few years back (sorry I do not
have a link handy) but it was essentially about implementing refault
logic to anonymous memory and swap out based on the refault price. If
there is effectively no swapin then it simply makes more sense to swap
out rather than refault a page cache.

That being said, I am not nacking the patch. Let's see whether something
regresses as there is a no clear cut for the proper behavior. But I am
bringing that up because we really need a better and more robust plan
for the future.

-- 
Michal Hocko
SUSE Labs
