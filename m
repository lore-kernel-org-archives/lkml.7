Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD3CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 07:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53A5420657
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 07:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbfC1HUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 03:20:48 -0400
Received: from mga03.intel.com ([134.134.136.65]:43665 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbfC1HUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 03:20:48 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Mar 2019 00:20:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,278,1549958400"; 
   d="scan'208";a="135473853"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga008.fm.intel.com with ESMTP; 28 Mar 2019 00:20:45 -0700
Date:   Thu, 28 Mar 2019 15:20:27 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Wei Yang <richardw.yang@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.or
Subject: Re: [PATCH 4/6] x86, mm: make split_mem_range() more easy to read
Message-ID: <20190328072027.GA6531@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20190212021215.13247-1-richardw.yang@linux.intel.com>
 <20190212021215.13247-5-richardw.yang@linux.intel.com>
 <alpine.DEB.2.21.1903232345500.1798@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1903232345500.1798@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 24, 2019 at 03:29:04PM +0100, Thomas Gleixner wrote:
> 
>+static int __meminit split_mem_range(struct map_range *mr, unsigned long start,
>+				     unsigned long end)
>+{
>+	static const struct mapinfo mapinfos[] = {
> #ifdef CONFIG_X86_64
>+		{ .mask = 1U << PG_LEVEL_1G, .size = PUD_SIZE },
> #endif
>+		{ .mask = 1U << PG_LEVEL_2M, .size = PMD_SIZE },
>+		{ .mask = 0, .size = PAGE_SIZE },
>+	};
>+	const struct mapinfo *mi;
>+	struct map_range *curmr;
>+	unsigned long addr;
>+	int idx;
>+
>+	for (idx = 0, addr = start, curmr = mr; addr < end; idx++, curmr++) {
>+		BUG_ON(idx == NR_RANGE_MR);
>+		mr_setup(curmr, addr, end);
> 
>+		/* Try map sizes top down. PAGE_SIZE will always succeed. */
>+		for (mi = mapinfos; !mr_try_map(curmr, mi); mi++);
>
>+		/* Get the start address for the next range */
>+		addr = curmr->end;
> 	}

I re-arrange the code to make split_mem_range() here easy to read.

My question is to the for loop.

For example, we have a range

       +--+---------+-----------------------+
       ^ 128M       1G                      2G
   128M - 4K

If my understanding is correct, the original behavior will split this into
three ranges:

   4K size: [128M - 4K, 128M]
   2M size: [128M, 1G]
   1G size: [1G, 2G]

While after your change, it will split this into two ranges:

   ?? size: [128M - 4K, 1G]
   2M size: [1G, 2G]

The question mark here is because you leave the page_size_mask unchanged in
this case.

Is my understanding correct? Or I missed something?

-- 
Wei Yang
Help you, Help me
