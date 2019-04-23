Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F0EBC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 12:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4380204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 12:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbfDWMfr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 08:35:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40546 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726033AbfDWMfr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 08:35:47 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0714D309E972;
        Tue, 23 Apr 2019 12:35:46 +0000 (UTC)
Received: from x1.home (ovpn-116-122.phx2.redhat.com [10.3.116.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6E46D5D9D4;
        Tue, 23 Apr 2019 12:35:41 +0000 (UTC)
Date:   Tue, 23 Apr 2019 06:35:40 -0600
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
Message-ID: <20190423063540.7ec83c31@x1.home>
In-Reply-To: <20190423103939.GF6022@redhat.com>
References: <20190419083258.19580-1-yan.y.zhao@intel.com>
        <20190419083505.19654-1-yan.y.zhao@intel.com>
        <20190423103939.GF6022@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Tue, 23 Apr 2019 12:35:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Apr 2019 11:39:39 +0100
Daniel P. Berrangé <berrange@redhat.com> wrote:

> On Fri, Apr 19, 2019 at 04:35:04AM -0400, Yan Zhao wrote:
> > device version attribute in mdev sysfs is used by user space software
> > (e.g. libvirt) to query device compatibility for live migration of VFIO
> > mdev devices. This attribute is mandatory if a mdev device supports live
> > migration.
> > 
> > It consists of two parts: common part and vendor proprietary part.
> > common part: 32 bit. lower 16 bits is vendor id and higher 16 bits
> >              identifies device type. e.g., for pci device, it is
> >              "pci vendor id" | (VFIO_DEVICE_FLAGS_PCI << 16).
> > vendor proprietary part: this part is varied in length. vendor driver can
> >              specify any string to identify a device.
> > 
> > When reading this attribute, it should show device version string of the
> > device of type <type-id>. If a device does not support live migration, it
> > should return errno.
> > When writing a string to this attribute, it returns errno for
> > incompatibility or returns written string length in compatibility case.
> > If a device does not support live migration, it always returns errno.
> > 
> > For user space software to use:
> > 1.
> > Before starting live migration, user space software first reads source side
> > mdev device's version. e.g.
> > "#cat \
> > /sys/bus/pci/devices/0000\:00\:02.0/5ac1fb20-2bbf-4842-bb7e-36c58c3be9cd/mdev_type/version"
> > 00028086-193b-i915-GVTg_V5_4
> > 
> > 2.
> > Then, user space software writes the source side returned version string
> > to device version attribute in target side, and checks the return value.
> > If a negative errno is returned in the target side, then mdev devices in
> > source and target sides are not compatible;
> > If a positive number is returned and it equals to the length of written
> > string, then the two mdev devices in source and target side are compatible.
> > e.g.
> > (a) compatibility case
> > "# echo 00028086-193b-i915-GVTg_V5_4 >
> > /sys/bus/pci/devices/0000\:00\:02.0/882cc4da-dede-11e7-9180-078a62063ab1/mdev_type/version"
> > 
> > (b) incompatibility case
> > "#echo 00028086-193b-i915-GVTg_V5_1 >
> > /sys/bus/pci/devices/0000\:00\:02.0/882cc4da-dede-11e7-9180-078a62063ab1/mdev_type/version"
> > -bash: echo: write error: Invalid argument  
> 
> What you have written here seems to imply that each mdev type is able to
> support many different versions at the same time. Writing a version into
> this sysfs file then chooses which of the many versions to actually use.

That's not actually what's being proposed here, reading the version
attribute provides an opaque string.  Writing the version attribute
from a different system reports whether that version string is
compatible for migration.  IOW, we're not creating a device of a given
version, we're only reporting if that version is compatible with this
mdev.  The version is intentionally opaque to allow vendor specific
nuances, therefore it's rather impractical create the sort of version
list requested below.

> This is good as it allows for live migration across driver software upgrades.
> 
> A mgmt application may well want to know what versions are supported for an
> mdev type *before* starting a migration. A mgmt app can query all the 100's
> of hosts it knows and thus figure out which are valid to use as the target
> of a migration.
> 
> IOW, we want to avoid the ever hitting the incompatibility case in the
> first place, by only choosing to migrate to a host that we know is going
> to be compatible.

This is provided, the migration source reports a version string which
can be queried against the version attribute on other hosts to insure
compatibility prior to migration.

> This would need some kind of way to report the full list of supported
> versions against the mdev supported types on the host.

This is not provided, matching versions are vendor specific.

> > 3. if two mdev devices are compatible, user space software can start
> > live migration, and vice versa.
> > 
> > Note: if a mdev device does not support live migration, it either does
> > not provide a version attribute, or always returns errno when its version
> > attribute is read/written.
> > 
> > Cc: Alex Williamson <alex.williamson@redhat.com>
> > Cc: Erik Skultety <eskultet@redhat.com>
> > Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > Cc: Cornelia Huck <cohuck@redhat.com>
> > Cc: "Tian, Kevin" <kevin.tian@intel.com>
> > Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
> > Cc: "Wang, Zhi A" <zhi.a.wang@intel.com>
> > Cc: Neo Jia <cjia@nvidia.com>
> > Cc: Kirti Wankhede <kwankhede@nvidia.com>
> > 
> > Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> > ---
> >  Documentation/vfio-mediated-device.txt | 36 ++++++++++++++++++++++++++
> >  samples/vfio-mdev/mbochs.c             | 17 ++++++++++++
> >  samples/vfio-mdev/mdpy.c               | 16 ++++++++++++
> >  samples/vfio-mdev/mtty.c               | 16 ++++++++++++
> >  4 files changed, 85 insertions(+)
> > 
> > diff --git a/Documentation/vfio-mediated-device.txt b/Documentation/vfio-mediated-device.txt
> > index c3f69bcaf96e..bc28471c0667 100644
> > --- a/Documentation/vfio-mediated-device.txt
> > +++ b/Documentation/vfio-mediated-device.txt
> > @@ -202,6 +202,7 @@ Directories and files under the sysfs for Each Physical Device
> >    |     |   |--- available_instances
> >    |     |   |--- device_api
> >    |     |   |--- description
> > +  |     |   |--- version
> >    |     |   |--- [devices]
> >    |     |--- [<type-id>]
> >    |     |   |--- create
> > @@ -209,6 +210,7 @@ Directories and files under the sysfs for Each Physical Device
> >    |     |   |--- available_instances
> >    |     |   |--- device_api
> >    |     |   |--- description
> > +  |     |   |--- version
> >    |     |   |--- [devices]
> >    |     |--- [<type-id>]
> >    |          |--- create
> > @@ -216,6 +218,7 @@ Directories and files under the sysfs for Each Physical Device
> >    |          |--- available_instances
> >    |          |--- device_api
> >    |          |--- description
> > +  |          |--- version
> >    |          |--- [devices]
> >  
> >  * [mdev_supported_types]
> > @@ -225,6 +228,8 @@ Directories and files under the sysfs for Each Physical Device
> >    [<type-id>], device_api, and available_instances are mandatory attributes
> >    that should be provided by vendor driver.
> >  
> > +  version is a mandatory attribute if a mdev device supports live migration.
> > +
> >  * [<type-id>]
> >  
> >    The [<type-id>] name is created by adding the device driver string as a prefix
> > @@ -246,6 +251,35 @@ Directories and files under the sysfs for Each Physical Device
> >    This attribute should show the number of devices of type <type-id> that can be
> >    created.
> >  
> > +* version
> > +
> > +  This attribute is rw. It is used to check whether two devices are compatible
> > +  for live migration. If this attribute is missing, then the corresponding mdev
> > +  device is regarded as not supporting live migration.
> > +
> > +  It consists of two parts: common part and vendor proprietary part.
> > +  common part: 32 bit. lower 16 bits is vendor id and higher 16 bits identifies
> > +               device type. e.g., for pci device, it is
> > +               "pci vendor id" | (VFIO_DEVICE_FLAGS_PCI << 16).
> > +  vendor proprietary part: this part is varied in length. vendor driver can
> > +               specify any string to identify a device.
> > +
> > +  When reading this attribute, it should show device version string of the device
> > +  of type <type-id>. If a device does not support live migration, it should
> > +  return errno.
> > +  When writing a string to this attribute, it returns errno for incompatibility
> > +  or returns written string length in compatibility case. If a device does not
> > +  support live migration, it always returns errno.
> > +
> > +  for example.
> > +  # cat \
> > + /sys/bus/pci/devices/0000\:00\:02.0/mdev_supported_types/i915-GVTg_V5_2/version
> > +  00028086-193b-i915-GVTg_V5_2
> > +
> > +  #echo 00028086-193b-i915-GVTg_V5_2 > \
> > + /sys/bus/pci/devices/0000\:00\:02.0/mdev_supported_types/i915-GVTg_V5_4/version
> > + -bash: echo: write error: Invalid argument
> > +  
> 
> IIUC this path is against the physical device. IOW, the mgmt app would have
> to first write to the "version" file to choose a version, and then write to
> the "create" file to actually create an virtual device. This has the obvious
> concurrency problem if multiple devices are being created at the same time
> and distinct versions for each device are required. There would need to be
> a locking scheme defined to ensure safety.

"Create a device of a given version" is not an intended feature of this
interface aiui.  Writing the version attribute only indicates
migration compatibility with a binary result.
 
> Wouldn't it be better if we can pass the desired version when we write to
> the "create" file, so that we avoid any concurrent usage problems. "version"
> could be just a read-only file with a *list* of supported versions.
> 
> eg
> 
>   $ cat /sys/bus/pci/devices/0000\:00\:02.0/mdev_supported_types/i915-GVTg_V5_4/version
>   5.0
>   5.1
>   5.2
> 
>   $ echo "83b8f4f2-509f-382f-3c1e-e6bfe0fa1001;version=5.2" >
>       /sys/devices/virtual/mtty/mtty/mdev_supported_types/mtty-2/create

This is reminiscent of the proposed aggregation support, but again,
this sort of feature is not intended here.  It's no expected that any
vendor driver would support creating device types of different
versions, but they may support migration from different versions.
Thanks,

Alex
