Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A79C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 16:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6545D2073F
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 16:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fLjS3fJE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbfLCQQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 11:16:54 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51482 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725848AbfLCQQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 11:16:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575389812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l5DRPz75FYfbi6k56DuDWzncPOz5zbOpOMHv3gX9mR0=;
        b=fLjS3fJEwFeoRRC6Xxkiiw6gUYV6gY116biCWxuAH2fCt3ic6T1Lz1lFlUYRmrB4rkqcvq
        E4cjjros13hEs62DxeUTWaZ5fCk4h26gq4DzT1Coebw612xQEQoZAJGaNVOojM7IMcuM8+
        YjlYSwXS53g4ndsgW3ZXRBWgGmFFyaA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-ZN7pHPpCOlSFurLJB_1bwg-1; Tue, 03 Dec 2019 11:16:47 -0500
Received: by mail-qk1-f198.google.com with SMTP id j192so2543868qke.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 08:16:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OAvig8M7YhwpuhEupgjTLkU7y0yDFNJcrooMFpTalaM=;
        b=b2xVyrqszRPLTb+ljmya0FiLbK9bU3xGz4Kn2G7Ja5sSk4Q1lOg47D79lDRrIbwH4s
         r4dSeR21RaRdI5/12sDDAMj+2BOIaCHKbg/dqReY+c6n7VDFSvhs3vl7tjI3wx9DfGz7
         1oQDaOAzsWirwiVIY814ZMLIChZWb3QZBHKVjGyXxyZ/YUnMfvwfXbdTP5wbfrgs5UK6
         Fv4VbGeF23aGvmN1k0K7tmt6thkOR3hlVj1ZOmWfqH1A7CvumL1duvq6M8Ud3rwa0mKN
         3zz9Fd8bgpqRF1B5OmhTHlIAbEDXVzFLiCQ/lzRN69ss8pi0KbJHi7wx0K+Cq280DIX5
         lesg==
X-Gm-Message-State: APjAAAVDDL9r+yfLA59v0r3stMlYFJTF2TLiH3uPcJdqVN1CE2QAsgoo
        tTkhLqqNjTScCz05zp3gdVCEjT8DklXjlRIf9xnE3zrFGkxidJVVt1bV80Y++6m2FNgyWT5BNLF
        R4wyPHpS+D2GhTbP4r5+UB5pU
X-Received: by 2002:a37:5c02:: with SMTP id q2mr5848883qkb.72.1575389806788;
        Tue, 03 Dec 2019 08:16:46 -0800 (PST)
X-Google-Smtp-Source: APXvYqzADuhWD+oXo0EFAH6UvLZQnyzJStpL8OpOHP4ltkZ4Yg/RluWK8PFf/WihKlf1cIBL/pBGtw==
X-Received: by 2002:a37:5c02:: with SMTP id q2mr5848850qkb.72.1575389806486;
        Tue, 03 Dec 2019 08:16:46 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id s20sm1938085qkj.100.2019.12.03.08.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 08:16:45 -0800 (PST)
Date:   Tue, 3 Dec 2019 11:16:44 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [PATCH v3 3/5] KVM: X86: Use APIC_DEST_* macros properly in
 kvm_lapic_irq.dest_mode
Message-ID: <20191203161644.GB17275@xz-x1>
References: <20191202201314.543-1-peterx@redhat.com>
 <20191202201314.543-4-peterx@redhat.com>
 <87wobdblda.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
In-Reply-To: <87wobdblda.fsf@vitty.brq.redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-MC-Unique: ZN7pHPpCOlSFurLJB_1bwg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2019 at 02:16:01PM +0100, Vitaly Kuznetsov wrote:
> Peter Xu <peterx@redhat.com> writes:
>=20
> > We were using either APIC_DEST_PHYSICAL|APIC_DEST_LOGICAL or 0|1 to
> > fill in kvm_lapic_irq.dest_mode.  It's fine only because in most cases
> > when we check against dest_mode it's against APIC_DEST_PHYSICAL (which
> > equals to 0).  However, that's not consistent.  We'll have problem
> > when we want to start checking against APIC_DEST_PHYSICAL
>=20
> APIC_DEST_LOGICAL

Fixed.

> > +=09irq->dest_mode =3D kvm_lapic_irq_dest_mode(
> > +=09    (1 << MSI_ADDR_DEST_MODE_SHIFT) & e->msi.address_lo);
>=20
> This usage is a bit fishy (I understand that it works, but),
> kvm_lapic_irq_dest_mode()'s input is bool (0/1) but here we're passing
> something different.
>=20
> I'm not sure kvm_lapic_irq_dest_mode() is even needed here, but in case
> it is I'd suggest to add '!!':
>=20
>  kvm_lapic_irq_dest_mode(!!((1 << MSI_ADDR_DEST_MODE_SHIFT) & e->msi.addr=
ess_lo))
>=20
> to make things explicit. I don't like how it looks though.

IMHO it's the same (converting uint to _Bool will be the same as "!!",
also A ? B : C will be another, so we probably wrote this three times,
each of them will translate to a similar pattern of "cmpl + setne" asm
code).  But sure I can add them if you prefer.

Thanks,

--=20
Peter Xu

