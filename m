Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED81C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 15:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E02092084D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 15:36:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfK1Pgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 10:36:49 -0500
Received: from verein.lst.de ([213.95.11.211]:52769 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726401AbfK1Pgt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 10:36:49 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5692068B05; Thu, 28 Nov 2019 16:36:46 +0100 (CET)
Date:   Thu, 28 Nov 2019 16:36:46 +0100
From:   "hch@lst.de" <hch@lst.de>
To:     Thomas Hellstrom <thellstrom@vmware.com>
Cc:     "hch@lst.de" <hch@lst.de>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH 2/2] dma-mapping: force unencryped devices are always
 addressing limited
Message-ID: <20191128153646.GA29430@lst.de>
References: <20191127144006.25998-1-hch@lst.de> <20191127144006.25998-3-hch@lst.de> <a95d9115fc2a80de2f97f001bbcd9aba6636e685.camel@vmware.com> <20191128075153.GD20659@lst.de> <MN2PR05MB6141B6D7E28A146EBF9CE79FA1470@MN2PR05MB6141.namprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR05MB6141B6D7E28A146EBF9CE79FA1470@MN2PR05MB6141.namprd05.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 28, 2019 at 08:02:16AM +0000, Thomas Hellstrom wrote:
> > We have a hard time handling that in generic code.  Do we have any
> > good use case for SWIOTLB_FORCE not that we have force_dma_unencrypted?
> > I'd love to be able to get rid of it..
> >
> IIRC the justification for it is debugging. Drivers that don't do
> syncing correctly or have incorrect assumptions of initialization of DMA
> memory will not work properly when SWIOTLB is forced. We recently found
> a vmw_pvscsi device flaw that way...

Ok. I guess debugging is reasonable.  Although that means I need
to repsin this quite a bit as I now need a callout to dma_direct.
I'll respin it in the next days.
