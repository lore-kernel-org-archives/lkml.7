Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19BEFC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5D9F2184B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfDKNnP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 09:43:15 -0400
Received: from 8bytes.org ([81.169.241.247]:34130 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726264AbfDKNnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 09:43:15 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id A327A42D; Thu, 11 Apr 2019 15:43:13 +0200 (CEST)
Date:   Thu, 11 Apr 2019 15:43:12 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jinyu Qi <jinyuqi@huawei.com>
Subject: Re: [PATCH] iommu/iova: Separate atomic variables to improve
 performance
Message-ID: <20190411134312.GC4518@8bytes.org>
References: <1554280521-18375-1-git-send-email-zhangshaokun@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554280521-18375-1-git-send-email-zhangshaokun@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 04:35:21PM +0800, Shaokun Zhang wrote:
> From: Jinyu Qi <jinyuqi@huawei.com> 
> 
> In struct iova_domain, there are three atomic variables, the former two
> are about TLB flush counters which use atomic_add operation, anoter is
> used to flush timer that use cmpxhg operation.
> These variables are in the same cache line, so it will cause some
> performance loss under the condition that many cores call queue_iova
> function, Let's isolate the two type atomic variables to different
> cache line to reduce cache line conflict.
> 
> Cc: Joerg Roedel <joro@8bytes.org>
> Signed-off-by: Jinyu Qi <jinyuqi@huawei.com>
> ---
>  include/linux/iova.h | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Applied, thanks.

