Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D51C2D0C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 13:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A90A72077B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 13:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nk+N/paw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729410AbfLKNEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 08:04:48 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25833 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729132AbfLKNEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 08:04:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576069486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=668P4/OaTFkh0OL4KrzWbTMYtWCJ7hnKwvkYl6vOypI=;
        b=Nk+N/pawziQpWUkhC7J70w9e0IpB2Kl4yyZh+HEcKmvIk87BnsvvpOObAk2+LEguhWF1Q1
        s3ZQwLH0f1ndYYkp4ClcU9mjs95VBxLneVKOr22OsvQwjSPuYlJJpekD2llEbs9j9F3q1g
        LFS+AmzrNDrq3g1DvtMmxzShaxzHO20=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-qvCX6NzeMlGg_bmoYvuLHA-1; Wed, 11 Dec 2019 08:04:42 -0500
Received: by mail-qk1-f197.google.com with SMTP id s9so14459953qkg.21
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 05:04:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ARBDs3VLIa5a0RMtKyWzB3pZRG0sJsUGt9fBfh6q/08=;
        b=YAMY7tGJxO9jB3Czf93Ca+dIFA5XaTbxFOorBuAPsh/2sb2WZTbE5xWSNjAvyegbCL
         z1UuHADxhLGVe3tzLYOHs9eRfbBZ/cMIvN6FeN/9ZdthO9lndcexvLiDXWujMKi0pLw2
         DVFe1EKKIIuZeRq/bItb3FnDjLrQvAcHK3lPwleMMagrqtRYDD526i6EV1kxPF5jjS1D
         nT6Zjqfbdqsg40by18foIpD92A8F63YzEMKUgeIKEJATQ0EfzQtJ4i4dJgioN0ZlD+DK
         KrFH3MCd9f+ZsQ4TzZHtVTiC/GUQIqYuhN6nLrX8AdZ6Uh6TorFKnSsF9GW/3qHa0qs8
         Dq7w==
X-Gm-Message-State: APjAAAVxl2KWAT5V5k+DBOuzm6dasIalMCao94Ley++BFp+aizkKmECp
        tliZZjwO/PIqOrZCFssp4WrIFkFE9wcI090XL4fw8KgJ5xDt8+7VScEUN4VSTrP/i4ZoD4p1NtX
        VE7wn7nL+SEgvqn9vkUfifJpZ
X-Received: by 2002:ac8:7491:: with SMTP id v17mr2569503qtq.154.1576069482495;
        Wed, 11 Dec 2019 05:04:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqy/4YfGzliqAf/Ryggut1GuwBdPupkaWePKoB8f6NY10Fx0F2PrhbbNHNNWZ0jnzd90OG1Ymw==
X-Received: by 2002:ac8:7491:: with SMTP id v17mr2569484qtq.154.1576069482284;
        Wed, 11 Dec 2019 05:04:42 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
        by smtp.gmail.com with ESMTPSA id g62sm647370qkd.25.2019.12.11.05.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 05:04:41 -0800 (PST)
Date:   Wed, 11 Dec 2019 08:04:36 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH RFC 04/15] KVM: Implement ring-based dirty memory tracking
Message-ID: <20191211075413-mutt-send-email-mst@kernel.org>
References: <20191129213505.18472-1-peterx@redhat.com>
 <20191129213505.18472-5-peterx@redhat.com>
 <1355422f-ab62-9dc3-2b48-71a6e221786b@redhat.com>
 <a3e83e6b-4bfa-3a6b-4b43-5dd451e03254@redhat.com>
 <20191210081958-mutt-send-email-mst@kernel.org>
 <8843d1c8-1c87-e789-9930-77e052bf72f9@redhat.com>
 <20191210160211.GE3352@xz-x1>
 <20191210164908-mutt-send-email-mst@kernel.org>
 <1597a424-9f62-824b-5308-c9622127d658@redhat.com>
MIME-Version: 1.0
In-Reply-To: <1597a424-9f62-824b-5308-c9622127d658@redhat.com>
X-MC-Unique: qvCX6NzeMlGg_bmoYvuLHA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 10:05:28AM +0100, Paolo Bonzini wrote:
> On 10/12/19 22:53, Michael S. Tsirkin wrote:
> > On Tue, Dec 10, 2019 at 11:02:11AM -0500, Peter Xu wrote:
> >> On Tue, Dec 10, 2019 at 02:31:54PM +0100, Paolo Bonzini wrote:
> >>> On 10/12/19 14:25, Michael S. Tsirkin wrote:
> >>>>> There is no new infrastructure to track the dirty pages---it's just=
 a
> >>>>> different way to pass them to userspace.
> >>>> Did you guys consider using one of the virtio ring formats?
> >>>> Maybe reusing vhost code?
> >>>
> >>> There are no used/available entries here, it's unidirectional
> >>> (kernel->user).
> >>
> >> Agreed.  Vring could be an overkill IMHO (the whole dirty_ring.c is
> >> 100+ LOC only).
> >=20
> > I guess you don't do polling/ event suppression and other tricks that
> > virtio came up with for speed then?

I looked at the code finally, there's actually available, and fetched is
exactly like used. Not saying existing code is a great fit for you as
you have an extra slot parameter to pass and it's reversed as compared
to vhost, with kernel being the driver and userspace the device (even
though vringh might fit, yet needs to be updated to support packed rings
though).  But sticking to an existing format is a good idea IMHO,
or if not I think it's not a bad idea to add some justification.

> There are no interrupts either, so no need for event suppression.  You
> have vmexits when the ring gets full (and that needs to be synchronous),
> but apart from that the migration thread will poll the rings once when
> it needs to send more pages.
>=20
> Paolo

OK don't use that then.

--=20
MST

