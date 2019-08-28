Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21446C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 08:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F077720828
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 08:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbfH1I2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 04:28:02 -0400
Received: from mga12.intel.com ([192.55.52.136]:33769 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbfH1I2C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 04:28:02 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2019 01:28:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,440,1559545200"; 
   d="scan'208";a="210081623"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga002.fm.intel.com with ESMTP; 28 Aug 2019 01:28:00 -0700
Date:   Wed, 28 Aug 2019 16:27:38 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [RESEND [PATCH] 0/2] mm/mmap.c: reduce subtree gap propagation a
 little
Message-ID: <20190828082738.GA20183@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20190828060614.19535-1-richardw.yang@linux.intel.com>
 <4503e006-76ba-ed06-0184-6e361a66ba88@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4503e006-76ba-ed06-0184-6e361a66ba88@suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 10:01:40AM +0200, Vlastimil Babka wrote:
>On 8/28/19 8:06 AM, Wei Yang wrote:
>> When insert and delete a vma, it will compute and propagate related subtree
>> gap. After some investigation, we can reduce subtree gap propagation a little.
>> 
>> [1]: This one reduce the propagation by update *next* gap after itself, since
>>      *next* must be a parent in this case.
>> [2]: This one achieve this by unlinking vma from list.
>> 
>> After applying these two patches, test shows it reduce 0.3% function call for
>> vma_compute_subtree_gap.
>
>BTW, what's the overall motivation of focusing so much
>micro-optimization effort on the vma tree lately? This has been rather
>stable code where we can be reasonably sure of all bugs being found. Now
>even after some review effort, subtle bugs can be introduced. And
>Matthew was warning for a while about an upcoming major rewrite of the
>whole data structure, which will undo all this effort?
>

Hi, Vlastimil

Thanks for your comment.

I just found there could be some refine for the code and then I modify and
test it. Hope this could help a little.

You concern is valid. The benefits / cost may be not that impressive. The
community have the final decision. For me, I just want to make it better if we
can.

-- 
Wei Yang
Help you, Help me
