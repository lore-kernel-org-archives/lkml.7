Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D923C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5934B2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732007AbfC0IIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 04:08:31 -0400
Received: from verein.lst.de ([213.95.11.211]:40345 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbfC0IIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 04:08:31 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 92A5A68B05; Wed, 27 Mar 2019 09:08:21 +0100 (CET)
Date:   Wed, 27 Mar 2019 09:08:21 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     hch@lst.de, robin.murphy@arm.com, vdumpa@nvidia.com,
        linux@armlinux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, joro@8bytes.org, m.szyprowski@samsung.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, tony@atomide.com
Subject: Re: [PATCH v2 RFC/RFT 0/5] Save single pages from CMA area
Message-ID: <20190327080821.GB20336@lst.de>
References: <20190326230131.16275-1-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326230131.16275-1-nicoleotsuka@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 04:01:26PM -0700, Nicolin Chen wrote:
> This series of patches try to save single pages from CMA area bypassing
> all CMA single page alloctions and allocating normal pages instead, as
> all addresses within one single page are contiguous.
> 
> We had once applied the PATCH-5 but reverted it as actually not all the
> callers handled the fallback allocations. Per Robin's suggestion, let's
> stuff alloc_pages()/free_page() fallbacks to those callers before having
> PATCH-5.

Given the problems this has caused so far I'd like to see a good
explanation of why this optimization is so important that all the churn
is even worth it..
