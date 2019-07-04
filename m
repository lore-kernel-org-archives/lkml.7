Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52820C06517
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 11:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B5B9205C9
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 11:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562238269;
	bh=vV9Dk6cX3Mr0RtFJ3RONfbTd7mSbJq5K8CSm3zvrN0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lOfZ2KljfSK1TnSPpIjeGeS1G3H85u9XHt/GLzI4Trj2KoaMaNZwUyjzHip4QdiEd
	 AtFXAvCK2JenFwD79HhJIch+a1Cg9RaJJmIv0F9JDq2j+kn+WpzHXzfdgRRvCwQtFA
	 P879aN/0PieH0Q2ZSbG/IBm/nPbmMZsrHsCxuDkI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbfGDLE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 07:04:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:35270 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727499AbfGDLE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 07:04:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7483FAEAF;
        Thu,  4 Jul 2019 11:04:26 +0000 (UTC)
Date:   Thu, 4 Jul 2019 13:04:25 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Kuo-Hsin Yang <vovoy@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Minchan Kim <minchan@kernel.org>,
        Sonny Rao <sonnyrao@chromium.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] mm: vmscan: scan anonymous pages on file refaults
Message-ID: <20190704110425.GD5620@dhcp22.suse.cz>
References: <20190628111627.GA107040@google.com>
 <20190701081038.GA83398@google.com>
 <20190703143057.GQ978@dhcp22.suse.cz>
 <20190704094716.GA245276@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190704094716.GA245276@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 04-07-19 17:47:16, Kuo-Hsin Yang wrote:
> On Wed, Jul 03, 2019 at 04:30:57PM +0200, Michal Hocko wrote:
> > 
> > How does the reclaim behave with workloads with file backed data set
> > not fitting into the memory? Aren't we going to to swap a lot -
> > something that the heuristic is protecting from?
> > 
> 
> In common case, most of the pages in a large file backed data set are
> non-executable. When there are a lot of non-executable file pages,
> usually more file pages are scanned because of the recent_scanned /
> recent_rotated ratio.
> 
> I modified the test program to set the accessed sizes of the executable
> and non-executable file pages respectively. The test program runs on 2GB
> RAM VM with kernel 5.2.0-rc7 and this patch, allocates 2000 MB anonymous
> memory, then accesses 100 MB executable file pages and 2100 MB
> non-executable file pages for 10 times. The test also prints the file
> and anonymous page sizes in kB from /proc/meminfo. There are not too
> many swaps in this test case. I got similar test result without this
> patch.

Could you record swap out stats please? Also what happens if you have
multiple readers?

Thanks!
-- 
Michal Hocko
SUSE Labs
