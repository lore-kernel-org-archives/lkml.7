Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425EDC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 20:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F378220851
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 20:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="g8yVrIlQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbfCGUxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 15:53:47 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:15176 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbfCGUxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 15:53:46 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c8184d00001>; Thu, 07 Mar 2019 12:53:36 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 07 Mar 2019 12:53:45 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 07 Mar 2019 12:53:45 -0800
Received: from [10.24.71.26] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 7 Mar
 2019 20:53:41 +0000
Subject: Re: [RFC net-next 0/8] Introducing subdev bus and devlink extension
To:     Parav Pandit <parav@mellanox.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>
CC:     Or Gerlitz <gerlitz.or@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "michal.lkml@markovi.net" <michal.lkml@markovi.net>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Jiri Pirko <jiri@mellanox.com>,
        Alex Williamson <alex.williamson@redhat.com>
References: <1551418672-12822-1-git-send-email-parav@mellanox.com>
 <20190301120358.7970f0ad@cakuba.netronome.com>
 <VI1PR0501MB227107F2EB29C7462DEE3637D1710@VI1PR0501MB2271.eurprd05.prod.outlook.com>
 <20190304173529.59aef2b3@cakuba.netronome.com>
 <VI1PR0501MB227144934A3FE9460D6970E5D1720@VI1PR0501MB2271.eurprd05.prod.outlook.com>
 <54d846bc-cfa5-6665-efcb-a6c85e87763b@nvidia.com>
 <VI1PR0501MB2271962A3044DD29CE0E4C0CD1720@VI1PR0501MB2271.eurprd05.prod.outlook.com>
 <VI1PR0501MB2271A1E091538621F00B2433D1720@VI1PR0501MB2271.eurprd05.prod.outlook.com>
 <VI1PR0501MB227137E2040C23E255DAC4F3D1730@VI1PR0501MB2271.eurprd05.prod.outlook.com>
 <97d63e18-b151-8b35-6687-1dcf5216f08a@nvidia.com>
 <VI1PR0501MB22711C5925D09B9822382AC3D1730@VI1PR0501MB2271.eurprd05.prod.outlook.com>
 <9dbc644f-4e4c-7119-8f99-99850fc67b73@nvidia.com>
 <VI1PR0501MB227181D2B27A29BCD8F5342FD14C0@VI1PR0501MB2271.eurprd05.prod.outlook.com>
X-Nvconfidentiality: public
From:   Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <9e9b3e39-a649-a9cd-83cc-dab74cf77ac7@nvidia.com>
Date:   Fri, 8 Mar 2019 02:23:32 +0530
MIME-Version: 1.0
In-Reply-To: <VI1PR0501MB227181D2B27A29BCD8F5342FD14C0@VI1PR0501MB2271.eurprd05.prod.outlook.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1551992016; bh=zWaqecoLkYYJ+K9JyhEWKy7XU9W5e7jK4NfeoDSP1sw=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=g8yVrIlQcMiLHdjbDMwXkUbehk9uTPXvTIfsgwdl/uylv3qlj7WU9uWoSfm//A7q4
         l05oE2HOZlreQL4QZvCTN3GMsCdo4tZ2Rl6Ysfzg94sc70QNgWpcNee7/WK8+Fp5mN
         vcjaazzEXusbVIMa0+LWFvlPXX2Y6p6GhxkkEBpy46jA7elW7eKGEtnXvffHYxVK/r
         BTZbaKr+R1pb9hxOIv4PgjKecrAnG0fdiL1JBKTUHTcIiFzppTZDARcVKnqbvnikRw
         i8yeddGJnfg/4Rhs9J7b0k5XAXdslvfcCvFsj+8Z6oaN8f67gL0C+VJfZVB92gLmOO
         mjpSoAtUS3WuA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



<snip>

>>>
>>> Yes. I got my patches to adapt to mdev way. Will be posting RFC v2 soon.
>>> Will wait for a day to receive more comments/views from Greg and others.
>>>
>>> As I explained in this cover-letter and discussion, First use case is
>>> to create and use mdevs in the host (and not in VM).
>>> Later on, I am sure once we have mdevs available, VM users will likely use
>> it.
>>>
>>> So, mlx5_core driver will have two components as starting point.
>>>
>>> 1. drivers/net/ethernet/mellanox/mlx5/core/mdev/mdev.c
>>> This is mdev device life cycle driver which will do, mdev_register_device()
>> and implements mlx5_mdev_ops.
>>>
>> Ok. I would suggest not use mdev.c file name, may be add device name,
>> something like mlx_mdev.c or vfio_mlx.c
>>
> mlx5/core is coding convention is not following to prefix mlx to its 40+ files.
> 
> it uses actual subsystem or functionality name, such as,
> sriov.c
> eswitch.c
> fw.c
> en_tc.c (en for Ethernet)
> lag.c
> so,
> mdev.c aligns to rest of the 40+ files.
> 
> 
>>> 2. drivers/net/ethernet/mellanox/mlx5/core/mdev/mdev_driver.c
>>> This is mdev device driver which does mdev_register_driver() and
>>> probe() creates netdev by heavily reusing existing code of the PF device.
>>> These drivers will not be placed under drivers/vfio/mdev, because this is
>> not a vfio driver.
>>> This is fine, right?
>>>
>>
>> I'm not too familiar with netdev, but can you create netdev on open() call on
>> mlx mdev device? Then you don't have to write mdev device driver.
>>
> Who invokes open() and release()?
> I believe it is the qemu would do open(), release, read/write/mmap?
> 
> Assuming that is the case,
> I think its incorrect to create netdev in open.
> Because when we want to map the mdev to VM using above mdev calls, we actually wont be creating netdev in host.
> Instead, some queues etc will be setup as part of these calls.
> 
> By default this created mdev is bound to vfio_mdev.
> And once we unbind the device from this driver, we need to bind to mlx5 driver so that driver can create the netdev etc.
> 
> Or did I get open() and friends call wrong?
> 

In 'struct mdev_parent_ops' there are create() and remove(). When user
creates mdev device by writing UUID to create sysfs, vendor driver's
create() callback gets called. This should be used to allocate/commit
resources from parent device and on remove() callback free those
resources. So there is no need to bind mlx5 driver to that mdev device.

open/release/read/write/mmap/ioctl are regular file operations for that
mdev device.

Thanks,
Kirti

