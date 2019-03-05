Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A362C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 22:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4E2720652
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 22:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="IjZerOJv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbfCEWjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 17:39:49 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:12595 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfCEWjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 17:39:49 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c7efaab0000>; Tue, 05 Mar 2019 14:39:39 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 05 Mar 2019 14:39:47 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 05 Mar 2019 14:39:47 -0800
Received: from [10.24.71.26] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 5 Mar
 2019 22:39:42 +0000
Subject: Re: [RFC net-next 0/8] Introducing subdev bus and devlink extension
To:     Parav Pandit <parav@mellanox.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>
CC:     Or Gerlitz <gerlitz.or@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "michal.lkml@markovi.net" <michal.lkml@markovi.net>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Jiri Pirko <jiri@mellanox.com>
References: <1551418672-12822-1-git-send-email-parav@mellanox.com>
 <20190301120358.7970f0ad@cakuba.netronome.com>
 <VI1PR0501MB227107F2EB29C7462DEE3637D1710@VI1PR0501MB2271.eurprd05.prod.outlook.com>
 <20190304173529.59aef2b3@cakuba.netronome.com>
 <VI1PR0501MB227144934A3FE9460D6970E5D1720@VI1PR0501MB2271.eurprd05.prod.outlook.com>
X-Nvconfidentiality: public
From:   Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <54d846bc-cfa5-6665-efcb-a6c85e87763b@nvidia.com>
Date:   Wed, 6 Mar 2019 04:09:30 +0530
MIME-Version: 1.0
In-Reply-To: <VI1PR0501MB227144934A3FE9460D6970E5D1720@VI1PR0501MB2271.eurprd05.prod.outlook.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1551825579; bh=tGRvUrQkjtix9q7pLP+Qhdz95+68jxuY79IWoeTR1hk=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=IjZerOJvLCsKfQlj7JdYIaXMdYzgE9gX5pumiEW9jEPvip8CA7zl/payZsZjjI+zq
         rviTCXHC/RSMUak87ZCBWXGCTZ/WxlPyNlQbpzkSn8NGTzaB5ef3FpcZ65BjNcsKOt
         bfOPXn4l3HK8fC3oqh/eMT68icR6mc9+tfV9m1RnJzt2Yfl+hrOVgoinI7ApfQTQeZ
         tLpqlOscJvitGBnWBOltApcl2gWoKIn68bX4EkXvBEITuajcsoHq5MOURe5RiVajwo
         KZWpqJR9OZymAeYRUNs8a6u7SKfXnFfPjUQa4dOzQ5s+R0mzlwKj/H0CUTh0MS0Mog
         B7enaRemGcdtg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/6/2019 1:16 AM, Parav Pandit wrote:
> 
> 
>> -----Original Message-----
>> From: Jakub Kicinski <jakub.kicinski@netronome.com>
>> Sent: Monday, March 4, 2019 7:35 PM
>> To: Parav Pandit <parav@mellanox.com>
>> Cc: Or Gerlitz <gerlitz.or@gmail.com>; netdev@vger.kernel.org; linux-
>> kernel@vger.kernel.org; michal.lkml@markovi.net; davem@davemloft.net;
>> gregkh@linuxfoundation.org; Jiri Pirko <jiri@mellanox.com>
>> Subject: Re: [RFC net-next 0/8] Introducing subdev bus and devlink extension
>>
>> Parav, please wrap your responses to at most 80 characters.
>> This is hard to read.
>>
> Sorry about it. I will wrap now on.
> 
>> On Mon, 4 Mar 2019 04:41:01 +0000, Parav Pandit wrote:
>>>> -----Original Message-----
>>>> From: Jakub Kicinski <jakub.kicinski@netronome.com>
>>>> Sent: Friday, March 1, 2019 2:04 PM
>>>> To: Parav Pandit <parav@mellanox.com>; Or Gerlitz
>>>> <gerlitz.or@gmail.com>
>>>> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
>>>> michal.lkml@markovi.net; davem@davemloft.net;
>>>> gregkh@linuxfoundation.org; Jiri Pirko <jiri@mellanox.com>
>>>> Subject: Re: [RFC net-next 0/8] Introducing subdev bus and devlink
>>>> extension
>>>>
>>>> On Thu, 28 Feb 2019 23:37:44 -0600, Parav Pandit wrote:
>>>>> Requirements for above use cases:
>>>>> --------------------------------
>>>>> 1. We need a generic user interface & core APIs to create sub
>>>>> devices from a parent pci device but should be generic enough for
>>>>> other parent devices 2. Interface should be vendor agnostic 3.
>>>>> User should be able to set device params at creation time 4. In
>>>>> future if needed, tool should be able to create passthrough device
>>>>> to map to a virtual machine
>>>>
>>>> Like a mediated device?
>>>
>>> Yes.
>>>
>>>> https://www.kernel.org/doc/Documentation/vfio-mediated-device.txt
>>>> https://www.dpdk.org/wp-content/uploads/sites/35/2018/06/Mediated-
>>>> Devices-Better-Userland-IO.pdf
>>>>
>>>> Other than pass-through it is entirely unclear to me why you'd need a
>> bus.
>>>> (Or should I say VM pass through or DPDK?)  Could you clarify why
>>>> the need for a bus?
>>>>
>>> A bus follow standard linux kernel device driver model to attach a
>>> driver to specific device. Platform device with my limited
>>> understanding looks a hack/abuse of it based on documentation [1], but
>>> it can possibly be an alternative to bus if it looks fine to Greg and
>>> others.
>>
>> I grok from this text that the main advantage you see is the ability to choose
>> a driver for the subdevice.
>>
> Yes.
> 
>>>> My thinking is that we should allow spawning subports in devlink and
>>>> if user specifies "passthrough" the device spawned would be an mdev.
>>>
>>> devlink device is much more comprehensive way to create sub-devices
>>> than sub-ports for at least below reasons.
>>>
>>> 1. devlink device already defines device->port relation which enables
>>> to create multiport device.
>>
>> I presume that by devlink device you mean devlink instance?  Yes, this part
>> I'm following.
>>
> Yes -> 'struct devlink' 
>>> subport breaks that.
>>
>> Breaks what?  The ability to create a devlink instance with multiple ports?
>>
> Right.
> 
>>> 2. With bus model, it enables us to load driver of same vendor or
>>> generic one such a vfio in future.
>>

You can achieve this with mdev as well.

>> Yes, sorry, I'm not an expert on mdevs, but isn't that the goal of those?
>> Could you go into more detail why not just use mdevs?
>>
> I am novice at mdev level too. mdev or vfio mdev.
> Currently by default we bind to same vendor driver, but when it was created as passthrough device, vendor driver won't create netdevice or rdma device for it.
> And vfio/mdev or whatever mature available driver would bind at that point.
> 

Using mdev framework, if you want to partition a physical device into
multiple logic devices, you can bind those devices to same vendor driver
through vfio-mdev, where as if you want to passthrough the device bind
it to vfio-pci. If I understand correctly, that is what you are looking for.


>>> 3. Devices live on the bus, mapping a subport to 'struct device' is
>>> not intuitive.
>>
>> Are you saying that the main devlink instance would not have any port
>> information for the subdevices?
>>
> Right, this newly created devlink device is the control point of its port(s).
> 
>> Devices live on a bus.  Software constructs - depend on how one wants to
>> model them - don't have to.
>>
>>> 4. sub-device allows to use existing devlink port, registers, health
>>> infrastructure to sub devices, which otherwise need to be duplicated
>>> for ports.
>>
>> Health stuff is not tied to a port, I'm not following you.  You can create a
>> reporter per port, per ACL rule or per SB or per whatever your heart desires..
>>
> Instead of creating multiple reporters and inventing these reporter naming schemes,
> creating devlink instance leverage all health reporting done for a devliink instance.
> So whatever is done for instance A (parent), can be available for instance B (subdev).
> 
>>> 5. Even though current devlink devices are networking devices, there
>>> is nothing restricts it to be that way. So subport is a restricted
>>> view.
>>> 6. devlink device already covers
>>> port sub-object, hence creating devlink device is desired.
>>>
>>>>> 5. A device can have multiple ports
>>>>
>>>> What does this mean, in practice?  You want to spawn a subdev which
>>>> can access both ports?  That'd be for RDMA use cases, more than
>>>> Ethernet, right?  (Just clarifying :))
>>>>
>>> Yep, you got it right. :-)
>>>
>>>>> So how is it done?
>>>>> ------------------
>>>>> (a) user in control
>>>>> To address above requirements, a generic tool iproute2/devlink is
>>>>> extended for sub device's life cycle.
>>>>> However a devlink tool and its kernel counter part is not
>>>>> sufficient to create protocol agnostic devices on a existing PCI
>>>>> bus.
>>>>
>>>> "Protocol agnostic"?...  What does that mean?
>>>>
>>> Devlink works on bus,device model. It doesn't matter what class of
>>> device is. For example, for pci class can be anything. So newly
>>> created sub-devices are not limited to netdev/rdma devices. Its
>>> agnostic to protocol. More importantly, we don't want to create these
>>> sub-devices who bus type is 'pci'. Because as described below, PCI has
>>> its addressing scheme and pci bus must not have mix-n match devices.
>>>
>>> So probably better wording should be,
>>> 'a devlink tool and its kernel counterpart is not sufficient to create
>>> sub-devices of same class as that of PCI device.
>>
>> Let me clarify - for networking devices the partition will most likely end up as
>> a subport, but its not a requirement that each partition must be a subport..
>> The question was about the necessity to invent a new bus, and have every
>> resource have a struct device..
>>
> 
> A device object and bus connecting all software objects correctly. This includes,
> 1. devlink bus/name handle based access
> 2. matching such device in sysfs
> 3. parent child hierarchy in sysfs
> 4. ability to bind different driver
> 5. multi-ports per device
> 6. still usable for single port use case
> 7. parameters setting at devlink instance level
> 8. parent-child relation handling power mgmt
> 9. follows standard linux driver model
> 
> Some are achievable to through mfd too, instead of subdev bus.
> Will follow Greg's guidance on this.
> 

I think you can achieve all the above points with mdev framework as
well. Check samples at samples/vfio-mdev/ in kernel for quick
understanding.

Thanks,
Kirti
