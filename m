Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F31AFC10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 19:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDD75206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 19:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570562488;
	bh=LTCPkj87u5QMn1xLjpxVY89MdkjCHaieTcAOR7aS66c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uHL23TTymwu2f1uEUQfknOGOQpRJvAW3VeN5X4pWlkKwDwNZEEOzO6maNUrtyix7W
	 QWLH665bNpngyLTk2AlkoVZowMJbA98awoWJ0ZDMOpIftxjyQ3s40dD2TB7zlPXY/g
	 k1VQlzxP9Nftb4NQSBM+jyeThvJ7wzYHSVh5YoE8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730393AbfJHTV1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 15:21:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:34880 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726439AbfJHTV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 15:21:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9689BB147;
        Tue,  8 Oct 2019 19:21:25 +0000 (UTC)
Date:   Tue, 8 Oct 2019 21:21:24 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Christopher Lameter <cl@linux.com>
Cc:     Kaitao Cheng <pilgrimtao@gmail.com>, akpm@linux-foundation.org,
        sashal@kernel.org, osalvador@suse.de, mgorman@techsingularity.net,
        rppt@linux.ibm.com, dan.j.williams@intel.com,
        alexander.h.duyck@linux.intel.com, pavel.tatashin@microsoft.com,
        glider@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Muchun Song <smuchun@gmail.com>
Subject: Re: [PATCH] mm, page_alloc: drop pointless static qualifier in
 build_zonelists()
Message-ID: <20191008192124.GT6681@dhcp22.suse.cz>
References: <20190927161416.62293-1-pilgrimtao@gmail.com>
 <alpine.DEB.2.21.1910081906120.4398@www.lameter.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1910081906120.4398@www.lameter.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 08-10-19 19:06:57, Cristopher Lameter wrote:
> On Sat, 28 Sep 2019, Kaitao Cheng wrote:
> 
> > There is no need to make the 'node_order' variable static
> > since new value always be assigned before use it.
> 
> In the past MAX_NUMMNODES could become quite large like 512 or 1k. Large
> array allocations on the stack are problematic.
> 
> Maybe that is no longer the case?

CONFIG_NODES_SHIFT=10 is nothing really unusual in distribution kernels.
Likely wasteful for most HW available but a proper way to address it in
this particular case is to use a different data structure than drop the
static modifier which seems to be more of an misunderstanding than an
intention.
-- 
Michal Hocko
SUSE Labs
