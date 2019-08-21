Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9593FC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 08:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 688072332A
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 08:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfHUIJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 04:09:30 -0400
Received: from mga17.intel.com ([192.55.52.151]:13135 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbfHUIJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 04:09:30 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2019 01:09:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,412,1559545200"; 
   d="scan'208";a="378061526"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga005.fm.intel.com with ESMTP; 21 Aug 2019 01:09:28 -0700
Date:   Wed, 21 Aug 2019 16:09:04 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        akpm@linux-foundation.org, mgorman@techsingularity.net,
        osalvador@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mm/mmap.c: extract __vma_unlink_list as counter part
 for __vma_link_list
Message-ID: <20190821080904.GA29221@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20190814021755.1977-1-richardw.yang@linux.intel.com>
 <20190814021755.1977-3-richardw.yang@linux.intel.com>
 <20190814051611.GA1958@infradead.org>
 <20190814065703.GA6433@richard>
 <2c5cdffd-f405-23b8-98f5-37b95ca9b027@suse.cz>
 <20190820172629.GB4949@bombadil.infradead.org>
 <20190821005234.GA5540@richard>
 <20190821005417.GC18776@bombadil.infradead.org>
 <20190821012244.GA13653@richard>
 <20190821015939.GA28819@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821015939.GA28819@bombadil.infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 06:59:39PM -0700, Matthew Wilcox wrote:
>On Wed, Aug 21, 2019 at 09:22:44AM +0800, Wei Yang wrote:
>> On Tue, Aug 20, 2019 at 05:54:17PM -0700, Matthew Wilcox wrote:
>> >On Wed, Aug 21, 2019 at 08:52:34AM +0800, Wei Yang wrote:
>> >> On Tue, Aug 20, 2019 at 10:26:29AM -0700, Matthew Wilcox wrote:
>> >> >On Wed, Aug 14, 2019 at 11:19:37AM +0200, Vlastimil Babka wrote:
>> >> >> On 8/14/19 8:57 AM, Wei Yang wrote:
>> >> >> > On Tue, Aug 13, 2019 at 10:16:11PM -0700, Christoph Hellwig wrote:
>> >> >> >>Btw, is there any good reason we don't use a list_head for vma linkage?
>> >> >> > 
>> >> >> > Not sure, maybe there is some historical reason?
>> >> >> 
>> >> >> Seems it was single-linked until 2010 commit 297c5eee3724 ("mm: make the vma
>> >> >> list be doubly linked") and I guess it was just simpler to add the vm_prev link.
>> >> >> 
>> >> >> Conversion to list_head might be an interesting project for some "advanced
>> >> >> beginner" in the kernel :)
>> >> >
>> >> >I'm working to get rid of vm_prev and vm_next, so it would probably be
>> >> >wasted effort.
>> >> 
>> >> You mean replace it with list_head?
>> >
>> >No, replace the rbtree with a new tree.  https://lwn.net/Articles/787629/
>> 
>> Sounds interesting.
>> 
>> While I am not sure the plan is settled down, and how long it would take to
>> replace the rb_tree with maple tree. I guess it would probably take some time
>> to get merged upstream.
>> 
>> IMHO, it would be good to have this cleanup in current kernel. Do you agree?
>
>The three cleanups you've posted are fine.  Doing more work (ie the
>list_head) seems like wasted effort to me.

Ah, got your point. I misunderstand it.

-- 
Wei Yang
Help you, Help me
