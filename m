Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8D7C10F0B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D653121852
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554281029;
	bh=RSe7hw37QTaYxjhu+zk8B4DH/+UPogPhdQ3QEyPnDBE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kA8dE1o1go3Q+9KGU5Jt4nV/la+ji0i9HK1BTNGkLgevEq4WEELH1vxkjkjDf/5jH
	 xqpNw3/fi4v+lF78LspYCayJUm4gt2yChVyEWfbv6oiJkqvq9ewDAdjiRnkHt4SwsA
	 5HwGjX1ufmD1u8CJSXPrpz2oXKPinZOBbl762gM8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728942AbfDCInr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 04:43:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:49244 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725822AbfDCInr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 04:43:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5E1ABB027;
        Wed,  3 Apr 2019 08:43:45 +0000 (UTC)
Date:   Wed, 3 Apr 2019 10:43:44 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     akpm@linux-foundation.org, david@redhat.com,
        dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
        anshuman.khandual@arm.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/4] mm, memory_hotplug: cleanup memory offline path
Message-ID: <20190403084344.GD15605@dhcp22.suse.cz>
References: <20190328134320.13232-1-osalvador@suse.de>
 <20190328134320.13232-2-osalvador@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190328134320.13232-2-osalvador@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 28-03-19 14:43:17, Oscar Salvador wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> check_pages_isolated_cb currently accounts the whole pfn range as being
> offlined if test_pages_isolated suceeds on the range. This is based on
> the assumption that all pages in the range are freed which is currently
> the case in most cases but it won't be with later changes, as pages
> marked as vmemmap won't be isolated.
> 
> Move the offlined pages counting to offline_isolated_pages_cb and
> rely on __offline_isolated_pages to return the correct value.
> check_pages_isolated_cb will still do it's primary job and check the pfn
> range.
> 
> While we are at it remove check_pages_isolated and offline_isolated_pages
> and use directly walk_system_ram_range as do in online_pages.
> 
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Oscar Salvador <osalvador@suse.de>

Can we merge this even without the rest of the series? It looks like a
useful thing regardless of this series. Sure we do not really use it
right now but it cleans up the code and actually removes more than it
adds...

-- 
Michal Hocko
SUSE Labs
