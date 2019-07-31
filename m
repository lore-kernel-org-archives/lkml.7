Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77CDAC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EF15206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564577045;
	bh=NzM5rZK8u18uLHYsnGoXrlS3dB1bxhf2/1KfDOZquw8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=k4SF4chOUZ33UCKqV1X6Of3RU7IhC0Vz18Wjj58hpWYMePE2ragWVK2YusPHL4Dku
	 cX+dAYXVtt7zBakz4NcWVUOeG+1U5iQIzr85HTkoJaEPFHj2H73vbvzQWXTE4DkGv7
	 uXKkjnQwiGOFe8ssvPEgayv+lhGty/sldl9nIXH4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387444AbfGaMoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 08:44:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:49526 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728929AbfGaMoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 08:44:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EC03AAFA4;
        Wed, 31 Jul 2019 12:44:01 +0000 (UTC)
Date:   Wed, 31 Jul 2019 14:43:56 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v1] drivers/base/memory.c: Don't store end_section_nr in
 memory blocks
Message-ID: <20190731124356.GL9330@dhcp22.suse.cz>
References: <20190731122213.13392-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731122213.13392-1-david@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 31-07-19 14:22:13, David Hildenbrand wrote:
> Each memory block spans the same amount of sections/pages/bytes. The size
> is determined before the first memory block is created. No need to store
> what we can easily calculate - and the calculations even look simpler now.

While this cleanup helps a bit, I am not sure this is really worth
bothering. I guess we can agree when I say that the memblock interface
is suboptimal (to put it mildly).  Shouldn't we strive for making it
a real hotplug API in the future? What do I mean by that? Why should
be any memblock fixed in size? Shouldn't we have use hotplugable units
instead (aka pfn range that userspace can work with sensibly)? Do we
know of any existing userspace that would depend on the current single
section res. 2GB sized memblocks?

All that being said, I do not oppose to the patch but can we start
thinking about the underlying memblock limitations rather than micro
cleanups?
-- 
Michal Hocko
SUSE Labs
