Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF70C04AB6
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 00:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A7F626963
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 00:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbfFAAOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 20:14:33 -0400
Received: from mga06.intel.com ([134.134.136.31]:8648 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726518AbfFAAOd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 20:14:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 May 2019 17:14:32 -0700
X-ExtLoop1: 1
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.29])
  by fmsmga008.fm.intel.com with ESMTP; 31 May 2019 17:14:30 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH -mm] mm, swap: Fix bad swap file entry warning
References: <20190531024102.21723-1-ying.huang@intel.com>
        <20190531061047.GB6896@dhcp22.suse.cz>
Date:   Sat, 01 Jun 2019 08:14:29 +0800
In-Reply-To: <20190531061047.GB6896@dhcp22.suse.cz> (Michal Hocko's message of
        "Fri, 31 May 2019 08:10:47 +0200")
Message-ID: <87tvda40wq.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko <mhocko@kernel.org> writes:

> On Fri 31-05-19 10:41:02, Huang, Ying wrote:
>> From: Huang Ying <ying.huang@intel.com>
>> 
>> Mike reported the following warning messages
>> 
>>   get_swap_device: Bad swap file entry 1400000000000001
>> 
>> This is produced by
>> 
>> - total_swapcache_pages()
>>   - get_swap_device()
>> 
>> Where get_swap_device() is used to check whether the swap device is
>> valid and prevent it from being swapoff if so.  But get_swap_device()
>> may produce warning message as above for some invalid swap devices.
>> This is fixed via calling swp_swap_info() before get_swap_device() to
>> filter out the swap devices that may cause warning messages.
>> 
>> Fixes: 6a946753dbe6 ("mm/swap_state.c: simplify total_swapcache_pages() with get_swap_device()")
>
> I suspect this is referring to a mmotm patch right?

Yes.

> There doesn't seem
> to be any sha like this in Linus' tree AFAICS. If that is the case then
> please note that mmotm patch showing up in linux-next do not have a
> stable sha1 and therefore you shouldn't reference them in the commit
> message. Instead please refer to the specific mmotm patch file so that
> Andrew knows it should be folded in to it.

Thanks for reminding!  I will be more careful in the future.  It seems
that Andrew has identified the right patch to be folded into.

Best Regards,
Huang, Ying
