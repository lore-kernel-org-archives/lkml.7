Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB08C432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 11:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4954206EC
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 11:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O9dKum7v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfLCLRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 06:17:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37438 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725838AbfLCLRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 06:17:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575371865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P0GMfVL6QAezA2eT0aIWQXB/37RirCO0eO2hEzXqpFM=;
        b=O9dKum7vkL8dVJMmve/y9xUu0wNattDpykPmBD3fGAPOK7Vvr3zNPYLe2/ro8twfAzEmnW
        0Yy84525heIb58o2is1qhgMJ2jUkrCDoWvuNi8x4tKlfd0qmoHQegRB1h9Gnuc/9uMvBJp
        t/CIrb987YCigXbQLDih1He5KkiBW84=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-136-sPdpSmqxOi6gF-qvWx7x_Q-1; Tue, 03 Dec 2019 06:17:44 -0500
Received: by mail-wr1-f70.google.com with SMTP id c17so1603440wrp.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 03:17:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8m7nF4w29pgZQB4V/SdwIROmAwTn+h+KHeQv4HnXE8M=;
        b=Vuh0ROmaznBXuqELeKSp3jDnQqMEKEZ72k3LA2FTGCjx1jfdnmyOc1KCgkQm5rRzAs
         oqFMJglwfu9OP6IkYbQPzUhHK6FOy8rSos+Uhmu3/Y6ffKOjWAP5ySPSApFy9rTyb2nB
         QVd1kAJO79j1WfpXmf6Cp2VhDuL8KMcuvDJrPI3jwuexDbwteAz4rU8QGsYEYzlQI0E0
         EWnfMfB4wYIZuxxpNTswKAlcp+m4+Hy+WXZGWE6KlTFDdFZerkJhTy5cxVrRu/PLiZxV
         EqF1CQB5aEZeJsVQLuQZ3WGwwppLbsqmcZM6kOudHKZ0H82j8o8bc4viyX3cYspGMWzt
         AUuQ==
X-Gm-Message-State: APjAAAWWkA0eJRbq7IfzznPHSnShaaA3GK4YQXU7+BdHSvzOZY0gSC2z
        Hl/A8JCUcumG4Dv09mHm6GRoRpUMlnUx8NiENbxaXssgkOH8Iqju51CO1ehIfSmPsSJmoCz6e1e
        aPXxSxWZgqg6PAhTqyPLTMogE
X-Received: by 2002:a5d:49c7:: with SMTP id t7mr4444068wrs.369.1575371862857;
        Tue, 03 Dec 2019 03:17:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqxHsfuHbTjkQH8eviKJ48+Nlp7C/1JLX3I4FiWaDe4+xpQuoyOM0/YkQJewOzX/cskP8i9LEw==
X-Received: by 2002:a5d:49c7:: with SMTP id t7mr4444037wrs.369.1575371862537;
        Tue, 03 Dec 2019 03:17:42 -0800 (PST)
Received: from steredhat (host28-88-dynamic.16-87-r.retail.telecomitalia.it. [87.16.88.28])
        by smtp.gmail.com with ESMTPSA id p17sm3209682wrx.20.2019.12.03.03.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 03:17:41 -0800 (PST)
Date:   Tue, 3 Dec 2019 12:17:39 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Stefan Hajnoczi <stefanha@gmail.com>
Cc:     netdev@vger.kernel.org, linux-hyperv@vger.kernel.org,
        kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
        Dexuan Cui <decui@microsoft.com>, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jorgen Hansen <jhansen@vmware.com>
Subject: Re: [RFC PATCH 0/3] vsock: support network namespace
Message-ID: <20191203111739.jbxptcpmvtwg7j2g@steredhat>
References: <20191128171519.203979-1-sgarzare@redhat.com>
 <20191203092649.GB153510@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20191203092649.GB153510@stefanha-x1.localdomain>
X-MC-Unique: sPdpSmqxOi6gF-qvWx7x_Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2019 at 09:26:49AM +0000, Stefan Hajnoczi wrote:
> On Thu, Nov 28, 2019 at 06:15:16PM +0100, Stefano Garzarella wrote:
> > Hi,
> > now that we have multi-transport upstream, I started to take a look to
> > support network namespace (netns) in vsock.
> >=20
> > As we partially discussed in the multi-transport proposal [1], it could
> > be nice to support network namespace in vsock to reach the following
> > goals:
> > - isolate host applications from guest applications using the same port=
s
> >   with CID_ANY
> > - assign the same CID of VMs running in different network namespaces
> > - partition VMs between VMMs or at finer granularity
> >=20
> > This preliminary implementation provides the following behavior:
> > - packets received from the host (received by G2H transports) are
> >   assigned to the default netns (init_net)
> > - packets received from the guest (received by H2G - vhost-vsock) are
> >   assigned to the netns of the process that opens /dev/vhost-vsock
> >   (usually the VMM, qemu in my tests, opens the /dev/vhost-vsock)
> >     - for vmci I need some suggestions, because I don't know how to do
> >       and test the same in the vmci driver, for now vmci uses the
> >       init_net
> > - loopback packets are exchanged only in the same netns
> >=20
> > Questions:
> > 1. Should we make configurable the netns (now it is init_net) where
> >    packets from the host should be delivered?
>=20
> Yes, it should be possible to have multiple G2H (e.g. virtio-vsock)
> devices and to assign them to different net namespaces.  Something like
> net/core/dev.c:dev_change_net_namespace() will eventually be needed.
>=20

Make sense, but for now we support only one G2H.
How we can provide this feature to the userspace?
Should we interface vsock with ip-link(8)?

I don't know if initially we can provide through sysfs a way to set the
netns of the only G2H loaded.

> > 2. Should we provide an ioctl in vhost-vsock to configure the netns
> >    to use? (instead of using the netns of the process that opens
> >    /dev/vhost-vsock)
>=20
> Creating the vhost-vsock instance in the process' net namespace makes
> sense.  Maybe wait for a use case before adding an ioctl.
>=20

Agree.

> > 3. Should we provide a way to disable the netns support in vsock?
>=20
> The code should follow CONFIG_NET_NS semantics.  I'm not sure what they
> are exactly since struct net is always defined, regardless of whether
> network namespaces are enabled.

I think that if CONFIG_NET_NS is not defined, all sockets and processes
are assigned to init_net and this RFC should work in this case, but I'll
try this case before v1.

I was thinking about the Kata's use case, I don't know if they launch the
VM in a netns and even the runtime in the host runs inside the same netns.

I'll send an e-mail to kata mailing list.

Thanks,
Stefano

