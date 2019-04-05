Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C582EC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 10:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8846120652
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 10:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554460257;
	bh=hVgHTrmUCickUmqGfi+43T0tLcwG+pSRYSJa/fC7Dcg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0Q/fwsn/ngqQ9ryU/Pcchf4mW2mr+CAW0ro7q6a+WB6Fg14eNTLzIdJ97gimshUGr
	 H1fl85wv2slt4qJ5O+VIU6zRgyi00ZjzcAqDDGW3iCcBApFLSzz/Xdis+8XEL+2C3D
	 +qQMMXkr7L8PVkyjE5WLy0IMloH0DMJ/A10TCmaA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730702AbfDEKa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 06:30:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:60350 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730579AbfDEKa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 06:30:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D67E3B07D;
        Fri,  5 Apr 2019 10:30:54 +0000 (UTC)
Date:   Fri, 5 Apr 2019 12:30:53 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Oscar Salvador <osalvador@suse.de>, akpm@linux-foundation.org,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 2/2] mm, memory_hotplug: provide a more generic
 restrictions for memory hotplug
Message-ID: <20190405103053.GO12864@dhcp22.suse.cz>
References: <20190404125916.10215-1-osalvador@suse.de>
 <20190404125916.10215-3-osalvador@suse.de>
 <880c5d09-7d4e-2a97-e826-a8a6572216b2@redhat.com>
 <20190404180144.lgpf6qgnp67ib5s7@d104.suse.de>
 <5f735328-3451-ebd7-048e-e83e74e2c622@redhat.com>
 <20190405071418.GN12864@dhcp22.suse.cz>
 <a4230528-dc7e-e17c-c363-e3da7961dbf1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4230528-dc7e-e17c-c363-e3da7961dbf1@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 05-04-19 10:05:09, David Hildenbrand wrote:
> On 05.04.19 09:14, Michal Hocko wrote:
> > On Thu 04-04-19 20:27:41, David Hildenbrand wrote:
> >> On 04.04.19 20:01, Oscar Salvador wrote:
> > [...]
> >>> But I am not really convinced by MHP_SYSTEM_RAM name, and I think we should stick
> >>> with MHP_MEMBLOCK_API because it represents __what__ is that flag about and its
> >>> function, e.g: create memory block devices.
> > 
> > Exactly
> 
> Fine with me for keeping what Oscar has.
> 
> > 
> >> This nicely aligns with the sub-section memory add support discussion.
> >>
> >> MHP_MEMBLOCK_API immediately implies that
> >>
> >> - memory is used as system ram. Memory can be onlined/offlined. Markers
> >>   at sections indicate if the section is online/offline.
> > 
> > No there is no implication like that. It means only that the onlined
> > memory has a sysfs interface. Nothing more, nothing less
> 
> As soon as there is a online/offline interface, you *can* (and user
> space usually *will*) online that memory. Onlining/offlining is only
> defined for memory to be added to the buddy - memory to be used as
> "system ram". Doing it for random device memory will not work / result
> in undefined behavior.

No, not really. We really do not care where the memory comes from. Is it
RAM, NVDIMM, $FOO_BAR_OF_A_FUTURE_BUZZ. We only do care that the memory
can be onlined - user triggered associated with a zone. The memory even
doesn't have to go to the page allocator.
-- 
Michal Hocko
SUSE Labs
