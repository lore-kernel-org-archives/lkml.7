Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D00C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 10:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29AA92089F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 10:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oa4cttyr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfKUKFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 05:05:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32548 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726980AbfKUKFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 05:05:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574330717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mTbZEMwYfOT6jDofWQMm684EqH0d5BOVG5EfNCsfnNw=;
        b=Oa4cttyrC5mPFyptLYSY8E3nanDLM6FfEKVK1AIRnaqjzm75FWc7+44hc/Liwvp2pCpH7S
        YC2h2LO4CqqIrV6eEEdJquT/yFQCAHI9s+9uM043dRRzwHwbkyCMxuqz4vaQ0kb9NXPcjc
        J4E9hrDWilcdHEjYtZUdzpRqm4lb/DE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-Y80XKPkaO8uAJhIl728Y6w-1; Thu, 21 Nov 2019 05:05:14 -0500
Received: by mail-wr1-f69.google.com with SMTP id z10so1821611wrr.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 02:05:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WjBe/bpFfR8YjJaRZQ403Que5OIq9zts89mo41qWm30=;
        b=U4kbwevrzKBRGGbvMlEcGZYkMQ3EZoE7eWrIYaFL4R+lsMZnMyG7n51uWM9/pkK949
         gA18lB/aamHTdNeMfhxOfrt20Wt4cfwk0Y2G3NfTlRIP0ML7uddz62av5odQ95sIu/Sz
         jnx1VVua+xARGYgN1HNSi3WklRDBCbp2LBpRETLhxYpj8NlazMz4AqNm205RL7Wi00zj
         qzFQu4HF11i3/2X3+EyrR0nMlA0YiE5I9e4DyxFEe9Vc/oHruHt+UBJ1xEYF64iXC+l7
         SYI+uTuIhVcVzDXdMfva5yNBuW6hQxcs06DU2IzXEx/yAyvZj70LMXU4iGBNQlgxyI3I
         LdXQ==
X-Gm-Message-State: APjAAAWMdI4dKfKUkqW+Dm+h+uuJNVt0ZGmrUa6kCFdhKtqIq1RqZBH2
        hOr2BeFKT9PQqgLS1gtfpqcaBKEvIGezkkDskt7wSH664xZWFAyvCw51HKtk79jD01rG1Rz58Y4
        3XyHtIH+i2f9nf8iWY4B7Of5T
X-Received: by 2002:a1c:7d16:: with SMTP id y22mr8565192wmc.106.1574330713222;
        Thu, 21 Nov 2019 02:05:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqyOlfVU/bWpGIHnKv57s8kK3m5vYZ/Pt8KTmBF8V0SJrqfD//MnSWSTdrBYEv5kqItZozpMBg==
X-Received: by 2002:a1c:7d16:: with SMTP id y22mr8565167wmc.106.1574330712947;
        Thu, 21 Nov 2019 02:05:12 -0800 (PST)
Received: from steredhat (a-nu5-32.tin.it. [212.216.181.31])
        by smtp.gmail.com with ESMTPSA id 17sm2273656wmg.19.2019.11.21.02.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 02:05:12 -0800 (PST)
Date:   Thu, 21 Nov 2019 11:05:10 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Stefan Hajnoczi <stefanha@gmail.com>
Cc:     netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
        Dexuan Cui <decui@microsoft.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jorgen Hansen <jhansen@vmware.com>
Subject: Re: [PATCH net-next 0/6] vsock: add local transport support
Message-ID: <20191121100510.7gdcx7c3qom2f3wo@steredhat>
References: <20191119110121.14480-1-sgarzare@redhat.com>
 <20191121094643.GD439743@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20191121094643.GD439743@stefanha-x1.localdomain>
X-MC-Unique: Y80XKPkaO8uAJhIl728Y6w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 09:46:43AM +0000, Stefan Hajnoczi wrote:
> On Tue, Nov 19, 2019 at 12:01:15PM +0100, Stefano Garzarella wrote:
> > This series introduces a new transport (vsock_loopback) to handle
> > local communication.
> > This could be useful to test vsock core itself and to allow developers
> > to test their applications without launching a VM.
> >=20
> > Before this series, vmci and virtio transports allowed this behavior,
> > but only in the guest.
> > We are moving the loopback handling in a new transport, because it
> > might be useful to provide this feature also in the host or when
> > no H2G/G2H transports (hyperv, virtio, vmci) are loaded.
> >=20
> > The user can use the loopback with the new VMADDR_CID_LOCAL (that
> > replaces VMADDR_CID_RESERVED) in any condition.
> > Otherwise, if the G2H transport is loaded, it can also use the guest
> > local CID as previously supported by vmci and virtio transports.
> > If G2H transport is not loaded, the user can also use VMADDR_CID_HOST
> > for local communication.
> >=20
> > Patch 1 is a cleanup to build virtio_transport_common without virtio
> > Patch 2 adds the new VMADDR_CID_LOCAL, replacing VMADDR_CID_RESERVED
> > Patch 3 adds a new feature flag to register a loopback transport
> > Patch 4 adds the new vsock_loopback transport based on the loopback
> >         implementation of virtio_transport
> > Patch 5 implements the logic to use the local transport for loopback
> >         communication
> > Patch 6 removes the loopback from virtio_transport
> >=20
> > @Jorgen: Do you think it might be a problem to replace
> > VMADDR_CID_RESERVED with VMADDR_CID_LOCAL?
> >=20
> > Thanks,
> > Stefano
> >=20
> > Stefano Garzarella (6):
> >   vsock/virtio_transport_common: remove unused virtio header includes
> >   vsock: add VMADDR_CID_LOCAL definition
> >   vsock: add local transport support in the vsock core
> >   vsock: add vsock_loopback transport
> >   vsock: use local transport when it is loaded
> >   vsock/virtio: remove loopback handling
> >=20
> >  MAINTAINERS                             |   1 +
> >  include/net/af_vsock.h                  |   2 +
> >  include/uapi/linux/vm_sockets.h         |   8 +-
> >  net/vmw_vsock/Kconfig                   |  12 ++
> >  net/vmw_vsock/Makefile                  |   1 +
> >  net/vmw_vsock/af_vsock.c                |  49 +++++-
> >  net/vmw_vsock/virtio_transport.c        |  61 +------
> >  net/vmw_vsock/virtio_transport_common.c |   3 -
> >  net/vmw_vsock/vmci_transport.c          |   2 +-
> >  net/vmw_vsock/vsock_loopback.c          | 217 ++++++++++++++++++++++++
> >  10 files changed, 283 insertions(+), 73 deletions(-)
> >  create mode 100644 net/vmw_vsock/vsock_loopback.c
>=20
> Please see my comments.  Otherwise:
>=20
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Thanks!
I'll send a v2 following your comments.

Stefano

