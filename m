Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B9E7C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 07:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D390C2053B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 07:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbfKLHQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 02:16:45 -0500
Received: from verein.lst.de ([213.95.11.211]:54099 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbfKLHQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 02:16:45 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5E6C968B05; Tue, 12 Nov 2019 08:16:40 +0100 (CET)
Date:   Tue, 12 Nov 2019 08:16:40 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, alan.cox@intel.com, kevin.tian@intel.com,
        mika.westerberg@linux.intel.com, Ingo Molnar <mingo@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        pengfei.xu@intel.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v5 02/10] iommu/vt-d: Use per-device dma_ops
Message-ID: <20191112071640.GA3343@lst.de>
References: <20190725031717.32317-1-baolu.lu@linux.intel.com> <20190725031717.32317-3-baolu.lu@linux.intel.com> <20190725054413.GC24527@lst.de> <bc831f88-5b19-7531-00aa-a7577dd5c1ac@linux.intel.com> <20190725114348.GA30957@lst.de> <a098359a-0f89-6028-68df-9f83718df256@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a098359a-0f89-6028-68df-9f83718df256@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 09:56:51AM +0800, Lu Baolu wrote:
> I think current code doesn't do the right thing. The user asks the iommu
> driver to use identity domain for a device, but the driver force it back
> to DMA domain because of the device address capability.
>
>> expensive.  I don't think that this change is a good idea, and even if
>> we decide that this is a good idea after all that should be done in a
>> separate prep patch that explains the rationale.
>
> Yes. Make sense.

Now that the bounce code has landed it might be good time to revisit
this patch in isolation and with a better explanation.
