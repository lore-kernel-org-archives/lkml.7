Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3B8C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED2EF2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554279162;
	bh=oxqO+I2gP18GlAFNasrT1s/o0poRHTspGsZZXf4Xkt4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=D/5455zrzIc2rwEbjBEUFbcpH4tHeluTH0UBrrMfG7GxwVfY/yeqDFl5fMJFgJlIS
	 LU1UUDjSdnVx/z+3YJUrPt9e0OisWsw33q09+JuHZeCAzP5XtxwM3BChiALztHL7x4
	 OFdUaIijp6ref9KOsfl/ZP0CDHlbQnYUNwGT0fvQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728685AbfDCIMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 04:12:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:42624 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726004AbfDCIMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 04:12:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CB885B010;
        Wed,  3 Apr 2019 08:12:38 +0000 (UTC)
Date:   Wed, 3 Apr 2019 10:12:32 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
        anshuman.khandual@arm.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 0/4] mm,memory_hotplug: allocate memmap from hotadded
 memory
Message-ID: <20190403081232.GB15605@dhcp22.suse.cz>
References: <20190328134320.13232-1-osalvador@suse.de>
 <cc68ec6d-3ad2-a998-73dc-cb90f3563899@redhat.com>
 <efb08377-ca5d-4110-d7ae-04a0d61ac294@redhat.com>
 <20190329084547.5k37xjwvkgffwajo@d104.suse.de>
 <20190329134243.GA30026@dhcp22.suse.cz>
 <20190401075936.bjt2qsrhw77rib77@d104.suse.de>
 <20190401115306.GF28293@dhcp22.suse.cz>
 <20190402082812.fefamf7qlzulb7t2@d104.suse.de>
 <20190402124845.GD28293@dhcp22.suse.cz>
 <20190403080113.adj2m3szhhnvzu56@d104.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403080113.adj2m3szhhnvzu56@d104.suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 03-04-19 10:01:16, Oscar Salvador wrote:
> On Tue, Apr 02, 2019 at 02:48:45PM +0200, Michal Hocko wrote:
> > So what is going to happen when you hotadd two memblocks. The first one
> > holds memmaps and then you want to hotremove (not just offline) it?
> 
> If you hot-add two memblocks, this means that either:
> 
> a) you hot-add a 256MB-memory-device (128MB per memblock)
> b) you hot-add two 128MB-memory-device
> 
> Either way, hot-removing only works for memory-device as a whole, so
> there is no problem.
> 
> Vmemmaps are created per hot-added operations, this means that
> vmemmaps will be created for the hot-added range.
> And since hot-add/hot-remove operations works with the same granularity,
> there is no problem.

What does prevent calling somebody arch_add_memory for a range spanning
multiple memblocks from a driver directly. In other words aren't you
making  assumptions about a future usage based on the qemu usecase?

-- 
Michal Hocko
SUSE Labs
