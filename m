Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC245C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 22:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5F1321855
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 22:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553813078;
	bh=1GwTRB0RlvogRMsRHGKJps4BHsYdRaS42pr3urP5bgM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZuAfqmUHjZO3w8i9oIUNR2ZvIQxX905Ex1non6BExGOydijyVmo3tgOkTLySWjM66
	 OTE/s0w6tzJblBHi+g8aLWze35o1ZYFYfp5rOfEwKag7FvDK6dnFMl8Vvw72Yq3psU
	 v/koBKme5pSM/adKjoBBwWdQBG2Y4W4NBDxjN4+w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbfC1Woh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 18:44:37 -0400
Received: from mga14.intel.com ([192.55.52.115]:22048 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727238AbfC1Woh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 18:44:37 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Mar 2019 15:44:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,282,1549958400"; 
   d="scan'208";a="126781810"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga007.jf.intel.com with ESMTP; 28 Mar 2019 15:44:35 -0700
Date:   Thu, 28 Mar 2019 16:45:50 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     "mhocko@suse.com" <mhocko@suse.com>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "riel@surriel.com" <riel@surriel.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Busch, Keith" <keith.busch@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Wu, Fengguang" <fengguang.wu@intel.com>,
        "Du, Fan" <fan.du@intel.com>, "Huang, Ying" <ying.huang@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 06/10] mm: vmscan: demote anon DRAM pages to PMEM node
Message-ID: <20190328224549.GA11100@localhost.localdomain>
References: <1553316275-21985-1-git-send-email-yang.shi@linux.alibaba.com>
 <1553316275-21985-7-git-send-email-yang.shi@linux.alibaba.com>
 <20190324222040.GE31194@localhost.localdomain>
 <ceec5604-b1df-2e14-8966-933865245f1c@linux.alibaba.com>
 <20190327003541.GE4328@localhost.localdomain>
 <39d8fb56-df60-9382-9b47-59081d823c3c@linux.alibaba.com>
 <20190327130822.GD7389@localhost.localdomain>
 <599849e6-05b6-1e4d-7578-5cf8825963d2@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <599849e6-05b6-1e4d-7578-5cf8825963d2@linux.alibaba.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 02:59:30PM -0700, Yang Shi wrote:
> Yes, it still could fail. I can't tell which way is better for now. I 
> just thought scanning another round then migrating should be still 
> faster than swapping off the top of my head.

I think it depends on the relative capacities between your primary and
migration tiers and how it's used. Applications may allocate and pin
directly out of pmem if they wish, so it's not a dedicated fallback
memory space like swap.
