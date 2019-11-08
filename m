Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F32FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 03:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D8E321882
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 03:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573184986;
	bh=hDn+O714HZCfqIEs2rgREb9No+oC6fIHjDsTtU0o66Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=bUG4fFg3khcl0LzCAfI1Vz8Jx1zOeVu4d1Jkh+GBDbXBCvw/gnl5Py5WxCD+WFeiP
	 lg687wjix42gQpdPrY8D5YsaWuVM6X0zbErht/bdFljnhjK3BaTBJPt9bRNTh2Ycaw
	 iqVnwPhE9k8j1uTRQHejRsJaqvnaA+F45zSYNmec=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729730AbfKHDto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 22:49:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:43490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726504AbfKHDto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 22:49:44 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5778B214DB;
        Fri,  8 Nov 2019 03:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573184983;
        bh=hDn+O714HZCfqIEs2rgREb9No+oC6fIHjDsTtU0o66Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ht1JJP2pBj9xSJeTifsdSQh3tK1GT6ObOVtroZ8OgoROiDSbaG/eE+k49+4ACO9FN
         Vscfpd4JLJQKrkoG8x4601kkJ2KCHTg68AzurK44fdfMNdbbR0QCMWSN1QeZMrnK6r
         ygmTvOf5ysIffaDM73lutF00mEIgcFXaDphFVvwM=
Date:   Thu, 7 Nov 2019 19:49:42 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc:     <linux-kernel@vger.kernel.org>, yuqi jin <jinyuqi@huawei.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Paul Burton <paul.burton@mips.com>,
        Michal Hocko <mhocko@suse.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v3] lib: optimize cpumask_local_spread()
Message-Id: <20191107194942.734bc867e1c9578d07cf1712@linux-foundation.org>
In-Reply-To: <1573091048-10595-1-git-send-email-zhangshaokun@hisilicon.com>
References: <1573091048-10595-1-git-send-email-zhangshaokun@hisilicon.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Nov 2019 09:44:08 +0800 Shaokun Zhang <zhangshaokun@hisilicon.com> wrote:

> In the multi-processors and NUMA system, I/O driver will find cpu cores
> that which shall be bound IRQ. When cpu cores in the local numa have
> been used, it is better to find the node closest to the local numa node,
> instead of choosing any online cpu immediately.
> 
> On Huawei Kunpeng 920 server, there are 4 NUMA node(0 -3) in the 2-cpu
> system(0 - 1). We perform PS (parameter server) business test, the
> behavior of the service is that the client initiates a request through
> the network card, the server responds to the request after calculation. 
> When two PS processes run on node2 and node3 separately and the
> network card is located on 'node2' which is in cpu1, the performance
> of node2 (26W QPS) and node3 (22W QPS) was different.
> It is better that the NIC queues are bound to the cpu1 cores in turn,
> then XPS will also be properly initialized, while cpumask_local_spread
> only considers the local node. When the number of NIC queues exceeds
> the number of cores in the local node, it returns to the online core
> directly. So when PS runs on node3 sending a calculated request,
> the performance is not as good as the node2. It is considered that
> the NIC and other I/O devices shall initialize the interrupt binding,
> if the cores of the local node are used up, it is reasonable to return
> the node closest to it.
> 
> Let's optimize it and find the nearest node through NUMA distance for the
> non-local NUMA nodes. The performance will be better if it return the
> nearest node than the random node.
> 
> After this patch, the performance of the node3 is the same as node2
> that is 26W QPS when the network card is still in 'node2'. Since it will
> return the closest non-local NUMA code rather than random node, it is no
> harm to others at least.

This is a little nicer:

--- a/lib/cpumask.c~lib-optimize-cpumask_local_spread-v3-fix
+++ a/lib/cpumask.c
@@ -254,7 +254,6 @@ static unsigned int __cpumask_local_spre
 	BUG();
 }
 
-static DEFINE_SPINLOCK(spread_lock);
 /**
  * cpumask_local_spread - select the i'th cpu with local numa cpu's first
  * @i: index number
@@ -270,6 +269,7 @@ unsigned int cpumask_local_spread(unsign
 {
 	static int node_dist[MAX_NUMNODES];
 	static bool used[MAX_NUMNODES];
+	static DEFINE_SPINLOCK(spread_lock);
 	unsigned long flags;
 	int cpu, j, id;
 
_

