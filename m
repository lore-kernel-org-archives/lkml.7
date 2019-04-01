Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC6EC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 11:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E008E20883
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 11:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554119591;
	bh=zEhd33Z6TChszaPgs9iRyc9N/w9fyUst27mWujReceE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1ExTRAGAYotXApHr7sJASLMcLRnZeojXuaJwq2PvMvGq+nFFM7sJOAXsJNFW7HTVW
	 PxzVetchpRHf3RacTNxFAtSwUk+8YeZEATWsePFz2sNKTpnKlfi9zsoqcfK22QXx2T
	 wzE6AU6pqk3x/BqEIGFrpRqubzssSfRsU/IWk/rA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfDALxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 07:53:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:40008 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726473AbfDALxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 07:53:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D24CDAEC8;
        Mon,  1 Apr 2019 11:53:07 +0000 (UTC)
Date:   Mon, 1 Apr 2019 13:53:06 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
        anshuman.khandual@arm.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 0/4] mm,memory_hotplug: allocate memmap from hotadded
 memory
Message-ID: <20190401115306.GF28293@dhcp22.suse.cz>
References: <20190328134320.13232-1-osalvador@suse.de>
 <cc68ec6d-3ad2-a998-73dc-cb90f3563899@redhat.com>
 <efb08377-ca5d-4110-d7ae-04a0d61ac294@redhat.com>
 <20190329084547.5k37xjwvkgffwajo@d104.suse.de>
 <20190329134243.GA30026@dhcp22.suse.cz>
 <20190401075936.bjt2qsrhw77rib77@d104.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401075936.bjt2qsrhw77rib77@d104.suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 01-04-19 09:59:36, Oscar Salvador wrote:
> On Fri, Mar 29, 2019 at 02:42:43PM +0100, Michal Hocko wrote:
> > Having a larger contiguous area is definitely nice to have but you also
> > have to consider the other side of the thing. If we have a movable
> > memblock with unmovable memory then we are breaking the movable
> > property. So there should be some flexibility for caller to tell whether
> > to allocate on per device or per memblock. Or we need something to move
> > memmaps during the hotremove.
> 
> By movable memblock you mean a memblock whose pages can be migrated over when
> this memblock is offlined, right?

I am mostly thinking about movable_node kernel parameter which makes
newly hotpluged memory go into ZONE_MOVABLE and people do use that to
make sure such a memory can be later hotremoved.

-- 
Michal Hocko
SUSE Labs
