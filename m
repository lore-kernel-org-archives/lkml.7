Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB9CC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 350CD20674
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbfDWO5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 10:57:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43466 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727695AbfDWO5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 10:57:30 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D344F30BC665;
        Tue, 23 Apr 2019 14:57:29 +0000 (UTC)
Received: from redhat.com (ovpn-112-50.ams2.redhat.com [10.36.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 130C361B77;
        Tue, 23 Apr 2019 14:57:11 +0000 (UTC)
Date:   Tue, 23 Apr 2019 15:57:08 +0100
From:   Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To:     Alex Williamson <alex.williamson@redhat.com>
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
Message-ID: <20190423145708.GP6022@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190419083258.19580-1-yan.y.zhao@intel.com>
 <20190419083505.19654-1-yan.y.zhao@intel.com>
 <20190423103939.GF6022@redhat.com>
 <20190423063540.7ec83c31@x1.home>
 <20190423134400.GL6022@redhat.com>
 <20190423084852.62168bb2@x1.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190423084852.62168bb2@x1.home>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 23 Apr 2019 14:57:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 08:48:52AM -0600, Alex Williamson wrote:
> On Tue, 23 Apr 2019 14:44:00 +0100
> Daniel P. Berrangé <berrange@redhat.com> wrote:
> 
> > On Tue, Apr 23, 2019 at 06:35:40AM -0600, Alex Williamson wrote:
> > > On Tue, 23 Apr 2019 11:39:39 +0100
> > > Daniel P. Berrangé <berrange@redhat.com> wrote:
> > >   
> > > > On Fri, Apr 19, 2019 at 04:35:04AM -0400, Yan Zhao wrote:  
> > > > > +* version
> > > > > +
> > > > > +  This attribute is rw. It is used to check whether two devices are compatible
> > > > > +  for live migration. If this attribute is missing, then the corresponding mdev
> > > > > +  device is regarded as not supporting live migration.
> > > > > +
> > > > > +  It consists of two parts: common part and vendor proprietary part.
> > > > > +  common part: 32 bit. lower 16 bits is vendor id and higher 16 bits identifies
> > > > > +               device type. e.g., for pci device, it is
> > > > > +               "pci vendor id" | (VFIO_DEVICE_FLAGS_PCI << 16).
> > > > > +  vendor proprietary part: this part is varied in length. vendor driver can
> > > > > +               specify any string to identify a device.
> > > > > +
> > > > > +  When reading this attribute, it should show device version string of the device
> > > > > +  of type <type-id>. If a device does not support live migration, it should
> > > > > +  return errno.
> > > > > +  When writing a string to this attribute, it returns errno for incompatibility
> > > > > +  or returns written string length in compatibility case. If a device does not
> > > > > +  support live migration, it always returns errno.
> > > > > +
> > > > > +  for example.
> > > > > +  # cat \
> > > > > + /sys/bus/pci/devices/0000\:00\:02.0/mdev_supported_types/i915-GVTg_V5_2/version
> > > > > +  00028086-193b-i915-GVTg_V5_2
> > > > > +
> > > > > +  #echo 00028086-193b-i915-GVTg_V5_2 > \
> > > > > + /sys/bus/pci/devices/0000\:00\:02.0/mdev_supported_types/i915-GVTg_V5_4/version
> > > > > + -bash: echo: write error: Invalid argument
> > > > > +    
> > > > 
> > > > IIUC this path is against the physical device. IOW, the mgmt app would have
> > > > to first write to the "version" file to choose a version, and then write to
> > > > the "create" file to actually create an virtual device. This has the obvious
> > > > concurrency problem if multiple devices are being created at the same time
> > > > and distinct versions for each device are required. There would need to be
> > > > a locking scheme defined to ensure safety.  
> > > 
> > > "Create a device of a given version" is not an intended feature of this
> > > interface aiui.  Writing the version attribute only indicates
> > > migration compatibility with a binary result.
> > >    
> > > > Wouldn't it be better if we can pass the desired version when we write to
> > > > the "create" file, so that we avoid any concurrent usage problems. "version"
> > > > could be just a read-only file with a *list* of supported versions.
> > > > 
> > > > eg
> > > > 
> > > >   $ cat /sys/bus/pci/devices/0000\:00\:02.0/mdev_supported_types/i915-GVTg_V5_4/version
> > > >   5.0
> > > >   5.1
> > > >   5.2
> > > > 
> > > >   $ echo "83b8f4f2-509f-382f-3c1e-e6bfe0fa1001;version=5.2" >
> > > >       /sys/devices/virtual/mtty/mtty/mdev_supported_types/mtty-2/create  
> > > 
> > > This is reminiscent of the proposed aggregation support, but again,
> > > this sort of feature is not intended here.  It's no expected that any
> > > vendor driver would support creating device types of different
> > > versions, but they may support migration from different versions.  
> > 
> > Hmm, that's a subtle distinction I wasn't seeing the patch series.
> > IIUC from what you're saying, a device can be created with version
> > "C", but for an incoming migration it can (potentially) accept
> > serialized state matching any of versions "A", "B" or "C".
> > 
> > That is sufficient if migration is being used as a host upgrade
> > tool, to move from OS release N to N + 1.
> > 
> > It wouldn't cover the case where you need to support backwards
> > migration too. eg if you have a mixture of hosts with release
> > N and N + 1 and want to make sure that VMs can always move
> > betweeen any host.  That would require that you can create
> > mdevs with the lowest common denominator version, not solely
> > the most recent.
> > 
> > In QEMU this is done by mgmt applications picking a versioned
> > machine type for QEMU that is older than most recent.
> 
> I suppose we'd need to determine how important that is, this is just a
> device after all, there are always fallback mechanisms via hotplug.
> There are a lot of pieces that need to line up for backwards migration
> including support for it at the individual vendor driver.  Nothing we
> design into the API is going to require vendor drivers to support
> backwards migration and we already have some vendors requiring host and
> guest driver alignment.  Specifying a version with a create syntax as
> you've provided is reasonable, but this also balloons into whole
> tangential interface providing information regarding what versions a
> vendor driver is able to create, because presumably management tools
> wouldn't prefer a try-and-see type interface.  I believe an intentional
> aspect of the proposal here is that we don't need to provide a list of
> compatible versions, that's handled internally to the vendor driver.

Worse is that multi-versions backwards migration also balloons the
testing matrix which is particularly time consuming.

To be clear I'm /not/ saying that multi-versions backwards migration
is a must-have. I just want to be sure we understand the limitations
of what's proposed and that we're happy with them.

Certainly forwards migration is the really big win here.

Backwards migration is more of a nice-to-have and only worth doing if
we expect people are willing to actually do enough testing to make
it reliable. Claiming to support backwards migration and then
never testing it works is even worse than not supporting it, because
it will be a rarely exercised code path comparatively speaking, so
easy to bit-rot if not well tested.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
