Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D140C10F0B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4090E206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554281167;
	bh=P90YKyS1fkJGyMdUA7QJuz0U6uGZcl5t4USSg1fTZYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hQinKCnJk3H3Ak//VJDDzxi3SvG3Tx4EkD706tKuK7HA2b3epFO7oa4dTEDT94Tzx
	 CtCvdTDqiVChh9+C5Q0C1QY0KQVzmYdzyjh4Ww4NZvQXvseUnCbKh3JhMHE4b59u/s
	 cMyocdT5+7bJDb0WN0CCfmleD+hSJG6jdtoFEVP4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbfDCIqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 04:46:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:49828 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725990AbfDCIqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 04:46:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 545D3ADA3;
        Wed,  3 Apr 2019 08:46:04 +0000 (UTC)
Date:   Wed, 3 Apr 2019 10:46:03 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     akpm@linux-foundation.org, david@redhat.com,
        dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
        anshuman.khandual@arm.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 2/4] mm, memory_hotplug: provide a more generic
 restrictions for memory hotplug
Message-ID: <20190403084603.GE15605@dhcp22.suse.cz>
References: <20190328134320.13232-1-osalvador@suse.de>
 <20190328134320.13232-3-osalvador@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190328134320.13232-3-osalvador@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 28-03-19 14:43:18, Oscar Salvador wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> arch_add_memory, __add_pages take a want_memblock which controls whether
> the newly added memory should get the sysfs memblock user API (e.g.
> ZONE_DEVICE users do not want/need this interface). Some callers even
> want to control where do we allocate the memmap from by configuring
> altmap.
> 
> Add a more generic hotplug context for arch_add_memory and __add_pages.
> struct mhp_restrictions contains flags which contains additional
> features to be enabled by the memory hotplug (MHP_MEMBLOCK_API
> currently) and altmap for alternative memmap allocator.
> 
> Please note that the complete altmap propagation down to vmemmap code
> is still not done in this patch. It will be done in the follow up to
> reduce the churn here.
> 
> This patch shouldn't introduce any functional change.

Is there an agreement on the interface here? Or do we want to hide almap
behind some more general looking interface? If the former is true, can
we merge it as it touches a code that might cause merge conflicts later on
as multiple people are working on this area.
-- 
Michal Hocko
SUSE Labs
