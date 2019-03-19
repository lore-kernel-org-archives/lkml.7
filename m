Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78678C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 20:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4876D2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 20:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbfCSU06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 16:26:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45990 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726824AbfCSU05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 16:26:57 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 542D1859FE;
        Tue, 19 Mar 2019 20:26:57 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.156])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 054AC60C7F;
        Tue, 19 Mar 2019 20:26:54 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 8CC3B220713; Tue, 19 Mar 2019 16:26:54 -0400 (EDT)
Date:   Tue, 19 Mar 2019 16:26:54 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Liu Bo <bo.liu@linux.alibaba.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH] virtio-fs: fix multiple tag support
Message-ID: <20190319202654.GB2299@redhat.com>
References: <20181210171318.16998-19-vgoyal@redhat.com>
 <20190317003521.69366-1-bo.liu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190317003521.69366-1-bo.liu@linux.alibaba.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 19 Mar 2019 20:26:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 17, 2019 at 08:35:21AM +0800, Liu Bo wrote:
> While doing memremap from pci_dev's system bus address to kernel virtual
> address, we assign a wrong value to the %end of pgmap.res, which ends up
> with a wrong resource size in the process of memremap, and that further
> prevent the second virtiofs pci device from being probed successfully.
> 
> Signed-off-by: Liu Bo <bo.liu@linux.alibaba.com>

Hi Liu Bo,

Thanks for the fix. This seems right. I will fix it in my internal
branch. These patches are not upstream yet. Will fold this into
existing patch for the next posting.

Thanks
Vivek

> ---
>  fs/fuse/virtio_fs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 88b00055589b..7abf2187d85f 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -713,7 +713,7 @@ static int virtio_fs_setup_dax(struct virtio_device *vdev, struct virtio_fs *fs)
>  	pgmap->res = (struct resource){
>  		.name = "virtio-fs dax window",
>  		.start = phys_addr,
> -		.end = phys_addr + cache_len,
> +		.end = phys_addr + cache_len - 1,
>  	};
>  
>  	fs->window_kaddr = devm_memremap_pages(&pci_dev->dev, pgmap);
> -- 
> 2.20.1.2.gb21ebb6
> 
