Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00066C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 02:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C80072084B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 02:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbfDBClZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 22:41:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60514 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726411AbfDBClZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 22:41:25 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 15549308339B;
        Tue,  2 Apr 2019 02:41:25 +0000 (UTC)
Received: from xz-x1 (dhcp-14-116.nay.redhat.com [10.66.14.116])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AF356601A5;
        Tue,  2 Apr 2019 02:41:17 +0000 (UTC)
Date:   Tue, 2 Apr 2019 10:41:15 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        eric.auger@redhat.com, cohuck@redhat.com
Subject: Re: [PATCH] vfio/type1: Limit DMA mappings per container
Message-ID: <20190402024115.GA11008@xz-x1>
References: <155414977872.12780.13728555131525362206.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <155414977872.12780.13728555131525362206.stgit@gimli.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Tue, 02 Apr 2019 02:41:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 02:16:52PM -0600, Alex Williamson wrote:

[...]

> @@ -1081,8 +1088,14 @@ static int vfio_dma_do_map(struct vfio_iommu *iommu,
>  		goto out_unlock;
>  	}
>  
> +	if (!atomic_add_unless(&iommu->dma_avail, -1, 0)) {
> +		ret = -ENOSPC;
> +		goto out_unlock;
> +	}
> +
>  	dma = kzalloc(sizeof(*dma), GFP_KERNEL);
>  	if (!dma) {
> +		atomic_inc(&iommu->dma_avail);

This should be the only special path to revert the change.  Not sure
whether this can be avoided by simply using atomic_read() or even
READ_ONCE() (I feel like we don't need atomic ops with dma_avail
because we've had the mutex but it of course it doesn't hurt...) to
replace atomic_add_unless() above to check against zero then we do
+1/-1 in vfio_[un]link_dma() only.  But AFAICT this patch is correct.

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu
