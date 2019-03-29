Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D74C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 02:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 960BF2184E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 02:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PXodbKoz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbfC2CgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 22:36:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34802 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727675AbfC2CgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 22:36:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=x5wrJojQMwMMqNV4mUTxSiikQGMgZPFASdd4DPbfGYk=; b=PXodbKozTbre1PKAnjXqjKbQv
        xHZWToZbgAeVVsGULg9dl9/vJlMuQy1v4CVR/DM3ujbpNrs0G8UrSkbbR5vCaXOEhikUrxz4preRj
        8SoYWLQTUvdfUquKH0N+DG9f0pkEb6zEmhQ1HPPwc6Dt0Y6n6Q0XzfL6lrV3wK8t8Ow4aOzPBkvyU
        SUzMfyObSEtBJGnh3SGZ0IQM2vOuYIDipmD0A9wb9/Y5tVrQGx5Br3Nkm/0MwSg5lxY7yBJ554lVe
        n9kg7bodgAEErghL+I/5CEgcAOjn+0KAKLKSv463Ui0evX4GqNxOdxpcgG32YWFMBnET2wUWTXVSI
        QCYlBdpMA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h9hN3-0000Eh-Ii; Fri, 29 Mar 2019 02:35:53 +0000
Date:   Thu, 28 Mar 2019 19:35:53 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ben Gardon <bgardon@google.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        linux-mm@kvack.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm, kvm: account kvm_vcpu_mmap to kmemcg
Message-ID: <20190329023552.GV10344@bombadil.infradead.org>
References: <20190329012836.47013-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190329012836.47013-1-shakeelb@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 06:28:36PM -0700, Shakeel Butt wrote:
> A VCPU of a VM can allocate upto three pages which can be mmap'ed by the
> user space application. At the moment this memory is not charged. On a
> large machine running large number of VMs (or small number of VMs having
> large number of VCPUs), this unaccounted memory can be very significant.
> So, this memory should be charged to a kmemcg. However that is not
> possible as these pages are mmapped to the userspace and PageKmemcg()
> was designed with the assumption that such pages will never be mmapped
> to the userspace.
> 
> One way to solve this problem is by introducing an additional memcg
> charging API similar to mem_cgroup_[un]charge_skmem(). However skmem
> charging API usage is contained and shared and no new users are
> expected but the pages which can be mmapped and should be charged to
> kmemcg can and will increase. So, requiring the usage for such API will
> increase the maintenance burden. The simplest solution is to remove the
> assumption of no mmapping PageKmemcg() pages to user space.

The usual response under these circumstances is "No, you can't have a
page flag bit".

I don't understand why we need a PageKmemcg anyway.  We already
have an entire pointer in struct page; can we not just check whether
page->mem_cgroup is NULL or not?
