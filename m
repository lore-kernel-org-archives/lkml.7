Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E1D4C5DF60
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 01:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE25E222C1
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 01:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573004042;
	bh=XMuTrxExlNXwc59KHpMaJLkEvPjFjpqC/tjBExf6rlI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=YxyaMALwllQ8O81Drv0eurPkoi4RBLlSdAz90/DJCWBiR0DM58tim0EN9wL2dWVDO
	 fRZiN3m1B7Hc0x2RlgaUuUq00Az/Yg08p7M5ledQMEx/FzRMT77MDQEFcsPy27JBFo
	 1HMUmI4alxZbRRNuA8Q2EV8xIaqb2ndRs85wStZA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730704AbfKFBeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 20:34:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:45476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730231AbfKFBeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 20:34:01 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E3A521A49;
        Wed,  6 Nov 2019 01:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573004040;
        bh=XMuTrxExlNXwc59KHpMaJLkEvPjFjpqC/tjBExf6rlI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=exSWQAkqaw1wfaoYHAe0SJ8QkilzGB6Vbt9yPlwgg2j32HPGrJ3EvJCIM1uXkH2r4
         bGCkYKm4qJp11OWIm0RK1uwj84heN3lfE6dCnLC24nCgcJxbb1MjDFucTH9eOhk24j
         zIfzyBNCbi9T96b/qsxFnRUFa5d8rPLzGYsSCGmI=
Date:   Tue, 5 Nov 2019 17:33:59 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Shaokun Zhang <zhangshaokun@hisilicon.com>,
        linux-kernel@vger.kernel.org, yuqi jin <jinyuqi@huawei.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Paul Burton <paul.burton@mips.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v2] lib: optimize cpumask_local_spread()
Message-Id: <20191105173359.39052327cf221d9c4b26b783@linux-foundation.org>
In-Reply-To: <20191105070141.GF22672@dhcp22.suse.cz>
References: <1572863268-28585-1-git-send-email-zhangshaokun@hisilicon.com>
        <20191105070141.GF22672@dhcp22.suse.cz>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Nov 2019 08:01:41 +0100 Michal Hocko <mhocko@kernel.org> wrote:

> On Mon 04-11-19 18:27:48, Shaokun Zhang wrote:
> > From: yuqi jin <jinyuqi@huawei.com>
> > 
> > In the multi-processor and NUMA system, I/O device may have many numa
> > nodes belonging to multiple cpus. When we get a local numa, it is
> > better to find the node closest to the local numa node, instead
> > of choosing any online cpu immediately.
> > 
> > For the current code, it only considers the local NUMA node and it
> > doesn't compute the distances between different NUMA nodes for the
> > non-local NUMA nodes. Let's optimize it and find the nearest node
> > through NUMA distance. The performance will be better if it return
> > the nearest node than the random node.
> 
> Numbers please

The changelog had

: When Parameter Server workload is tested using NIC device on Huawei
: Kunpeng 920 SoC:
: Without the patch, the performance is 22W QPS;
: Added this patch, the performance become better and it is 26W QPS.

> [...]
> > +/**
> > + * cpumask_local_spread - select the i'th cpu with local numa cpu's first
> > + * @i: index number
> > + * @node: local numa_node
> > + *
> > + * This function selects an online CPU according to a numa aware policy;
> > + * local cpus are returned first, followed by the nearest non-local ones,
> > + * then it wraps around.
> > + *
> > + * It's not very efficient, but useful for setup.
> > + */
> > +unsigned int cpumask_local_spread(unsigned int i, int node)
> > +{
> > +	int node_dist[MAX_NUMNODES] = {0};
> > +	bool used[MAX_NUMNODES] = {0};
> 
> Ugh. This might be a lot of stack space. Some distro kernels use large
> NODE_SHIFT (e.g 10 so this would be 4kB of stack space just for the
> node_dist).

Yes, that's big.  From a quick peek I suspect we could get by using an
array of unsigned shorts here but that might be fragile over time even
if it works now?

Perhaps we could make it a statically allocated array and protect the
entire thing with a spin_lock_irqsave()?  It's not a frequently called
function.

