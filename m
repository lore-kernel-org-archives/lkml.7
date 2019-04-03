Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86913C10F06
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EBCD206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbfDCIeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 04:34:02 -0400
Received: from charybdis-ext.suse.de ([195.135.221.2]:46420 "EHLO suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726105AbfDCIeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 04:34:01 -0400
Received: by suse.de (Postfix, from userid 1000)
        id 4B04E47E3; Wed,  3 Apr 2019 10:34:00 +0200 (CEST)
Date:   Wed, 3 Apr 2019 10:34:00 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
        anshuman.khandual@arm.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 0/4] mm,memory_hotplug: allocate memmap from hotadded
 memory
Message-ID: <20190403083359.vqbzy5krjfzfjedx@d104.suse.de>
References: <cc68ec6d-3ad2-a998-73dc-cb90f3563899@redhat.com>
 <efb08377-ca5d-4110-d7ae-04a0d61ac294@redhat.com>
 <20190329084547.5k37xjwvkgffwajo@d104.suse.de>
 <20190329134243.GA30026@dhcp22.suse.cz>
 <20190401075936.bjt2qsrhw77rib77@d104.suse.de>
 <20190401115306.GF28293@dhcp22.suse.cz>
 <20190402082812.fefamf7qlzulb7t2@d104.suse.de>
 <20190402124845.GD28293@dhcp22.suse.cz>
 <20190403080113.adj2m3szhhnvzu56@d104.suse.de>
 <20190403081232.GB15605@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403081232.GB15605@dhcp22.suse.cz>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 10:12:32AM +0200, Michal Hocko wrote:
> What does prevent calling somebody arch_add_memory for a range spanning
> multiple memblocks from a driver directly. In other words aren't you
> making  assumptions about a future usage based on the qemu usecase?

Well, right now they cannot as it is not exported.
But if we want to do it in the future, then yes, I would have to
be more careful because I made the assumption that hot-add/hot-remove
are working with the same granularity, which is the case right now.

Given said this, I think that something like you said before, giving
the option to the caller to specify whether it wants vmemmaps per the
whole hot-added range or per memblock is a reasonable thing to do.
That way, there will not be a problem working with different granularities
in hot-add/hot-remove operations and we would be on safe side.

-- 
Oscar Salvador
SUSE L3
