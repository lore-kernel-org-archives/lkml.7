Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C575FC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 949C72175B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbfDWOtJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 10:49:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57802 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbfDWOtI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 10:49:08 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EAFE210C6E;
        Tue, 23 Apr 2019 14:48:56 +0000 (UTC)
Received: from x1.home (ovpn-116-122.phx2.redhat.com [10.3.116.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 795CC5D6A9;
        Tue, 23 Apr 2019 14:48:52 +0000 (UTC)
Date:   Tue, 23 Apr 2019 08:48:52 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Cc:     Yan Zhao <yan.y.zhao@intel.com>,
        intel-gvt-dev@lists.freedesktop.org, cjia@nvidia.com,
        kvm@vger.kernel.org, aik@ozlabs.ru, Zhengxiao.zx@alibaba-inc.com,
        shuangtai.tst@alibaba-inc.com, qemu-devel@nongnu.org,
        kwankhede@nvidia.com, eauger@redhat.com, yi.l.liu@intel.com,
        eskultet@redhat.com, ziye.yang@intel.com, mlevitsk@redhat.com,
        pasic@linux.ibm.com, libvir-list@redhat.com,
        arei.gonglei@huawei.com, felipe@nutanix.com, Ken.Xue@amd.com,
        kevin.tian@intel.com, dgilbert@redhat.com, zhenyuw@linux.intel.com,
        changpeng.liu@intel.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, zhi.a.wang@intel.com,
        jonathan.davies@nutanix.com, shaopeng.he@intel.com
Subject: Re: [Qemu-devel] [PATCH 1/2] vfio/mdev: add version field as
 mandatory attribute for mdev device
Message-ID: <20190423084852.62168bb2@x1.home>
In-Reply-To: <20190423134400.GL6022@redhat.com>
References: <20190419083258.19580-1-yan.y.zhao@intel.com>
        <20190419083505.19654-1-yan.y.zhao@intel.com>
        <20190423103939.GF6022@redhat.com>
        <20190423063540.7ec83c31@x1.home>
        <20190423134400.GL6022@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Tue, 23 Apr 2019 14:49:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Apr 2019 14:44:00 +0100
Daniel P. Berrangé <berrange@redhat.com> wrote:

> On Tue, Apr 23, 2019 at 06:35:40AM -0600, Alex Williamson wrote:
> > On Tue, 23 Apr 2019 11:39:39 +0100
> > Daniel P. Berrangé <berrange@redhat.com> wrote:
> >   
> > > On Fri, Apr 19, 2019 at 04:35:04AM -0400, Yan Zhao wrote:  
> > > > +* version
> > > > +
> > > > +  This attribute is rw. It is used to check whether two devices are compatible
> > > > +  for live migration. If this attribute is missing, then the corresponding mdev
> > > > +  device is regarded as not supporting live migration.
> > > > +
> > > > +  It consists of two parts: common part and vendor proprietary part.
> > > > +  common part: 32 bit. lower 16 bits is vendor id and higher 16 bits identifies
> > > > +               device type. e.g., for pci device, it is
> > > > +               "pci vendor id" | (VFIO_DEVICE_FLAGS_PCI << 16).
> > > > +  vendor proprietary part: this part is varied in length. vendor driver can
> > > > +               specify any string to identify a device.
> > > > +
> > > > +  When reading this attribute, it should show device version string of the device
> > > > +  of type <type-id>. If a device does not support live migration, it should
> > > > +  return errno.
> > > > +  When writing a string to this attribute, it returns errno for incompatibility
> > > > +  or returns written string length in compatibility case. If a device does not
> > > > +  support live migration, it always returns errno.
> > > > +
> > > > +  for example.
> > > > +  # cat \
> > > > + /sys/bus/pci/devices/0000\:00\:02.0/mdev_supported_types/i915-GVTg_V5_2/version
> > > > +  00028086-193b-i915-GVTg_V5_2
> > > > +
> > > > +  #echo 00028086-193b-i915-GVTg_V5_2 > \
> > > > + /sys/bus/pci/devices/0000\:00\:02.0/mdev_supported_types/i915-GVTg_V5_4/version
> > > > + -bash: echo: write error: Invalid argument
> > > > +    
> > > 
> > > IIUC this path is against the physical device. IOW, the mgmt app would have
> > > to first write to the "version" file to choose a version, and then write to
> > > the "create" file to actually create an virtual device. This has the obvious
> > > concurrency problem if multiple devices are being created at the same time
> > > and distinct versions for each device are required. There would need to be
> > > a locking scheme defined to ensure safety.  
> > 
> > "Create a device of a given version" is not an intended feature of this
> > interface aiui.  Writing the version attribute only indicates
> > migration compatibility with a binary result.
> >    
> > > Wouldn't it be better if we can pass the desired version when we write to
> > > the "create" file, so that we avoid any concurrent usage problems. "version"
> > > could be just a read-only file with a *list* of supported versions.
> > > 
> > > eg
> > > 
> > >   $ cat /sys/bus/pci/devices/0000\:00\:02.0/mdev_supported_types/i915-GVTg_V5_4/version
> > >   5.0
> > >   5.1
> > >   5.2
> > > 
> > >   $ echo "83b8f4f2-509f-382f-3c1e-e6bfe0fa1001;version=5.2" >
> > >       /sys/devices/virtual/mtty/mtty/mdev_supported_types/mtty-2/create  
> > 
> > This is reminiscent of the proposed aggregation support, but again,
> > this sort of feature is not intended here.  It's no expected that any
> > vendor driver would support creating device types of different
> > versions, but they may support migration from different versions.  
> 
> Hmm, that's a subtle distinction I wasn't seeing the patch series.
> IIUC from what you're saying, a device can be created with version
> "C", but for an incoming migration it can (potentially) accept
> serialized state matching any of versions "A", "B" or "C".
> 
> That is sufficient if migration is being used as a host upgrade
> tool, to move from OS release N to N + 1.
> 
> It wouldn't cover the case where you need to support backwards
> migration too. eg if you have a mixture of hosts with release
> N and N + 1 and want to make sure that VMs can always move
> betweeen any host.  That would require that you can create
> mdevs with the lowest common denominator version, not solely
> the most recent.
> 
> In QEMU this is done by mgmt applications picking a versioned
> machine type for QEMU that is older than most recent.

I suppose we'd need to determine how important that is, this is just a
device after all, there are always fallback mechanisms via hotplug.
There are a lot of pieces that need to line up for backwards migration
including support for it at the individual vendor driver.  Nothing we
design into the API is going to require vendor drivers to support
backwards migration and we already have some vendors requiring host and
guest driver alignment.  Specifying a version with a create syntax as
you've provided is reasonable, but this also balloons into whole
tangential interface providing information regarding what versions a
vendor driver is able to create, because presumably management tools
wouldn't prefer a try-and-see type interface.  I believe an intentional
aspect of the proposal here is that we don't need to provide a list of
compatible versions, that's handled internally to the vendor driver.

I don't know if we could start with the proposal here and later add
these sorts of features.  Ideas?  Thanks,

Alex
