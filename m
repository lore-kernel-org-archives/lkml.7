Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E2D4CA9ED5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 07:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11FF3206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 07:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572937307;
	bh=oNCY9lIPtGRThezvUsIa2kyjNXmrNF/FDour8uEFiiI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hEqr5ngPLN+qmfihB3LWn9zjj7m8pXEvuBRAKESqhPgtxTSOeDOLwyYsoPHFeC2IJ
	 2a+KO7qvJT0nLqazg8QcZJUdVCzDtf0mj/qDk4YJ7AOknS199cgiuIqBhPTWhWKuMt
	 7kaVSFu6wQt9IQNpapWVqBDmroiD1CmPzd1i5RJI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387676AbfKEHBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 02:01:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:49548 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387517AbfKEHBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 02:01:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 88710AD35;
        Tue,  5 Nov 2019 07:01:43 +0000 (UTC)
Date:   Tue, 5 Nov 2019 08:01:41 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc:     linux-kernel@vger.kernel.org, yuqi jin <jinyuqi@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Paul Burton <paul.burton@mips.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v2] lib: optimize cpumask_local_spread()
Message-ID: <20191105070141.GF22672@dhcp22.suse.cz>
References: <1572863268-28585-1-git-send-email-zhangshaokun@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572863268-28585-1-git-send-email-zhangshaokun@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 04-11-19 18:27:48, Shaokun Zhang wrote:
> From: yuqi jin <jinyuqi@huawei.com>
> 
> In the multi-processor and NUMA system, I/O device may have many numa
> nodes belonging to multiple cpus. When we get a local numa, it is
> better to find the node closest to the local numa node, instead
> of choosing any online cpu immediately.
> 
> For the current code, it only considers the local NUMA node and it
> doesn't compute the distances between different NUMA nodes for the
> non-local NUMA nodes. Let's optimize it and find the nearest node
> through NUMA distance. The performance will be better if it return
> the nearest node than the random node.

Numbers please

[...]
> +/**
> + * cpumask_local_spread - select the i'th cpu with local numa cpu's first
> + * @i: index number
> + * @node: local numa_node
> + *
> + * This function selects an online CPU according to a numa aware policy;
> + * local cpus are returned first, followed by the nearest non-local ones,
> + * then it wraps around.
> + *
> + * It's not very efficient, but useful for setup.
> + */
> +unsigned int cpumask_local_spread(unsigned int i, int node)
> +{
> +	int node_dist[MAX_NUMNODES] = {0};
> +	bool used[MAX_NUMNODES] = {0};

Ugh. This might be a lot of stack space. Some distro kernels use large
NODE_SHIFT (e.g 10 so this would be 4kB of stack space just for the
node_dist).

> +	int cpu, j, id;
-- 
Michal Hocko
SUSE Labs
