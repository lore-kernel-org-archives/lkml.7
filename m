Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 040B0C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 07:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C44302075B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 07:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559026894;
	bh=9OgRPFORAAbPUitsEkycLVF20n4Sq84GANMTevJR5fU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xn2KRtfXPpfG2XlWTdlYtDZeS/ymIfP6XhXQ+GeojT7oj0Eze8PSNW4ObJlKLMKSn
	 Nq3oJV71niixwWG3l7Q0OP6lJA6PHQqyDmPF5qvi97Nb7cpxBf5melUZ+6TM2mErwj
	 onqK1Q690GDMb6/We6R1iCttalkz84SrOZ0iQUVE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbfE1HBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 03:01:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:50106 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726305AbfE1HBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 03:01:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id ACA3EAD7E;
        Tue, 28 May 2019 07:01:31 +0000 (UTC)
Date:   Tue, 28 May 2019 09:01:28 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Rik van Riel <riel@surriel.com>,
        Shakeel Butt <shakeelb@google.com>,
        Christoph Lameter <cl@linux.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v5 0/7] mm: reparent slab memory on cgroup removal
Message-ID: <20190528070128.GM1658@dhcp22.suse.cz>
References: <20190521200735.2603003-1-guro@fb.com>
 <20190522214347.GA10082@tower.DHCP.thefacebook.com>
 <20190522145906.60c9e70ac0ed7ee3918a124c@linux-foundation.org>
 <20190522222254.GA5700@castle>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522222254.GA5700@castle>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 22-05-19 22:23:01, Roman Gushchin wrote:
> On Wed, May 22, 2019 at 02:59:06PM -0700, Andrew Morton wrote:
> > On Wed, 22 May 2019 21:43:54 +0000 Roman Gushchin <guro@fb.com> wrote:
> > 
> > > Is this patchset good to go? Or do you have any remaining concerns?
> > > 
> > > It has been carefully reviewed by Shakeel; and also Christoph and Waiman
> > > gave some attention to it.
> > > 
> > > Since commit 172b06c32b94 ("mm: slowly shrink slabs with a relatively")
> > > has been reverted, the memcg "leak" problem is open again, and I've heard
> > > from several independent people and companies that it's a real problem
> > > for them. So it will be nice to close it asap.
> > > 
> > > I suspect that the fix is too heavy for stable, unfortunately.
> > > 
> > > Please, let me know if you have any issues that preventing you
> > > from pulling it into the tree.
> > 
> > I looked, and put it on ice for a while, hoping to hear from
> > mhocko/hannes.  Did they look at the earlier versions?
> 
> Johannes has definitely looked at one of early versions of the patchset,
> and one of the outcomes was his own patchset about pushing memcg stats
> up by the tree, which eliminated the need to deal with memcg stats
> on kmem_cache reparenting.
> 
> The problem and the proposed solution have been discussed on latest LSFMM,
> and I didn't hear any opposition. So I assume that Michal is at least
> not against the idea in general. A careful code review is always welcome,
> of course.

I didn't get to review this properly (ETOOBUSY). This is a tricky area
so a careful review is definitely due. I would really appreciate if
Vladimir could have a look. I understand he is busy with other stuff but
a highlevel review from him would be really helpful.
-- 
Michal Hocko
SUSE Labs
