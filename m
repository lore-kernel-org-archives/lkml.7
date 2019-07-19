Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A64C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 12:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6333921849
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 12:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Pgruhfeu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbfGSMBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 08:01:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57556 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbfGSMBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 08:01:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GYa8Y0O0VgiXTRyOA5LGwgDtr8JeN/MnJP6GF1XHHxQ=; b=Pgruhfeu2Fy+OD6YYRsr0F7JM
        ZZOHGcpHleoOMwWS2yO3DbS96X0LYZkJyjZzTnj1RmSstpzCv2YN+1gH+fAm4eb/dOR4DOUXS73v2
        eT1jfCuU9qxwlL6F0UvEo7VymkVU1C3I87aPH2Ef/dep92/fqYghxtzYUz/Zg4hbljxEQd5dvPkFU
        yTcScRcrYO7IqLYIvciefGlEDYbXdaGlNa6eEvlgpxZhS2wZq/Vedipz2EfSguqb05EwB8Ku789Zt
        Z7ztWgCIA5K0XgU5r5FW3wBSie544EaLbjdkPcql2LhXQsvXfMFs08aWVcHVk9nj1yKeEsDT/tetO
        Ii3DmK53g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hoRZ5-0005Ub-RZ; Fri, 19 Jul 2019 12:00:43 +0000
Date:   Fri, 19 Jul 2019 05:00:43 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Pavel Machek <pavel@ucw.cz>, Christoph Hellwig <hch@infradead.org>,
        john.hubbard@gmail.com, SCheung@nvidia.com,
        akpm@linux-foundation.org, aneesh.kumar@linux.vnet.ibm.com,
        benh@kernel.crashing.org, bsingharora@gmail.com,
        dan.j.williams@intel.com, dnellans@nvidia.com,
        ebaskakov@nvidia.com, hannes@cmpxchg.org, jglisse@redhat.com,
        jhubbard@nvidia.com, kirill.shutemov@linux.intel.com,
        linux-kernel@vger.kernel.org, liubo95@huawei.com,
        mhairgrove@nvidia.com, mhocko@kernel.org,
        paulmck@linux.vnet.ibm.com, ross.zwisler@linux.intel.com,
        sgutti@nvidia.com, torvalds@linux-foundation.org,
        vdavydov.dev@gmail.com
Subject: Re: [PATCH] mm/Kconfig: additional help text for HMM_MIRROR option
Message-ID: <20190719120043.GA15320@infradead.org>
References: <20190717074124.GA21617@amd>
 <20190719013253.17642-1-jhubbard@nvidia.com>
 <20190719055748.GA29082@infradead.org>
 <20190719105239.GA10627@amd>
 <20190719114853.GB15816@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190719114853.GB15816@ziepe.ca>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 08:48:53AM -0300, Jason Gunthorpe wrote:
> It is like MMU_NOTIFIERS, if something needs it, then it will select
> it.
> 
> Maybe it should just be a hidden kconfig anyhow as there is no reason
> to turn it on without also turning on a using driver.

We can't just select it due to the odd X86_64 || PPC64 dependency.

Which also answers Pavels question:  you never really need it, as we
can only use it for optional functionality due to that.
