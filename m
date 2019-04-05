Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58135C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 07:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E4512175B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 07:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554449630;
	bh=KwZWXlxWk6dRqFuwPropCv/xtvZLE8FsgFtk7cPh9Yk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SXlSq7HmQmXKUQDqACBUUHHGzCLXdb3ZV3Fq5QfAdd4E+hkLfGt69Qc/Kb78WiDbd
	 wowuvePDq+0i2hMPqXOcdlpHEl9L6bjAzMx/75qqDTvMDRtAI3v4NGAVoQShwHuD/y
	 oy4V6p53NLtxEL67EBuSfOA6ua+vNyme2boR1gDM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730068AbfDEHds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 03:33:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:45970 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726594AbfDEHds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 03:33:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5CCA1AB48;
        Fri,  5 Apr 2019 07:14:23 +0000 (UTC)
Date:   Fri, 5 Apr 2019 09:14:18 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Oscar Salvador <osalvador@suse.de>, akpm@linux-foundation.org,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 2/2] mm, memory_hotplug: provide a more generic
 restrictions for memory hotplug
Message-ID: <20190405071418.GN12864@dhcp22.suse.cz>
References: <20190404125916.10215-1-osalvador@suse.de>
 <20190404125916.10215-3-osalvador@suse.de>
 <880c5d09-7d4e-2a97-e826-a8a6572216b2@redhat.com>
 <20190404180144.lgpf6qgnp67ib5s7@d104.suse.de>
 <5f735328-3451-ebd7-048e-e83e74e2c622@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f735328-3451-ebd7-048e-e83e74e2c622@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 04-04-19 20:27:41, David Hildenbrand wrote:
> On 04.04.19 20:01, Oscar Salvador wrote:
[...]
> > But I am not really convinced by MHP_SYSTEM_RAM name, and I think we should stick
> > with MHP_MEMBLOCK_API because it represents __what__ is that flag about and its
> > function, e.g: create memory block devices.

Exactly

> This nicely aligns with the sub-section memory add support discussion.
> 
> MHP_MEMBLOCK_API immediately implies that
> 
> - memory is used as system ram. Memory can be onlined/offlined. Markers
>   at sections indicate if the section is online/offline.

No there is no implication like that. It means only that the onlined
memory has a sysfs interface. Nothing more, nothing less

This is an internal API so we are not carving anything into the stone.
So can we simply start with what we have and go from there? I am getting
felling that this discussion just makes the whole thing more muddy.
-- 
Michal Hocko
SUSE Labs
