Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8109AC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4772D20857
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YBZTCpib"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfDIKEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 06:04:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37184 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbfDIKEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 06:04:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ECN5RtyAoOFeKS2bytXLHxuqXCY8zXSsiaFPh0hQOLE=; b=YBZTCpibRaLdOoYWUhK9zEG/0
        BTqM90ug44ilMFjAoeZSG1zHMsGuzCmfCw6zMxBSVSwaiUxPPEttp+BVD4PxBgWkTUiWkcouLTNkm
        3cO3mpOjPHaR+Yh1aXQSmj6s7qR8TCRY9N+dyrq4ShyJKFS2Dx7AsXv29PHt9l+Uwpy5vB3fsc3lZ
        oDu5i+lPtNXqjsNhQ6B4NIrREIcorgn7GuD4o2shm/2Fr4J4b+kNvFVKsnR+9p+9nP/hmcJKHh73X
        bUx5+sib41bVfh8IjO4ycM+bzbqA0x53BifGUJRfr+4NAB7f1nj5WebbWG0HqYZhIw+ANg3On6m0Z
        +SoGUUkRg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hDncK-0007WU-W6; Tue, 09 Apr 2019 10:04:36 +0000
Date:   Tue, 9 Apr 2019 03:04:36 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [PATCH 01/18] drivers core: Add I/O ASID allocator
Message-ID: <20190409100436.GA28683@infradead.org>
References: <1554767973-30125-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1554767973-30125-2-git-send-email-jacob.jun.pan@linux.intel.com>
 <20190409100049.GC9224@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190409100049.GC9224@smile.fi.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 01:00:49PM +0300, Andriy Shevchenko wrote:
> I think it makes sense to add a helper macro to rcupdate.h
> (and we have several cases in kernel that can utilize it)
> 
> #define kfree_non_null_rcu(ptr, rcu_head)		\
> 	do {						\
> 		if (ptr)				\
> 			kfree_rcu(ptr, rcu_head);	\
> 	} while (0)
> 
> as a more common pattern for resource deallocators.

I think that should move straight into kfree_rcu.  In general
we expect *free* to deal with NULL pointers transparently, so we
should do so here as well.
