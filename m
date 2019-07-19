Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 354EAC76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 05:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09F1E206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 05:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ke7EMova"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfGSF6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 01:58:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58010 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfGSF6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 01:58:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=JkahPmPzl6XZ6PskjBrzfoX7QWUaVtcVienRoSXNBdU=; b=ke7EMova/E8ImCWNRwWDKVXZV
        xgzr0GEZFXulmnT/l8uOv0wFrCN82MkrPTDYXlySUskl/EnLLsMNExFIyi8lgY1FSkSNl2KfQqdbp
        eRidTmKZxSZMtCi4HrpM57RcSnNUXp4vMdpaik7CTHOXb1q42yApJ88phf1rposyrvlkt2zuDDAnz
        uOL5PTQNv3/Kg3HHmxTZPUaHQ056M13IKsRm7/WouU8558AfnRgvaiSXsC28lz+OIJeHdNpfhJBG5
        tsRGY+PvE8zlWUbzMU2iSeCCySgvs5HNhMACkege/wZaSaq4iRzsHorj3E8cPDBLScnFM+m2onD/4
        vVRJxBGcg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hoLts-0007jh-7i; Fri, 19 Jul 2019 05:57:48 +0000
Date:   Thu, 18 Jul 2019 22:57:48 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     john.hubbard@gmail.com
Cc:     pavel@ucw.cz, SCheung@nvidia.com, akpm@linux-foundation.org,
        aneesh.kumar@linux.vnet.ibm.com, benh@kernel.crashing.org,
        bsingharora@gmail.com, dan.j.williams@intel.com,
        dnellans@nvidia.com, ebaskakov@nvidia.com, hannes@cmpxchg.org,
        jglisse@redhat.com, jhubbard@nvidia.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        liubo95@huawei.com, mhairgrove@nvidia.com, mhocko@kernel.org,
        paulmck@linux.vnet.ibm.com, ross.zwisler@linux.intel.com,
        sgutti@nvidia.com, torvalds@linux-foundation.org,
        vdavydov.dev@gmail.com, Jason Gunthorpe <jgg@ziepe.ca>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] mm/Kconfig: additional help text for HMM_MIRROR option
Message-ID: <20190719055748.GA29082@infradead.org>
References: <20190717074124.GA21617@amd>
 <20190719013253.17642-1-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190719013253.17642-1-jhubbard@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 06:32:53PM -0700, john.hubbard@gmail.com wrote:
> +	  HMM_MIRROR provides a way to mirror ranges of the CPU page tables
> +	  of a process into a device page table. Here, mirror means "keep
> +	  synchronized". Prerequisites: the device must provide the ability
> +	  to write-protect its page tables (at PAGE_SIZE granularity), and
> +	  must be able to recover from the resulting potential page faults.
> +
> +	  Select HMM_MIRROR if you have hardware that meets the above
> +	  description. An early, partial list of such hardware is:
> +	  an NVIDIA GPU >= Pascal, Mellanox IB >= mlx5, or an AMD GPU.

Nevermind that the Nvidia support is stagaging and looks rather broken,
there is no Mellanox user of this either at this point.

But either way this has no business in a common kconfig help.  Just
drop the fine grained details and leave it to the overview.
