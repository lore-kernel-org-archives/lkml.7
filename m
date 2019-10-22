Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B444CA9EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 13:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 524BC21928
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 13:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571751112;
	bh=6DitficGz+KEm9q7yUtIkyDhaJLJhg5H8T0NYC6f8go=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xyYm6K5Fh4o7Jtzo2vBSFjR3OPjWNy/x3JShbBT8YOXi9dattgQFllKU/lZO9hv2H
	 NvmsV6ZXR1W0AyuqY3AeJFXF3G5Nk/BNbyHKofLZqkcg55AA6Ci1iGwWn1yZJEvVVP
	 4/ur3uk6ssVHFxvlNGuJYh0KEgqu2qCXt/FEw8nA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732077AbfJVNbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 09:31:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:43230 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725788AbfJVNbu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 09:31:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 53E02B13E;
        Tue, 22 Oct 2019 13:31:49 +0000 (UTC)
Date:   Tue, 22 Oct 2019 15:31:48 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>,
        Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH 00/16] The new slab memory controller
Message-ID: <20191022133148.GP9379@dhcp22.suse.cz>
References: <20191018002820.307763-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018002820.307763-1-guro@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 17-10-19 17:28:04, Roman Gushchin wrote:
> This patchset provides a new implementation of the slab memory controller,
> which aims to reach a much better slab utilization by sharing slab pages
> between multiple memory cgroups. Below is the short description of the new
> design (more details in commit messages).
> 
> Accounting is performed per-object instead of per-page. Slab-related
> vmstat counters are converted to bytes. Charging is performed on page-basis,
> with rounding up and remembering leftovers.
> 
> Memcg ownership data is stored in a per-slab-page vector: for each slab page
> a vector of corresponding size is allocated. To keep slab memory reparenting
> working, instead of saving a pointer to the memory cgroup directly an
> intermediate object is used. It's simply a pointer to a memcg (which can be
> easily changed to the parent) with a built-in reference counter. This scheme
> allows to reparent all allocated objects without walking them over and changing
> memcg pointer to the parent.
> 
> Instead of creating an individual set of kmem_caches for each memory cgroup,
> two global sets are used: the root set for non-accounted and root-cgroup
> allocations and the second set for all other allocations. This allows to
> simplify the lifetime management of individual kmem_caches: they are destroyed
> with root counterparts. It allows to remove a good amount of code and make
> things generally simpler.

What is the performance impact? Also what is the effect on the memory
reclaim side and the isolation. I would expect that mixing objects from
different cgroups would have a negative/unpredictable impact on the
memcg slab shrinking.
-- 
Michal Hocko
SUSE Labs
