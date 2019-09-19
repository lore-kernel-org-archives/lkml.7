Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1344C4CEC9
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 00:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3D5121907
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 00:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730717AbfISAbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 20:31:09 -0400
Received: from mga01.intel.com ([192.55.52.88]:33665 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730015AbfISAbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 20:31:09 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Sep 2019 17:31:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,522,1559545200"; 
   d="scan'208";a="177883572"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga007.jf.intel.com with ESMTP; 18 Sep 2019 17:31:06 -0700
Date:   Thu, 19 Sep 2019 08:30:47 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Yunfeng Ye <yeyunfeng@huawei.com>
Cc:     Wei Yang <richardw.yang@linux.intel.com>, rppt@linux.ibm.com,
        akpm@linux-foundation.org, osalvador@suse.de, mhocko@suse.co,
        dan.j.williams@intel.com, david@redhat.com, cai@lca.pw,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Support memblock alloc on the exact node for
 sparse_buffer_init()
Message-ID: <20190919003047.GA20697@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <af88d8ab-4088-e857-575f-9be57542e130@huawei.com>
 <20190918065140.GA5446@richard>
 <a0cbf140-7045-81bf-4686-6e742f97ceb8@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0cbf140-7045-81bf-4686-6e742f97ceb8@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 03:08:41PM +0800, Yunfeng Ye wrote:
>
>
>On 2019/9/18 14:51, Wei Yang wrote:
>> On Wed, Sep 18, 2019 at 12:22:29PM +0800, Yunfeng Ye wrote:
>>> Currently, when memblock_find_in_range_node() fail on the exact node, it
>>> will use %NUMA_NO_NODE to find memblock from other nodes. At present,
>>> the work is good, but when the large memory is insufficient and the
>>> small memory is enough, we want to allocate the small memory of this
>>> node first, and do not need to allocate large memory from other nodes.
>>>
>>> In sparse_buffer_init(), it will prepare large chunks of memory for page
>>> structure. The page management structure requires a lot of memory, but
>>> if the node does not have enough memory, it can be converted to a small
>>> memory allocation without having to allocate it from other nodes.
>>>
>>> Add %MEMBLOCK_ALLOC_EXACT_NODE flag for this situation. Normally, the
>>> behavior is the same with %MEMBLOCK_ALLOC_ACCESSIBLE, only that it will
>>> not allocate from other nodes when a single node fails to allocate.
>>>
>>> If large contiguous block memory allocated fail in sparse_buffer_init(),
>>> it will allocates small block memmory section by section later.
>>>
>> 
>> Looks this changes current behavior even it fall back to section based
>> allocation.
>> 
>When fall back to section allocation, it still use %MEMBLOCK_ALLOC_ACCESSIBLE
>,I think the behavior is not change, Can you tell me the detail about the
>changes. thanks.
>

You pass MEMBLOCK_ALLOC_EXACT_NODE for the first round allocation, which
forbid it allocates from other node. This is different from current behavior.
Am I right?
