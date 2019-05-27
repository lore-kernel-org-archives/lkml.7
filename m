Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86CAC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 15:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 960EE2183F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 15:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbfE0PXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 11:23:07 -0400
Received: from 8bytes.org ([81.169.241.247]:40374 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbfE0PXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 11:23:07 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 75B98244; Mon, 27 May 2019 17:23:05 +0200 (CEST)
Date:   Mon, 27 May 2019 17:23:04 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Eric Auger <eric.auger@redhat.com>
Cc:     eric.auger.pro@gmail.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, dwmw2@infradead.org,
        lorenzo.pieralisi@arm.com, robin.murphy@arm.com,
        will.deacon@arm.com, hanjun.guo@linaro.org, sudeep.holla@arm.com,
        alex.williamson@redhat.com, shameerali.kolothum.thodi@huawei.com
Subject: Re: [PATCH v4 3/8] iommu/vt-d: Duplicate iommu_resv_region objects
 per device list
Message-ID: <20190527152303.GD12745@8bytes.org>
References: <20190527085541.5294-1-eric.auger@redhat.com>
 <20190527085541.5294-4-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527085541.5294-4-eric.auger@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 10:55:36AM +0200, Eric Auger wrote:
> -			list_add_tail(&rmrr->resv->list, head);
> +			length = rmrr->end_address - rmrr->base_address + 1;
> +			resv = iommu_alloc_resv_region(rmrr->base_address,
> +						       length, prot,
> +						       IOMMU_RESV_DIRECT,
> +						       GFP_ATOMIC);
> +			if (!resv)
> +				break;
> +
> +			list_add_tail(&resv->list, head);

Okay, so this happens in a rcu_read_locked section and must be atomic,
but I don't like this extra parameter to iommu_alloc_resv_region().

How about replacing the rcu-lock with the dmar_global_lock, which
protects against changes to the global rmrr list? This will make this
loop preemptible and taking the global lock is okay because this
function is in no way performance relevant.

Regards,

	Joerg
