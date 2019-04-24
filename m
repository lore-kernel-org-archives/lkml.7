Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 600E7C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D4D2218FE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:45:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730652AbfDXOpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:45:51 -0400
Received: from verein.lst.de ([213.95.11.211]:54312 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731885AbfDXOpt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:45:49 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id A2A4B67358; Wed, 24 Apr 2019 16:45:32 +0200 (CEST)
Date:   Wed, 24 Apr 2019 16:45:32 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, alan.cox@intel.com, kevin.tian@intel.com,
        mika.westerberg@linux.intel.com, pengfei.xu@intel.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 02/10] swiotlb: Factor out slot allocation and free
Message-ID: <20190424144532.GA21480@lst.de>
References: <20190421011719.14909-1-baolu.lu@linux.intel.com> <20190421011719.14909-3-baolu.lu@linux.intel.com> <20190422164555.GA31181@lst.de> <0c6e5983-312b-0d6b-92f5-64861cd6804d@linux.intel.com> <20190423061232.GB12762@lst.de> <dff50b2c-5e31-8b4a-7fdf-99d17852746b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dff50b2c-5e31-8b4a-7fdf-99d17852746b@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 03:32:16PM +0800, Lu Baolu wrote:
> When we add the bounce buffer between IOVA and physical buffer, the
> bounced buffer must starts from the same offset in a page, otherwise,
> IOMMU can't work here.

Why?  Even with the odd hardware descriptors typical in Intel land that
only allow offsets in the first page, not the following ones, having
a zero offset where we previously had one should be fine.
