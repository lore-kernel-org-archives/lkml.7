Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85311C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 15:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 552A020656
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 15:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732797AbfDQPrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 11:47:22 -0400
Received: from mga12.intel.com ([192.55.52.136]:61296 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732476AbfDQPrW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 11:47:22 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Apr 2019 08:43:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,362,1549958400"; 
   d="scan'208";a="162731832"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga004.fm.intel.com with ESMTP; 17 Apr 2019 08:43:54 -0700
Date:   Wed, 17 Apr 2019 09:37:39 -0600
From:   Keith Busch <keith.busch@intel.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        mgorman@techsingularity.net, riel@surriel.com, hannes@cmpxchg.org,
        akpm@linux-foundation.org, dan.j.williams@intel.com,
        fengguang.wu@intel.com, fan.du@intel.com, ying.huang@intel.com,
        ziy@nvidia.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [v2 RFC PATCH 0/9] Another Approach to Use PMEM as NUMA Node
Message-ID: <20190417153739.GD4786@localhost.localdomain>
References: <1554955019-29472-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190412084702.GD13373@dhcp22.suse.cz>
 <a68137bb-dcd8-4e4a-b3a9-69a66f9dccaf@linux.alibaba.com>
 <20190416074714.GD11561@dhcp22.suse.cz>
 <876768ad-a63a-99c3-59de-458403f008c4@linux.alibaba.com>
 <a0bf6b61-1ec2-6209-5760-80c5f205d52e@intel.com>
 <20190417092318.GG655@dhcp22.suse.cz>
 <20190417152345.GB4786@localhost.localdomain>
 <20190417153923.GO5878@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417153923.GO5878@dhcp22.suse.cz>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 05:39:23PM +0200, Michal Hocko wrote:
> On Wed 17-04-19 09:23:46, Keith Busch wrote:
> > On Wed, Apr 17, 2019 at 11:23:18AM +0200, Michal Hocko wrote:
> > > On Tue 16-04-19 14:22:33, Dave Hansen wrote:
> > > > Keith Busch had a set of patches to let you specify the demotion order
> > > > via sysfs for fun.  The rules we came up with were:
> > > 
> > > I am not a fan of any sysfs "fun"
> > 
> > I'm hung up on the user facing interface, but there should be some way a
> > user decides if a memory node is or is not a migrate target, right?
> 
> Why? Or to put it differently, why do we have to start with a user
> interface at this stage when we actually barely have any real usecases
> out there?

The use case is an alternative to swap, right? The user has to decide
which storage is the swap target, so operating in the same spirit.
