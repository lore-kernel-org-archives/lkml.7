Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9171C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 20:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57CF5206E6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 20:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfKMULe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 15:11:34 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:37236 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbfKMULe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 15:11:34 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E89F91203B429;
        Wed, 13 Nov 2019 12:11:32 -0800 (PST)
Date:   Wed, 13 Nov 2019 12:11:32 -0800 (PST)
Message-Id: <20191113.121132.1658930697082028145.davem@davemloft.net>
To:     laurentiu.tudor@nxp.com
Cc:     hch@lst.de, robin.murphy@arm.com, joro@8bytes.org,
        ruxandra.radulescu@nxp.com, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, netdev@vger.kernel.org,
        ioana.ciornei@nxp.com, leoyang.li@nxp.com, diana.craciun@nxp.com,
        madalin.bucur@nxp.com, camelia.groza@nxp.com
Subject: Re: [PATCH v3 0/4] dma-mapping: introduce new dma unmap and sync
 variants
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191113122407.1171-1-laurentiu.tudor@nxp.com>
References: <20191113122407.1171-1-laurentiu.tudor@nxp.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 13 Nov 2019 12:11:33 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Date: Wed, 13 Nov 2019 12:24:17 +0000

> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> 
> This series introduces a few new dma unmap and sync api variants that,
> on top of what the originals do, return the virtual address
> corresponding to the input dma address. In order to do that a new dma
> map op is added, .get_virt_addr that takes the input dma address and
> returns the virtual address backing it up.
> The second patch adds an implementation for this new dma map op in the
> generic iommu dma glue code and wires it in.
> The third patch updates the dpaa2-eth driver to use the new apis.

The driver should store the mapping in it's private software state if
it needs this kind of conversion.

This is huge precendence for this, and there is therefore no need to
add even more complication and methods and burdon to architecture code
for the sake of this.

Thank you.
