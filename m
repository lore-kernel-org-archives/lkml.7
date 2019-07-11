Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5BDC742A2
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 18:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E26892177B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 18:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729620AbfGKSh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 14:37:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38914 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728574AbfGKSh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 14:37:58 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 08843308FC4B;
        Thu, 11 Jul 2019 18:37:58 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E02AC5C1B4;
        Thu, 11 Jul 2019 18:37:57 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id B36CB41F40;
        Thu, 11 Jul 2019 18:37:57 +0000 (UTC)
Date:   Thu, 11 Jul 2019 14:37:57 -0400 (EDT)
From:   Pankaj Gupta <pagupta@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        dan j williams <dan.j.williams@intel.com>,
        yuval shaia <yuval.shaia@oracle.com>,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        cohuck@redhat.com, lcapitulino@redhat.com
Message-ID: <1212628880.41065287.1562870277331.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190711134403-mutt-send-email-mst@kernel.org>
References: <20190710142700.10215-1-pagupta@redhat.com> <20190711134403-mutt-send-email-mst@kernel.org>
Subject: Re: [PATCH] virtio_pmem: fix sparse warning
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.116.73, 10.4.195.14]
Thread-Topic: virtio_pmem: fix sparse warning
Thread-Index: LvMnWrPi+AQ4FOoPbqDv6ACAjugRew==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Thu, 11 Jul 2019 18:37:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> 
> On Wed, Jul 10, 2019 at 07:57:00PM +0530, Pankaj Gupta wrote:
> > This patch fixes below sparse warning related to __virtio
> > type in virtio pmem driver. This is reported by Intel test
> > bot on linux-next tree.
> > 
> > nd_virtio.c:56:28: warning: incorrect type in assignment (different base
> > types)
> > nd_virtio.c:56:28:    expected unsigned int [unsigned] [usertype] type
> > nd_virtio.c:56:28:    got restricted __virtio32
> > nd_virtio.c:93:59: warning: incorrect type in argument 2 (different base
> > types)
> > nd_virtio.c:93:59:    expected restricted __virtio32 [usertype] val
> > nd_virtio.c:93:59:    got unsigned int [unsigned] [usertype] ret
> > 
> > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> > Reported-by: kbuild test robot <lkp@intel.com>
> > ---
> > 
> > This fixes a warning, so submitting it as a separate
> > patch on top of virtio pmem series.
> >  
> >  include/uapi/linux/virtio_pmem.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/uapi/linux/virtio_pmem.h
> > b/include/uapi/linux/virtio_pmem.h
> > index efcd72f2d20d..f89129bf1f84 100644
> > --- a/include/uapi/linux/virtio_pmem.h
> > +++ b/include/uapi/linux/virtio_pmem.h
> > @@ -23,12 +23,12 @@ struct virtio_pmem_config {
> >  
> >  struct virtio_pmem_resp {
> >  	/* Host return status corresponding to flush request */
> > -	__u32 ret;
> > +	__virtio32 ret;
> >  };
> >  
> >  struct virtio_pmem_req {
> >  	/* command type */
> > -	__u32 type;
> > +	__virtio32 type;
> >  };
> >  
> >  #endif
> 
> req/resp are in memory right?
> Then this looks like a wrong fix.
> The accessors should all use cpu_to/from_le
> and they types should be __le32.

o.k

> 
> > --
> > 2.20.1
> 
