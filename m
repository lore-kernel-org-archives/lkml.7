Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C23C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 12:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3C4A22519
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 12:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BOs8vOgc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbfKTMd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 07:33:58 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51293 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728030AbfKTMd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 07:33:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574253236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hDEGjYwfPSlpk5kc526ke8LgFJkbaaKnKQB2+ZMTOJA=;
        b=BOs8vOgcEtaDk/tOO9oZxDWC6+eMUKXGP5zigovn/J8BMKniNTpzBdNqXV/LNzzNDz7Qmr
        YCCwFvYelIW3ixUnmgQImyuBGUvGaXGPBvA74+o/LxOiyq7T7DeEcBDJ7wyv5hzg75mh2U
        z6g5a1NMA6klPSze3Lg5ZS/Xk8WSFMc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-jAoLtsQdNXqb-Oc6RXEl6A-1; Wed, 20 Nov 2019 07:33:54 -0500
Received: by mail-wr1-f70.google.com with SMTP id m17so20903053wrb.20
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 04:33:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SJ127gtEOsgnqOjk57d0lGlsBueTu+Z8QRRvitzC3aU=;
        b=oVLruXF58jkIndsgwvnFTX69A5uTT6xOQ/IpPpIwUK2rB5BdFqO7uKD6yc5zZAk/6Y
         Z6g3yNjwGAi+l0LvjliI6JEBNo6KzBAwa4Nj6sNU8RzhFukoFkwdrbuJ0eZS629Ayvoy
         uPSc++jRYTKgJVqOEefqnSF5HlpPM/RkTo6zwrYpcdFMcHF5nc5S/Gmrh2Tt7ij8V44Y
         ZPR52IXOG/wnIWZou7ueDUhT4Gm0LYeQ/HDu0IWF0PlYsI4Tgx6HpSw9Pe588yVD5TRY
         cPdLuGKV08BV1c5abGx4Vb0+4JIQTxBbAHKw9ayVnN8DZcKr518Ial8AdUHIUDGeEsQN
         VCxA==
X-Gm-Message-State: APjAAAUaphOA986CIb3SsMBApqlos+HL3eOtWxltUqj/46uH7tZ/YBYl
        S5TG0A8lBs04xybrBkc/B2SyQHF/rafCe2W+dacIwv4+iYp7vKoasNAc3JBYnGYHoAROfRk9b38
        aJxA6/pEN2OPLBBK39WYpdmso
X-Received: by 2002:a1c:a512:: with SMTP id o18mr2866099wme.4.1574253233161;
        Wed, 20 Nov 2019 04:33:53 -0800 (PST)
X-Google-Smtp-Source: APXvYqyjBY1pEIFdzQg3nliRwValwzusj6ZnGuzsbaO+x2qEPD7G2UTNso0DUkrCJFtjTT0/sXfFHw==
X-Received: by 2002:a1c:a512:: with SMTP id o18mr2866072wme.4.1574253232865;
        Wed, 20 Nov 2019 04:33:52 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:dc24:9a59:da87:5724? ([2001:b07:6468:f312:dc24:9a59:da87:5724])
        by smtp.gmail.com with ESMTPSA id m9sm30457516wro.66.2019.11.20.04.33.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2019 04:33:52 -0800 (PST)
Subject: Re: [PATCH] KVM: x86: Zero the IOAPIC scan request dest vCPUs bitmap
To:     Nitesh Narayan Lal <nitesh@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mtosatti@redhat.com,
        rkrcmar@redhat.com, vkuznets@redhat.com,
        sean.j.christopherson@intel.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org
References: <20191120121224.9850-1-nitesh@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <24c18608-2731-c560-8677-26498e848a39@redhat.com>
Date:   Wed, 20 Nov 2019 13:33:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191120121224.9850-1-nitesh@redhat.com>
Content-Language: en-US
X-MC-Unique: jAoLtsQdNXqb-Oc6RXEl6A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/11/19 13:12, Nitesh Narayan Lal wrote:
> Not zeroing the bitmap used for identifying the destination vCPUs for an
> IOAPIC scan request in fixed delivery mode could lead to waking up unwant=
ed
> vCPUs. This patch zeroes the vCPU bitmap before passing it to
> kvm_bitmap_or_dest_vcpus(), which is responsible for setting the bitmap
> with the bits corresponding to the destination vCPUs.
>=20
> Fixes: 7ee30bc132c6("KVM: x86: deliver KVM IOAPIC scan request to target =
vCPUs")
> Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
> ---
>  arch/x86/kvm/ioapic.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/x86/kvm/ioapic.c b/arch/x86/kvm/ioapic.c
> index ce30ef23c86b..9fd2dd89a1c5 100644
> --- a/arch/x86/kvm/ioapic.c
> +++ b/arch/x86/kvm/ioapic.c
> @@ -332,6 +332,7 @@ static void ioapic_write_indirect(struct kvm_ioapic *=
ioapic, u32 val)
>  =09=09=09irq.delivery_mode =3D e->fields.delivery_mode << 8;
>  =09=09=09irq.dest_id =3D e->fields.dest_id;
>  =09=09=09irq.dest_mode =3D e->fields.dest_mode;
> +=09=09=09bitmap_zero(&vcpu_bitmap, 16);
>  =09=09=09kvm_bitmap_or_dest_vcpus(ioapic->kvm, &irq,
>  =09=09=09=09=09=09 &vcpu_bitmap);
>  =09=09=09if (old_dest_mode !=3D e->fields.dest_mode ||
>=20

Queued, thanks.

Paolo

