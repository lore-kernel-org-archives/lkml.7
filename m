Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA31C48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 03:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FBC921852
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 03:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561607834;
	bh=/ADTO1E4aEzzEHDIMo3CfYNwAeZmCkOo4BbM1VeAIWE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=SeAeF+QFkfrKAbD2MCY02OKgDRQH4Fv2Vxc1/KEL7i4n0zyLGsdrU4sh54rmKyDoZ
	 +9ozMVPn9rY5oRB5/wuV9XoSQ6+9efMrWty7R6fx2gePB/kw+Vbqd53mwPammNCioS
	 K781kuHjKZCWYlcfSQ4um/2g17rC2ZJKNJiGMNgs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfF0D5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 23:57:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:39482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726640AbfF0D5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 23:57:13 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCE9C21841;
        Thu, 27 Jun 2019 03:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561607832;
        bh=/ADTO1E4aEzzEHDIMo3CfYNwAeZmCkOo4BbM1VeAIWE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2UONyGGMTtlEsb/66mZHRuM9LWiMvATVylVUq0a4E0J3dMQcf4r1Q4+fAPrLrcnUf
         ZrADGVLjSa8IAAONkU1uxWYm3XwMo09Neg7Q9TmaCjtjIKSPXCGTqqxd0FN+hqnwbT
         6AOYBpnTaoEbPcHcmpEl/vWs2hKlCkAbcabdv438=
Date:   Wed, 26 Jun 2019 20:57:11 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, <osalvador@suse.de>,
        <khandual@linux.vnet.ibm.com>, <mhocko@suse.com>,
        <mgorman@techsingularity.net>, <aarcange@redhat.com>,
        <rcampbell@nvidia.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/mempolicy: Fix an incorrect rebind node in
 mpol_rebind_nodemask
Message-Id: <20190626205711.379c61b9cdfb9f43ae71c844@linux-foundation.org>
In-Reply-To: <5CEBECF9.2060500@huawei.com>
References: <1558768043-23184-1-git-send-email-zhongjiang@huawei.com>
        <20190525112851.ee196bcbbc33bf9e0d869236@linux-foundation.org>
        <2ff829ea-1d74-9d4b-8501-e9c2ebdc36ef@suse.cz>
        <5CEBECF9.2060500@huawei.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 May 2019 21:58:17 +0800 zhong jiang <zhongjiang@huawei.com> wrote:

> On 2019/5/27 20:23, Vlastimil Babka wrote:
> > On 5/25/19 8:28 PM, Andrew Morton wrote:
> >> (Cc Vlastimil)
> > Oh dear, 2 years and I forgot all the details about how this works.
> >
> >> On Sat, 25 May 2019 15:07:23 +0800 zhong jiang <zhongjiang@huawei.com> wrote:
> >>
> >>> We bind an different node to different vma, Unluckily,
> >>> it will bind different vma to same node by checking the /proc/pid/numa_maps.   
> >>> Commit 213980c0f23b ("mm, mempolicy: simplify rebinding mempolicies when updating cpusets")
> >>> has introduced the issue.  when we change memory policy by seting cpuset.mems,
> >>> A process will rebind the specified policy more than one times. 
> >>> if the cpuset_mems_allowed is not equal to user specified nodes. hence the issue will trigger.
> >>> Maybe result in the out of memory which allocating memory from same node.
> > I have a hard time understanding what the problem is. Could you please
> > write it as a (pseudo) reproducer? I.e. an example of the process/admin
> > mempolicy/cpuset actions that have some wrong observed results vs the
> > correct expected result.
> Sorry, I havn't an testcase to reproduce the issue. At first, It was disappeared by
> my colleague to configure the xml to start an vm.  To his suprise, The bind mempolicy
> doesn't work.

So... what do we do with this patch?

> Thanks,
> zhong jiang
> >>> --- a/mm/mempolicy.c
> >>> +++ b/mm/mempolicy.c
> >>> @@ -345,7 +345,7 @@ static void mpol_rebind_nodemask(struct mempolicy *pol, const nodemask_t *nodes)
> >>>  	else {
> >>>  		nodes_remap(tmp, pol->v.nodes,pol->w.cpuset_mems_allowed,
> >>>  								*nodes);
> >>> -		pol->w.cpuset_mems_allowed = tmp;
> >>> +		pol->w.cpuset_mems_allowed = *nodes;
> > Looks like a mechanical error on my side when removing the code for
> > step1+step2 rebinding. Before my commit there was
> >
> > pol->w.cpuset_mems_allowed = step ? tmp : *nodes;
> >
> > Since 'step' was removed and thus 0, I should have used *nodes indeed.
> > Thanks for catching that.

Was that an ack?

> >>>  	}
> >>>  
> >>>  	if (nodes_empty(tmp))
> >> hm, I'm not surprised the code broke.  What the heck is going on in
> >> there?  It used to have a perfunctory comment, but Vlastimil deleted
> >> it.
> > Yeah the comment was specific for the case that was being removed.
> >
> >> Could someone please propose a comment for the above code block
> >> explaining why we're doing what we do?
> > I'll have to relearn this first...
> >
> >
> 
