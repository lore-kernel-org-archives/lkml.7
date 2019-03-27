Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221D4C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 00:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAD082087E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 00:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553646875;
	bh=+EXJpwLLheutVqRQbe2SMIWPuXOJs45hfWjlXkY4ELI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=exvdGqqlDP+EmJaJb7C65uV02NQLXXtXY+ccfNpzWjkhRt1L2PQC6wIJhjv8lmInL
	 9pJAcKhbeAw42wvNI1z6Qa+63DoTQkpMDTuPbzZZ/U62Fjm1El7QPRicMzLOn7AUm+
	 9Y5cOtEgP2oWoI6kZ4xN6SRbHWzzN8L4NtOMkddM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732411AbfC0Aed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 20:34:33 -0400
Received: from mga01.intel.com ([192.55.52.88]:61857 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731451AbfC0Aed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 20:34:33 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Mar 2019 17:34:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,274,1549958400"; 
   d="scan'208";a="130458805"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga006.jf.intel.com with ESMTP; 26 Mar 2019 17:34:30 -0700
Date:   Tue, 26 Mar 2019 18:35:41 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     mhocko@suse.com, mgorman@techsingularity.net, riel@surriel.com,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        dave.hansen@intel.com, keith.busch@intel.com,
        dan.j.williams@intel.com, fengguang.wu@intel.com, fan.du@intel.com,
        ying.huang@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/10] mm: vmscan: demote anon DRAM pages to PMEM node
Message-ID: <20190327003541.GE4328@localhost.localdomain>
References: <1553316275-21985-1-git-send-email-yang.shi@linux.alibaba.com>
 <1553316275-21985-7-git-send-email-yang.shi@linux.alibaba.com>
 <20190324222040.GE31194@localhost.localdomain>
 <ceec5604-b1df-2e14-8966-933865245f1c@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ceec5604-b1df-2e14-8966-933865245f1c@linux.alibaba.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 12:49:21PM -0700, Yang Shi wrote:
> On 3/24/19 3:20 PM, Keith Busch wrote:
> > How do these pages eventually get to swap when migration fails? Looks
> > like that's skipped.
> 
> Yes, they will be just put back to LRU. Actually, I don't expect it would be
> very often to have migration fail at this stage (but I have no test data to
> support this hypothesis) since the pages have been isolated from LRU, so
> other reclaim path should not find them anymore.
> 
> If it is locked by someone else right before migration, it is likely
> referenced again, so putting back to LRU sounds not bad.
> 
> A potential improvement is to have sync migration for kswapd.

Well, it's not that migration fails only if the page is recently
referenced. Migration would fail if there isn't available memory in
the migration node, so this implementation carries an expectation that
migration nodes have higher free capacity than source nodes. And since
your attempting THP's without ever splitting them, that also requires
lower fragmentation for a successful migration.

Applications, however, may allocate and pin pages directly out of that
migration node to the point it does not have so much free capacity or
physical continuity, so we probably shouldn't assume it's the only way
to reclaim pages.
