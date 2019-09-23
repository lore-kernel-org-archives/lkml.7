Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDE0C32755
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 15:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E200207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 15:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="19j54Uyg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731128AbfIWPJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 11:09:57 -0400
Received: from merlin.infradead.org ([205.233.59.134]:42988 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbfIWPJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 11:09:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VxdorSasQihgyGrRfngeW8imjxqrW6HQgqpg3Uet6QA=; b=19j54Uyg7eJ86wORZyg9s/5qo
        AH4gXSstEeWW1uJu94k801lH9iKza86o97FNXMRf4B3ZR0IN/oXa9w37GN97lA9pC82IkLqd+M5ej
        jU7fXVusAZy7gkDvUmzeE5X82UOsna4gz7LW2MvB/AWm3Cyj1+QWsI37hCRAD7DWokAZTNToMugWG
        0u0wJ2VwReNXbHeOzN8130M+SyLJRnAR6hdl7OpJzAjb0lxvcYXN45n6ov4M25CBmgahdM4Kn+beI
        tJKZmrriJ2XIxyaqenH6nXt99oiAC3XKQHNPLSlst4LVkQp/Wsfym7/kxAbS4pTgfhA0ikESjSbpK
        h/1DfR/ag==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iCPyF-0004ZM-GS; Mon, 23 Sep 2019 15:09:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D4227305E43;
        Mon, 23 Sep 2019 17:08:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 28FB020D80D42; Mon, 23 Sep 2019 17:09:42 +0200 (CEST)
Date:   Mon, 23 Sep 2019 17:09:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Yunsheng Lin <linyunsheng@huawei.com>,
        Greg KH <gregkh@linuxfoundation.org>, rafael@kernel.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH] driver core: ensure a device has valid node id in
 device_add()
Message-ID: <20190923150942.GD2369@hirez.programming.kicks-ass.net>
References: <9598b359-ab96-7d61-687a-917bee7a5cd9@huawei.com>
 <20190910093114.GA19821@kroah.com>
 <34feca56-c95e-41a6-e09f-8fc2d2fd2bce@huawei.com>
 <20190910110451.GP2063@dhcp22.suse.cz>
 <20190910111252.GA8970@kroah.com>
 <5a5645d2-030f-7921-432f-ff7d657405b8@huawei.com>
 <20190910125339.GZ2063@dhcp22.suse.cz>
 <20190911053334.GH4023@dhcp22.suse.cz>
 <ca590101-bfc8-3934-d803-537aacb707e0@huawei.com>
 <20190911064926.GJ4023@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190911064926.GJ4023@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 08:49:26AM +0200, Michal Hocko wrote:
> On Wed 11-09-19 14:15:51, Yunsheng Lin wrote:

> > >>>>>> When passing the return value of dev_to_node() to cpumask_of_node()
> > >>>>>> without checking the node id if the node id is not valid, there is
> > >>>>>> global-out-of-bounds detected by KASAN as below:
> > >>>>>
> > >>>>> OK, I seem to remember this being brought up already. And now when I
> > >>>>> think about it, we really want to make cpumask_of_node NUMA_NO_NODE
> > >>>>> aware. That means using the same trick the allocator does for this
> > >>>>> special case.

> No. Please read the above paragraph again. NUMA_NO_NODE really means no
> node affinity. So all cpus should be usable. Making any assumptions
> about a local context is just wrong.

So none of this makes sense to me. How can a device have NUMA_NO_NODE on
a NUMA machine. It needs to have a physical presence _somwhere_; and
that cannot be equidistant from all CPUs.

Please explain how this makes physical sense.
