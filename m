Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7DBC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 04:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62F3C218DA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 04:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="MCiHozPL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728700AbfDXENr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 00:13:47 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:15354 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbfDXENq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 00:13:46 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cbfe2750000>; Tue, 23 Apr 2019 21:13:41 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 23 Apr 2019 21:13:44 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 23 Apr 2019 21:13:44 -0700
Received: from nvidia.com (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 24 Apr
 2019 04:13:43 +0000
Date:   Tue, 23 Apr 2019 21:13:41 -0700
From:   Neo Jia <cjia@nvidia.com>
To:     Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
CC:     Yan Zhao <yan.y.zhao@intel.com>,
        <intel-gvt-dev@lists.freedesktop.org>, <kvm@vger.kernel.org>,
        <aik@ozlabs.ru>, <Zhengxiao.zx@alibaba-inc.com>,
        <shuangtai.tst@alibaba-inc.com>, <qemu-devel@nongnu.org>,
        <kwankhede@nvidia.com>, <eauger@redhat.com>, <yi.l.liu@intel.com>,
        <eskultet@redhat.com>, <ziye.yang@intel.com>,
        <mlevitsk@redhat.com>, <pasic@linux.ibm.com>,
        <libvir-list@redhat.com>, <arei.gonglei@huawei.com>,
        <felipe@nutanix.com>, <Ken.Xue@amd.com>, <kevin.tian@intel.com>,
        <dgilbert@redhat.com>, <zhenyuw@linux.intel.com>,
        <alex.williamson@redhat.com>, <changpeng.liu@intel.com>,
        <cohuck@redhat.com>, <linux-kernel@vger.kernel.org>,
        <zhi.a.wang@intel.com>, <jonathan.davies@nutanix.com>,
        <shaopeng.he@intel.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] vfio/mdev: add version field as
 mandatory attribute for mdev device
Message-ID: <20190424041340.GA5498@nvidia.com>
References: <20190419083258.19580-1-yan.y.zhao@intel.com>
 <20190419083505.19654-1-yan.y.zhao@intel.com>
 <20190423103939.GF6022@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190423103939.GF6022@redhat.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1556079221; bh=m8gOn2B1g2bQ591PhvROeRFRvKnk6OyIOZF3JB4dA64=;
        h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:References:
         MIME-Version:Content-Type:Content-Disposition:
         Content-Transfer-Encoding:In-Reply-To:X-NVConfidentiality:
         User-Agent:X-Originating-IP:X-ClientProxiedBy;
        b=MCiHozPLhh5n80paDMb5cxXglbdstr725AkzgNoSPz0yqUWr0PbulY0dR5taIXz9m
         vfa9WTKHJ4ZzC//47RK+NT8uZsD0uaQ6+9ZGMFLUfFZJ3FUO/XOLRH3RKXJ3nPvDlF
         TH4ssSjg1MrWuJ01l7V2/5VtzWX0EsvTlqpk9/2jP7cI5La+yiRUD/z2Ah6o3QDVyF
         fgtGeXLmtOJRtw7X1D3ZhuD793nroEhYmqmFBooPtHu4Vc/lnwTbiSecx+5qzW/Ad3
         0JbLnjYLcWtyxzkkKMA/XW45EjocUPA6muujevEnoVMje6/oy3Ip52cuM1L9e7Iei3
         3eRnHhseUgjgA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 11:39:39AM +0100, Daniel P. Berrang=E9 wrote:
> On Fri, Apr 19, 2019 at 04:35:04AM -0400, Yan Zhao wrote:
> > device version attribute in mdev sysfs is used by user space software
> > (e.g. libvirt) to query device compatibility for live migration of VFIO
> > mdev devices. This attribute is mandatory if a mdev device supports liv=
e
> > migration.
> >=20
> > It consists of two parts: common part and vendor proprietary part.
> > common part: 32 bit. lower 16 bits is vendor id and higher 16 bits
> >              identifies device type. e.g., for pci device, it is
> >              "pci vendor id" | (VFIO_DEVICE_FLAGS_PCI << 16).
> > vendor proprietary part: this part is varied in length. vendor driver c=
an
> >              specify any string to identify a device.
> >=20
> > When reading this attribute, it should show device version string of th=
e
> > device of type <type-id>. If a device does not support live migration, =
it
> > should return errno.
> > When writing a string to this attribute, it returns errno for
> > incompatibility or returns written string length in compatibility case.
> > If a device does not support live migration, it always returns errno.
> >=20
> > For user space software to use:
> > 1.
> > Before starting live migration, user space software first reads source =
side
> > mdev device's version. e.g.
> > "#cat \
> > /sys/bus/pci/devices/0000\:00\:02.0/5ac1fb20-2bbf-4842-bb7e-36c58c3be9c=
d/mdev_type/version"
> > 00028086-193b-i915-GVTg_V5_4
> >=20
> > 2.
> > Then, user space software writes the source side returned version strin=
g
> > to device version attribute in target side, and checks the return value=
.
> > If a negative errno is returned in the target side, then mdev devices i=
n
> > source and target sides are not compatible;
> > If a positive number is returned and it equals to the length of written
> > string, then the two mdev devices in source and target side are compati=
ble.
> > e.g.
> > (a) compatibility case
> > "# echo 00028086-193b-i915-GVTg_V5_4 >
> > /sys/bus/pci/devices/0000\:00\:02.0/882cc4da-dede-11e7-9180-078a62063ab=
1/mdev_type/version"
> >=20
> > (b) incompatibility case
> > "#echo 00028086-193b-i915-GVTg_V5_1 >
> > /sys/bus/pci/devices/0000\:00\:02.0/882cc4da-dede-11e7-9180-078a62063ab=
1/mdev_type/version"
> > -bash: echo: write error: Invalid argument
>=20
> What you have written here seems to imply that each mdev type is able to
> support many different versions at the same time. Writing a version into
> this sysfs file then chooses which of the many versions to actually use.
>=20
> This is good as it allows for live migration across driver software upgra=
des.
>=20
> A mgmt application may well want to know what versions are supported for =
an
> mdev type *before* starting a migration. A mgmt app can query all the 100=
's
> of hosts it knows and thus figure out which are valid to use as the targe=
t
> of a migration.
>=20
> IOW, we want to avoid the ever hitting the incompatibility case in the
> first place, by only choosing to migrate to a host that we know is going
> to be compatible.
>=20
> This would need some kind of way to report the full list of supported
> versions against the mdev supported types on the host.

What would be the typical scenario / use case for mgmt layer to query the v=
ersion
information? Do they expect this get done completely offline as long as the
vendor driver installed on each host?

Thanks,
Neo

>=20
>=20
