Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E31C4CECE
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 08:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C3C620872
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 08:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408129AbfJQIHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 04:07:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55426 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727791AbfJQIHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 04:07:09 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 80E9B6907A;
        Thu, 17 Oct 2019 08:07:09 +0000 (UTC)
Received: from [10.36.117.42] (ovpn-117-42.ams2.redhat.com [10.36.117.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2699D5D70D;
        Thu, 17 Oct 2019 08:07:07 +0000 (UTC)
Subject: Re: [RFC] Memory Tiering
To:     Dave Hansen <dave.hansen@intel.com>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>,
        Wu Fengguang <fengguang.wu@intel.com>,
        Huang Ying <ying.huang@intel.com>
References: <c3d6de4d-f7c3-b505-2e64-8ee5f70b2118@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <0679872d-3d03-2fa3-5bd2-80f694357203@redhat.com>
Date:   Thu, 17 Oct 2019 10:07:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <c3d6de4d-f7c3-b505-2e64-8ee5f70b2118@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 17 Oct 2019 08:07:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.10.19 22:05, Dave Hansen wrote:
> The memory hierarchy is getting more complicated and the kernel is
> playing an increasing role in managing the different tiers.  A few
> different groups of folks described "migration" optimizations they were
> doing in this area at LSF/MM earlier this year.  One of the questions
> folks asked was why autonuma wasn't being used.
> 
> At Intel, the primary new tier that we're looking at is persistent
> memory (PMEM).  We'd like to be able to use "persistent memory"
> *without* using its persistence properties, treating it as slightly
> slower DRAM.  Keith Busch has some patches to use NUMA migration to
> automatically migrate DRAM->PMEM instead of discarding it near the end
> of the reclaim process.  Huang Ying has some patches which use a
> modified autonuma to migrate frequently-used data *back* from PMEM->DRAM.

Very interesting topic. I heard similar demand from HPC folks 
(especially involving other memory types ("tiers")). There, I think you 
often want to let the application manage that. But of course, for many 
applications an automatic management might already be beneficial.

Am I correct that you are using PMEM in this area along with ZONE_DEVICE 
and not by giving PMEM to the buddy (add_memory())?

> 
> We've tried to do this all generically so that it is not tied to
> persistent memory and can be applied to any memory types in lots of
> topologies.
> 
> We've been running this code in various forms for the past few months,
> comparing it to pure DRAM and hardware-based caching.  The initial
> results are encouraging and we thought others might want to take a look
> at the code or run their own experiments.  We're expecting to post the
> individual patches soon.  But, until then, the code is available here:
> 
>   	https://git.kernel.org/pub/scm/linux/kernel/git/vishal/tiering.git
> 
> and is tagged with "tiering-0.2", aka. d8e31e81b1dca9.
> 
> Note that internally folks have been calling this "hmem" which is
> terribly easy to confuse with the existing hmm.  There are still some
> "hmem"'s in the tree, but I don't expect them to live much longer.
> 


-- 

Thanks,

David / dhildenb
