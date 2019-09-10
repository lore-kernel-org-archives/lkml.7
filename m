Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46133C4740A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 14:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 158CA2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 14:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568124073;
	bh=0ExGHZcnS5acd9BsNp/vbksKCteH1/dCfEqmA1S1e14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yxvEfkDn5T22JeFRJ27Dr+0xsbPa8iHN5fGQOcnEgLz7KZxaAH8jlsPtvQS8BKIwj
	 +rppbVJAiG+bdW1iWypIJYkziOtXHOEWMC3XKoSPb0SPlILf/lTwFDkiKJQA8ZNMes
	 cU1eEINnEncluia45Kunnc6tG9N3qvRQtIL14q5c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732121AbfIJOBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 10:01:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:57444 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726634AbfIJOBL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 10:01:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 60A59B71C;
        Tue, 10 Sep 2019 14:01:09 +0000 (UTC)
Date:   Tue, 10 Sep 2019 16:01:07 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Toshiki Fukasawa <t-fukasawa@vx.jp.nec.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "adobriyan@gmail.com" <adobriyan@gmail.com>,
        "hch@lst.de" <hch@lst.de>,
        "longman@redhat.com" <longman@redhat.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "mst@redhat.com" <mst@redhat.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Junichi Nomura <j-nomura@ce.jp.nec.com>
Subject: Re: [RFC PATCH v2] mm: initialize struct pages reserved by
 ZONE_DEVICE driver.
Message-ID: <20190910140107.GD2063@dhcp22.suse.cz>
References: <20190906081027.15477-1-t-fukasawa@vx.jp.nec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906081027.15477-1-t-fukasawa@vx.jp.nec.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 06-09-19 08:09:52, Toshiki Fukasawa wrote:
[...]
> @@ -5856,8 +5855,6 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
>  		if (!altmap)
>  			return;
>  
> -		if (start_pfn == altmap->base_pfn)
> -			start_pfn += altmap->reserve;
>  		end_pfn = altmap->base_pfn + vmem_altmap_offset(altmap);

Who is actually setting reserve? This is is something really impossible
to grep for in the kernle and git grep on altmap->reserve doesn't show
anything AFAICS.

Btw. irrespective to this issue all three callers should be using
pfn_to_online_page rather than pfn_to_page AFAICS. It doesn't really
make sense to collect data for offline pfn ranges. They might be
uninitialized even without zone device.
-- 
Michal Hocko
SUSE Labs
