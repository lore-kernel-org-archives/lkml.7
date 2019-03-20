Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45C8C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 02:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B483217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 02:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfCTCEI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 22:04:08 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:36213 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727358AbfCTCEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 22:04:07 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=bo.liu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TNAMPs2_1553047442;
Received: from US-160370MP2.local(mailfrom:bo.liu@linux.alibaba.com fp:SMTPD_---0TNAMPs2_1553047442)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 20 Mar 2019 10:04:04 +0800
Date:   Tue, 19 Mar 2019 19:04:01 -0700
From:   Liu Bo <bo.liu@linux.alibaba.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH] virtio-fs: fix multiple tag support
Message-ID: <20190320020400.ka5z7swyv27be656@US-160370MP2.local>
Reply-To: bo.liu@linux.alibaba.com
References: <20181210171318.16998-19-vgoyal@redhat.com>
 <20190317003521.69366-1-bo.liu@linux.alibaba.com>
 <20190319202654.GB2299@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319202654.GB2299@redhat.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 04:26:54PM -0400, Vivek Goyal wrote:
> On Sun, Mar 17, 2019 at 08:35:21AM +0800, Liu Bo wrote:
> > While doing memremap from pci_dev's system bus address to kernel virtual
> > address, we assign a wrong value to the %end of pgmap.res, which ends up
> > with a wrong resource size in the process of memremap, and that further
> > prevent the second virtiofs pci device from being probed successfully.
> > 
> > Signed-off-by: Liu Bo <bo.liu@linux.alibaba.com>
> 
> Hi Liu Bo,
> 
> Thanks for the fix. This seems right. I will fix it in my internal
> branch. These patches are not upstream yet. Will fold this into
> existing patch for the next posting.
>

Feel free to fold it, and I'm looking forward to the 1.0 release.

thanks,
-liubo

> Thanks
> Vivek
> 
> > ---
> >  fs/fuse/virtio_fs.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> > index 88b00055589b..7abf2187d85f 100644
> > --- a/fs/fuse/virtio_fs.c
> > +++ b/fs/fuse/virtio_fs.c
> > @@ -713,7 +713,7 @@ static int virtio_fs_setup_dax(struct virtio_device *vdev, struct virtio_fs *fs)
> >  	pgmap->res = (struct resource){
> >  		.name = "virtio-fs dax window",
> >  		.start = phys_addr,
> > -		.end = phys_addr + cache_len,
> > +		.end = phys_addr + cache_len - 1,
> >  	};
> >  
> >  	fs->window_kaddr = devm_memremap_pages(&pci_dev->dev, pgmap);
> > -- 
> > 2.20.1.2.gb21ebb6
> > 
