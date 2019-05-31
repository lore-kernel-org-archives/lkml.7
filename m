Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A76E5C28CC3
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 06:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76D7826431
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 06:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559283051;
	bh=Q7OY+Yp83Yr6TdSIE3Wpw//Mt1qym3h6mD04s0he6Ps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uIY+sksqowDZ2KjACy1lXxsD30/GFtejDndgCfQHBk9qyFcALxZTmoyNnvM0Mq0ba
	 BwSfvgvV8jhID9BSpw08zBugI5KNcRwezvKRx4YTo+LsbS6TrN2qh31oHsNkdeYXhU
	 QZHVrI85hB3pU7OSZRQhPHhONRFWRKZt/aigHlzo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfEaGKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 02:10:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:57264 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726275AbfEaGKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 02:10:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 44BBFAF8E;
        Fri, 31 May 2019 06:10:49 +0000 (UTC)
Date:   Fri, 31 May 2019 08:10:47 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH -mm] mm, swap: Fix bad swap file entry warning
Message-ID: <20190531061047.GB6896@dhcp22.suse.cz>
References: <20190531024102.21723-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190531024102.21723-1-ying.huang@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 31-05-19 10:41:02, Huang, Ying wrote:
> From: Huang Ying <ying.huang@intel.com>
> 
> Mike reported the following warning messages
> 
>   get_swap_device: Bad swap file entry 1400000000000001
> 
> This is produced by
> 
> - total_swapcache_pages()
>   - get_swap_device()
> 
> Where get_swap_device() is used to check whether the swap device is
> valid and prevent it from being swapoff if so.  But get_swap_device()
> may produce warning message as above for some invalid swap devices.
> This is fixed via calling swp_swap_info() before get_swap_device() to
> filter out the swap devices that may cause warning messages.
> 
> Fixes: 6a946753dbe6 ("mm/swap_state.c: simplify total_swapcache_pages() with get_swap_device()")

I suspect this is referring to a mmotm patch right? There doesn't seem
to be any sha like this in Linus' tree AFAICS. If that is the case then
please note that mmotm patch showing up in linux-next do not have a
stable sha1 and therefore you shouldn't reference them in the commit
message. Instead please refer to the specific mmotm patch file so that
Andrew knows it should be folded in to it.

Thanks!
-- 
Michal Hocko
SUSE Labs
