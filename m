Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40710C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 07:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F6BE20644
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 07:36:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfHPHgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 03:36:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60006 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbfHPHgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 03:36:15 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 833BC369D3;
        Fri, 16 Aug 2019 07:36:15 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7302F19C6A;
        Fri, 16 Aug 2019 07:36:15 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 5E8582551B;
        Fri, 16 Aug 2019 07:36:15 +0000 (UTC)
Date:   Fri, 16 Aug 2019 03:36:14 -0400 (EDT)
From:   Pankaj Gupta <pagupta@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Message-ID: <1526809439.8842269.1565940974952.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAPcyv4gLqd43CLDuGYrDdx4xR1_oc3D0hzdETz8uQmV1C2Dp_Q@mail.gmail.com>
References: <20190731111207.12836-1-pagupta@redhat.com> <CAPcyv4gLqd43CLDuGYrDdx4xR1_oc3D0hzdETz8uQmV1C2Dp_Q@mail.gmail.com>
Subject: Re: [PATCH] libnvdimm: change disk name of virtio pmem disk
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.116.204, 10.4.195.21]
Thread-Topic: libnvdimm: change disk name of virtio pmem disk
Thread-Index: 9nluNaz18R3eUqbznRETd5vqCIb7PA==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 16 Aug 2019 07:36:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> >
> > This patch adds prefix 'v' in disk name for virtio pmem.
> > This differentiates virtio-pmem disks from the pmem disks.
> 
> I don't think the small matter that this device does not support
> MAP_SYNC warrants a separate naming scheme.  That said I do think we
> need to export this attribute in sysfs, likely at the region level,
> and then display that information in ndctl. This is distinct from the
> btt case where it is operating a different data consistency contract
> than baseline pmem.

o.k. I will look to add the information in sysfs and display using ndctl.

Thanks,
Pankaj

> >
> > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> > ---
> >  drivers/nvdimm/namespace_devs.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/nvdimm/namespace_devs.c
> > b/drivers/nvdimm/namespace_devs.c
> > index a16e52251a30..8e5d29266fb0 100644
> > --- a/drivers/nvdimm/namespace_devs.c
> > +++ b/drivers/nvdimm/namespace_devs.c
> > @@ -182,8 +182,12 @@ const char *nvdimm_namespace_disk_name(struct
> > nd_namespace_common *ndns,
> >                 char *name)
> >  {
> >         struct nd_region *nd_region = to_nd_region(ndns->dev.parent);
> > +       const char *prefix = "";
> >         const char *suffix = NULL;
> >
> > +       if (!is_nvdimm_sync(nd_region))
> > +               prefix = "v";
> > +
> >         if (ndns->claim && is_nd_btt(ndns->claim))
> >                 suffix = "s";
> >
> > @@ -201,7 +205,7 @@ const char *nvdimm_namespace_disk_name(struct
> > nd_namespace_common *ndns,
> >                         sprintf(name, "pmem%d.%d%s", nd_region->id, nsidx,
> >                                         suffix ? suffix : "");
> >                 else
> > -                       sprintf(name, "pmem%d%s", nd_region->id,
> > +                       sprintf(name, "%spmem%d%s", prefix, nd_region->id,
> >                                         suffix ? suffix : "");
> >         } else if (is_namespace_blk(&ndns->dev)) {
> >                 struct nd_namespace_blk *nsblk;
> > --
> > 2.20.1
> >
> 
