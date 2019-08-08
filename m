Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9203FC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 06:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 561D02186A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 06:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565244135;
	bh=ZsVN6hiyLNSl5zHLqbtEaOdEE4h0pjLz65LatWstZf4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=r9TFw94iF4fdjDAX8y2S9yr04jDttU1hkJIi4LWPisJuJjPn+xNiNR2H0fcOrTpXV
	 vTnpQKIzyzgvOU55cK5vMDsHty8Zi6MnAYqjOMV8v8WDXPoSRu4VUlvHKMXq84El5/
	 TFIwmPaCzzPxtrhlSMXBWV+gaA/JAdXY2kigshfM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731004AbfHHGCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 02:02:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:58724 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726106AbfHHGCN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 02:02:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B2659B68F;
        Thu,  8 Aug 2019 06:02:11 +0000 (UTC)
Date:   Thu, 8 Aug 2019 08:02:10 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org,
        kirill.shutemov@linux.intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mmap.c: refine data locality of find_vma_prev
Message-ID: <20190808060210.GE11812@dhcp22.suse.cz>
References: <20190806081123.22334-1-richardw.yang@linux.intel.com>
 <3e57ba64-732b-d5be-1ad6-eecc731ef405@suse.cz>
 <20190807003109.GB24750@richard>
 <20190807075101.GN11812@dhcp22.suse.cz>
 <20190808032638.GA28138@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808032638.GA28138@richard>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 08-08-19 11:26:38, Wei Yang wrote:
> On Wed, Aug 07, 2019 at 09:51:01AM +0200, Michal Hocko wrote:
> >On Wed 07-08-19 08:31:09, Wei Yang wrote:
> >> On Tue, Aug 06, 2019 at 11:29:52AM +0200, Vlastimil Babka wrote:
> >> >On 8/6/19 10:11 AM, Wei Yang wrote:
> >> >> When addr is out of the range of the whole rb_tree, pprev will points to
> >> >> the biggest node. find_vma_prev gets is by going through the right most
> >> >
> >> >s/biggest/last/ ? or right-most?
> >> >
> >> >> node of the tree.
> >> >> 
> >> >> Since only the last node is the one it is looking for, it is not
> >> >> necessary to assign pprev to those middle stage nodes. By assigning
> >> >> pprev to the last node directly, it tries to improve the function
> >> >> locality a little.
> >> >
> >> >In the end, it will always write to the cacheline of pprev. The caller has most
> >> >likely have it on stack, so it's already hot, and there's no other CPU stealing
> >> >it. So I don't understand where the improved locality comes from. The compiler
> >> >can also optimize the patched code so the assembly is identical to the previous
> >> >code, or vice versa. Did you check for differences?
> >> 
> >> Vlastimil
> >> 
> >> Thanks for your comment.
> >> 
> >> I believe you get a point. I may not use the word locality. This patch tries
> >> to reduce some unnecessary assignment of pprev.
> >> 
> >> Original code would assign the value on each node during iteration, this is
> >> what I want to reduce.
> >
> >Is there any measurable difference (on micro benchmarks or regular
> >workloads)?
> 
> I wrote a test case to compare these two methods, but not find visible
> difference in run time.

What is the point in changing this code if it doesn't lead to any
measurable improvement?
-- 
Michal Hocko
SUSE Labs
