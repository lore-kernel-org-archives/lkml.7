Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17AA6C10F06
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E21FD20830
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:01:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbfDCIBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 04:01:18 -0400
Received: from charybdis-ext.suse.de ([195.135.221.2]:24274 "EHLO suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726360AbfDCIBS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 04:01:18 -0400
Received: by suse.de (Postfix, from userid 1000)
        id A8CEC47E0; Wed,  3 Apr 2019 10:01:16 +0200 (CEST)
Date:   Wed, 3 Apr 2019 10:01:16 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
        anshuman.khandual@arm.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 0/4] mm,memory_hotplug: allocate memmap from hotadded
 memory
Message-ID: <20190403080113.adj2m3szhhnvzu56@d104.suse.de>
References: <20190328134320.13232-1-osalvador@suse.de>
 <cc68ec6d-3ad2-a998-73dc-cb90f3563899@redhat.com>
 <efb08377-ca5d-4110-d7ae-04a0d61ac294@redhat.com>
 <20190329084547.5k37xjwvkgffwajo@d104.suse.de>
 <20190329134243.GA30026@dhcp22.suse.cz>
 <20190401075936.bjt2qsrhw77rib77@d104.suse.de>
 <20190401115306.GF28293@dhcp22.suse.cz>
 <20190402082812.fefamf7qlzulb7t2@d104.suse.de>
 <20190402124845.GD28293@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402124845.GD28293@dhcp22.suse.cz>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 02:48:45PM +0200, Michal Hocko wrote:
> So what is going to happen when you hotadd two memblocks. The first one
> holds memmaps and then you want to hotremove (not just offline) it?

If you hot-add two memblocks, this means that either:

a) you hot-add a 256MB-memory-device (128MB per memblock)
b) you hot-add two 128MB-memory-device

Either way, hot-removing only works for memory-device as a whole, so
there is no problem.

Vmemmaps are created per hot-added operations, this means that
vmemmaps will be created for the hot-added range.
And since hot-add/hot-remove operations works with the same granularity,
there is no problem.

E.g:

# (qemu) object_add memory-backend-ram,id=ram0,size=128M
# (qemu) device_add pc-dimm,id=dimm0,memdev=ram0,node=1

# (qemu) object_add memory-backend-ram,id=ram1,size=512M
# (qemu) device_add pc-dimm,id=dimm1,memdev=ram1,node=1

# (qemu) object_add memory-backend-ram,id=ram2,size=1G
# (qemu) device_add pc-dimm,id=dimm2,memdev=ram2,node=1

These are three hot-add operations.
Each hot-add operation will create use vmemmaps to hold the memmap for
its hot-added sections.

-- 
Oscar Salvador
SUSE L3
