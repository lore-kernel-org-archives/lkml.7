Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05963C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 16:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8075206DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 16:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VXUM5F7y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbfCMQKd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 12:10:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56470 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfCMQKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 12:10:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qXSwAAV6U5ZAo2UFtzM/3+KbhqrKguOs3vZ1sm50gdM=; b=VXUM5F7yK83stCU5ImwxWJYJC
        JYJLwhx4Ys7ENMde+8u9JlUrU7GT3mtSr7BsnjEZq2C6WTCMeXouBUMgEuP4QFhguR1GTD1y9X3Xw
        JRnIeNrV3Ql6tMdPpiAsQ7Xwun+mcHka6cHO8IeTlTZN8qhE+ulG/dSYehoEdeUJyeapuXjH8Yb6i
        1D377eAAyPiZ4MMq6rEyj5i4FaQLRsQb0/6UYvNtVOK059DzdL+1zxq6q9WOYsuBh3p3NQVEhqg0/
        Z7C2GeOMsiq/UxmMTd60zA5JiEa/uS92sE5ZMdDl2itTgxBUOST8yK/7D2WwaL6ho/5YH46f7HOUt
        /NsylLe+Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h46Sb-0007jV-RE; Wed, 13 Mar 2019 16:10:29 +0000
Date:   Wed, 13 Mar 2019 09:10:29 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, alan.cox@intel.com, kevin.tian@intel.com,
        mika.westerberg@linux.intel.com, pengfei.xu@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v1 4/9] iommu/vt-d: Add bounce buffer API for domain
 map/unmap
Message-ID: <20190313161029.GA23513@infradead.org>
References: <20190312060005.12189-1-baolu.lu@linux.intel.com>
 <20190312060005.12189-5-baolu.lu@linux.intel.com>
 <20190312163845.GA13141@infradead.org>
 <e653341d-e001-7262-740b-2262842be06d@linux.intel.com>
 <c9fe7879-569e-b4f4-d6ec-47ab7e6fd443@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9fe7879-569e-b4f4-d6ec-47ab7e6fd443@linux.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 10:31:52AM +0800, Lu Baolu wrote:
> Hi again,
> 
> On 3/13/19 10:04 AM, Lu Baolu wrote:
> > Hi,
> > 
> > On 3/13/19 12:38 AM, Christoph Hellwig wrote:
> > > On Tue, Mar 12, 2019 at 02:00:00PM +0800, Lu Baolu wrote:
> > > > This adds the APIs for bounce buffer specified domain
> > > > map() and unmap(). The start and end partial pages will
> > > > be mapped with bounce buffered pages instead. This will
> > > > enhance the security of DMA buffer by isolating the DMA
> > > > attacks from malicious devices.
> > > 
> > > Please reuse the swiotlb code instead of reinventing it.
> > > 
> 
> Just looked into the code again. At least we could reuse below
> functions:
> 
> swiotlb_tbl_map_single()
> swiotlb_tbl_unmap_single()
> swiotlb_tbl_sync_single()
> 
> Anything else?

Yes, that is probably about the level you want to reuse, given that the
next higher layer already has hooks into the direct mapping code.
