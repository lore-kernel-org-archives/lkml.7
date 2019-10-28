Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05287CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 12:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7162214D9
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 12:38:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389136AbfJ1MiJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 08:38:09 -0400
Received: from verein.lst.de ([213.95.11.211]:34263 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727024AbfJ1MiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 08:38:09 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id F170068B05; Mon, 28 Oct 2019 13:38:05 +0100 (CET)
Date:   Mon, 28 Oct 2019 13:38:05 +0100
From:   "hch@lst.de" <hch@lst.de>
To:     Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc:     "hch@lst.de" <hch@lst.de>, "joro@8bytes.org" <joro@8bytes.org>,
        Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Leo Li <leoyang.li@nxp.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        Diana Madalina Craciun <diana.craciun@nxp.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Madalin Bucur <madalin.bucur@nxp.com>
Subject: Re: [PATCH v2 1/3] dma-mapping: introduce new dma unmap and sync
 api variants
Message-ID: <20191028123805.GA25160@lst.de>
References: <20191024124130.16871-1-laurentiu.tudor@nxp.com> <20191024124130.16871-2-laurentiu.tudor@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024124130.16871-2-laurentiu.tudor@nxp.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 12:41:41PM +0000, Laurentiu Tudor wrote:
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> 
> Introduce a few new dma unmap and sync variants that, on top of the
> original variants, return the virtual address corresponding to the
> input dma address.
> In order to implement this a new dma map op is added and used:
>     void *get_virt_addr(dev, dma_handle);
> It does the actual conversion of an input dma address to the output
> virtual address.

We'll definitively need an implementation for dma-direct at least as
well.  Also as said previously we need a dma_can_unmap_by_dma_addr()
or similar helper that tells the driver beforehand if this works, so
that the driver can either use a sub-optimal workaround or fail the
probe if this functionality isn't implemented.
