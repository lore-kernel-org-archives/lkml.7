Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E68C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 09:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05CAB2073F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 09:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gNotrljL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbfKUJ7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 04:59:55 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41456 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726132AbfKUJ7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 04:59:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574330394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yt8HpiGqxds2OMjKtJNRUWY5kPKw9cLn1g1BZYhvSYU=;
        b=gNotrljLmTnc2ekzx/cz3kVuMKQgAp+26Bj9OUfUeljpnx/tJmBqV0ijTx89Y8Nvq4gYrT
        HYP8YI84Dd+LsTEkJKhqsY1p1vNrz3+BRAegHgjX5OPcEX/ymAa8+ImwCcj4w671hPeOg9
        kViWL+6yvRUT2TZyLXx2V0T07vicMOY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-D1daMzZaNkyBp0gqpmlf1g-1; Thu, 21 Nov 2019 04:59:53 -0500
Received: by mail-wr1-f69.google.com with SMTP id b2so405585wrj.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 01:59:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uJVUKucSDZy17F3anNizQDOnRpUUDTqYqO9jAnfMJpQ=;
        b=gnUelXqce73QhbqKGec4jIfF1ESloaOBAyVsaHdbVco227kWYvQjdIoklevJw0CaN9
         cpntYfHbgZAF8N/bJs6ZSIwn+1VztF4zo/6lidGG8ot34VvZtEQA3tP2cMW6F+nFmkT8
         rNyAmbEIh70yJM6QTL+6U0uuwcAnxJYRw2UhE2TJJwA/RHRc8uMTyHvYaSefN/TvDMfF
         0X5mhfwwcIxpISnMXPO9peN2YmW6V8r1kp/flMoERb/Z64fd+WyErPwfcmdYb6EQAAJR
         B+SaI+2dlWSggZcEGhbjrCOHhg80aP6MUv7y9iCW8YCfuiAjXKHDlSCPlLFutgOzMdpY
         kxAQ==
X-Gm-Message-State: APjAAAWefw7MiYePQPtTvhhCtLAi6LBjBKRy9VETdJtPmeS67o5+dF3B
        NmDZJP2CS1inkA58simZj6f4FV2AAyL6TN1ULWuZ7UX7vMjhyITUnnDGThLfq/dO9bOEk/SJIvS
        bcDJs9rPQmxU+u+i4CIN+/75Y
X-Received: by 2002:a1c:6309:: with SMTP id x9mr8375552wmb.108.1574330392045;
        Thu, 21 Nov 2019 01:59:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqwPhJ9p31NlkxFdXc1WkCFoBS07DC7jz3SIB+5yTxT/Kdnf/tqFWQvPhtgZ6YH4XQmcMUxa7A==
X-Received: by 2002:a1c:6309:: with SMTP id x9mr8375533wmb.108.1574330391716;
        Thu, 21 Nov 2019 01:59:51 -0800 (PST)
Received: from steredhat (a-nu5-32.tin.it. [212.216.181.31])
        by smtp.gmail.com with ESMTPSA id a8sm2249793wme.11.2019.11.21.01.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 01:59:51 -0800 (PST)
Date:   Thu, 21 Nov 2019 10:59:48 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Stefan Hajnoczi <stefanha@gmail.com>
Cc:     netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
        Dexuan Cui <decui@microsoft.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jorgen Hansen <jhansen@vmware.com>
Subject: Re: [PATCH net-next 4/6] vsock: add vsock_loopback transport
Message-ID: <20191121095948.bc7lc3ptsh6jxizw@steredhat>
References: <20191119110121.14480-1-sgarzare@redhat.com>
 <20191119110121.14480-5-sgarzare@redhat.com>
 <20191121093458.GB439743@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20191121093458.GB439743@stefanha-x1.localdomain>
X-MC-Unique: D1daMzZaNkyBp0gqpmlf1g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 09:34:58AM +0000, Stefan Hajnoczi wrote:
> On Tue, Nov 19, 2019 at 12:01:19PM +0100, Stefano Garzarella wrote:
>=20
> Ideas for long-term changes below.
>=20
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>=20

Thanks for reviewing!

> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 760049454a23..c2a3dc3113ba 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -17239,6 +17239,7 @@ F:=09net/vmw_vsock/diag.c
> >  F:=09net/vmw_vsock/af_vsock_tap.c
> >  F:=09net/vmw_vsock/virtio_transport_common.c
> >  F:=09net/vmw_vsock/virtio_transport.c
> > +F:=09net/vmw_vsock/vsock_loopback.c
> >  F:=09drivers/net/vsockmon.c
> >  F:=09drivers/vhost/vsock.c
> >  F:=09tools/testing/vsock/
>=20
> At this point you are most active in virtio-vsock and I am reviewing
> patches on a best-effort basis.  Feel free to add yourself as
> maintainer.
>=20

Sure, I'd be happy to maintain it.

> > diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopb=
ack.c
> > new file mode 100644
> > index 000000000000..3d1c1a88305f
> > --- /dev/null
> > +++ b/net/vmw_vsock/vsock_loopback.c
> > @@ -0,0 +1,217 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * loopback transport for vsock using virtio_transport_common APIs
> > + *
> > + * Copyright (C) 2013-2019 Red Hat, Inc.
> > + * Author: Asias He <asias@redhat.com>
> > + *         Stefan Hajnoczi <stefanha@redhat.com>
> > + *         Stefano Garzarella <sgarzare@redhat.com>
> > + *
> > + */
> > +#include <linux/spinlock.h>
> > +#include <linux/module.h>
> > +#include <linux/list.h>
> > +#include <linux/virtio_vsock.h>
>=20
> Is it time to rename the generic functionality in
> virtio_transport_common.c?  This doesn't have anything to do with virtio
> :).
>=20

Completely agree, new transports could use it to handle the protocol withou=
t
reimplementing things already done.

> > +
> > +static struct workqueue_struct *vsock_loopback_workqueue;
> > +static struct vsock_loopback *the_vsock_loopback;
>=20
> the_vsock_loopback could be a static global variable (not a pointer) and
> vsock_loopback_workqueue could also be included in the struct.
>=20
> The RCU pointer is really a way to synchronize vsock_loopback_send_pkt()
> and vsock_loopback_cancel_pkt() with module exit.  There is no other
> reason for using a pointer.
>=20
> It's cleaner to implement the synchronization once in af_vsock.c (or
> virtio_transport_common.c) instead of making each transport do it.
> Maybe try_module_get() and related APIs provide the necessary semantics
> so that core vsock code can hold the transport module while it's being
> used to send/cancel a packet.

Right, the module cannot be unloaded until open sockets, so here the
synchronization is not needed.

The synchronization come from virtio-vsock device that can be
hot-unplugged while sockets are still open, but that can't happen here.

I will remove the pointers and RCU in the v2.

Can I keep your R-b or do you prefer to watch v2 first?

>=20
> > +MODULE_ALIAS_NETPROTO(PF_VSOCK);
>=20
> Why does this module define the alias for PF_VSOCK?  Doesn't another
> module already define this alias?

It is a way to load this module when PF_VSOCK is starting to be used.
MODULE_ALIAS_NETPROTO(PF_VSOCK) is already defined in vmci_transport
and hyperv_transport. IIUC it is used for the same reason.

In virtio_transport we don't need it because it will be loaded when
the PCI device is discovered.

Do you think there's a better way?
Should I include the vsock_loopback transport directly in af_vsock
without creating a new module?

Thanks,
Stefano

