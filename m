Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3964DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 03:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1BDC2075C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 03:36:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbfC1DgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 23:36:11 -0400
Received: from mga11.intel.com ([192.55.52.93]:29522 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726108AbfC1DgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 23:36:11 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Mar 2019 20:36:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,278,1549958400"; 
   d="scan'208";a="130813594"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga006.jf.intel.com with ESMTP; 27 Mar 2019 20:36:09 -0700
Date:   Thu, 28 Mar 2019 11:35:48 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Wei Yang <richardw.yang@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.or
Subject: Re: [PATCH 4/6] x86, mm: make split_mem_range() more easy to read
Message-ID: <20190328033548.GA19364@richard>
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
>Wei,
>
>On Tue, 12 Feb 2019, Wei Yang wrote:
>> 
>> This patch changes the implementation from the first perception to the
>> second to reduce one different handling on end_pfn. After doing so, the
>> code is easier to read.
>
>It's maybe slightly easier to read, but it's still completely unreadable
>garbage.
>
>  Not your fault, it was garbage before.
>
>But refining garbage still results in garbage. Just the smell is slightly
>different.
>
>Why?
>
> 1) Doing all the calculations PFN based is just a pointless
>    indirection. Just look at all the rounding magic and back and forth
>    conversions.
>    
>    All of that can be done purely address/size based which makes the code
>    truly readable.
>
> 2) The 5(3) sections are more or less copied code with a few changes of
>    constants, except for the first section (A) which has an extra quirk
>    for 32bit. Plus all the 64bit vs. 32bit #ifdeffery which is not making
>    it any better.
>
>    This copied mess can be avoided by using helper functions and proper
>    loops.
>
> 3) During the bootmem phase the code tries to preserve large mappings
>    _AFTER_ splitting them up and then it tries to merge the resulting
>    overlaps.
>
>    This is completely backwards because the expansion of the range can be
>    tried right away when then mapping of a large page is attempted. Surely
>    not with the current mess, but with a proper loop based approach it can
>    be done nicely.
>
>    Btw, there is a bug in that expansion code which could result in
>    undoing the enforced 4K mapping of the lower 2M/4M range on 32bit. It's
>    probably not an issue in practice because the low range is usually not
>    contiguous. But it works by chance not by design.

Hi, Thomas

I want to confirm with you, this bug is in adjust_range_page_size_mask(),
right?

-- 
Wei Yang
Help you, Help me
