Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D0D3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A6E72173C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553692643;
	bh=OcZLipStdhvWEVK8CSPXkrrlGxkbqsgb9TgAdsd2UD0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HKnNwYPd5u6dHqpF+SPuWmb3MyhUtx1nnghvty2Cig6JowefpRYiq2oGiaTsnXU9m
	 +03QCKRvIXuY7eu6FzZPnluGZIoMVSeNMOVq4/GvPe+0GC0fSeB17FqCzfjyduhRvl
	 gHEiEUQgioJc1dXV7Al1qrB8cnB7mN4m2k5exd4U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729981AbfC0NRV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:17:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:36346 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728101AbfC0NRV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 09:17:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EF780AFE4;
        Wed, 27 Mar 2019 13:17:19 +0000 (UTC)
Date:   Wed, 27 Mar 2019 14:17:18 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, catalin.marinas@arm.com, cl@linux.com,
        willy@infradead.org, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] kmemleak: survive in a low-memory situation
Message-ID: <20190327131718.GJ11927@dhcp22.suse.cz>
References: <20190327005948.24263-1-cai@lca.pw>
 <20190327084432.GA11927@dhcp22.suse.cz>
 <651bd879-c8c0-b162-fee7-1e523904b14e@lca.pw>
 <20190327114458.GF11927@dhcp22.suse.cz>
 <68cff59d-2b0e-5a7b-bca9-36784522059b@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68cff59d-2b0e-5a7b-bca9-36784522059b@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 27-03-19 09:05:31, Qian Cai wrote:
> On 3/27/19 7:44 AM, Michal Hocko wrote> What? Normal spin lock implementation
> doesn't disable interrupts. So
> > either I misunderstand what you are saying or you seem to be confused.
> > the thing is that in_atomic relies on preempt_count to work properly and
> > if you have CONFIG_PREEMPT_COUNT=n then you simply never know whether
> > preemption is disabled so you do not know that a spin_lock is held.
> > irqs_disabled on the other hand checks whether arch specific flag for
> > IRQs handling is set (or cleared). So you would only catch irq safe spin
> > locks with the above check.
> 
> Exactly, because kmemleak_alloc() is only called in a few call sites, slab
> allocation, neigh_hash_alloc(), alloc_page_ext(), sg_kmalloc(),
> early_amd_iommu_init() and blk_mq_alloc_rqs(), my review does not yield any of
> those holding irq unsafe spinlocks.

I do not understand. What about a regular kmalloc(GFP_NOWAIT) callers with a simple
spinlock held?

-- 
Michal Hocko
SUSE Labs
