Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18785C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D041F206DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553692033;
	bh=ehdrA8XSdTsuYLvjpIvD3FM2sG47CInE45L5IymLs8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hyF1uMKrG2ajTshyzSWI0jVhf/Ljs2dg6w5zHsK2uGy9+7sSpIh74ptvezx7EAxEg
	 N7prK/OiemdNv3VUzMgiAm4Lx8kIlpM/IKUS4ZsNoNK2SxYVGs/roKp9Z+xrWa50Z7
	 3e/TwmHhV75OFHOZho2hba6/J8JiGo+RZq8GRwrQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730098AbfC0NHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:07:12 -0400
Received: from mga03.intel.com ([134.134.136.65]:54578 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728101AbfC0NHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 09:07:12 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Mar 2019 06:07:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,276,1549958400"; 
   d="scan'208";a="331140619"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga006.fm.intel.com with ESMTP; 27 Mar 2019 06:07:10 -0700
Date:   Wed, 27 Mar 2019 07:08:22 -0600
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
Message-ID: <20190327130822.GD7389@localhost.localdomain>
References: <1553316275-21985-1-git-send-email-yang.shi@linux.alibaba.com>
 <1553316275-21985-7-git-send-email-yang.shi@linux.alibaba.com>
 <20190324222040.GE31194@localhost.localdomain>
 <ceec5604-b1df-2e14-8966-933865245f1c@linux.alibaba.com>
 <20190327003541.GE4328@localhost.localdomain>
 <39d8fb56-df60-9382-9b47-59081d823c3c@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39d8fb56-df60-9382-9b47-59081d823c3c@linux.alibaba.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 08:41:15PM -0700, Yang Shi wrote:
> On 3/26/19 5:35 PM, Keith Busch wrote:
> > migration nodes have higher free capacity than source nodes. And since
> > your attempting THP's without ever splitting them, that also requires
> > lower fragmentation for a successful migration.
> 
> Yes, it is possible. However, migrate_pages() already has logic to 
> handle such case. If the target node has not enough space for migrating 
> THP in a whole, it would split THP then retry with base pages.

Oh, you're right, my mistake on splitting. So you have a good best effort
migrate, but I still think it can fail for legitimate reasons that should
have a swap fallback.
