Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE9EC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CEA921783
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ANwsGQxP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfKKOH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 09:07:28 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30896 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726845AbfKKOH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 09:07:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573481246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:openpgp;
        bh=ZGs0M6vNOlR72l+3qKrXi768QPAALJbpnXDDJqiP0K0=;
        b=ANwsGQxPB9LPAIWYyd7f04BMg0ZKth9TSyE47uZ6u6M40/haBQGTH5TsfLRXPA1R8CFib2
        C4zh85iiayjpoPwfVULgD5VTZOW6j9OTWsgTPK4en4oy93qh+cNozU6bT1P0YPV5huseZd
        Gek2gtBsW33c3kNKkD0c6G5Rf2rifZo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-AIHhBN9PP4StHdyZCGtgpw-1; Mon, 11 Nov 2019 09:07:25 -0500
Received: by mail-wr1-f72.google.com with SMTP id q6so6538653wrv.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 06:07:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HHT8z9ApKJ84GVmGisp2JZyy+3t2iYfQwx7HQlS2FAw=;
        b=MX7R+X7lKhcZlMu2NejXxRiLXmrbORs8z6khXNeFcBm5Rq2/NgJzURDHRNS5p0ZHZ7
         LBW9XsZwLsM4/E26leqeEZbWpdiLfoLIiOGfkmDEu6XWiO1lVFGpB1XhhV4bXZIfShj8
         yHH0VLuCROJuaFZzCDCX2phi27nwHJSOrhlgNN9udxRstOuPWNRV7LbM/FVLIKb3WF/4
         fkmhtrweEd/zd2TpaB0BReAvXI2OV8zhOgtu/oOQVWyZ7+iyLQSDUl1eLrUgLjL+WPJM
         7avenQ7qLoQpVRc0J8Z0pFEP3+h7vVPgJRULNAWLXBq6pIOOMgsQDu/eOqCvwRwKjFk7
         IGKg==
X-Gm-Message-State: APjAAAVorvnajDR6j7PYxyNrVaKGGZ8ENT+l93UV/LMCANkU+tuq8/Rd
        vg2nRNUNavx5XIdRImBI/rkOWrUC1vgkBhs2V/RCX/SkXU+ANS7y8yiR8tDDuu7eMtgV4DCpAzo
        pRsyuKxlrfXX+wcKZDf8V07Qe
X-Received: by 2002:adf:f60a:: with SMTP id t10mr17727031wrp.29.1573481243880;
        Mon, 11 Nov 2019 06:07:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqymX6a+Us/pFWg+HkVt+RJVFYpS4w6sHQvgwVRhK7Od4V2R+giqMbAZhKM06rQzj9qXOOvIcw==
X-Received: by 2002:adf:f60a:: with SMTP id t10mr17727007wrp.29.1573481243620;
        Mon, 11 Nov 2019 06:07:23 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:a0f7:472a:1e7:7ef? ([2001:b07:6468:f312:a0f7:472a:1e7:7ef])
        by smtp.gmail.com with ESMTPSA id f14sm14645823wrv.17.2019.11.11.06.07.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2019 06:07:23 -0800 (PST)
Subject: Re: [PATCH] KVM: MMIO: get rid of odd out_err label in
 kvm_coalesced_mmio_init
To:     linmiaohe <linmiaohe@huawei.com>, rkrcmar@redhat.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1573286900-19041-1-git-send-email-linmiaohe@huawei.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <e6780f84-e5e5-09ec-3cef-535a2d33ef92@redhat.com>
Date:   Mon, 11 Nov 2019 15:07:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1573286900-19041-1-git-send-email-linmiaohe@huawei.com>
Content-Language: en-US
X-MC-Unique: AIHhBN9PP4StHdyZCGtgpw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/19 09:08, linmiaohe wrote:
> From: Miaohe Lin <linmiaohe@huawei.com>
>=20
> The out_err label and var ret is unnecessary, clean them up.
>=20
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  virt/kvm/coalesced_mmio.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>=20
> diff --git a/virt/kvm/coalesced_mmio.c b/virt/kvm/coalesced_mmio.c
> index 8ffd07e2a160..00c747dbc82e 100644
> --- a/virt/kvm/coalesced_mmio.c
> +++ b/virt/kvm/coalesced_mmio.c
> @@ -110,14 +110,11 @@ static const struct kvm_io_device_ops coalesced_mmi=
o_ops =3D {
>  int kvm_coalesced_mmio_init(struct kvm *kvm)
>  {
>  =09struct page *page;
> -=09int ret;
> =20
> -=09ret =3D -ENOMEM;
>  =09page =3D alloc_page(GFP_KERNEL | __GFP_ZERO);
>  =09if (!page)
> -=09=09goto out_err;
> +=09=09return -ENOMEM;
> =20
> -=09ret =3D 0;
>  =09kvm->coalesced_mmio_ring =3D page_address(page);
> =20
>  =09/*
> @@ -128,8 +125,7 @@ int kvm_coalesced_mmio_init(struct kvm *kvm)
>  =09spin_lock_init(&kvm->ring_lock);
>  =09INIT_LIST_HEAD(&kvm->coalesced_zones);
> =20
> -out_err:
> -=09return ret;
> +=09return 0;
>  }
> =20
>  void kvm_coalesced_mmio_free(struct kvm *kvm)
>=20

Queued, thanks.

Paolo

