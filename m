Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 155DCC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 08:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4032222BD
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 08:20:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bw70PeBZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbfKMIUq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 03:20:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53701 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725993AbfKMIUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 03:20:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573633244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:openpgp;
        bh=whJvieYSPZF3C0Ev7gvfZK1XEQG2EzzzHM80XB6g75A=;
        b=Bw70PeBZgNnnFEiAg4WDTsvZhpIoN4+p2i0WVtiArVYx2v8nBe2iMB4068sdE+jP/U8VKb
        56Wp8lNYsn+mwjR9fgqSkia92wCgMOcy0KH2KUi3/66AJqh3PokHhvn8+y42qM2p2kxWWz
        XKxY1JnOcpiv8vDBmQM6DsVoG7qeO0M=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-112-Fr5eHIqnOe2nmmy_8AnaUQ-1; Wed, 13 Nov 2019 03:20:43 -0500
Received: by mail-wr1-f70.google.com with SMTP id m17so1137405wrb.20
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 00:20:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gRJtnCq+CKt1kPsmHkXPWnEtQz9JufgD24IWcr8duAg=;
        b=HKQoW7aTUBrOkd1i1+yZGA6CPnn4gBaLdp4XQeh7YrBUsu9uw83ppBeuJK1VVanfUU
         ojrll3zAZGaIu43Li3tu/02pwPDEFeXFqx8xER4sKfcNrSlhsiyO4D1AE7IGysFLBnai
         Rn8ANMhJvRco5dhkdvyQPUoV6CiiJrCYdOja5eSJgfUKQTTH2q4i+J6m3CnhzOgAOIvA
         NXCgGpbeNWA5loPp5fhCcEVHqMvDbMNKKbU0rlKGSZou4ZTBccJRPfqw3uNlbiHt9Bw1
         iOahiHtPhMmFMwep9aRk9q2JTeiYRWEST6qmwU0Ooo+QLiNkMoVgnZfcWEoy+ssmvVi7
         wmLg==
X-Gm-Message-State: APjAAAXQnxsiIOhlucTi+7m5MgMsz4oEOtW8zudKdrjy5VLTcPyGEzIs
        ec0OKsKWGDQbM/UDsQguNBVIEbxZkRYzgWWfywpPg9aif21+sJmtn3bLD6+OQI26ZenvVv4XBCw
        CEi0iUW4gJZO4P4l2Ij6TMXYk
X-Received: by 2002:a5d:4986:: with SMTP id r6mr1507905wrq.307.1573633241983;
        Wed, 13 Nov 2019 00:20:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqyvuhfthJLiZbIf7ASFW0EJey9TeYZbP3dIAq7chny/myshfoEZhQsu6Zyv9TB2AwA4sR/anA==
X-Received: by 2002:a5d:4986:: with SMTP id r6mr1507868wrq.307.1573633241635;
        Wed, 13 Nov 2019 00:20:41 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:8c9d:1a6f:4730:367c? ([2001:b07:6468:f312:8c9d:1a6f:4730:367c])
        by smtp.gmail.com with ESMTPSA id 19sm2670309wrc.47.2019.11.13.00.20.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2019 00:20:41 -0800 (PST)
Subject: Re: [PATCH] KVM: X86: Reset the three MSR list number variables to 0
 in kvm_init_msr_list()
To:     Xiaoyao Li <xiaoyao.li@intel.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Chenyi Qiang <chenyi.qiang@intel.com>
References: <20191113011521.32255-1-xiaoyao.li@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <02a71740-a98d-622e-ee3e-705fe707c772@redhat.com>
Date:   Wed, 13 Nov 2019 09:20:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191113011521.32255-1-xiaoyao.li@intel.com>
Content-Language: en-US
X-MC-Unique: Fr5eHIqnOe2nmmy_8AnaUQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/11/19 02:15, Xiaoyao Li wrote:
> When applying commit 7a5ee6edb42e ("KVM: X86: Fix initialization of MSR
> lists"), it forgot to reset the three MSR lists number varialbes to 0
> while removing the useless conditionals.
>=20
> Fixes: 7a5ee6edb42e (KVM: X86: Fix initialization of MSR lists)
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  arch/x86/kvm/x86.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 8c8a5e20ea06..9368b0e6bf21 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -5102,6 +5102,10 @@ static void kvm_init_msr_list(void)
> =20
>  =09perf_get_x86_pmu_capability(&x86_pmu);
> =20
> +=09num_msrs_to_save =3D 0;
> +=09num_emulated_msrs =3D 0;
> +=09num_msr_based_features =3D 0;
> +
>  =09for (i =3D 0; i < ARRAY_SIZE(msrs_to_save_all); i++) {
>  =09=09if (rdmsr_safe(msrs_to_save_all[i], &dummy[0], &dummy[1]) < 0)
>  =09=09=09continue;
>=20

Ouch.  Sorry.

Paolo

