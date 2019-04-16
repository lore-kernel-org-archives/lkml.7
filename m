Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B02FFC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 22:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80A5120880
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 22:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730624AbfDPWSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 18:18:53 -0400
Received: from mga17.intel.com ([192.55.52.151]:53323 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbfDPWSx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 18:18:53 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Apr 2019 15:18:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,359,1549958400"; 
   d="scan'208";a="151456063"
Received: from agluck-desk.sc.intel.com (HELO agluck-desk) ([10.3.52.160])
  by orsmga002.jf.intel.com with ESMTP; 16 Apr 2019 15:18:52 -0700
Date:   Tue, 16 Apr 2019 15:18:52 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Cong Wang <xiyou.wangcong@gmail.com>, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/2] ras: fix an off-by-one error in __find_elem()
Message-ID: <20190416221852.GA10781@agluck-desk>
References: <20190416012001.5338-1-xiyou.wangcong@gmail.com>
 <20190416090726.GD27892@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416090726.GD27892@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 11:07:26AM +0200, Borislav Petkov wrote:
> On Mon, Apr 15, 2019 at 06:20:00PM -0700, Cong Wang wrote:
> > ce_arr.array[] is always within the range [0, ce_arr.n-1].
> > However, the binary search code in __find_elem() uses ce_arr.n
> > as the maximum index, which could lead to an off-by-one
> > out-of-bound access when the element after the last is exactly
> > the one just got deleted, that is, 'min' returned to caller as
> > 'ce_arr.n'.
> 
> Sorry, I don't follow.
> 
> There's a debugfs interface in /sys/kernel/debug/ras/cec/ with which you
> can input random PFNs and test the thing.
> 
> Show me pls how this can happen with an example.

The array of previously seen pfn values is one page.

The problem case occurs when we've seen enough distinct
errors that we have filled every entry, then we try to
look up a pfn that is larger that any seen before.

The loop:

	while (min < max) {
		...
	}

will terminate with "min" set to MAX_ELEMS. Then we
execute:

	this_pfn = PFN(ca->array[min]);

which references beyond the end of the space allocated
for ca->array.

Probably won't crash, but we will read a garbage value
from whatever memory is allocated next.

Chances are high that the test:

	if (this_pfn == pfn)

won't find that the garbage value matches the pfn that
we were looking for ... so we will likley be lucky and
not do anything too dumb. But we shouldn't just cross
our fingers and hope.

Fix looks mostly OK, but we should probably move the

	if (to)
		*to = min;

inside the new

	if (min < ca->n) {
		...
	}

clause.

-Tony
