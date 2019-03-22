Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC18BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 09:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0967218D3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 09:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbfCVJbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 05:31:50 -0400
Received: from 8bytes.org ([81.169.241.247]:58562 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727713AbfCVJbu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 05:31:50 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 1FB592D8; Fri, 22 Mar 2019 10:31:48 +0100 (CET)
Date:   Fri, 22 Mar 2019 10:31:46 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Robert Richter <rrichter@marvell.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Ganapatrao Kulkarni <gkulkarni@marvell.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iommu/iova: Fix tracking of recently failed iova
 address
Message-ID: <20190322093146.GA18669@8bytes.org>
References: <20190315155553.11857-1-rrichter@marvell.com>
 <7515342b-f4b2-9406-5249-93ae7880835a@arm.com>
 <20190320185718.jhr6gvs7jdbn4x3p@rric.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320185718.jhr6gvs7jdbn4x3p@rric.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 06:57:23PM +0000, Robert Richter wrote:
> From: Robert Richter <rrichter@marvell.com>
> Subject: [PATCH v2] iommu/iova: Fix tracking of recently failed iova address
>  size
> 
> If a 32 bit allocation request is too big to possibly succeed, it
> early exits with a failure and then should never update max32_alloc_
> size. This patch fixes current code, now the size is only updated if
> the slow path failed while walking the tree. Without the fix the
> allocation may enter the slow path again even if there was a failure
> before of a request with the same or a smaller size.
> 
> Cc: <stable@vger.kernel.org> # 4.20+
> Fixes: bee60e94a1e2 ("iommu/iova: Optimise attempts to allocate iova from 32bit address range")
> Signed-off-by: Robert Richter <rrichter@marvell.com>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Robert Richter <rrichter@marvell.com>
> ---
>  drivers/iommu/iova.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Applied, thanks.
