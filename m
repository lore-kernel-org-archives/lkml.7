Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B219C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 08:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 679F42173C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 08:44:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731729AbfHHIou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 04:44:50 -0400
Received: from mga17.intel.com ([192.55.52.151]:29778 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731048AbfHHIot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 04:44:49 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 01:44:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,360,1559545200"; 
   d="scan'208";a="374781621"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga006.fm.intel.com with ESMTP; 08 Aug 2019 01:44:48 -0700
Date:   Thu, 8 Aug 2019 16:44:25 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org,
        kirill.shutemov@linux.intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mmap.c: refine data locality of find_vma_prev
Message-ID: <20190808084425.GA32524@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20190806081123.22334-1-richardw.yang@linux.intel.com>
 <3e57ba64-732b-d5be-1ad6-eecc731ef405@suse.cz>
 <20190807003109.GB24750@richard>
 <20190807075101.GN11812@dhcp22.suse.cz>
 <20190808032638.GA28138@richard>
 <20190808060210.GE11812@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808060210.GE11812@dhcp22.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 08:02:10AM +0200, Michal Hocko wrote:
>On Thu 08-08-19 11:26:38, Wei Yang wrote:
>> On Wed, Aug 07, 2019 at 09:51:01AM +0200, Michal Hocko wrote:
>> >On Wed 07-08-19 08:31:09, Wei Yang wrote:
>> >> On Tue, Aug 06, 2019 at 11:29:52AM +0200, Vlastimil Babka wrote:
>> >> >On 8/6/19 10:11 AM, Wei Yang wrote:
>> >> >> When addr is out of the range of the whole rb_tree, pprev will points to
>> >> >> the biggest node. find_vma_prev gets is by going through the right most
>> >> >
>> >> >s/biggest/last/ ? or right-most?
>> >> >
>> >> >> node of the tree.
>> >> >> 
>> >> >> Since only the last node is the one it is looking for, it is not
>> >> >> necessary to assign pprev to those middle stage nodes. By assigning
>> >> >> pprev to the last node directly, it tries to improve the function
>> >> >> locality a little.
>> >> >
>> >> >In the end, it will always write to the cacheline of pprev. The caller has most
>> >> >likely have it on stack, so it's already hot, and there's no other CPU stealing
>> >> >it. So I don't understand where the improved locality comes from. The compiler
>> >> >can also optimize the patched code so the assembly is identical to the previous
>> >> >code, or vice versa. Did you check for differences?
>> >> 
>> >> Vlastimil
>> >> 
>> >> Thanks for your comment.
>> >> 
>> >> I believe you get a point. I may not use the word locality. This patch tries
>> >> to reduce some unnecessary assignment of pprev.
>> >> 
>> >> Original code would assign the value on each node during iteration, this is
>> >> what I want to reduce.
>> >
>> >Is there any measurable difference (on micro benchmarks or regular
>> >workloads)?
>> 
>> I wrote a test case to compare these two methods, but not find visible
>> difference in run time.
>
>What is the point in changing this code if it doesn't lead to any
>measurable improvement?

You are right.

>-- 
>Michal Hocko
>SUSE Labs

-- 
Wei Yang
Help you, Help me
