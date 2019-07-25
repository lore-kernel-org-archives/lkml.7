Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 319F0C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 07:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D39B20840
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 07:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729689AbfGYHOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 03:14:17 -0400
Received: from mga01.intel.com ([192.55.52.88]:16267 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726001AbfGYHOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 03:14:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jul 2019 00:14:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,305,1559545200"; 
   d="scan'208";a="253846210"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.29])
  by orsmga001.jf.intel.com with ESMTP; 25 Jul 2019 00:14:15 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     huang ying <huang.ying.caritas@gmail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: kernel BUG at mm/swap_state.c:170!
References: <CABXGCsN9mYmBD-4GaaeW_NrDu+FDXLzr_6x+XNxfmFV6QkYCDg@mail.gmail.com>
        <CAC=cRTMz5S636Wfqdn3UGbzwzJ+v_M46_juSfoouRLS1H62orQ@mail.gmail.com>
        <CABXGCsOo-4CJicvTQm4jF4iDSqM8ic+0+HEEqP+632KfCntU+w@mail.gmail.com>
        <878ssqbj56.fsf@yhuang-dev.intel.com>
        <CABXGCsOhimxC17j=jApoty-o1roRhKYoe+oiqDZ3c1s2r3QxFw@mail.gmail.com>
        <87zhl59w2t.fsf@yhuang-dev.intel.com>
        <CABXGCsNRpq=AF1aRgyquszy2MZzVfKZwrKXiSW-PnGiAR652cg@mail.gmail.com>
Date:   Thu, 25 Jul 2019 15:14:15 +0800
In-Reply-To: <CABXGCsNRpq=AF1aRgyquszy2MZzVfKZwrKXiSW-PnGiAR652cg@mail.gmail.com>
        (Mikhail Gavrilov's message of "Thu, 25 Jul 2019 11:17:21 +0500")
Message-ID: <87v9vq7fi0.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com> writes:

> On Tue, 23 Jul 2019 at 10:08, Huang, Ying <ying.huang@intel.com> wrote:
>>
>> Thanks!  I have found another (easier way) to reproduce the panic.
>> Could you try the below patch on top of v5.2-rc2?  It can fix the panic
>> for me.
>>
>
> Thanks! Amazing work! The patch fixes the issue completely. The system
> worked at a high load of 16 hours without failures.

Thanks a lot for your help!

Hi, Matthew and Kirill,

I think we can fold this fix patch into your original patch and try
again.

> But still seems to me that page cache is being too actively crowded
> out with a lack of memory. Since, in addition to the top speed SSD on
> which the swap is located, there is also the slow HDD in the system
> that just starts to rustle continuously when swap being used. It would
> seem better to push some of the RAM onto a fast SSD into the swap
> partition than to leave the slow HDD without a cache.
>
> https://imgur.com/a/e8TIkBa
>
> But I am afraid it will be difficult to implement such an algorithm
> that analyzes the waiting time for the file I/O and waiting for paging
> (memory) and decides to leave parts in memory where the waiting time
> is more higher it would be more efficient for systems with several
> drives with access speeds can vary greatly. By waiting time I mean
> waiting time reading/writing to storage multiplied on the count of
> hits. Thus, we will not just keep in memory the most popular parts of
> the memory/disk, but also those parts of which read/write where was
> most costly.

Yes.  This is a valid problem.  I remember Johannes has a solution long
ago, but I don't know why he give up that.  Some information can be
found in the following URL.

https://lwn.net/Articles/690079/

Best Regards,
Huang, Ying

> --
> Best Regards,
> Mike Gavrilov.
