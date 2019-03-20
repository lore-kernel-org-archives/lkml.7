Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F70C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 09:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 941352186A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 09:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553074663;
	bh=4813U6LkFC145zp2AAe2Gfo9HmiF+anV9941cXTwJe0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Wwi0YU3V+/Z4jOv8foFYPI6eQlzZYn39qaxYw6EsKyYh6KtauBzBF4Yz3LUVKChWj
	 lY8rK1xQ7uzja/TvV/HVK1BrxM3s0eCxzCbSbwUEx8bfJ9mykCedIUe5V7pGddrXno
	 pWQLxdEJ+0JBLOXg6T+oFmG4DWwTOtibT1MlOCt4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbfCTJhm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 05:37:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:37742 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726832AbfCTJhl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 05:37:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8853FABD0;
        Wed, 20 Mar 2019 09:37:40 +0000 (UTC)
Date:   Wed, 20 Mar 2019 10:37:40 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        osalvador@suse.de, david@redhat.com, richard.weiyang@gmail.com,
        rppt@linux.ibm.com
Subject: Re: [PATCH] mm, memory_hotplug: Fix the wrong usage of N_HIGH_MEMORY
Message-ID: <20190320093740.GH30433@dhcp22.suse.cz>
References: <20190320080732.14933-1-bhe@redhat.com>
 <20190320084600.GG30433@dhcp22.suse.cz>
 <20190320090624.GN18740@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320090624.GN18740@MiWiFi-R3L-srv>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 20-03-19 17:06:24, Baoquan He wrote:
> On 03/20/19 at 09:46am, Michal Hocko wrote:
> > On Wed 20-03-19 16:07:32, Baoquan He wrote:
> > > In function node_states_check_changes_online(), N_HIGH_MEMORY is used
> > > to substitute ZONE_HIGHMEM directly. This is not right. N_HIGH_MEMORY
> > > always has value '3' if CONFIG_HIGHMEM=y, while ZONE_HIGHMEM's value
> > > is not. It depends on whether CONFIG_ZONE_DMA/CONFIG_ZONE_DMA32 are
> > > enabled. Obviously it's not true for CONFIG_ZONE_DMA32 on 32bit system,
> > > and CONFIG_ZONE_DMA is also optional.
> > > 
> > > Replace it with ZONE_HIGHMEM.
> > 
> > N*MEMORY is confusing as hell but I am really curious whether we have
> > ZONE_DMA32 and ZONE_HIGMEM together?
> 
> Not sure. AFAIK, on x86_32 it can't be.
> 
> > 
> > That being said N.*MEMORY is intended to check for nodes rather than
> > zones so the patch looks good to me but I think the above explanation is
> > misleading and will add even more mud to the picture when somebody tries
> > to understand what the heck is going on here.
> 
> Yes, agree. I also thought this again after I sent out patch, feel log is not
> good. As you said, they are value of enum node_states and enum zone_type
> separately.
> 
> How about this:
> 
> ~~~
> In function node_states_check_changes_online(), N_HIGH_MEMORY is used
> to substitute ZONE_HIGHMEM directly. This is not right. N_HIGH_MEMORY
> is to mark the memory state of node. Here zone index is checked, which
> should be compared with 'ZONE_HIGHMEM' accordingly.
> 
> Replace it with ZONE_HIGHMEM.

OK, this is better. Thanks!

Feel free to stamp the patch with
Acked-by: Michal Hocko <mhocko@suse.com>

-- 
Michal Hocko
SUSE Labs
