Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E7EBC2D0B1
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 13:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 079322464E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 13:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575637509;
	bh=RNg+zLEFc3CkEl5tzIKiNU62sxIhgiG6gkgRSZegPXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zx7r8A67EmXEd3RziCRvPBosWgUxbbwIf0wK1Dh7QwrH/uJ9u4+PXH0JdtVn2wKec
	 dLolBOblwnIF2cHCLK0G13vi7JZVCd/isqLK2j71T7kMK+CK5OFtESVQqMFwhuXxWp
	 IO7D+Ru3EpNIAfw+ZMvfP2WS2MPE6gdZ7C01anOI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbfLFNFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 08:05:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:58886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbfLFNFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 08:05:07 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13FF521835;
        Fri,  6 Dec 2019 13:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575637507;
        bh=RNg+zLEFc3CkEl5tzIKiNU62sxIhgiG6gkgRSZegPXw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2F3tsf+OH84WnQyV7z+FNLjD81BIgqkVT+qQXYrLBRLDy5ml7Zwetcv19aH2l3NH+
         /jI/rtDw6/iN9uifS/W71B/QVu4aEFkph8ibHWcxROYbw3EvklGg2fKoIUzxAMqxca
         hGXSGwaCZCt+aXnC3bHl8Z+Z6A20reX7XsQF9X3E=
Date:   Fri, 6 Dec 2019 14:05:05 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pavel Machek <pavel@denx.de>, Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Qian Cai <cai@lca.pw>, Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 4.19 226/321] mm/hotplug: invalid PFNs from
 pfn_to_online_page()
Message-ID: <20191206130505.GD1399220@kroah.com>
References: <20191203223427.103571230@linuxfoundation.org>
 <20191203223438.874783822@linuxfoundation.org>
 <20191205221452.GB25107@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205221452.GB25107@duo.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2019 at 11:14:52PM +0100, Pavel Machek wrote:
> Hi!
> 
> > This is due to the commit 9f1eb38e0e11 ("mm, kmemleak: little
> > optimization while scanning") starts to use pfn_to_online_page() instead
> > of pfn_valid().  However, in the CONFIG_MEMORY_HOTPLUG=y case,
> > pfn_to_online_page() does not call memblock_is_map_memory() while
> > pfn_valid() does.
> ...
> > Fixes: 9f1eb38e0e11 ("mm, kmemleak: little optimization while scanning")
> 
> Commit 9f1eb38e0e11 does not seem to be in v4.19-stable tree. Is this
> commit still neccessary/good idea?

Good catch.

Sasha, should this be reverted?  How did your scripts pick this?

thanks,

greg k-h
