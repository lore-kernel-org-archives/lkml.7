Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2290CA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 07:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 892DE21925
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 07:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571384654;
	bh=azma7LQs8ZO7QqTinH/NH5IEVQ4d5o2RuE2NP5fOSCo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yFDJMnO8V9q5J7DsemSJkichbfT+rCPu/yoxWjgfBf4YlcdaJvyhUZb07XXo9XUeL
	 0igb1vWpfkqGJB3eStOpQd/JBoiSldLgJDE/F49X+jR3cVcFgfltz/i3QtSsgr1HHY
	 sAwv/izVXjk5VHr2QbDDOOB/ezzU/yAkKrtjMxpM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407332AbfJRHoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 03:44:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:33520 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727388AbfJRHoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 03:44:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7AA88B1BB;
        Fri, 18 Oct 2019 07:44:11 +0000 (UTC)
Date:   Fri, 18 Oct 2019 09:44:11 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dan.j.williams@intel.com
Subject: Re: [PATCH 0/4] [RFC] Migrate Pages in lieu of discard
Message-ID: <20191018074411.GC5017@dhcp22.suse.cz>
References: <20191016221148.F9CCD155@viggo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016221148.F9CCD155@viggo.jf.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 16-10-19 15:11:48, Dave Hansen wrote:
> We're starting to see systems with more and more kinds of memory such
> as Intel's implementation of persistent memory.
> 
> Let's say you have a system with some DRAM and some persistent memory.
> Today, once DRAM fills up, reclaim will start and some of the DRAM
> contents will be thrown out.  Allocations will, at some point, start
> falling over to the slower persistent memory.
> 
> That has two nasty properties.  First, the newer allocations can end
> up in the slower persistent memory.  Second, reclaimed data in DRAM
> are just discarded even if there are gobs of space in persistent
> memory that could be used.
> 
> This set implements a solution to these problems.  At the end of the
> reclaim process in shrink_page_list() just before the last page
> refcount is dropped, the page is migrated to persistent memory instead
> of being dropped.
> 
> While I've talked about a DRAM/PMEM pairing, this approach would
> function in any environment where memory tiers exist.
> 
> This is not perfect.  It "strands" pages in slower memory and never
> brings them back to fast DRAM.  Other things need to be built to
> promote hot pages back to DRAM.
> 
> This is part of a larger patch set.  If you want to apply these or
> play with them, I'd suggest using the tree from here.  It includes
> autonuma-based hot page promotion back to DRAM:
> 
> 	http://lkml.kernel.org/r/c3d6de4d-f7c3-b505-2e64-8ee5f70b2118@intel.com
> 
> This is also all based on an upstream mechanism that allows
> persistent memory to be onlined and used as if it were volatile:
> 
> 	http://lkml.kernel.org/r/20190124231441.37A4A305@viggo.jf.intel.com

How does this compare to
http://lkml.kernel.org/r/1560468577-101178-1-git-send-email-yang.shi@linux.alibaba.com?

-- 
Michal Hocko
SUSE Labs
