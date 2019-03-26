Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A23C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B318020811
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732048AbfCZPf1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 11:35:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53238 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbfCZPf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 11:35:27 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 63261307B48D;
        Tue, 26 Mar 2019 15:35:26 +0000 (UTC)
Received: from x1.home (ovpn-116-99.phx2.redhat.com [10.3.116.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1FAC2100ACFB;
        Tue, 26 Mar 2019 15:35:21 +0000 (UTC)
Date:   Tue, 26 Mar 2019 09:35:20 -0600
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
Message-ID: <20190326093520.24c211ab@x1.home>
In-Reply-To: <A2975661238FB949B60364EF0F2C257439E4DB32@SHSMSX104.ccr.corp.intel.com>
References: <1552378703-11202-1-git-send-email-yi.l.liu@intel.com>
        <1552378703-11202-2-git-send-email-yi.l.liu@intel.com>
        <20190319121416.27495651@x1.home>
        <A2975661238FB949B60364EF0F2C257439E48CA9@SHSMSX104.ccr.corp.intel.com>
        <20190320132202.6279a190@x1.home>
        <A2975661238FB949B60364EF0F2C257439E4BBF2@SHSMSX104.ccr.corp.intel.com>
        <20190325121720.53935577@x1.home>
        <A2975661238FB949B60364EF0F2C257439E4DB32@SHSMSX104.ccr.corp.intel.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 26 Mar 2019 15:35:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Mar 2019 12:37:37 +0000
"Liu, Yi L" <yi.l.liu@intel.com> wrote:

> > From: Alex Williamson [mailto:alex.williamson@redhat.com]
> > Sent: Tuesday, March 26, 2019 2:17 AM
> > To: Liu, Yi L <yi.l.liu@intel.com>
> > Subject: Re: [RFC v2 1/2] vfio/pci: export common symbols in vfio-pci
> > 
> > On Sat, 23 Mar 2019 11:06:44 +0000
> > "Liu, Yi L" <yi.l.liu@intel.com> wrote:  
> > > Hi Alex,  
> 
> [...]
> 
> > >
> > > I tried to get a common file which includes the definitions of the module
> > > options and the common interfaces and get it linked separately with each
> > > module. It works well when linked separately by config the
> > > CONFIG_VFIO_PCI=m and CONFIG_VFIO_PCI_MDEV=m in kernel
> > > configuration file. CONFIG_VFIO_PCI_MDEV is a new Kconfig macro
> > > for the mdev wrapped version driver. However, if building the vfio-pci
> > > and the mdev wrapped version into kernel image (config the
> > > CONFIG_VFIO_PCI=y and CONFIG_VFIO_PCI_MDEV=y), then the symbols
> > > defined in the common file will be shared thus doesn't allow dissimilar
> > > user settings.
> > >
> > > Per my understanding, I think we expect to allow simultaneous usage of
> > > the two drivers. So I think the way above doesn't meet our expectation.  
> > 
> > I agree.  They should be related in implementation only, from a user
> > perspective they should be entirely separate.
> >   
> > > I considered a possible proposal as below. May listen to your opinion
> > > on it before heading to cook. Also, better idea is welcomed. :-)
> > >
> > > - get a common file includes interfaces which are common and have
> > >   input parameters to differentiate the calling from vfio-pci and the
> > >   wrapped version. e.g. vfio_pci_rw(). may call it as vfio_pci_common.c.
> > >
> > > - get another common file includes the definitions of the module options,
> > >   and the functions which referred the options. Define all of them as static.
> > >   may call it as common.c
> > >
> > > - get vfio_pci.c which includes the module_init/exit interfaces and driver
> > >   registration operations of vfio-pci.ko. This file should include the common.c
> > >   above to have same module options with the mdev wrapped version.
> > >
> > > - get vfio_pci_mdev.c which includes the module_init/exit interfaces and
> > >   driver registration operations of vfio-pci-mdev.ko. It should also include
> > >   the common.c above to have same module options with vfio-pci.ko.
> > >
> > > - Makefile:
> > > vfio-pci-y := vfio_pci.o vfio_pci_common.o vfio_pci_intrs.o vfio_pci_rdwr.o  
> > vfio_pci_config.o  
> > > vfio-pci-$(CONFIG_VFIO_PCI_IGD) += vfio_pci_igd.o
> > > vfio-pci-$(CONFIG_VFIO_PCI_NVLINK2) += vfio_pci_nvlink2.o
> > >
> > > vfio-pci-mdev-y := vfio_pci_mdev.o vfio_pci_common.o vfio_pci_intrs.o  
> > vfio_pci_rdwr.o vfio_pci_config.o  
> > > vfio-pci-mdev-$(CONFIG_VFIO_PCI_IGD) += vfio_pci_igd.o
> > > vfio-pci-mdev-$(CONFIG_VFIO_PCI_NVLINK2) += vfio_pci_nvlink2.o
> > >
> > > obj-$(CONFIG_VFIO_PCI) += vfio-pci.o
> > > obj-$(CONFIG_VFIO_PCI_MDEV) += vfio-pci-mdev.o  
> > 
> > Each module needs it's own module_init/exit and will register its own
> > struct pci_driver, which gives us separate control of the probe and  
> 
> Agreed.
> 
> > remove callbacks.  I think we want the drivers to have the same module
> > parameters initially, but we don't necessarily want to require it for
> > any future options, so we can duplicate the parameter declarations.
> > Then to support the shared code, I think we can easily push nointxmask,
> > disable_vga, and disable_idle_d3 into bools on the struct
> > vfio_pci_device, which would be allocated and set by each module's
> > probe function before calling the shared probe function.  
> 
> sounds good to me. 
> 
> > vfio_fill_ids() could take a pointer to the array to keep them separate
> > between modules.   
> 
> Agreed.
> 
> > I think that just leaves the config permission bits,
> > vfio_pci_{un}init_perm_bits(). Could we use a simple atomic reference
> > counter on those to potentially share them so they get initialized by
> > the first caller and freed by the last user, at least in the case of
> > both drivers being compiled statically into the kernel?  Thanks,  
> 
> Sure, I can add it. The two modules will still share the cap_perms and
> ecap_perms config bits when built statically in kernel. However, I think
> such share is reasonable. I'll check if any other similar bits in other files.
> 
> > Alex  
> 
> Thanks for the suggestions, Alex. Let me prepare another RFC.

Thank Yi, I appreciate your work on this.  Also, I wonder if we might
want to reconsider placing this driver in samples, the Makefile might
be a little bit ugly with paths back to drivers/vfio/pci, but I don't
think we run into the same barriers as you did with previous
approaches.  Placing it in samples would at least alleviate any
confusion that this isn't a vfio-pci replacement, but more of an mdev
wrapper proof of concept.  Thanks,

Alex
