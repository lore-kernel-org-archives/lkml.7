Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA31FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 09:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1505121D6C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 09:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573204736;
	bh=ZOSlEKmRgZ8uOhxG+ECZ17l1Qgm/7CRRNkz14AQi58I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GQGzYKDIXS1Kh9oOx6XNTggFvlyIm0dSVLclHlYxb5fT15aGD3ZF27WwBV4VNBg70
	 SccrYQB1NTndsr0RRVCuz285DFR60xLuXAJ1zJkJHBvZeBL8/X1fmSX+u7C2rpbtWS
	 kDuxJQlkBWph992dNWhRmFRIgRt86ydhw793G8nc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730959AbfKHJSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 04:18:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:55394 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726987AbfKHJSy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 04:18:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0BBD5B216;
        Fri,  8 Nov 2019 09:18:53 +0000 (UTC)
Date:   Fri, 8 Nov 2019 10:18:51 +0100
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
        "mst@redhat.com" <mst@redhat.com>, "cai@lca.pw" <cai@lca.pw>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Junichi Nomura <j-nomura@ce.jp.nec.com>
Subject: Re: [PATCH 0/3] make pfn walker support ZONE_DEVICE
Message-ID: <20191108091851.GB15658@dhcp22.suse.cz>
References: <20191108000855.25209-1-t-fukasawa@vx.jp.nec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108000855.25209-1-t-fukasawa@vx.jp.nec.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 08-11-19 00:08:03, Toshiki Fukasawa wrote:
> This patch set tries to make pfn walker support ZONE_DEVICE.
> This idea is from the TODO in below patch:
> 
>   commit aad5f69bc161af489dbb5934868bd347282f0764
>   Author: David Hildenbrand <david@redhat.com>
>   Date:   Fri Oct 18 20:19:20 2019 -0700
> 
> 	fs/proc/page.c: don't access uninitialized memmaps in fs/proc/page.c
> 
> pfn walker's ZONE_DEVICE support requires capability to identify
> that a memmap has been initialized. The uninitialized cases are 
> as follows:
> 
> 	a) pages reserved for ZONE_DEVICE driver
> 	b) pages currently initializing
> 
> This patch set solves both of them.

Why do we want this? What is the usecase?

> 
> Toshiki Fukasawa (3):
>   procfs: refactor kpage_*_read() in fs/proc/page.c
>   mm: Introduce subsection_dev_map
>   mm: make pfn walker support ZONE_DEVICE
> 
>  fs/proc/page.c           | 155 ++++++++++++++++++++---------------------------
>  include/linux/memremap.h |   6 ++
>  include/linux/mmzone.h   |  19 ++++++
>  mm/memremap.c            |  31 ++++++++++
>  mm/sparse.c              |  32 ++++++++++
>  5 files changed, 154 insertions(+), 89 deletions(-)
> 
> -- 
> 1.8.3.1
> 

-- 
Michal Hocko
SUSE Labs
