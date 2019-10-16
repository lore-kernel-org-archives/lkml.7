Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C855FA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 11:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23A4E20854
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 11:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571226436;
	bh=szD1v/tv/70IgNvkNfPiL4jJRsh2aZc2iifLdcP6Uho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pKdl+1//2f7FZ5rhMfUD6uutx/EWqVKmlFLZwSz33UDB9cIFnVusUWsnP4tL0MEsZ
	 NBNImI1gTUTN0UfqZBVT+pSVPeo6DQqVutLqiNbo+JAJGd/5+SGHx4JH3uHpmTMKtn
	 V2Ku+LSLG2IpUcM2IclqyUaOcVHmMtWcmujOzOpE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387880AbfJPLrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 07:47:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:44930 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727187AbfJPLrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 07:47:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C585FB3E2;
        Wed, 16 Oct 2019 11:47:08 +0000 (UTC)
Date:   Wed, 16 Oct 2019 13:47:08 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        virtualization@lists.linux-foundation.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>, Qian Cai <cai@lca.pw>
Subject: Re: [PATCH RFC v3 8/9] mm/memory_hotplug: Introduce
 offline_and_remove_memory()
Message-ID: <20191016114708.GY317@dhcp22.suse.cz>
References: <20190919142228.5483-1-david@redhat.com>
 <20190919142228.5483-9-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190919142228.5483-9-david@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 19-09-19 16:22:27, David Hildenbrand wrote:
> virtio-mem wants to offline and remove a memory block once it unplugged
> all subblocks (e.g., using alloc_contig_range()). Let's provide
> an interface to do that from a driver. virtio-mem already supports to
> offline partially unplugged memory blocks. Offlining a fully unplugged
> memory block will not require to migrate any pages. All unplugged
> subblocks are PageOffline() and have a reference count of 0 - so
> offlining code will simply skip them.
> 
> All we need an interface to trigger the "offlining" and the removing in a
> single operation - to make sure the memory block cannot get onlined by
> user space again before it gets removed.
> 
> To keep things simple, allow to only work on a single memory block.

Without a user it is not really clear why do we need this interface.
I am also not really sure why do you want/need to control beyond the
offlining stage. Care to explain some more?
-- 
Michal Hocko
SUSE Labs
