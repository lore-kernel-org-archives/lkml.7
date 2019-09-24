Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6520EC4320D
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 15:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 301E521783
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 15:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569337911;
	bh=N9Fc9xapxK42Ld92i1tE4TtP30dzJu+G8igRTDgiRtY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=W5WhYXJ5e3fiac+jw4gitwuVv4s779FjWCqyyUXrjtND4WrRJkqws97s08/VWtPh4
	 Hfp6guM0fZqqcfq+Apk9okBeJIoVMNdiVTcR8qvlnt+dDeEI5YNcYd5ow5xVT/k3SP
	 tARSJ0hkHS037LqrJ4HK66c+d3GzBQOZ8VLBxaH0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388241AbfIXPLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 11:11:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:47534 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727741AbfIXPLu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 11:11:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7DB58B048;
        Tue, 24 Sep 2019 15:11:48 +0000 (UTC)
Date:   Tue, 24 Sep 2019 17:11:47 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v1] mm/memory_hotplug: Don't take the cpu_hotplug_lock
Message-ID: <20190924151147.GB23050@dhcp22.suse.cz>
References: <20190924143615.19628-1-david@redhat.com>
 <1569337401.5576.217.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1569337401.5576.217.camel@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 24-09-19 11:03:21, Qian Cai wrote:
[...]
> While at it, it might be a good time to rethink the whole locking over there, as
> it right now read files under /sys/kernel/slab/ could trigger a possible
> deadlock anyway.
> 
[...]
> [  442.452090][ T5224] -> #0 (mem_hotplug_lock.rw_sem){++++}:
> [  442.459748][ T5224]        validate_chain+0xd10/0x2bcc
> [  442.464883][ T5224]        __lock_acquire+0x7f4/0xb8c
> [  442.469930][ T5224]        lock_acquire+0x31c/0x360
> [  442.474803][ T5224]        get_online_mems+0x54/0x150
> [  442.479850][ T5224]        show_slab_objects+0x94/0x3a8
> [  442.485072][ T5224]        total_objects_show+0x28/0x34
> [  442.490292][ T5224]        slab_attr_show+0x38/0x54
> [  442.495166][ T5224]        sysfs_kf_seq_show+0x198/0x2d4
> [  442.500473][ T5224]        kernfs_seq_show+0xa4/0xcc
> [  442.505433][ T5224]        seq_read+0x30c/0x8a8
> [  442.509958][ T5224]        kernfs_fop_read+0xa8/0x314
> [  442.515007][ T5224]        __vfs_read+0x88/0x20c
> [  442.519620][ T5224]        vfs_read+0xd8/0x10c
> [  442.524060][ T5224]        ksys_read+0xb0/0x120
> [  442.528586][ T5224]        __arm64_sys_read+0x54/0x88
> [  442.533634][ T5224]        el0_svc_handler+0x170/0x240
> [  442.538768][ T5224]        el0_svc+0x8/0xc

I believe the lock is not really needed here. We do not deallocated
pgdat of a hotremoved node nor destroy the slab state because an
existing slabs would prevent hotremove to continue in the first place.

There are likely details to be checked of course but the lock just seems
bogus.
-- 
Michal Hocko
SUSE Labs
