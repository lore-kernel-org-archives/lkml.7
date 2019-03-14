Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01574C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 09:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC4922085A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 09:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfCNJKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 05:10:47 -0400
Received: from mga04.intel.com ([192.55.52.120]:61403 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726896AbfCNJKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 05:10:46 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Mar 2019 02:10:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,477,1544515200"; 
   d="scan'208";a="133982089"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga003.jf.intel.com with ESMTP; 14 Mar 2019 02:10:43 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1h4MNt-0002XB-ET; Thu, 14 Mar 2019 11:10:41 +0200
Date:   Thu, 14 Mar 2019 11:10:41 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     George Spelvin <lkml@sdf.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Abramov <st5pub@yandex.ru>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Don Mullis <don.mullis@gmail.com>,
        Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH 4/5] lib/list_sort: Simplify and remove
 MAX_LIST_LENGTH_BITS
Message-ID: <20190314091041.GU9224@smile.fi.intel.com>
References: <cover.1552097842.git.lkml@sdf.org>
 <dd447448384883bd42c41f0de6a83430b6435dc1.1552097842.git.lkml@sdf.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd447448384883bd42c41f0de6a83430b6435dc1.1552097842.git.lkml@sdf.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2019 at 03:06:44AM +0000, George Spelvin wrote:
> Rather than a fixed-size array of pending sorted runs, use the ->prev
> links to keep track of things.  This reduces stack usage, eliminates
> some ugly overflow handling, and reduces the code size.
> 
> Also:
> * merge() no longer needs to handle NULL inputs, so simplify.
> * The same applies to merge_and_restore_back_links(), which is renamed
>   to the less ponderous merge_final().  (It's a static helper function,
>   so we don't need a super-descriptive name; comments will do.)
> 
> x86-64 code size 1086 -> 740 bytes (-346)

> +	do {
> +		size_t bit;
>  		struct list_head *cur = list;
> +
> +		/* Extract the head of "list" as a single-element list "cur" */
>  		list = list->next;
>  		cur->next = NULL;
>  
> +		/* Do merges corresponding to set lsbits in count */

> +		for (bit = 1; count & bit; bit <<= 1) {
> +			cur = merge(priv, (cmp_func)cmp, pending, cur);
> +			pending = pending->prev;  /* Untouched by merge() */
>  		}

Wouldn't be it the same to

	bit = ffz(count);
	while (bit--) {
		...
	}
?

Though I dunno which one is generating better code.

> +		/* And place the result at the head of "pending" */
> +		cur->prev = pending;
> +		pending = cur;
> +		count++;
> +	} while (list->next);
> +
> +	/* Now merge together last element with all pending lists */
> +	while (pending->prev) {
> +		list = merge(priv, (cmp_func)cmp, pending, list);
> +		pending = pending->prev;
>  	}

-- 
With Best Regards,
Andy Shevchenko


