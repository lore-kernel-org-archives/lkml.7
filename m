Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CDFC10F13
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 03:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 389EA20674
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 03:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbfDLDIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 23:08:39 -0400
Received: from mga06.intel.com ([134.134.136.31]:64695 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726678AbfDLDIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 23:08:39 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Apr 2019 20:08:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,339,1549958400"; 
   d="scan'208";a="130695233"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga007.jf.intel.com with ESMTP; 11 Apr 2019 20:08:37 -0700
Date:   Fri, 12 Apr 2019 11:08:18 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Wei Yang <richardw.yang@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.or
Subject: Re: [PATCH 4/6] x86, mm: make split_mem_range() more easy to read
Message-ID: <20190412030818.GA29324@richard>
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

>Find a mostly untested patch which implements this below. I just booted it
>in a 64bit guest and it did not explode.
>
>It removes 55 lines of code instead of adding 35 and reduces the binary
>size by 408 bytes on 64bit and 128 bytes on 32bit.
>
>Note, it's a combo of changes (including your patch 1/6) and needs to be
>split up. It would be nice if you have time to split it up into separate
>patches, add proper changelogs and test the heck out of it on both 32 and
>64 bit. If you don't have time, please let me know.

I tried to test mem hotplug with this applied.

On x86_64, this looks good. It split ranges well. While I found some problem
on testing mem hotplug on x86_32.

I start up a guest memory and trying to plug 1G memory.

The original memory split range looks good:

[    0.004260] ywtest: [mem 0x00000000-0x00100000]
[    0.004261] ywtest: [mem 0x00000000-0x000fffff] page size 4k
[    0.004268] ywtest: [mem 0x37200000-0x37400000]
[    0.004269] ywtest: [mem 0x37200000-0x373fffff] page size 2M
[    0.004271] ywtest: [mem 0x20000000-0x37200000]
[    0.004272] ywtest: [mem 0x20000000-0x371fffff] page size 2M
[    0.004280] ywtest: [mem 0x00100000-0x20000000]
[    0.004281] ywtest: [mem 0x00100000-0x001fffff] page size 4k
[    0.004281] ywtest: [mem 0x00200000-0x1fffffff] page size 2M
[    0.004292] ywtest: [mem 0x37400000-0x375fe000]
[    0.004293] ywtest: [mem 0x37400000-0x375fdfff] page size 4k

While I can't online the new added memory device. And the new memory device's
range is out of 4G, which is a little bit strange.

>
>Thanks,
>
>	tglx
>
-- 
Wei Yang
Help you, Help me
