Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30FE3C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 16:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DCD626C55
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 16:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbfEaQnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 12:43:55 -0400
Received: from verein.lst.de ([213.95.11.211]:41831 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726531AbfEaQny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 12:43:54 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 50CCA68AA6; Fri, 31 May 2019 18:43:28 +0200 (CEST)
Date:   Fri, 31 May 2019 18:43:27 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "marex@denx.de" <marex@denx.de>, Leo Li <leoyang.li@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "noring@nocrew.org" <noring@nocrew.org>,
        "JuergenUrban@gmx.de" <JuergenUrban@gmx.de>
Subject: Re: [PATCH v7 0/5] prerequisites for device reserved local mem
 rework
Message-ID: <20190531164327.GB27525@lst.de>
References: <20190529102843.13174-1-laurentiu.tudor@nxp.com> <20190529113427.GC11952@kroah.com> <20190529113758.GA9399@lst.de> <5b8164b3-74a3-9ba4-8c28-61a14ec57a39@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b8164b3-74a3-9ba4-8c28-61a14ec57a39@nxp.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 02:06:12PM +0000, Laurentiu Tudor wrote:
> Thanks, hope this time everything is fine.

I've applied it to the dma-mapping tree now.

> When you get the time, please let me know your ideas on the next steps.

I think the next step is to move the call to
dma_alloc_from_dev_coherent from dma_alloc_attrs into the ->alloc
instances.  The only onces that really need it for now are the
generic and legacy arm dma-direct code, and drivers/iommu/dma-iommu.c
as well as the ARM DMA API code, as those are the ones use for
architectures that declare coherent regions.  The other iommus are
not used on OF platforms (at least that's what my analysis said a while
ago, feel free to double check it)
