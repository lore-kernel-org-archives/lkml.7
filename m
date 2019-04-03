Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E852C10F06
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDF5D2147A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554281358;
	bh=ffPOkgZdwfC3V2tcRbeNjPGHdLRiZ5ehp27X6fLG+3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KeYNr0j7blmXuh6MUWAXSRhLClqE/oRiZ/TFTA4YMW+6QX6MuYNsMaup5GfWJE0Fj
	 0wwMLjRJS7I0bLz2z4ccYlYwKkhBQKtphfRAbwQPHzDlQcDiO4CDVyymp5VWm3VnF3
	 ziWX0kza9RSa+qdKtq5I7jp3tfdDMRGp+dqWNUw0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729020AbfDCItR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 04:49:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:50864 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725822AbfDCItR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 04:49:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BBDCCADA3;
        Wed,  3 Apr 2019 08:49:15 +0000 (UTC)
Date:   Wed, 3 Apr 2019 10:49:15 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Oscar Salvador <osalvador@suse.de>, akpm@linux-foundation.org,
        dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
        anshuman.khandual@arm.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 0/4] mm,memory_hotplug: allocate memmap from hotadded
 memory
Message-ID: <20190403084915.GF15605@dhcp22.suse.cz>
References: <20190329134243.GA30026@dhcp22.suse.cz>
 <20190401075936.bjt2qsrhw77rib77@d104.suse.de>
 <20190401115306.GF28293@dhcp22.suse.cz>
 <20190402082812.fefamf7qlzulb7t2@d104.suse.de>
 <20190402124845.GD28293@dhcp22.suse.cz>
 <20190403080113.adj2m3szhhnvzu56@d104.suse.de>
 <20190403081232.GB15605@dhcp22.suse.cz>
 <d55aa259-56c0-9601-ffce-997ea1fb3ac5@redhat.com>
 <20190403083757.GC15605@dhcp22.suse.cz>
 <04a5b856-c8e0-937b-72bb-b9d17a12ccc7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04a5b856-c8e0-937b-72bb-b9d17a12ccc7@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 03-04-19 10:41:35, David Hildenbrand wrote:
> On 03.04.19 10:37, Michal Hocko wrote:
[...]
> > That being said it should be the caller of the hotplug code to tell
> > the vmemmap allocation strategy. For starter, I would only pack vmemmaps
> > for "regular" kernel zone memory. Movable zones should be more careful.
> > We can always re-evaluate later when there is a strong demand for huge
> > pages on movable zones but this is not the case now because those pages
> > are not really movable in practice.
> 
> Remains the issue with potential different user trying to remove memory
> it didn't add in some other granularity. We then really have to identify
> and isolate that case.

Can you give an example of a sensible usecase that would require this?
-- 
Michal Hocko
SUSE Labs
