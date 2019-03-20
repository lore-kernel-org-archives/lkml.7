Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D006C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D63821841
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfCTTWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 15:22:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49134 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbfCTTWG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 15:22:06 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 75EC8368E6;
        Wed, 20 Mar 2019 19:22:06 +0000 (UTC)
Received: from x1.home (ovpn-116-218.phx2.redhat.com [10.3.116.218])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2FB4C60461;
        Wed, 20 Mar 2019 19:22:03 +0000 (UTC)
Date:   Wed, 20 Mar 2019 13:22:02 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     "Liu, Yi L" <yi.l.liu@intel.com>
Cc:     "kwankhede@nvidia.com" <kwankhede@nvidia.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "Sun, Yi Y" <yi.y.sun@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "jean-philippe.brucker@arm.com" <jean-philippe.brucker@arm.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC v2 1/2] vfio/pci: export common symbols in vfio-pci
Message-ID: <20190320132202.6279a190@x1.home>
In-Reply-To: <A2975661238FB949B60364EF0F2C257439E48CA9@SHSMSX104.ccr.corp.intel.com>
References: <1552378703-11202-1-git-send-email-yi.l.liu@intel.com>
        <1552378703-11202-2-git-send-email-yi.l.liu@intel.com>
        <20190319121416.27495651@x1.home>
        <A2975661238FB949B60364EF0F2C257439E48CA9@SHSMSX104.ccr.corp.intel.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 20 Mar 2019 19:22:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Mar 2019 11:49:37 +0000
"Liu, Yi L" <yi.l.liu@intel.com> wrote:

> > From: Alex Williamson [mailto:alex.williamson@redhat.com]
> > Sent: Wednesday, March 20, 2019 2:14 AM
> > To: Liu, Yi L <yi.l.liu@intel.com>
> > Subject: Re: [RFC v2 1/2] vfio/pci: export common symbols in vfio-pci
> > 
> > On Tue, 12 Mar 2019 16:18:22 +0800
> > "Liu, Yi L" <yi.l.liu@intel.com> wrote:
> >   
> > > This patch exports the following symbols from vfio-pci driver
> > > for vfio-pci alike driver. e.g. vfio-pci-mdev driver
> > >
> > > *) vfio_pci_set_vga_decode();
> > > *) vfio_pci_release();
> > > *) vfio_pci_open();
> > > *) vfio_pci_register_dev_region();
> > > *) vfio_pci_ioctl();
> > > *) vfio_pci_rw();
> > > *) vfio_pci_mmap();
> > > *) vfio_pci_request();
> > > *) vfio_pci_probe_misc();
> > > *) vfio_pci_remove_misc();
> > > *) vfio_err_handlers;
> > > *) vfio_pci_reflck_attach();
> > > *) vfio_pci_reflck_put();  
> > 
> > Exporting all these symbols scares me a bit.  They're GPL and we don't
> > guarantee a kernel ABI, but I don't really want to support arbitrary
> > use cases either.  What if we re-factored the shared bits into a common
> > file and just linked them together?  Thanks,  
> 
> Hi, Alex,
> 
> Before refactor the code, I'd like to check with you on the module
> parameters for the two modules. The existing vfio-pci driver has
> some module parameters. e.g. ids, nointxmask, disable_idle_d3.
> For future usage and maintain, I think it is better to let the two
> drivers have same parameters. However, I'm not 100% on whether
> we want to allow user load vfio-pci.ko and vfio-pci-mdev.ko with
> different parameter value? e.g. load vfio-pci.ko with nointxmask=false
> while load vfio-pci-mdev.ko with nointxmask=true. How about your
> opinion on it?

Hi Yi,

I agree that it makes sense to retain the module options for the mdev
wrapped version, but I expect we should also allow dissimilar user
settings.  If those lived in the common code that gets linked separately
with each module, that should work fine, I think.  We can worry about
refactoring for future driver that might not want those options later.
Thanks,

Alex
