Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E97C7C433FF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 07:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBAA42173B
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 07:19:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730709AbfHOHT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 03:19:58 -0400
Received: from 8bytes.org ([81.169.241.247]:49730 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726366AbfHOHT5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 03:19:57 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 027072F9; Thu, 15 Aug 2019 09:19:54 +0200 (CEST)
Date:   Thu, 15 Aug 2019 09:19:54 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     corbet@lwn.net, tony.luck@intel.com, fenghua.yu@intel.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, linux-doc@vger.kernel.org,
        linux-ia64@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Thomas.Lendacky@amd.com,
        Suravee.Suthikulpanit@amd.com, Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 06/10] iommu: Remember when default domain type was set
 on kernel command line
Message-ID: <20190815071954.GD22669@8bytes.org>
References: <20190814133841.7095-1-joro@8bytes.org>
 <20190814133841.7095-7-joro@8bytes.org>
 <754a526e-a6d4-8a3f-0b35-9dd3def5d24b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <754a526e-a6d4-8a3f-0b35-9dd3def5d24b@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Lu Baolu,

thanks for your review!

On Thu, Aug 15, 2019 at 01:01:57PM +0800, Lu Baolu wrote:
> > +#define IOMMU_CMD_LINE_DMA_API		(1 << 0)
> 
> Prefer BIT() micro?

Yes, I'll change that.

> > +	iommu_set_cmd_line_dma_api();
> 
> IOMMU command line is also set in other places, for example,
> iommu_setup() (arch/x86/kernel/pci-dma.c). Need to call this there as
> well?

You are right, I'll better add a 'bool cmd_line' parameter to the
iommu_set_default_*() functions and tell the IOMMU core this way. That
will also fix iommu=pt/nopt.

Thanks,

	Joerg
