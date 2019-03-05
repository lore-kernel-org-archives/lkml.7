Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E06C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 01:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56881206DD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 01:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="xK2lpDJV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbfCEBfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 20:35:39 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40252 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfCEBfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 20:35:38 -0500
Received: by mail-qt1-f194.google.com with SMTP id j36so7378060qta.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 17:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=KGTBU0vBCAOZEPvdR3JH6R+KAxb7IVUoQQZT2/2HP3w=;
        b=xK2lpDJVRPX5hZp7ZFJGm2F15dyHW2RFfzALFHQL/MxcUpT0OiMS+tS+K8OBL0J8mB
         20i+LkGLRqeGsnQfHVD5nvEHYh4RBzUP8u43pCTYYHYxecTtCGv6BZcfGY1R9ZX4ba0k
         KjIKNq9WEnd/J3L/5kt+U6yIt76Oi9N9jZtPIsXBK+mE9P4Ra+RmLDkhRCg5zLemWpMP
         OXpxYKpAQFrd9p9uVHi0OTDdJ0MNL3pXrQNUWBSdcecG60UtrejDIQD1rdu6QHiaH7S1
         D0iI43SFFUe0LSZmf3WnVrnep4i9yKGUQm3k8AMDwNvd5x5SpZ5VtKjpqF4o3Pi+6UWK
         m89w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=KGTBU0vBCAOZEPvdR3JH6R+KAxb7IVUoQQZT2/2HP3w=;
        b=EJKh0Aadr9r4/GpqYHMdKU9OI11NK6ia/M5d8jj5fhMuLAcNSc2oQsz3q0903wn7cm
         COob7/BmCP1Z6prX9LLIr+RGIboomqThKuRqR9r8K+6HiRs0lOHLHJoTJ0NhG8+MmW/1
         t2ruy1XvhE+V49mrXH+/nFN7Xlvbm/jk5lppJWwIw/dHRK7Dw3UMvn+dAR1IRiKRt+/+
         srrvXb3LyHHoPXtif7HAyIC3MYORK3YoJAeL056AanTOq7gYhgJvU/AZM9y3clcdnXbC
         K2/y5HrJ2klXjre4Eb8zeNljIXk+HmOtGUkB5xDMv5fyBOPZs4pK5oGTq2qYeNQNwgUc
         JHbQ==
X-Gm-Message-State: APjAAAVSmQwLeET4ofF8FgZL/vYQBk5ZKWk0wGYpQOb8SzYAN//jpVhw
        F/4n7bpvgqSHF/kHoiYMvGnoeg==
X-Google-Smtp-Source: APXvYqwseb3mbgypknfSmFLtTfxPAHzMNpaj7zPZJuHix0QAV5zQMsb73eMmA4bX/3yYNVjpNAu8Qg==
X-Received: by 2002:a0c:9ae5:: with SMTP id k37mr269942qvf.128.1551749736911;
        Mon, 04 Mar 2019 17:35:36 -0800 (PST)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id v22sm5211081qtb.72.2019.03.04.17.35.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Mar 2019 17:35:36 -0800 (PST)
Date:   Mon, 4 Mar 2019 17:35:29 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Parav Pandit <parav@mellanox.com>
Cc:     Or Gerlitz <gerlitz.or@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "michal.lkml@markovi.net" <michal.lkml@markovi.net>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Jiri Pirko <jiri@mellanox.com>
Subject: Re: [RFC net-next 0/8] Introducing subdev bus and devlink extension
Message-ID: <20190304173529.59aef2b3@cakuba.netronome.com>
In-Reply-To: <VI1PR0501MB227107F2EB29C7462DEE3637D1710@VI1PR0501MB2271.eurprd05.prod.outlook.com>
References: <1551418672-12822-1-git-send-email-parav@mellanox.com>
        <20190301120358.7970f0ad@cakuba.netronome.com>
        <VI1PR0501MB227107F2EB29C7462DEE3637D1710@VI1PR0501MB2271.eurprd05.prod.outlook.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parav, please wrap your responses to at most 80 characters.
This is hard to read.

On Mon, 4 Mar 2019 04:41:01 +0000, Parav Pandit wrote:
> > -----Original Message-----
> > From: Jakub Kicinski <jakub.kicinski@netronome.com>
> > Sent: Friday, March 1, 2019 2:04 PM
> > To: Parav Pandit <parav@mellanox.com>; Or Gerlitz <gerlitz.or@gmail.com>
> > Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> > michal.lkml@markovi.net; davem@davemloft.net;
> > gregkh@linuxfoundation.org; Jiri Pirko <jiri@mellanox.com>
> > Subject: Re: [RFC net-next 0/8] Introducing subdev bus and devlink extension
> > 
> > On Thu, 28 Feb 2019 23:37:44 -0600, Parav Pandit wrote:  
> > > Requirements for above use cases:
> > > --------------------------------
> > > 1. We need a generic user interface & core APIs to create sub devices
> > > from a parent pci device but should be generic enough for other parent
> > > devices 2. Interface should be vendor agnostic 3. User should be able
> > > to set device params at creation time 4. In future if needed, tool
> > > should be able to create passthrough device to map to a virtual
> > > machine  
> > 
> > Like a mediated device?
> 
> Yes.
>  
> > https://www.kernel.org/doc/Documentation/vfio-mediated-device.txt
> > https://www.dpdk.org/wp-content/uploads/sites/35/2018/06/Mediated-
> > Devices-Better-Userland-IO.pdf
> > 
> > Other than pass-through it is entirely unclear to me why you'd need a bus.
> > (Or should I say VM pass through or DPDK?)  Could you clarify why the need
> > for a bus?
> >   
> A bus follow standard linux kernel device driver model to attach a
> driver to specific device. Platform device with my limited
> understanding looks a hack/abuse of it based on documentation [1],
> but it can possibly be an alternative to bus if it looks fine to Greg
> and others.

I grok from this text that the main advantage you see is the ability to
choose a driver for the subdevice.

> > My thinking is that we should allow spawning subports in devlink
> > and if user specifies "passthrough" the device spawned would be an
> > mdev. 
> 
> devlink device is much more comprehensive way to create sub-devices
> than sub-ports for at least below reasons.
>
> 1. devlink device already defines device->port relation which enables
> to create multiport device.

I presume that by devlink device you mean devlink instance?  Yes, this
part I'm following.

> subport breaks that.

Breaks what?  The ability to create a devlink instance with multiple
ports?

> 2. With bus model, it enables us to load driver of same vendor or
> generic one such a vfio in future.

Yes, sorry, I'm not an expert on mdevs, but isn't that the goal of
those?  Could you go into more detail why not just use mdevs?

> 3. Devices live on the bus, mapping a subport to 'struct device' is
> not intuitive. 

Are you saying that the main devlink instance would not have any port
information for the subdevices?

Devices live on a bus.  Software constructs - depend on how one wants
to model them - don't have to.

> 4. sub-device allows to use existing devlink port,
> registers, health infrastructure to sub devices, which otherwise need
> to be duplicated for ports. 

Health stuff is not tied to a port, I'm not following you.  You can
create a reporter per port, per ACL rule or per SB or per whatever your
heart desires..

> 5. Even though current devlink devices are networking devices, there
> is nothing restricts it to be that way. So subport is a restricted
> view. 
> 6. devlink device already covers
> port sub-object, hence creating devlink device is desired.
> 
> > > 5. A device can have multiple ports  
> > 
> > What does this mean, in practice?  You want to spawn a subdev which
> > can access both ports?  That'd be for RDMA use cases, more than
> > Ethernet, right?  (Just clarifying :))
> >  
> Yep, you got it right. :-)
>  
> > > So how is it done?
> > > ------------------
> > > (a) user in control
> > > To address above requirements, a generic tool iproute2/devlink is
> > > extended for sub device's life cycle.
> > > However a devlink tool and its kernel counter part is not
> > > sufficient to create protocol agnostic devices on a existing PCI
> > > bus.  
> > 
> > "Protocol agnostic"?...  What does that mean?
> >   
> Devlink works on bus,device model. It doesn't matter what class of
> device is. For example, for pci class can be anything. So newly
> created sub-devices are not limited to netdev/rdma devices. Its
> agnostic to protocol. More importantly, we don't want to create these
> sub-devices who bus type is 'pci'. Because as described below, PCI
> has its addressing scheme and pci bus must not have mix-n match
> devices.
> 
> So probably better wording should be,
> 'a devlink tool and its kernel counterpart is not sufficient to
> create sub-devices of same class as that of PCI device.

Let me clarify - for networking devices the partition will most likely
end up as a subport, but its not a requirement that each partition must
be a subport..  The question was about the necessity to invent a new
bus, and have every resource have a struct device..

> > > (b) subdev bus
> > > A given bus defines well defined addressing scheme. Creating sub
> > > devices on existing PCI bus with a different naming scheme is
> > > just weird. So, creating well named devices on appropriate bus is
> > > desired.  
> > 
> > What's that address scheme you're referring to, you seem to assign
> > IDs in sequence?
> >  
> Yes. a device on subdev bus follows standard linux driver model based
> id assignment scheme = u32. And devices are well named as 'subdev0'.
> Prefix + id as the default scheme of core driver model. 

I thought "well defined addressing scheme" means I can address
subdevice X of device Y with your scheme.  I can't, it's just an
global ID.  Thanks for clarifying.

> > > Given that, these are user created devices for a given hardware
> > > and in absence of a central entity like PCISIG to assign vendor
> > > and device ids, A unique vendor and device id are maintained as
> > > enum in include/linux/subdev_ids.h.  
> > 
> > Why do we need IDs?  The sysfs hierarchy isn't sufficient?    
> 
> > Do we need a driver to match on those again?  Is it going to be a
> > different driver? 
> IDs are used to match driver against the created device.
> It can be same or different driver.
> Even in same driver case, it provides a clear code separation for
> creating sub-devices and their respective one or more protocol
> devices (netdev, rep-netdev, rdma ..)
> 
> > > subdev bus device names follow default device naming scheme of
> > > Linux kernel. It is done as 'subdev<instance_id>' such as,
> > > subdev0, subdev3.
> > >
> > > System example view:
> > > --------------------
> > >
> > > $ devlink dev show
> > > pci/0000:05:00.0
> > >
> > > $ devlink dev add pci/0000:05:00.0  
> > 
> > That does not look great.
> >  
> Yes, It must return bus+device attributes in user output too
> Code in existing patchset returns it, it is not shown here.
> I will fix the cover-letter.
> 
> > Also you have to return the id of the spawned device, otherwise
> > this is very racy.
> >   
> Yes, that is correct. It must return an devlink device id =
> {bus+device} attr. I will update the example in v2.
> 
> > > $ devlink dev show
> > > pci/0000:05:00.0
> > > subdev/subdev0  
>
> > Please don't spawn devlink instances.  Devlink instance is supposed
> > to represent an ASIC.  If we start spawning them willy nilly for
> > whatever software construct we want to model the clarity of the
> > ontology will suffer a lot.  
> Devlink devices not restricted to ASIC even though today it is
> representing ASIC for one vendor. Today for one ASIC, it already
> presents multiple devlink devices (128 or more) for PF and VFs, two
> PFs on same ASIC etc. VF is just a sub-device which is well defined
> by PCISIG, whereas sub-device is not. Sub-device do consume actual
> ASIC resources (just like PFs and VFs), Hence point-(6) of
> cover-letter indicate that the devlink capability to tell how many
> such sub-devices can be created.
> 
> In above example, they are created for a given bus-device following
> existing devlink construct.
>
> > Please see the discussion on my recent patchset.  I think Jiri CCed
> > you. 
> I will review the discussion in short while after this reply, and
> provide comments.
> 
> > > Alternatives considered:
> > > ------------------------
> > > Will discuss separately if needed to keep this RFC short.  
> > 
> > Please do discuss.
> >  
> (a) subports instead of subdevices.
> We dropped this option because its two restrictive; I explained above
> the benefits of devlink device.
> 
> (b) extending iproute2/ip link and iproute2/rdma tools to creating
> sub-devices. But that is too limiting which doesn't provide all the
> features we get using devlink. It also doesn't address the
> passthrough needs and its just ugly to create and manage PCI level
> devices using high level tools like 'ip' and 'rdma'.
> 
> (c) creating platform device and platform driver instead of subdev bus
> Our understanding is that - platform device for this purpose would be
> an abuse/misuse, but our view is limited based on kernel
> documentation in [2]. [1] says "platform devices typically appear as
> autonomous entities" Sub-devices are well managed, created,
> configurable by user. Most things of [1] -> "Platform devices"
> section do not match with subdev.
> 
> Greg suggested to use mfd framework (wrapper to platform), which also
> needs extension. mfd_remove_devices() removes all the devices, while
> here based on user request, we want to add/remove individual device.
> Will wait if he is ok with subdev bus or he prefers to extend the
> platform documentation and mfd for removing individual devices.
> 
> (d) drivers/visorbus
> This bus is limited to UUID/GUID based naming scheme and very
> specific to s-Par standard and vendor. Additionally its guest drivers
> are living in staging for more than year. So it doesn't appear the
> right direction.
> 
> (e) creating subdev as child objects of devlink device (such as port,
> registers, health, etc). In this mode, a given devlink device has
> multiport child device which is anchored using 'struct device' and
> life cycled through devlink. Only difference with current proposal is
> it doesn't follow standard driver model to bind to other driver. It
> also doesn't show in unified way using devlink dev show.
> 
> So instead of these alternatives, devlink device that matches PF, VF,
> sub-device, + subdev bus seems better design. This follows all
> standard constructs of 1. Devlink, 2. Linux driver model. It is not
> limited to ports and generic enough for networking and not networking
> devices. 
> > The things key thing for me on the netdev side is what is the
> > forwarding model to this new entity.  Is this basically VMDQ?
> > Should we just go ahead and mandate "switchdev mode" here?
> >   
> It will follow the switchdev mode, but it not limited to it.
> Switchdev mode is for the eswitch functionality. There isn't a need
> to combine this. rdma Infiniband will be able to use this without
> switchdev mode.

It's the devlink instance that's in "switchdev mode", regardless of
type of any of its ports.

> > Thanks for working on a common architecture and suffering through
> > people's reviews rather than adding a debugfs interface that does
> > this like a different vendor did :)  
> Oh yes, lets not do debugfs.
> Thanks a lot Jakub for the review.
> This common architecture should be able to address such common needs.
> Please let me know if this needs more refinement, if I missed
> something.
> 
> [1] https://www.kernel.org/doc/Documentation/driver-model/platform.txt
> 

