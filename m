Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EA9C4CECE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 13:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F8D821907
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 13:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aICZyLgg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729772AbfIRNls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 09:41:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51413 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728555AbfIRNls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 09:41:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1568814106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:openpgp;
        bh=lOA2ND/Y20MxKTrJHqX4w538+rbJX81Bul6IxbGl4qs=;
        b=aICZyLgguxVOrDRKHRyI8gOTwlhECTBwbCah1cfaulM79HszSCvWGntuziwOu+ZKT9ecWq
        5ejMnZS4ByMuCo1a8AuTUdIL3TDM8pl4eXLU6OzFDuPK/MjgSBeVdUevvfryp5ENv/bLtS
        M9Jq5fxlRauYJRaOrMvdbsiPcLgsqQ4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-AeLugHf8P7WxOSUPj7NapQ-1; Wed, 18 Sep 2019 09:41:44 -0400
Received: by mail-wm1-f71.google.com with SMTP id d10so41402wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 06:41:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7K7pSZ1gZDCuW8+m95UaYWDgIQiIxgTqxy4bjauGjZU=;
        b=MNHewgmu/b6UfMdMoQm7HrCqZRZE6VOMJS2oCyJziyygSnxqOeHC/ajX0zKRUrde3c
         Dz5i3BIgTrZ++CJNYTlTSeNLl9I6NUVK12j1smWOZsXBRBFvMghojMCuf2xR60+5zQaW
         RtsB8Gd41ox0xiiCZFbeWObnrB4Nv4XHu1cr/9QPuMCOIXZjzikr6lVbgOMZrJ42/tF2
         GJXbihWu3zO8QxAE7YJt0/FJheXO63VHiajXmEnK9+5YNLQhiGwPPpq9c+tz1P6wLVZs
         ViZEpGyGiQy8QFaeE8T42mrv3sEfYiF94ja+SFg1751yBVN67sJpxn5PvEZe7wZMTtXr
         FWog==
X-Gm-Message-State: APjAAAVMaxbCxPb6c+UgsLzZsvDFwu5nugSODEjBcWBh78qWEB7DLjI0
        hWDRZoYVSF6RjLNmOMSLSQRcDg8NxvInvOMMm+TmOauQ4R5tMxtemOx9DVxIuKbRz3h0vQsNjiu
        DnHGxdwP7d2yYsw2Jk2xMyM9i
X-Received: by 2002:a5d:5111:: with SMTP id s17mr3211074wrt.59.1568814103505;
        Wed, 18 Sep 2019 06:41:43 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxX6ZKR7Diu5xNKtsYfOnNOdPjx4nrWm0krLE0vVKOpxRlYvN28D0JA4reZTs4+CGliSpxY8g==
X-Received: by 2002:a5d:5111:: with SMTP id s17mr3211049wrt.59.1568814103200;
        Wed, 18 Sep 2019 06:41:43 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c46c:2acb:d8d2:21d8? ([2001:b07:6468:f312:c46c:2acb:d8d2:21d8])
        by smtp.gmail.com with ESMTPSA id z4sm6165473wrh.93.2019.09.18.06.41.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2019 06:41:42 -0700 (PDT)
Subject: Re: [PATCH] kvm: Ensure writes to the coalesced MMIO ring are within
 bounds
To:     Will Deacon <will@kernel.org>, kvm@vger.kernel.org
Cc:     kernellwp@gmail.com, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "# 5 . 2 . y" <stable@kernel.org>
References: <20190918131545.6405-1-will@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <9d993b71-4f2d-4d6e-39c9-f2ef849f5e5f@redhat.com>
Date:   Wed, 18 Sep 2019 15:41:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190918131545.6405-1-will@kernel.org>
Content-Language: en-US
X-MC-Unique: AeLugHf8P7WxOSUPj7NapQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/09/19 15:15, Will Deacon wrote:
> When records are written to the coalesced MMIO ring in response to a
> vCPU MMIO exit, the 'ring->last' field is used to index the ring buffer
> page. Although we hold the 'kvm->ring_lock' at this point, the ring
> structure is mapped directly into the host userspace and can therefore
> be modified to point at arbitrary pages within the kernel.
>=20
> Since this shouldn't happen in normal operation, simply bound the index
> by KVM_COALESCED_MMIO_MAX to contain the accesses within the ring buffer
> page.
>=20
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: <stable@kernel.org> # 5.2.y
> Fixes: 5f94c1741bdc ("KVM: Add coalesced MMIO support (common part)")
> Reported-by: Bill Creasey <bcreasey@google.com>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>=20
> I think there are some other fixes kicking around for this, but they
> still rely on 'ring->last' being stable, which isn't necessarily the
> case. I'll send the -stable backport for kernels prior to 5.2 once this
> hits mainline.

Google's patch, which checks if ring->last is not in range and fails
with -EOPNOTSUPP if not, is slightly better.  I'll send it in a second
and Cc you (and also send it as a pull request to Linus).

Paolo

>  virt/kvm/coalesced_mmio.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>=20
> diff --git a/virt/kvm/coalesced_mmio.c b/virt/kvm/coalesced_mmio.c
> index 5294abb3f178..09b3e4421550 100644
> --- a/virt/kvm/coalesced_mmio.c
> +++ b/virt/kvm/coalesced_mmio.c
> @@ -67,6 +67,7 @@ static int coalesced_mmio_write(struct kvm_vcpu *vcpu,
>  {
>  =09struct kvm_coalesced_mmio_dev *dev =3D to_mmio(this);
>  =09struct kvm_coalesced_mmio_ring *ring =3D dev->kvm->coalesced_mmio_rin=
g;
> +=09u32 last;
> =20
>  =09if (!coalesced_mmio_in_range(dev, addr, len))
>  =09=09return -EOPNOTSUPP;
> @@ -79,13 +80,13 @@ static int coalesced_mmio_write(struct kvm_vcpu *vcpu=
,
>  =09}
> =20
>  =09/* copy data in first free entry of the ring */
> -
> -=09ring->coalesced_mmio[ring->last].phys_addr =3D addr;
> -=09ring->coalesced_mmio[ring->last].len =3D len;
> -=09memcpy(ring->coalesced_mmio[ring->last].data, val, len);
> -=09ring->coalesced_mmio[ring->last].pio =3D dev->zone.pio;
> +=09last =3D ring->last % KVM_COALESCED_MMIO_MAX;
> +=09ring->coalesced_mmio[last].phys_addr =3D addr;
> +=09ring->coalesced_mmio[last].len =3D len;
> +=09memcpy(ring->coalesced_mmio[last].data, val, len);
> +=09ring->coalesced_mmio[last].pio =3D dev->zone.pio;
>  =09smp_wmb();
> -=09ring->last =3D (ring->last + 1) % KVM_COALESCED_MMIO_MAX;
> +=09ring->last =3D (last + 1) % KVM_COALESCED_MMIO_MAX;
>  =09spin_unlock(&dev->kvm->ring_lock);
>  =09return 0;
>  }
>=20

