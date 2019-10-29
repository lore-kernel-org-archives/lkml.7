Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A501DCA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 12:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7310B214B2
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 12:29:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PQb4u8cs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732403AbfJ2M3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 08:29:45 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49067 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729867AbfJ2M3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 08:29:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572352183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=isE3WXtq6TdHNbe0eCrSyqXMPps4oLg4qOCvldTLLWc=;
        b=PQb4u8csqYgokGPJ+pAuNvs0jtrNIiVUznhmHMewx/W62qsi3ddwbsN2Gwy7kOojZrXRG4
        XIrFAybkOz6+qghRwJUnYdpal0/ZmrNXaVkH+mAMtO7V/U0WIuMUrvO9XXkvMKtBReL6es
        i5UjvELgbWAMHPMBDDX7zjgXtlVnw80=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-5xRQ-dLzNiCOO_F_zL5VZg-1; Tue, 29 Oct 2019 08:29:39 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 21D0A801E64;
        Tue, 29 Oct 2019 12:29:38 +0000 (UTC)
Received: from [10.36.118.15] (unknown [10.36.118.15])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6906960C4B;
        Tue, 29 Oct 2019 12:29:34 +0000 (UTC)
Subject: Re: [PATCH 1/3] KVM: arm/arm64: vgic: Remove the declaration of
 kvm_send_userspace_msi()
To:     Zenghui Yu <yuzenghui@huawei.com>, maz@kernel.org,
        james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com
Cc:     wanghaibin.wang@huawei.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20191029071919.177-1-yuzenghui@huawei.com>
 <20191029071919.177-2-yuzenghui@huawei.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <a38976ea-8c10-6fde-67a8-a25aa13c964e@redhat.com>
Date:   Tue, 29 Oct 2019 13:29:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20191029071919.177-2-yuzenghui@huawei.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 5xRQ-dLzNiCOO_F_zL5VZg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zenghui,

On 10/29/19 8:19 AM, Zenghui Yu wrote:
> The callsite of kvm_send_userspace_msi() is currently arch agnostic.
> There seems no reason to keep an extra declaration of it in arm_vgic.h
> (we already have one in include/linux/kvm_host.h).
>=20
> Remove it.
>=20
> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> ---
>  include/kvm/arm_vgic.h | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
> index af4f09c02bf1..0fb240ec0a2a 100644
> --- a/include/kvm/arm_vgic.h
> +++ b/include/kvm/arm_vgic.h
> @@ -378,8 +378,6 @@ static inline int kvm_vgic_get_max_vcpus(void)
>  =09return kvm_vgic_global_state.max_gic_vcpus;
>  }
> =20
> -int kvm_send_userspace_msi(struct kvm *kvm, struct kvm_msi *msi);
> -
>  /**
>   * kvm_vgic_setup_default_irq_routing:
>   * Setup a default flat gsi routing table mapping all SPIs
>=20

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric

