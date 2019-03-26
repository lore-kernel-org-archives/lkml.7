Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B744C10F05
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 12:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDA5420879
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 12:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553603126;
	bh=e90zrrnTPe6aXqGN6s7zPHYtw037Dv/1hyTW/o/uYAw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Otc0qa5L34CJFmHhJ+V8CMT7SJ4BaWBXIfp4OEE/KG43/r6Mgt9IdCsZah1Cje1rV
	 vA5qO7tnbJ7VHEEu4uFFmpqFYWwGmfvjlRvpS+k+L3ffHUMBDnnGSHxJzH2mA9FE/7
	 OyU5bKsStLmur8wCSlt5LfVZ3L54FtbsGo9MKzMc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730587AbfCZMZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 08:25:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:48344 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726111AbfCZMZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 08:25:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C215BAF19;
        Tue, 26 Mar 2019 12:25:23 +0000 (UTC)
Date:   Tue, 26 Mar 2019 13:25:22 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        logang@deltatee.com, osalvador@suse.de, hannes@cmpxchg.org,
        akpm@linux-foundation.org, richard.weiyang@gmail.com,
        rientjes@google.com, zi.yan@cs.rutgers.edu
Subject: Re: [RFC] mm/hotplug: Make get_nid_for_pfn() work with
 HAVE_ARCH_PFN_VALID
Message-ID: <20190326122522.GO28406@dhcp22.suse.cz>
References: <1553155700-3414-1-git-send-email-anshuman.khandual@arm.com>
 <20190321083639.GJ8696@dhcp22.suse.cz>
 <621cc94c-210d-6fd4-a2e1-b7cfce733cf3@arm.com>
 <20190322120219.GI32418@dhcp22.suse.cz>
 <65a4b160-a654-8bd3-8022-491094cf6b8f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65a4b160-a654-8bd3-8022-491094cf6b8f@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 26-03-19 17:33:19, Anshuman Khandual wrote:
[...]
> I could get it working with the following re-order of memblock_[free|remove] and
> arch_remove_memory(). I did not observe any other adverse side affect because of
> this change. Does it look okay ?

Memblock should only work with physical memory ranges without touching
struct pages so this should be safe. But you should double check of
course.

> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1863,11 +1863,11 @@ void __ref __remove_memory(int nid, u64 start, u64 size)
>  
>         /* remove memmap entry */
>         firmware_map_remove(start, start + size, "System RAM");
> +       arch_remove_memory(nid, start, size, NULL);
> +
>         memblock_free(start, size);
>         memblock_remove(start, size);
>  
> -       arch_remove_memory(nid, start, size, NULL);
> -
>         try_offline_node(nid);
>  
>         mem_hotplug_done();

-- 
Michal Hocko
SUSE Labs
