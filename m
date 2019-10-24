Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B960BCA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 08:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E1A420684
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 08:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438387AbfJXIvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 04:51:10 -0400
Received: from mga18.intel.com ([134.134.136.126]:27016 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730621AbfJXIvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 04:51:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2019 01:51:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,224,1569308400"; 
   d="scan'208";a="210110065"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.29])
  by fmsmga001.fm.intel.com with ESMTP; 24 Oct 2019 01:51:08 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Chen Wandun <chenwandun@huawei.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [Question] Is there race between swapoff and swapout
References: <8860e8b1-7bad-0b4a-60d1-4893973b9cb2@huawei.com>
Date:   Thu, 24 Oct 2019 16:51:08 +0800
In-Reply-To: <8860e8b1-7bad-0b4a-60d1-4893973b9cb2@huawei.com> (Chen Wandun's
        message of "Mon, 14 Oct 2019 21:22:35 +0800")
Message-ID: <87sgnih6gz.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chen Wandun <chenwandun@huawei.com> writes:

> I analysied the code about swapoff and swapout, and I suspected there may be a race.
> The kernel version is 4.14 stable.
>
> CPU0						CPU1
> swapoff						swap out
> 						add_to_swap
> 							get_swap_page
> 	......							get_swap_pages						
> 									spin_lock(&swap_avail_lock)
> 									get swap_info_struct
> 									spin_unlock(&swap_avail_lock)		
> 	spin_lock(&swap_avail_lock)									
> 	__def_from_avail_list(swap_info_struct)								
>     	spin_unlock(&swap_avail_lock)					......	
> 	try_to_unuse  // unuse all slot
> 									/* get a free slot from swap_info_struct,
> 									 * and write data to slot later
> 									 */	
> 									scan_swap_map_slots
> 	free swap_info_struct
> 	.......
>
> 	
> If CPU1 get the swap_info_struct first, then CPU0 delete it from list and
> unuse all slot in swap_info_struct, before CPU0 free swap_info_struct CPU1
> call scan_swap_map_slots to alloc a free slot.
>
> I am not sure the analysis above is correct,
> Please let me know if there is any mistake

SWP_WRITEOK will be cleared during swapoff, and it is checked during
swap slots allocation.

Best Regards,
Huang, Ying

> Thanks
> ChenWandun
