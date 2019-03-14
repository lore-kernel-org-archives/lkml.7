Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB39C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 08:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C523E217F5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 08:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552551742;
	bh=TCKQMlt8DkoQSn5JNBM0Y/n6ODVL6o6isOkm4XyyyFU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gWo4wOqo97p/idweiogSp416MJAbAubXy81yWyhXRcB00+iW0Nw9iYBez2GnVnCoQ
	 1Bg4W3KfSkQm5W6fTt9itjXN/tKw7qD7XYIi3g1yoLTewyJX4uGPClZUqAxn2GnF09
	 Bcgj9z3uR//pse4WWohxrRgVXFCHf5vk+YzsZKNk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbfCNIWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 04:22:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:48710 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726421AbfCNIWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 04:22:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3D8E2ACE3;
        Thu, 14 Mar 2019 08:22:20 +0000 (UTC)
Date:   Thu, 14 Mar 2019 09:22:19 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Qian Cai <cai@lca.pw>, akpm@linux-foundation.org, vbabka@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/hotplug: fix offline undo_isolate_page_range()
Message-ID: <20190314082219.GD7473@dhcp22.suse.cz>
References: <20190313143133.46200-1-cai@lca.pw>
 <20190314080922.dk5ljg7fbtarzrog@d104.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190314080922.dk5ljg7fbtarzrog@d104.suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 14-03-19 09:09:22, Oscar Salvador wrote:
> On Wed, Mar 13, 2019 at 10:31:33AM -0400, Qian Cai wrote:
> > Also, after calling the "useless" undo_isolate_page_range() here, it
> > reaches the point of no returning by notifying MEM_OFFLINE. Those pages
> > will be marked as MIGRATE_MOVABLE again once onlining. The only thing
> > left to do is to decrease the number of isolated pageblocks zone
> > counter which would make some paths of the page allocation slower that
> > the above commit introduced. A memory block is usually at most 1GiB in
> > size, so an "int" should be enough to represent the number of pageblocks
> > in a block. Fix an incorrect comment along the way.
> 
> Well, x86_64's memblocks can be up to 2GB depending on the memory we got.
> Plus the fact that alloc_contig_range can be used to isolate 16GB-hugetlb
> pages on powerpc, and that could be a lot of pageblocks.
> 
> While an "int" could still hold, I think we should use "long" just to be
> more future-proof.

I would rather not touch that for now. If we really need to change the
type then do it when it is really needed. I pressume more things would
have to be changed anyway.

-- 
Michal Hocko
SUSE Labs
