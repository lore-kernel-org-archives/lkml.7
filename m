Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FD9C10F00
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 20:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 872732147C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 20:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fwqIWCOy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbfC0Ufd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 16:35:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51384 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbfC0Ufd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 16:35:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QPOloOxRTaTdLOpUVbW+jky/YMc8w2U+BABUuwfTLpA=; b=fwqIWCOyonfUBxY/jYxMe7Cta
        LrKDdKpoPiEiX7TXLGKbtSDRk/5QtQcNckocOCp8bTsUWepcPLwBuOqq+/xDvMEF0e+QopEX7cANr
        JoeMqtKfG8rbY1K3WEx87Da5m0eAaf9B8ttoJA2eDYrgHbS4IJ+Uz4vfee4bsIHsRezaMTFyIM5k4
        M7X+3il7hPr53Ks7kLecEjfE0hxw+RM8yd3estaG1wS7OUN7aDUIBasLdDqt3UultvUAFs1FvxzIj
        GZ23+02PfyUH5M0xsQGPoZWMQQr2saeEdpTLMAcGWdUMkQZnLaDb714B7QWoF3YcoW0lWU4jLbxFk
        Kx7LMerQA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h9FGa-0006KX-GT; Wed, 27 Mar 2019 20:35:20 +0000
Date:   Wed, 27 Mar 2019 13:35:20 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        "Du, Fan" <fan.du@intel.com>, "Huang, Ying" <ying.huang@intel.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/10] Another Approach to Use PMEM as NUMA Node
Message-ID: <20190327203520.GU10344@bombadil.infradead.org>
References: <1553316275-21985-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190326135837.GP28406@dhcp22.suse.cz>
 <43a1a59d-dc4a-6159-2c78-e1faeb6e0e46@linux.alibaba.com>
 <20190326183731.GV28406@dhcp22.suse.cz>
 <f08fb981-d129-3357-e93a-a6b233aa9891@linux.alibaba.com>
 <20190327090100.GD11927@dhcp22.suse.cz>
 <CAPcyv4heiUbZvP7Ewoy-Hy=-mPrdjCjEuSw+0rwdOUHdjwetxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4heiUbZvP7Ewoy-Hy=-mPrdjCjEuSw+0rwdOUHdjwetxg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 10:34:11AM -0700, Dan Williams wrote:
> On Wed, Mar 27, 2019 at 2:01 AM Michal Hocko <mhocko@kernel.org> wrote:
> > No, Linux NUMA implementation makes all numa nodes available by default
> > and provides an API to opt-in for more fine tuning. What you are
> > suggesting goes against that semantic and I am asking why. How is pmem
> > NUMA node any different from any any other distant node in principle?
> 
> Agree. It's just another NUMA node and shouldn't be special cased.
> Userspace policy can choose to avoid it, but typical node distance
> preference should otherwise let the kernel fall back to it as
> additional memory pressure relief for "near" memory.

I think this is sort of true, but sort of different.  These are
essentially CPU-less nodes; there is no CPU for which they are
fast memory.  Yes, they're further from some CPUs than from others.
I have never paid attention to how Linux treats CPU-less memory nodes,
but it would make sense to me if we don't default to allocating from
remote nodes.  And treating pmem nodes as being remote from all CPUs
makes a certain amount of sense to me.

eg on a four CPU-socket system, consider this as being

pmem1 --- node1 --- node2 --- pmem2
            |   \ /   |
            |    X    |
            |   / \   |
pmem3 --- node3 --- node4 --- pmem4

which I could actually see someone building with normal DRAM, and we
should probably handle the same way as pmem; for a process running on
node3, allocate preferentially from node3, then pmem3, then other nodes,
then other pmems.

