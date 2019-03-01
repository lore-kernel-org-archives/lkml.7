Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A92C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 20:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BB4920848
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 20:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="H+fCQB9u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbfCAUEI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 15:04:08 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42736 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfCAUEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 15:04:08 -0500
Received: by mail-qt1-f196.google.com with SMTP id u7so20042295qtg.9
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 12:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=H19RJOt6TXUfkPwmURpIfl1nQSOcFVfBOQmJTt4ITno=;
        b=H+fCQB9uQPZ05MKmaluGCBlNtRXIW203kQQrjBiCyiGcMvulhpiZDxKiJptkf/BkzP
         uqnj6RXKyaSrfrTBVnMYayaLR7P5El6DvIs6hdAUk5iWr5Bekd++lFGe7dSGH0VoAcnx
         kmOeJDbImtyH22ab1nZOe1pEfCIzBOm9yZI46s1yBIoZ/q3tj1m6mKTSA4yiM7dqwDSC
         qlGKsz/eFoYKTBD4YdwJjCwS2Is2lnL8J4lNFxP7ORUnmxMAfkyA028Chk3VeDCovsIv
         CXG17rz405Es2ng1YuUvCOCnFwywBbgjEruBsG8ovd0i0cd7tRX5lrR2hGrKmwfUaaj+
         7ZNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=H19RJOt6TXUfkPwmURpIfl1nQSOcFVfBOQmJTt4ITno=;
        b=nUmJ9VWMakl/9JWDQWN8RfQ1TLsswMIDwocuf98nGDESVYlDDY86/C7fklLbiEEnlH
         Ef1H069FKmTDdKakij9uY26sCxMNxux1VVvloRCCD1x+J8OP8TU/GiGSfXucLRjEMZyG
         TqcxxW2kUvHyzvRhjNKt8B7zl99BNKCDsxXzcYm0nGfuZH/WnphpmzjH2GTg5lo+Ukqu
         oAOLviR9ncoE34Mkc72evcfVXzCVhs4A0ZDMlc/bGSJwImtx7PjcJ4mqU+LuyYOnwCko
         rp8L0oX5hS1CdvQXSaIOdFAxf7Ff4Mp3zCFw0M5B7QtlzXepbLgQx1qK+zlqV5WRO2lE
         uBNQ==
X-Gm-Message-State: APjAAAX18zNq6de/6kYAyf4Ho7b0G2AAxm8C0KFDdlyp+0Wb7Rrn2bNz
        EleMUnF7MCRWukzzPEvYgP7gKg==
X-Google-Smtp-Source: APXvYqxNNoVAethC6OGiAphSs4vbZrA10YotQTUs5ySVaZZLW9EE/kuFao+0wrGhe+yoJcJ4fvotVw==
X-Received: by 2002:a0c:e703:: with SMTP id d3mr5370624qvn.47.1551470646972;
        Fri, 01 Mar 2019 12:04:06 -0800 (PST)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id q2sm11296915qtp.1.2019.03.01.12.04.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Mar 2019 12:04:06 -0800 (PST)
Date:   Fri, 1 Mar 2019 12:03:58 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Parav Pandit <parav@mellanox.com>,
        Or Gerlitz <gerlitz.or@gmail.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        michal.lkml@markovi.net, davem@davemloft.net,
        gregkh@linuxfoundation.org, jiri@mellanox.com
Subject: Re: [RFC net-next 0/8] Introducing subdev bus and devlink extension
Message-ID: <20190301120358.7970f0ad@cakuba.netronome.com>
In-Reply-To: <1551418672-12822-1-git-send-email-parav@mellanox.com>
References: <1551418672-12822-1-git-send-email-parav@mellanox.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Feb 2019 23:37:44 -0600, Parav Pandit wrote:
> Use case:
> ---------
> A user wants to create/delete hardware linked sub devices without
> using SR-IOV.
> These devices for a pci device can be netdev (optional rdma device)
> or other devices. Such sub devices share some of the PCI device
> resources and also have their own dedicated resources.
> 
> Few examples are:
> 1. netdev having its own txq(s), rq(s) and/or hw offload parameters.
> 2. netdev with switchdev mode using netdev representor
> 3. rdma device with IB link layer and IPoIB netdev
> 4. rdma/RoCE device and a netdev
> 5. rdma device with multiple ports
> 
> Requirements for above use cases:
> --------------------------------
> 1. We need a generic user interface & core APIs to create sub devices
> from a parent pci device but should be generic enough for other parent
> devices
> 2. Interface should be vendor agnostic
> 3. User should be able to set device params at creation time
> 4. In future if needed, tool should be able to create passthrough
> device to map to a virtual machine

Like a mediated device?

https://www.kernel.org/doc/Documentation/vfio-mediated-device.txt
https://www.dpdk.org/wp-content/uploads/sites/35/2018/06/Mediated-Devices-Better-Userland-IO.pdf

Other than pass-through it is entirely unclear to me why you'd need 
a bus.  (Or should I say VM pass through or DPDK?)  Could you clarify
why the need for a bus?

My thinking is that we should allow spawning subports in devlink and 
if user specifies "passthrough" the device spawned would be an mdev.

> 5. A device can have multiple ports

What does this mean, in practice?  You want to spawn a subdev which can
access both ports?  That'd be for RDMA use cases, more than Ethernet,
right?  (Just clarifying :))

> 6. An orchestration software wants to know how many such sub devices
> can be created from a parent device so that it can manage them in global
> cluster resources.
> 
> So how is it done?
> ------------------
> (a) user in control
> To address above requirements, a generic tool iproute2/devlink is
> extended for sub device's life cycle.
> However a devlink tool and its kernel counter part is not sufficient
> to create protocol agnostic devices on a existing PCI bus.

"Protocol agnostic"?...  What does that mean?

> (b) subdev bus
> A given bus defines well defined addressing scheme. Creating sub devices
> on existing PCI bus with a different naming scheme is just weird.
> So, creating well named devices on appropriate bus is desired.

What's that address scheme you're referring to, you seem to assign IDs
in sequence?

> Hence a new 'subdev' bus is created.
> User adds/removes new sub devices subdev on this bus via a devlink tool.
> devlink tool instructs hardware driver to create/remove/configure
> such devices. Hardware vendor driver places devices on the bus.
> Another or same vendor driver matches based on vendor-id, device-id
> scheme and run through classic device driver model.
> 
> Given that, these are user created devices for a given hardware and in
> absence of a central entity like PCISIG to assign vendor and device ids,
> A unique vendor and device id are maintained as enum in
> include/linux/subdev_ids.h.

Why do we need IDs?  The sysfs hierarchy isn't sufficient?  Do we need
a driver to match on those again?  Is it going to be a different driver?

> subdev bus device names follow default device naming scheme of Linux
> kernel. It is done as 'subdev<instance_id>' such as, subdev0, subdev3.
> 
> subdev device inherits its parent's DMA parameters.
> subdev will follow rich power management infrastructure of core kernel/
> So that every vendor driver doesn't have to iterate over its child
> devices, invent a locking and device anchoring scheme.
> 
> Patchset summary:
> -----------------
> Patch-1, 2 introduces a subdev bus and interface for subdev life cycle.
> Patch-3 extends modpost tool for module device id table.
> Patch-4,5,6 implements a devlink vendor driver to add/remove devices.
> Patch-7 mlx5 driver implements subdev devices and places them on subdev
> bus. 
> Patch-8 match against the subdev for mlx5 vendor, device id and creates
> fake netdevice.
> 
> All patches are only a reference implementation to see RFC in works
> at devlink, sysfs and device model level. Once RFC looks good, more
> solid upstreamable version of the implementation will be done.
> All patches are functional except the last two patches, which just
> create fake subdev devices and fake netdevice.
> 
> System example view:
> --------------------
> 
> $ devlink dev show
> pci/0000:05:00.0
> 
> $ devlink dev add pci/0000:05:00.0

That does not look great.  

Also you have to return the id of the spawned device, otherwise this 
is very racy.

> $ devlink dev show
> pci/0000:05:00.0
> subdev/subdev0

Please don't spawn devlink instances.  Devlink instance is supposed to
represent an ASIC.  If we start spawning them willy nilly for whatever
software construct we want to model the clarity of the ontology will
suffer a lot.

Please see the discussion on my recent patchset.  I think Jiri CCed you.

> sysfs view with subdev:
> 
> $ ls -l /sys/bus/pci/devices/0000:05:00.0
> [..]
> drwxr-xr-x 3 root root        0 Feb 13 15:57 infiniband
> -rw-r--r-- 1 root root     4096 Feb 13 15:57 msi_bus
> drwxr-xr-x 3 root root        0 Feb 13 15:57 net
> drwxr-xr-x 2 root root        0 Feb 13 15:57 power
> drwxr-xr-x 3 root root        0 Feb 13 15:57 ptp
> drwxr-xr-x 4 root root        0 Feb 13 15:57 subdev0
> 
> $ ls -l /sys/bus/pci/devices/0000:05:00.0/subdev0
> lrwxrwxrwx 1 root root    0 Feb 13 15:58 driver -> ../../../../../bus/subdev/drivers/mlx5_core
> drwxr-xr-x 3 root root    0 Feb 13 15:58 net
> drwxr-xr-x 2 root root    0 Feb 13 15:58 power
> lrwxrwxrwx 1 root root    0 Feb 13 15:58 subsystem -> ../../../../../bus/subdev
> -rw-r--r-- 1 root root 4096 Feb 13 15:58 uevent
> 
> $ ls -l /sys/bus/pci/devices/0000:05:00.0/subdev0/net/
> drwxr-xr-x 5 root root 0 Feb 13 15:58 eth0
> 
> Software view:
> -------------
> Some of you if you prefer to see in picture, below diagram tries to
> show software modules in bus/device hierarchy.
> 
> devlink user (iproute2/devlink)
> ------------------------------
>          |
>          |
>   +----------------+
>   | devlink module |
>   |         doit() |     +------------------+
>   |            |   |     |   vendor driver  |
>   +------------|---+     |   (mlx5)         |
>                ----------+-> subdev_ops()   |
>                          +|-----------------+
>                           |
>                 +---------|--+  +-----------+  +------------------+
>                 | subdev bus |  | core      |  | subdev device    |
>                 | driver     |  | kernel    |  | drivers          |
>                 | (add/del)  |  | dev model |  | (netdev, rdma)   |
>                 |       ----------------------> probe/remove()    |
>                 +------------+  +-----------+  +------------------+
> 
> Alternatives considered:
> ------------------------
> Will discuss separately if needed to keep this RFC short.

Please do discuss.

The things key thing for me on the netdev side is what is the
forwarding model to this new entity.  Is this basically VMDQ?  
Should we just go ahead and mandate "switchdev mode" here?

Thanks for working on a common architecture and suffering through
people's reviews rather than adding a debugfs interface that does 
this like a different vendor did :)
