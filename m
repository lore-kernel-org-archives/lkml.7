Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D59CC282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49A3B218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556178837;
	bh=YdMgnXYAI/yAygkfcSIMFDiK3a9yZsZGc8nAqaSDOEM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yq9oaeEiagTrm2Q0KM+AiCGG3Xb6VRmPFbW61ov8PuYaBF+TxIfDotfKY11dThz6f
	 hnUeq3blNjQscVx1uUw5EEUDbraSRLZ63LVW5PUW5xT9ycWuMaOim66dbpv8MLFMyr
	 eQvYgw9hVHJg3x1/23tJ7NphJWVB/y03kmgOC4mo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbfDYHx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 03:53:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:40422 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726533AbfDYHxz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 03:53:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 66B4DAD7B;
        Thu, 25 Apr 2019 07:53:54 +0000 (UTC)
Date:   Thu, 25 Apr 2019 09:53:53 +0200
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
Subject: Re: [RFC PATCH 0/5] New fallback workflow for heterogeneous memory
 system
Message-ID: <20190425075353.GO12751@dhcp22.suse.cz>
References: <1556155295-77723-1-git-send-email-fan.du@intel.com>
 <20190425063727.GJ12751@dhcp22.suse.cz>
 <5A90DA2E42F8AE43BC4A093BF067884825785EE8@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5A90DA2E42F8AE43BC4A093BF067884825785EE8@SHSMSX104.ccr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 25-04-19 07:41:40, Du, Fan wrote:
> 
> 
> >-----Original Message-----
> >From: Michal Hocko [mailto:mhocko@kernel.org]
> >Sent: Thursday, April 25, 2019 2:37 PM
> >To: Du, Fan <fan.du@intel.com>
> >Cc: akpm@linux-foundation.org; Wu, Fengguang <fengguang.wu@intel.com>;
> >Williams, Dan J <dan.j.williams@intel.com>; Hansen, Dave
> ><dave.hansen@intel.com>; xishi.qiuxishi@alibaba-inc.com; Huang, Ying
> ><ying.huang@intel.com>; linux-mm@kvack.org; linux-kernel@vger.kernel.org
> >Subject: Re: [RFC PATCH 0/5] New fallback workflow for heterogeneous
> >memory system
> >
> >On Thu 25-04-19 09:21:30, Fan Du wrote:
> >[...]
> >> However PMEM has different characteristics from DRAM,
> >> the more reasonable or desirable fallback style would be:
> >> DRAM node 0 -> DRAM node 1 -> PMEM node 2 -> PMEM node 3.
> >> When DRAM is exhausted, try PMEM then.
> >
> >Why and who does care? NUMA is fundamentally about memory nodes with
> >different access characteristics so why is PMEM any special?
> 
> Michal, thanks for your comments!
> 
> The "different" lies in the local or remote access, usually the underlying
> memory is the same type, i.e. DRAM.
> 
> By "special", PMEM is usually in gigantic capacity than DRAM per dimm, 
> while with different read/write access latency than DRAM.

You are describing a NUMA in general here. Yes access to different NUMA
nodes has a different read/write latency. But that doesn't make PMEM
really special from a regular DRAM. There are few other people trying to
work with PMEM as NUMA nodes and these kind of arguments are repeating
again and again. So far I haven't really heard much beyond hand waving.
Please go and read through those discussion so that we do not have to go
throug the same set of arguments again.

I absolutely do see and understand people want to find a way to use
their shiny NVIDIMs but please step back and try to think in more
general terms than PMEM is special and we have to treat it that way.
We currently have ways to use it as DAX device and a NUMA node then
focus on how to improve our NUMA handling so that we can get maximum out
of the HW rather than make a PMEM NUMA node a special snow flake.

Thank you.

-- 
Michal Hocko
SUSE Labs
