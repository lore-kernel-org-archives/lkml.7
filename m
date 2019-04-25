Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8257C282E3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AADFB218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556178524;
	bh=+Qgon2X3Xpjxac7EpKvxR+RQaesDw4jyLzgtHPOFurk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kqQKVPt5LQwLE4BHOVIq2WwYsgh07S/vJdjfNVpvg7+daf21LN8hhJlpA6kbEfLMA
	 G49ewclAK1IuCA/S7xD0km7KNo9r1cvCKrFlAr4EIbtorAX+2k7qul/k4wKZj0Z1cq
	 PDWKyfJtcObz7rKrUOhfvoCzk8FrEa/xhU3vQNSA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbfDYHsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 03:48:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:39600 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726184AbfDYHsn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 03:48:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 23A2AAF60;
        Thu, 25 Apr 2019 07:48:42 +0000 (UTC)
Date:   Thu, 25 Apr 2019 09:48:41 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     "Du, Fan" <fan.du@intel.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Wu, Fengguang" <fengguang.wu@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "xishi.qiuxishi@alibaba-inc.com" <xishi.qiuxishi@alibaba-inc.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 5/5] mm, page_alloc: Introduce
 ZONELIST_FALLBACK_SAME_TYPE fallback list
Message-ID: <20190425074841.GN12751@dhcp22.suse.cz>
References: <1556155295-77723-1-git-send-email-fan.du@intel.com>
 <1556155295-77723-6-git-send-email-fan.du@intel.com>
 <20190425063807.GK12751@dhcp22.suse.cz>
 <5A90DA2E42F8AE43BC4A093BF067884825785F04@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5A90DA2E42F8AE43BC4A093BF067884825785F04@SHSMSX104.ccr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 25-04-19 07:43:09, Du, Fan wrote:
> 
> 
> >-----Original Message-----
> >From: Michal Hocko [mailto:mhocko@kernel.org]
> >Sent: Thursday, April 25, 2019 2:38 PM
> >To: Du, Fan <fan.du@intel.com>
> >Cc: akpm@linux-foundation.org; Wu, Fengguang <fengguang.wu@intel.com>;
> >Williams, Dan J <dan.j.williams@intel.com>; Hansen, Dave
> ><dave.hansen@intel.com>; xishi.qiuxishi@alibaba-inc.com; Huang, Ying
> ><ying.huang@intel.com>; linux-mm@kvack.org; linux-kernel@vger.kernel.org
> >Subject: Re: [RFC PATCH 5/5] mm, page_alloc: Introduce
> >ZONELIST_FALLBACK_SAME_TYPE fallback list
> >
> >On Thu 25-04-19 09:21:35, Fan Du wrote:
> >> On system with heterogeneous memory, reasonable fall back lists woul be:
> >> a. No fall back, stick to current running node.
> >> b. Fall back to other nodes of the same type or different type
> >>    e.g. DRAM node 0 -> DRAM node 1 -> PMEM node 2 -> PMEM node 3
> >> c. Fall back to other nodes of the same type only.
> >>    e.g. DRAM node 0 -> DRAM node 1
> >>
> >> a. is already in place, previous patch implement b. providing way to
> >> satisfy memory request as best effort by default. And this patch of
> >> writing build c. to fallback to the same node type when user specify
> >> GFP_SAME_NODE_TYPE only.
> >
> >So an immediate question which should be answered by this changelog. Who
> >is going to use the new gfp flag? Why cannot all allocations without an
> >explicit numa policy fallback to all existing nodes?
> 
> PMEM is good for frequently read accessed page, e.g. page cache(implicit page
> request), or user space data base (explicit page request)
> For now this patch create GFP_SAME_NODE_TYPE for such cases, additional
> Implementation will be followed up.

Then simply configure that NUMA node as movable and you get these
allocations for any movable allocation. I am not really convinced a new
gfp flag is really justified.
-- 
Michal Hocko
SUSE Labs
