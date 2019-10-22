Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9479CA9EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 09:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0449207FC
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 09:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571735675;
	bh=xH0PBkt/EYM2XeUpTwcTDiKlAVw0oDtSEMxnc7Ve8fA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=12j1Ge47l73uMrdukYKZhgJkgiAqwwdkfZLl5he7MeTbDgao2HDLIHqrVjsxuvY4v
	 kmmC0ZPYWHMml7g/r4/8CotDHHQUmjePKwnjWuK+boX4sUp2VLY0iLhxB3I5GgRFdd
	 MwobsI/W6zXtGi/kg35jbyDfJJ9DPs9RMU1NesBA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388239AbfJVJOe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 05:14:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:41958 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731314AbfJVJOe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 05:14:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 360B2B954;
        Tue, 22 Oct 2019 09:14:32 +0000 (UTC)
Date:   Tue, 22 Oct 2019 11:14:31 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Pingfan Liu <kernelfans@gmail.com>, Qian Cai <cai@lca.pw>,
        Vlastimil Babka <vbabka@suse.cz>,
        Wei Yang <richard.weiyang@gmail.com>
Subject: Re: [PATCH v2 0/2] mm: Memory offlining + page isolation cleanups
Message-ID: <20191022091431.GG9379@dhcp22.suse.cz>
References: <20191021172353.3056-1-david@redhat.com>
 <25d3f071-3268-298b-e0c8-9c307d1015fe@redhat.com>
 <20191022080835.GZ9379@dhcp22.suse.cz>
 <1f56744d-2c22-6c12-8fe8-4a71e791c467@redhat.com>
 <20191022082131.GC9379@dhcp22.suse.cz>
 <de39873c-ae55-88ed-0b4e-4f67a75ef81c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de39873c-ae55-88ed-0b4e-4f67a75ef81c@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 22-10-19 10:32:11, David Hildenbrand wrote:
[...]
> E.g., arch/x86/kvm/mmu.c:kvm_is_mmio_pfn()

Thanks for these references. I am not really familiar with kvm so I
cannot really comment on the specific code but I am wondering why
it simply doesn't check for ZONE_DEVICE explicitly? Also we do care
about holes in RAM (from the early boot), those should be reserved
already AFAIR. So we are left with hotplugged memory with holes and
I am not really sure we should bother with this until there is a clear
usecase in sight.
-- 
Michal Hocko
SUSE Labs
