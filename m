Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76477C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 17:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 453AC205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 17:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O+b+hACe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730106AbfLLRSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 12:18:42 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54215 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730054AbfLLRSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 12:18:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576171119;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w+lNpQbi7n9NjMFW1p/6ELUJOEe40X4isyqspjvYH6E=;
        b=O+b+hACeXayeUGthcHSD718qcOKpIT0HhiOllpTYuuzUb2Wp4EBfP0JYHbrf3TMdfIkQkx
        ws6+fDbBTLubPLZz417vJwGQVJ5gvpahZ3WMrgt/OCDgevb7zOFV5UZ+9SOHCgd2NVYDkI
        nP/b48RUWoJt04Ccegl6LEM6bOfpKEc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-6-QZXbhuPryg5UqmAu_zLg-1; Thu, 12 Dec 2019 12:18:37 -0500
X-MC-Unique: 6-QZXbhuPryg5UqmAu_zLg-1
Received: by mail-wr1-f69.google.com with SMTP id z10so1267033wrt.21
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 09:18:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w+lNpQbi7n9NjMFW1p/6ELUJOEe40X4isyqspjvYH6E=;
        b=eefCAQbwEvw2O6tcsIxOSUpENWQBuR6xphVtX43XyKoZ3+1CL2oBP2RvUC923DJRxJ
         QIESpALIiYZ6vF3BKeMHQzkVw2lcUUQ4gAZqO2KOk6l7nFhQSB8bfPF/u4TXuKEdyY17
         Ey2nngI6UWh+2kRN/sAWNWZMlb/LZ5K9SDnWPMvGEyBaRQ36RCfwUynFKfpl+QOMuKCz
         da9VRbo43LWN9CRzeJ9od5wEDoI2I2kRnn2jGUHUIWHMZKEQZAGIuIwxsisKlBdlnDM4
         7ZfuTFUfuGXsixLzwTGSXGND/96WDHFvijN9qwyTW7GZCyl9wQGgzCfLlG6wdaRZngzU
         VtuQ==
X-Gm-Message-State: APjAAAWxEqpWwPCflHiL+gT5dLRwPSiw8itH7ucAvUniWzn8qzFlK606
        7mzeEmBLGwfbj4PUBQUu77gnTCPYgtAj0c8kYiOeZwZu0aF3rKKl3gf9KK6hpS5Hglzmv1vD07G
        G3K3rwKSMfAB5gIb22NLsSBm3
X-Received: by 2002:a5d:5273:: with SMTP id l19mr7640201wrc.175.1576171116419;
        Thu, 12 Dec 2019 09:18:36 -0800 (PST)
X-Google-Smtp-Source: APXvYqxdf/lJae5vRRMQuAYB1NsUfS2ri+yj2mZtXoOp6zeDlaXOa3l7O6kmQWVGurWJ+dIsn9JABg==
X-Received: by 2002:a5d:5273:: with SMTP id l19mr7640165wrc.175.1576171116091;
        Thu, 12 Dec 2019 09:18:36 -0800 (PST)
Received: from steredhat ([95.235.120.92])
        by smtp.gmail.com with ESMTPSA id h2sm6702690wrv.66.2019.12.12.09.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 09:18:35 -0800 (PST)
Date:   Thu, 12 Dec 2019 18:18:32 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     virtualization@lists.linux-foundation.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jason Wang <jasowang@redhat.com>, kvm <kvm@vger.kernel.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] vhost/vsock: accept only packets with the right dst_cid
Message-ID: <CAGxU2F5KYABXjATchcqw_rA13cyUzug0zrGX6TJX2CLqj9ZwGw@mail.gmail.com>
References: <20191206143912.153583-1-sgarzare@redhat.com>
 <20191211110235-mutt-send-email-mst@kernel.org>
 <20191212123624.ahyhrny7u6ntn3xt@steredhat>
 <20191212075356-mutt-send-email-mst@kernel.org>
 <20191212131453.yocx6wckoluwofbb@steredhat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212131453.yocx6wckoluwofbb@steredhat>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 2:14 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
> On Thu, Dec 12, 2019 at 07:56:26AM -0500, Michael S. Tsirkin wrote:
> > On Thu, Dec 12, 2019 at 01:36:24PM +0100, Stefano Garzarella wrote:
> > > On Wed, Dec 11, 2019 at 11:03:07AM -0500, Michael S. Tsirkin wrote:
> > > > On Fri, Dec 06, 2019 at 03:39:12PM +0100, Stefano Garzarella wrote:
> > > > > When we receive a new packet from the guest, we check if the
> > > > > src_cid is correct, but we forgot to check the dst_cid.
> > > > >
> > > > > The host should accept only packets where dst_cid is
> > > > > equal to the host CID.
> > > > >
> > > > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > > >
> > > > Stefano can you clarify the impact pls?
> > >
> > > Sure, I'm sorry I didn't do it earlier.
> > >
> > > > E.g. is this needed on stable? Etc.
> > >
> > > This is a better analysis (I hope) when there is a malformed guest
> > > that sends a packet with a wrong dst_cid:
> > > - before v5.4 we supported only one transport at runtime, so the sockets
> > >   in the host can only receive packets from guests. In this case, if
> > >   the dst_cid is wrong, maybe the only issue is that the getsockname()
> > >   returns an inconsistent address (the cid returned is the one received
> > >   from the guest)
> > >
> > > - from v5.4 we support multi-transport, so the L1 VM (e.g. L0 assigned
> > >   cid 5 to this VM) can have both Guest2Host and Host2Guest transports.
> > >   In this case, we have these possible issues:
> > >   - L2 (or L1) guest can use cid 0, 1, and 2 to reach L1 (or L0),
> > >     instead we should allow only CID_HOST (2) to reach the level below.
> > >     Note: this happens also with not malformed guest that runs Linux v5.4
> > >   - if a malformed L2 guest sends a packet with the wrong dst_cid, for example
> > >     instead of CID_HOST, it uses the cid assigned by L0 to L1 (5 in this
> > >     example), this packets can wrongly queued to a socket on L1 bound to cid 5,
> > >     that only expects connections from L0.
> >
> > Oh so a security issue?
> >
>
> It seems so, I'll try to see if I can get a real example,
> maybe I missed a few checks.

I was wrong!
Multi-transport will be released with v5.5, which will contain this patch.

Linux <= v5.4 are safe, with the exception of the potential wrong
address returned by getsockname().

In addition, trying Linux <= v5.4 (both guests and host), I found that
userspace applications can use any dst_cid to reach the host.

It is not a security issue but for sure a wrong semantics.
Maybe we should still consider to backport this patch on stables to get
the right semantics.

Thanks,
Stefano

