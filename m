Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 934A5C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 13:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65A522073B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 13:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WKzO+k8f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727643AbfLJNZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 08:25:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50199 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727508AbfLJNZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 08:25:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575984350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n00JJ/T4yzKQXwRZ4QxpKz4nx3mh99h11BJMbwluGO0=;
        b=WKzO+k8fAgJjTImIhOEqXoFLxbU8xB6A58C/4GaKRum91cc0KMpx23aCm3eT0efCTd+mQA
        MMy08h2QGLdhYatH01VWhAFY9Vq4Boiv0QLDKFRxCS1zCHmaFThfwEl8bdIuTobBZKikIw
        mMV5zYdpLT42Ary0MIk72FEtXdphcy4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-WspzY52qNCCFFyQFYSvi5A-1; Tue, 10 Dec 2019 08:25:48 -0500
Received: by mail-wm1-f71.google.com with SMTP id 7so592004wmf.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 05:25:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=h/LUwbgV6TmsnuImnzKLy4kXaRWB507qnk8lk81yvpI=;
        b=lTjmV/6G0wd9jHEvBv4w1VHxJ2cysxpu01IXoAQk0n3xcglw4rmLJEZBZjMlEJNaPN
         gID/F1WDgFpgBGwIP0LOC33I80c/hvO4fJQ4UdwmBW2jWAxA3+mT6IIB9ZeBWgo9uYSr
         nuZrzmgtK+azAqDUW4bkWb5x6JNiD1bNvMJ3TVfeTef3SvtRzTFBIglZq/sw92bp/FiR
         +xf0KjsxuHFJNwoZzkA5eoi8czEPLrC9PFKsLc1R5Fc2z23DvqP8bbUbvgyZ4tABixIS
         DxrnDGaYsQ3hEVDCaH+9Xt9ARMx5DFP7JSKDKbdzAfvG3/6M3R3/2k87iV/nCBlWZuv7
         KAJw==
X-Gm-Message-State: APjAAAXgnE9NCLPX9p0sZZYmu5cZW0DbQ69t6gk8tspvpRvPkwghi47y
        NhKi+yRX2DnTlMOK3U/olCuyK7rFd6sIFXQzSlqF8GnjxJX6hVz0I4bzsBUU4GEYNqdCBFaZx05
        6kF4/g0rG6Y+/34C4qiSufDf2
X-Received: by 2002:adf:b602:: with SMTP id f2mr3125155wre.99.1575984347509;
        Tue, 10 Dec 2019 05:25:47 -0800 (PST)
X-Google-Smtp-Source: APXvYqycwvEm+aXyU7FL7AtjcKlWZq1DB7Nbgrk/qYzyK5Qdvd+vvqukZEz1jI6Kz5T5LwoE0oYz+Q==
X-Received: by 2002:adf:b602:: with SMTP id f2mr3125139wre.99.1575984347323;
        Tue, 10 Dec 2019 05:25:47 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
        by smtp.gmail.com with ESMTPSA id w17sm3212357wrt.89.2019.12.10.05.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 05:25:46 -0800 (PST)
Date:   Tue, 10 Dec 2019 08:25:43 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>, Peter Xu <peterx@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH RFC 04/15] KVM: Implement ring-based dirty memory tracking
Message-ID: <20191210081958-mutt-send-email-mst@kernel.org>
References: <20191129213505.18472-1-peterx@redhat.com>
 <20191129213505.18472-5-peterx@redhat.com>
 <1355422f-ab62-9dc3-2b48-71a6e221786b@redhat.com>
 <a3e83e6b-4bfa-3a6b-4b43-5dd451e03254@redhat.com>
MIME-Version: 1.0
In-Reply-To: <a3e83e6b-4bfa-3a6b-4b43-5dd451e03254@redhat.com>
X-MC-Unique: WspzY52qNCCFFyQFYSvi5A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2019 at 12:04:53PM +0100, Paolo Bonzini wrote:
> On 04/12/19 11:38, Jason Wang wrote:
> >>
> >> +=A0=A0=A0 entry =3D &ring->dirty_gfns[ring->dirty_index & (ring->size=
 - 1)];
> >> +=A0=A0=A0 entry->slot =3D slot;
> >> +=A0=A0=A0 entry->offset =3D offset;
> >=20
> >=20
> > Haven't gone through the whole series, sorry if it was a silly question
> > but I wonder things like this will suffer from similar issue on
> > virtually tagged archs as mentioned in [1].
>=20
> There is no new infrastructure to track the dirty pages---it's just a
> different way to pass them to userspace.

Did you guys consider using one of the virtio ring formats?
Maybe reusing vhost code?

If you did and it's not a good fit, this is something good to mention
in the commit log.

I also wonder about performance numbers - any data here?


> > Is this better to allocate the ring from userspace and set to KVM
> > instead? Then we can use copy_to/from_user() friends (a little bit slow
> > on recent CPUs).
>=20
> Yeah, I don't think that would be better than mmap.
>=20
> Paolo
>=20
>=20
> > [1] https://lkml.org/lkml/2019/4/9/5

