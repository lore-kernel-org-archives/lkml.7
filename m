Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7591C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95D6E2089F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mdv59X/r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729747AbfDXGTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 02:19:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46814 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfDXGTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 02:19:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=AhL3OBArdLULWWAGd+Y9As6FXTjI1ELiaAccRI7OLMk=; b=mdv59X/rkQ7zpftRusEa6CCo2
        ZmT0/jlGXeurZtSF93cqt4+BK0b1LcWB+uw7NMsg/QiXHesfQ5I2coehtuMExCPiMUaCdtJ7HGVjj
        Z9F72jy9QFmi82bcwUa2m/UBgVZAb43hbpkbElAf5WeqAr1hVBKrKG/pgSlWDjj/BhbaUzRSs+gP9
        sDdcC+l8cs+IVsrskYGcIypkP1CkG0BxZmcJxxGLwdOsZ+6wymjCvWvAaSGwGskiMmBPArPREz8D3
        IMT1SiJxJNrVO9dCa+xfPYXa+BjozHiJxB1zqC97EKkJCgQOnEBEpv5Io1Lgo0Dn3ztb3VfML0Tc7
        k27gYPTaw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJBFH-0000yJ-5L; Wed, 24 Apr 2019 06:19:03 +0000
Date:   Tue, 23 Apr 2019 23:19:03 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Eric Auger <eric.auger@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 06/19] drivers core: Add I/O ASID allocator
Message-ID: <20190424061903.GB30717@infradead.org>
References: <1556062279-64135-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1556062279-64135-7-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556062279-64135-7-git-send-email-jacob.jun.pan@linux.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 04:31:06PM -0700, Jacob Pan wrote:
> The allocator doesn't really belong in drivers/iommu because some
> drivers would like to allocate PASIDs for devices that aren't managed by
> an IOMMU, using the same ID space as IOMMU. It doesn't really belong in
> drivers/pci either since platform device also support PASID. Add the
> allocator in drivers/base.

I'd still add it to drivers/iommu, just selectable separately from the
core iommu code..
