Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23AD7C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 12:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E02D72084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 12:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IICgH3f0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbfDZMVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 08:21:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58040 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbfDZMVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 08:21:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6Fye5JDH7T/Xhdt3eo4IxCjOUBVE+iEQv5juCCRCrvE=; b=IICgH3f0uac3ZNFdH4gJzAMpj
        OpMP7U8L1FYek3lLPFxT09u/4AyzXHIfbxKQozyQh6L26IFJMYTFhXZlOj+A9JLsROxjwM8wsGQD1
        UkYQyyVkRnW0VrbbBs6ju3ueYG3mUCrxkFFV6XtAwuy0G7URF2Mxb36IvFXHadnblmra4VOy5OrPr
        YfJkAg2actbLmBq38ve9wovlVAyAvAPot0ujRsM4mOXPw20pY/nuDtkDRkKPas2tRUJP2IN0E41PJ
        PcQaw1Vbc7Nezw6//33iNM+AVYHorggajqBMzU7zwymPsolX1Se9zI9i3Kqo6uK2DC3vH7t4/CkO9
        IwwVktTwg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJzqt-0007gd-8a; Fri, 26 Apr 2019 12:21:15 +0000
Date:   Fri, 26 Apr 2019 05:21:15 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andriy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>
Subject: Re: [PATCH v2 06/19] drivers core: Add I/O ASID allocator
Message-ID: <20190426122115.GA29449@infradead.org>
References: <1556062279-64135-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1556062279-64135-7-git-send-email-jacob.jun.pan@linux.intel.com>
 <20190424061903.GB30717@infradead.org>
 <20190425111912.0e15eb7d@jacob-builder>
 <856b0457-bd2f-c2af-fdeb-45fe0bd3136b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <856b0457-bd2f-c2af-fdeb-45fe0bd3136b@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 12:47:43PM +0100, Jean-Philippe Brucker wrote:
> >> On Tue, Apr 23, 2019 at 04:31:06PM -0700, Jacob Pan wrote:
> >>> The allocator doesn't really belong in drivers/iommu because some
> >>> drivers would like to allocate PASIDs for devices that aren't
> >>> managed by an IOMMU, using the same ID space as IOMMU. It doesn't
> >>> really belong in drivers/pci either since platform device also
> >>> support PASID. Add the allocator in drivers/base.  
> >>
> >> I'd still add it to drivers/iommu, just selectable separately from the
> >> core iommu code..
> > Perhaps I misunderstood. If a driver wants to use IOASIDs w/o iommu
> > subsystem even turned on, how could selecting from the core iommu code
> > help? Could you elaborate on "selectable"?
> 
> How about doing the same as CONFIG_IOMMU_IOVA? The code is in
> drivers/iommu but can be selected by non-IOMMU_API users, independently
> of CONFIG_IOMMU_SUPPORT. It's true that this allocator will mostly be
> used by IOMMU drivers.

That is exactly what I meant!
