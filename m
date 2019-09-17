Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3093DC4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 10:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07B6E21897
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 10:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568714943;
	bh=jbQX0td1NLhsBvE/dovva4ikJ5XHSjhoamqrL1DcJNY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=O9xZbAcb3dUK4bB9jxFmAFBtUn/Rv1bVk9/NmJC+bObiCoq3zZDe8D6qeDoIU2Jv6
	 sc24qKUIbwD9bnIaHAOx3Q8NKMrHwloyNRryQyUo5teHjkM24vMtlXCYvutDtI9cXl
	 PZ0yq7OxLcYj/khKDqA2CxYjrMF9T5mQ0GVHSaac=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbfIQKJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 06:09:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:33546 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725601AbfIQKI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 06:08:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 53904B601;
        Tue, 17 Sep 2019 10:08:56 +0000 (UTC)
Date:   Tue, 17 Sep 2019 12:08:54 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>, catalin.marinas@arm.com,
        will@kernel.org, mingo@redhat.com, bp@alien8.de, rth@twiddle.net,
        ink@jurassic.park.msu.ru, mattst88@gmail.com,
        benh@kernel.crashing.org, paulus@samba.org,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com, ysato@users.sourceforge.jp,
        dalias@libc.org, davem@davemloft.net, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, jiaxun.yang@flygoat.com,
        chenhc@lemote.com, akpm@linux-foundation.org, rppt@linux.ibm.com,
        anshuman.khandual@arm.com, tglx@linutronix.de, cai@lca.pw,
        robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, x86@kernel.org,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        len.brown@intel.com, axboe@kernel.dk, dledford@redhat.com,
        jeffrey.t.kirsher@intel.com, linux-alpha@vger.kernel.org,
        naveen.n.rao@linux.vnet.ibm.com, mwb@linux.vnet.ibm.com,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        tbogendoerfer@suse.de, linux-mips@vger.kernel.org,
        rafael@kernel.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH v5] numa: make node_to_cpumask_map() NUMA_NO_NODE aware
Message-ID: <20190917100854.GC1872@dhcp22.suse.cz>
References: <1568640481-133352-1-git-send-email-linyunsheng@huawei.com>
 <87pnjzsd8f.fsf@mpe.ellerman.id.au>
 <d748aae4-4d48-6f8a-2f6d-67fad5224ba9@huawei.com>
 <20190917093655.GA1872@dhcp22.suse.cz>
 <07c78b6c-277e-eec0-a6cd-46beab1f1547@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07c78b6c-277e-eec0-a6cd-46beab1f1547@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 17-09-19 17:53:57, Yunsheng Lin wrote:
> On 2019/9/17 17:36, Michal Hocko wrote:
> > On Tue 17-09-19 14:20:11, Yunsheng Lin wrote:
> >> On 2019/9/17 13:28, Michael Ellerman wrote:
> >>> Yunsheng Lin <linyunsheng@huawei.com> writes:
> > [...]
> >>>> But we cannot really copy the page allocator logic. Simply because the
> >>>> page allocator doesn't enforce the near node affinity. It just picks it
> >>>> up as a preferred node but then it is free to fallback to any other numa
> >>>> node. This is not the case here and node_to_cpumask_map will only restrict
> >>>> to the particular node's cpus which would have really non deterministic
> >>>> behavior depending on where the code is executed. So in fact we really
> >>>> want to return cpu_online_mask for NUMA_NO_NODE.
> >>>>
> >>>> Some arches were already NUMA_NO_NODE aware, but they return cpu_all_mask,
> >>>> which should be identical with cpu_online_mask when those arches do not
> >>>> support cpu hotplug, this patch also changes them to return cpu_online_mask
> >>>> in order to be consistent and use NUMA_NO_NODE instead of "-1".
> >>>
> >>> Except some of those arches *do* support CPU hotplug, powerpc and sparc
> >>> at least. So switching from cpu_all_mask to cpu_online_mask is a
> >>> meaningful change.
> >>
> >> Yes, thanks for pointing out.
> >>
> >>>
> >>> That doesn't mean it's wrong, but you need to explain why it's the right
> >>> change.
> >>
> >> How about adding the below to the commit log:
> >> Even if some of the arches do support CPU hotplug, it does not make sense
> >> to return the cpu that has been hotplugged.
> >>
> >> Any suggestion?
> > 
> > Again, for the third time, I believe. Make it a separate patch please.
> > There is absolutely no reason to conflate those two things.
> 
> Ok, thanks.
> Will make the cpu_all_mask -> cpu_online_mask change a separate patch.

Thanks. This really needs per arch maintainer to check closely.

> Also, do you think it is better to resend this as individual patches for each arch
> or have all these changes in a single patch? I am not sure which is the common
> practice for a multi-arches changes like this.

It really depends on arch maintainers. Both approaches have some pros
and cons. A single patch is more compact and and parts are not going to
get lost in noise. They might generate some conflicts with parallel
changes. I suspect a conflict risk is quite low in this code considering
from a recent activity. A follow up arch specific patch would have to be
routed via Andrew as well.

If Andrew is ok routing it through his tree and none of the arch
maintainers is opposed then I would go with a single patch.
-- 
Michal Hocko
SUSE Labs
