Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8EB5C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 20:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFA7720675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 20:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbfCGUjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 15:39:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34754 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbfCGUjg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 15:39:36 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5C073307E042;
        Thu,  7 Mar 2019 20:39:36 +0000 (UTC)
Received: from w520.home (ovpn-116-24.phx2.redhat.com [10.3.116.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 675E95D783;
        Thu,  7 Mar 2019 20:39:33 +0000 (UTC)
Date:   Thu, 7 Mar 2019 13:39:31 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     "Liu, Yi L" <yi.l.liu@intel.com>
Cc:     kwankhede@nvidia.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, joro@8bytes.org,
        jean-philippe.brucker@arm.com, peterx@redhat.com,
        linux-kernel@vger.kernel.org, yi.y.sun@intel.com
Subject: Re: [RFC v1 0/2] vfio/pci: wrap pci device as mdev with vfio-pci
 driver
Message-ID: <20190307133931.58ce6f4c@w520.home>
In-Reply-To: <1551617881-8520-1-git-send-email-yi.l.liu@intel.com>
References: <1551617881-8520-1-git-send-email-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 07 Mar 2019 20:39:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  3 Mar 2019 20:57:59 +0800
"Liu, Yi L" <yi.l.liu@intel.com> wrote:

> This patchset aims to add a vfio-pci-like meta driver on existing
> PCI devices, as a demo user of the vfio changes introduced in
> "vfio/mdev: IOMMU aware mediated device" patchset from Baolu Lu.
> 
> To build such a meta driver. We have two choices.
> a) add a vfio-pci alike sample driver under samples directory
> b) add some extensions in vfio-pci driver to make it wrap pci
>    device as mdev
> 
> For choice a), the new sample driver will have quite a few
> duplicated code with vfio-pci driver since the new sample
> driver also wants to virtualize the PCI config space. So
> this choice may bring in extra maintain effort in kernel
> and also looks strange since there will be a bunch of
> duplicated code with vfio-pci driver.
> 
> For choice b), it may reuse the existing vfio-pci driver
> by adding a new working mode. With this mode, user can wrap
> a pci device as a mediated device by binding it with the
> vfio-pci driver which works in the new mode. Thus can be used
> to verify the ""vfio/mdev: IOMMU aware mediated device"
> patchset.
> 
> This patchset is following choice b). However, we are open on
> the direction of the implementation of this vfio-pci-like meta
> driver. Pls feel free give your suggestions.

Thanks for doing this Yi!  Rather than a module option for vfio-pci,
what about having this build into a separate module (ex.
vfio-pci-mdev)?  Then we could test "regular" vfio-pci along side mdev
wrapped devices simply by which driver we bind and it'd probably be more
friendly to existing users, like libvirt.  This might also make a good
base driver for experimenting with device specific mdev migration as
well.  Thanks,

Alex
