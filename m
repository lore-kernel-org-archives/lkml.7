Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C643C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 19:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED1372073B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 19:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SPiOv51O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbfLDTwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 14:52:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54882 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727033AbfLDTwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 14:52:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575489155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2HusBtOWadZiLTPK1SmC8n0gdc/q9WlraTHbywKYh/s=;
        b=SPiOv51Od90VVz9h6Kaw7QLPsGNBtI7zdwdfGy6YM9Hqa5jJhEAWXPg/e1t8nNkig6P4PN
        RF7MvyFgd5LrMCAVhf3m7LtRmUa91RuDnlsXmJ1KzB3nOavpaluZaZByLp7LSorZ/XAugm
        Nq0LQBbgzJjVXfblQ3JM8LzCO4sPIBo=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-RpAcTRqAOJSRyERAGVZdvw-1; Wed, 04 Dec 2019 14:52:33 -0500
Received: by mail-qk1-f199.google.com with SMTP id b9so529297qkl.13
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 11:52:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=COps3gzSWJZrk5fQQE220Gmmy+Anmpkd5GgCFKaWMT0=;
        b=PeF2z2QfBm4/kxmozz9vzJdMrw7s/1h0mUm0BVcp6C4ozRsP9Dv96m7TDbtLJgT0wZ
         IzXCmlj0r3SfXnvcFEiQ80D6IhdZTbhet5e2UlDfIADJJ3l7Kdq1vQoNWlWOLMf6y92y
         Uzh72cxQ0ieILAQEHy+WXxBwpulaSzeJvBG2dT+2+6PMvPq16d6TB3jFpdgApUez4AeR
         57IFxS7SDJ0wzdbs3i198TVSL4jEqKL5/xqNLjCFiT28zy5pZglW6jWwdkiolgKNohS/
         2YxIHdJG03NFzeLJKCtdUrteH2LIA5XFCUf3sHNTOLFyW7djMzD7XN6dLYpJpdlp1k4H
         CzRg==
X-Gm-Message-State: APjAAAUuKnFnccYwnkHga8T81n1Zidtk/sRPbLSgrl5v5lizAwszaRVC
        b5cQDMbINhLx7e4BGgnONVZ0FAA2zXuWXavYoYr26vTLpO1lcIBoRLZhjmSlyR73TVy4dNz3EM8
        99iX4001CYas+USTZZoUUBgtx
X-Received: by 2002:a37:9345:: with SMTP id v66mr4783220qkd.195.1575489152869;
        Wed, 04 Dec 2019 11:52:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqwmm8jnKWcmw4+PPJFHhDL8CRLCxfukJjz5uZsgYx4DOnQ3LuvLF7qvQ1/vOwQrDYghrXaqbA==
X-Received: by 2002:a37:9345:: with SMTP id v66mr4783190qkd.195.1575489152545;
        Wed, 04 Dec 2019 11:52:32 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id t9sm453529qkt.112.2019.12.04.11.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 11:52:31 -0800 (PST)
Date:   Wed, 4 Dec 2019 14:52:30 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC 04/15] KVM: Implement ring-based dirty memory tracking
Message-ID: <20191204195230.GF19939@xz-x1>
References: <20191129213505.18472-1-peterx@redhat.com>
 <20191129213505.18472-5-peterx@redhat.com>
 <1355422f-ab62-9dc3-2b48-71a6e221786b@redhat.com>
 <a3e83e6b-4bfa-3a6b-4b43-5dd451e03254@redhat.com>
MIME-Version: 1.0
In-Reply-To: <a3e83e6b-4bfa-3a6b-4b43-5dd451e03254@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-MC-Unique: RpAcTRqAOJSRyERAGVZdvw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2019 at 12:04:53PM +0100, Paolo Bonzini wrote:
> On 04/12/19 11:38, Jason Wang wrote:
> >>
> >> +=C2=A0=C2=A0=C2=A0 entry =3D &ring->dirty_gfns[ring->dirty_index & (r=
ing->size - 1)];
> >> +=C2=A0=C2=A0=C2=A0 entry->slot =3D slot;
> >> +=C2=A0=C2=A0=C2=A0 entry->offset =3D offset;
> >=20
> >=20
> > Haven't gone through the whole series, sorry if it was a silly question
> > but I wonder things like this will suffer from similar issue on
> > virtually tagged archs as mentioned in [1].
>=20
> There is no new infrastructure to track the dirty pages---it's just a
> different way to pass them to userspace.
>=20
> > Is this better to allocate the ring from userspace and set to KVM
> > instead? Then we can use copy_to/from_user() friends (a little bit slow
> > on recent CPUs).
>=20
> Yeah, I don't think that would be better than mmap.

Yeah I agree, because I didn't see how copy_to/from_user() helped to
do icache/dcache flushings...

Some context here: Jason raised this question offlist first on whether
we should also need these flush_dcache_cache() helpers for operations
like kvm dirty ring accesses.  I feel like it should, however I've got
two other questions, on:

  - if we need to do flush_dcache_page() on kernel modified pages
    (assuming the same page has mapped to userspace), then why don't
    we need flush_cache_page() too on the page, where
    flush_cache_page() is defined not-a-nop on those archs?

  - assuming an arch has not-a-nop impl for flush_[d]cache_page(),
    would atomic operations like cmpxchg really work for them
    (assuming that ISAs like cmpxchg should depend on cache
    consistency).

Sorry I think these are for sure a bit out of topic for kvm dirty ring
patchset, but since we're at it, I'm raising the questions up in case
there're answers..

Thanks,

--=20
Peter Xu

