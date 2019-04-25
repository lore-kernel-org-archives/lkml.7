Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E311FC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB293217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556181786;
	bh=xqWwpBW/0A7P0WH34h69zVG4+D1R5HG9KGDtDoOwYeI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nxuCBCfNPKmBbzgB0JQe1XuxiuC7+ZdfpKrha21npKEurqn5sS0l9cnDPeg8hJccs
	 w/5mcsmSPz2xlkGSxJ6MiGyuwUg2fTM0DDtsq4URtm7j3IjqmDOwT6d3M1pXe86HvN
	 FL0SBGHww6flHdgljr89j6pwd9WCYUZjH7CnKc8o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbfDYInF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 04:43:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:48796 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725965AbfDYInE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 04:43:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A9156AD18;
        Thu, 25 Apr 2019 08:43:03 +0000 (UTC)
Date:   Thu, 25 Apr 2019 10:43:02 +0200
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
Message-ID: <20190425084302.GQ12751@dhcp22.suse.cz>
References: <1556155295-77723-1-git-send-email-fan.du@intel.com>
 <1556155295-77723-6-git-send-email-fan.du@intel.com>
 <20190425063807.GK12751@dhcp22.suse.cz>
 <5A90DA2E42F8AE43BC4A093BF067884825785F04@SHSMSX104.ccr.corp.intel.com>
 <20190425074841.GN12751@dhcp22.suse.cz>
 <5A90DA2E42F8AE43BC4A093BF067884825785F50@SHSMSX104.ccr.corp.intel.com>
 <20190425080936.GP12751@dhcp22.suse.cz>
 <5A90DA2E42F8AE43BC4A093BF067884825785FA5@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5A90DA2E42F8AE43BC4A093BF067884825785FA5@SHSMSX104.ccr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 25-04-19 08:20:28, Du, Fan wrote:
> 
> 
> >-----Original Message-----
> >From: owner-linux-mm@kvack.org [mailto:owner-linux-mm@kvack.org] On
> >Behalf Of Michal Hocko
> >Sent: Thursday, April 25, 2019 4:10 PM
> >To: Du, Fan <fan.du@intel.com>
> >Cc: akpm@linux-foundation.org; Wu, Fengguang <fengguang.wu@intel.com>;
> >Williams, Dan J <dan.j.williams@intel.com>; Hansen, Dave
> ><dave.hansen@intel.com>; xishi.qiuxishi@alibaba-inc.com; Huang, Ying
> ><ying.huang@intel.com>; linux-mm@kvack.org; linux-kernel@vger.kernel.org
> >Subject: Re: [RFC PATCH 5/5] mm, page_alloc: Introduce
> >ZONELIST_FALLBACK_SAME_TYPE fallback list
> >
> >On Thu 25-04-19 07:55:58, Du, Fan wrote:
> >> >> PMEM is good for frequently read accessed page, e.g. page cache(implicit
> >> >> page
> >> >> request), or user space data base (explicit page request)
> >> >> For now this patch create GFP_SAME_NODE_TYPE for such cases,
> >additional
> >> >> Implementation will be followed up.
> >> >
> >> >Then simply configure that NUMA node as movable and you get these
> >> >allocations for any movable allocation. I am not really convinced a new
> >> >gfp flag is really justified.
> >>
> >> Case 1: frequently write and/or read accessed page deserved to DRAM
> >
> >NUMA balancing
> 
> Sorry, I mean page cache case here.
> Numa balancing works for pages mapped in pagetable style.

I would still expect that a remote PMEM node access latency is
smaller/comparable to the real storage so a promoting part is not that
important for the unmapped pagecache. Maybe I am wrong here but that
really begs for some experiments before we start adding special casing.
-- 
Michal Hocko
SUSE Labs
