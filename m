Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A459ACA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 21:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AA2520679
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 21:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572384834;
	bh=uUPuRp21vww4JYMwj4VwNL4OIhJJzH6oL3Bf7yVJvsc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=aX+00vuRcac+OZcoEtiDut4+yKnaOirMVXXG421rwxhfSAJ7p3U5l5zfNUFuTPfX4
	 TrxmPmWvkSXnyKAgJEvkZ2o8nvKHOwNyeLlBH8F+DG3Jg4vGtXMEJ7DvNwE0CjlunN
	 JJwREY3YEgrXScufiFRHfkaaAPONklu6VtoKaWGw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729194AbfJ2Vdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 17:33:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:46076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726364AbfJ2Vdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 17:33:53 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7CD320659;
        Tue, 29 Oct 2019 21:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572384832;
        bh=uUPuRp21vww4JYMwj4VwNL4OIhJJzH6oL3Bf7yVJvsc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ig2sslsC+KKOWPf5TweLOBiWHqzEIdHcblfcpRa78d8p9GG4aMiDM+J6BCmf+GCfU
         VCbyJiS9/RUoTppBGPF7/jWTGfV1ySfmgkDK89lYtWGuIrHojUb/R27+lZ+7hKExg/
         ku50TDOkl6WcZDYLoluREtTZ+5pLWWNpSVmyWQ6Q=
Date:   Tue, 29 Oct 2019 14:33:51 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [patch for-5.3 0/4] revert immediate fallback to remote
 hugepages
Message-Id: <20191029143351.95f781f09a9fbf254163d728@linux-foundation.org>
In-Reply-To: <20191029151549.GO31513@dhcp22.suse.cz>
References: <alpine.DEB.2.21.1909261149380.39830@chino.kir.corp.google.com>
        <20190927074803.GB26848@dhcp22.suse.cz>
        <CAHk-=wgba5zOJtGBFCBP3Oc1m4ma+AR+80s=hy=BbvNr3GqEmA@mail.gmail.com>
        <20190930112817.GC15942@dhcp22.suse.cz>
        <20191001054343.GA15624@dhcp22.suse.cz>
        <20191001083743.GC15624@dhcp22.suse.cz>
        <20191018141550.GS5017@dhcp22.suse.cz>
        <53c4a6ca-a4d0-0862-8744-f999b17d82d8@suse.cz>
        <alpine.DEB.2.21.1910241156370.130350@chino.kir.corp.google.com>
        <08a3f4dd-c3ce-0009-86c5-9ee51aba8557@suse.cz>
        <20191029151549.GO31513@dhcp22.suse.cz>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Oct 2019 16:15:49 +0100 Michal Hocko <mhocko@kernel.org> wrote:

> > 
> > 1. local node only THP allocation with no reclaim, just compaction.
> > 2. for madvised VMA's or when synchronous compaction is enabled always - THP
> >    allocation from any node with effort determined by global defrag setting
> >    and VMA madvise
> > 3. fallback to base pages on any node
> > 
> > Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> 
> I've given this a try and here are the results of my previous testcase
> (memory full of page cache).

Thanks, I'll queue this for some more testing.  At some point we should
decide on a suitable set of Fixes: tags and a backporting strategy, if any?
