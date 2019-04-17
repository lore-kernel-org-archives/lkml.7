Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E37AC282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 15:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2805921773
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 15:20:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732621AbfDQPUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 11:20:05 -0400
Received: from mga04.intel.com ([192.55.52.120]:5654 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729940AbfDQPUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 11:20:04 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Apr 2019 08:20:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,362,1549958400"; 
   d="scan'208";a="316758568"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga005.jf.intel.com with ESMTP; 17 Apr 2019 08:20:02 -0700
Date:   Wed, 17 Apr 2019 09:13:47 -0600
From:   Keith Busch <keith.busch@intel.com>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Michal Hocko <mhocko@kernel.org>, mgorman@techsingularity.net,
        riel@surriel.com, hannes@cmpxchg.org, akpm@linux-foundation.org,
        dan.j.williams@intel.com, fengguang.wu@intel.com, fan.du@intel.com,
        ying.huang@intel.com, ziy@nvidia.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v2 RFC PATCH 0/9] Another Approach to Use PMEM as NUMA Node
Message-ID: <20190417151347.GA4786@localhost.localdomain>
References: <1554955019-29472-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190412084702.GD13373@dhcp22.suse.cz>
 <a68137bb-dcd8-4e4a-b3a9-69a66f9dccaf@linux.alibaba.com>
 <20190416074714.GD11561@dhcp22.suse.cz>
 <876768ad-a63a-99c3-59de-458403f008c4@linux.alibaba.com>
 <a0bf6b61-1ec2-6209-5760-80c5f205d52e@intel.com>
 <99320338-d9d3-74ca-5b07-6c3ca718800f@linux.alibaba.com>
 <1556283f-de69-ce65-abf8-22f6f8d7d358@intel.com>
 <8bc32012-b747-3827-1814-91942357d170@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8bc32012-b747-3827-1814-91942357d170@linux.alibaba.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 04:17:44PM -0700, Yang Shi wrote:
> On 4/16/19 4:04 PM, Dave Hansen wrote:
> > On 4/16/19 2:59 PM, Yang Shi wrote:
> > > On 4/16/19 2:22 PM, Dave Hansen wrote:
> > > > Keith Busch had a set of patches to let you specify the demotion order
> > > > via sysfs for fun.  The rules we came up with were:
> > > > 1. Pages keep no history of where they have been
> > > > 2. Each node can only demote to one other node
> > > Does this mean any remote node? Or just DRAM to PMEM, but remote PMEM
> > > might be ok?
> > In Keith's code, I don't think we differentiated.  We let any node
> > demote to any other node you want, as long as it follows the cycle rule.
> 
> I recall Keith's code let the userspace define the target node.

Right, you have to opt-in in my original proposal since it may be a
bit presumptuous of the kernel to decide how a node's memory is going
to be used. User applications have other intentions for it.

It wouldn't be too difficult to make HMAT to create a reasonable initial
migration graph too, and that can also make that an opt-in user choice.

> Anyway, we may need add one rule: not migrate-on-reclaim from PMEM
> node.  Demoting from  PMEM to DRAM sounds pointless.

I really don't think we should be making such hard rules on PMEM. It
makes more sense to consider performance and locality for migration
rules than on a persistence attribute.
