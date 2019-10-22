Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51C0CA9EB7
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 11:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93046207FC
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 11:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KQ5y4F2c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388774AbfJVLkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 07:40:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32163 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387488AbfJVLkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 07:40:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571744408;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:openpgp;
        bh=hr2PZJqY6ri+x9eL2G3gfJOxyUdGSaLhO3Ruj/lc0V8=;
        b=KQ5y4F2cjGidXq7KGelAR5P63EKnOutUbh92mC8f0mWRXMIHnl7ae9Ny0BAzZsDrEB7hKf
        K4R8G9ttUMYksdWk+JzftolE6pZQ1XbVg/D2D3JAhbbhUTiYABHmjtOW+/hM6PbRfWyL7t
        /IlLdCuzBthRbJqWHgeZuEGKqlm1uho=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-7YndE5vrNaSVUQU1qxhAsQ-1; Tue, 22 Oct 2019 07:40:07 -0400
Received: by mail-wr1-f72.google.com with SMTP id e14so8962168wrm.21
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 04:40:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PeLZbmIO9rpF1zF9RF04jfgeZFapsne4Se0jbZ+6eME=;
        b=WCIwtQrvhb08XF4kjHBhZw73pLaN7GfBJR7L4qQ8+65mWbqmO3o18c5e2xPdIC7/uz
         RQ0oLmifeAJNOtBygyUTrD2GfCywoyfqjwLuH3ibNZpLZictawo6fRSDIwqmxa0ntNQx
         RtKD6MvixrjNZA7Xq3H0FOIjj/AuUSMYs2cxUHCpK7V3gajDmngAnrKxsn5Rf4zxDCMK
         RfNu/sgP8zcW5Kr1J49ZmGUS6ZgXpR+azgKeNVJqoAHAFLeb59T9Jubg0XmXe5twjqFU
         Z819R+JmiQIFPGB76ufDJPy7Tgj/hORlzxjBhro1fGmNuEub7IpJ3sHabuk12jIWtaer
         QBEQ==
X-Gm-Message-State: APjAAAWotHDHLQEgcVxSVO0huNqxp+Jj9kmSCmb1uim/ck21v2hXlFTj
        b/fuDPkSqKQNI/IJnh4bXZil+JRgQwp2kVKIEpy/JNw7WTdiRxjmzVcPFz1NNd7EY9gNZVJ+dQo
        jEq9hVA2zU4Fz2URpCYHS2jsv
X-Received: by 2002:a5d:4803:: with SMTP id l3mr3107947wrq.381.1571744405930;
        Tue, 22 Oct 2019 04:40:05 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxOzCpV/sIwcKO18/EmaaENiPNQj4rz0dY689l1MwSwWyS7FlrjW+u/4JCPYAZK91BybxKeZw==
X-Received: by 2002:a5d:4803:: with SMTP id l3mr3107924wrq.381.1571744405614;
        Tue, 22 Oct 2019 04:40:05 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c0e4:dcf4:b543:ce19? ([2001:b07:6468:f312:c0e4:dcf4:b543:ce19])
        by smtp.gmail.com with ESMTPSA id s12sm18705126wra.82.2019.10.22.04.40.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2019 04:40:05 -0700 (PDT)
Subject: Re: [PATCH] KVM: x86/vPMU: Declare kvm_pmu->reprogram_pmi field using
 DECLARE_BITMAP
To:     Like Xu <like.xu@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <2175c2cd-2c1e-22e8-2f67-3fc334ef2a40@redhat.com>
 <20191021105504.120838-1-like.xu@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <6b7569cf-5977-6992-8c97-cd8a11660f3d@redhat.com>
Date:   Tue, 22 Oct 2019 13:40:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191021105504.120838-1-like.xu@linux.intel.com>
Content-Language: en-US
X-MC-Unique: 7YndE5vrNaSVUQU1qxhAsQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/19 12:55, Like Xu wrote:
> Replace the explicit declaration of "u64 reprogram_pmi" with the generic
> macro DECLARE_BITMAP for all possible appropriate number of bits.
>=20
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Like Xu <like.xu@linux.intel.com>
> ---
>  arch/x86/include/asm/kvm_host.h |  2 +-
>  arch/x86/kvm/pmu.c              | 15 +++++----------
>  2 files changed, 6 insertions(+), 11 deletions(-)
>=20
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_h=
ost.h
> index 50eb430b0ad8..236a876a5a2e 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -469,7 +469,7 @@ struct kvm_pmu {
>  =09struct kvm_pmc gp_counters[INTEL_PMC_MAX_GENERIC];
>  =09struct kvm_pmc fixed_counters[INTEL_PMC_MAX_FIXED];
>  =09struct irq_work irq_work;
> -=09u64 reprogram_pmi;
> +=09DECLARE_BITMAP(reprogram_pmi, X86_PMC_IDX_MAX);
>  };
> =20
>  struct kvm_pmu_ops;
> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index 46875bbd0419..75e8f9fae031 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -62,8 +62,7 @@ static void kvm_perf_overflow(struct perf_event *perf_e=
vent,
>  =09struct kvm_pmc *pmc =3D perf_event->overflow_handler_context;
>  =09struct kvm_pmu *pmu =3D pmc_to_pmu(pmc);
> =20
> -=09if (!test_and_set_bit(pmc->idx,
> -=09=09=09      (unsigned long *)&pmu->reprogram_pmi)) {
> +=09if (!test_and_set_bit(pmc->idx, pmu->reprogram_pmi)) {
>  =09=09__set_bit(pmc->idx, (unsigned long *)&pmu->global_status);
>  =09=09kvm_make_request(KVM_REQ_PMU, pmc->vcpu);
>  =09}
> @@ -76,8 +75,7 @@ static void kvm_perf_overflow_intr(struct perf_event *p=
erf_event,
>  =09struct kvm_pmc *pmc =3D perf_event->overflow_handler_context;
>  =09struct kvm_pmu *pmu =3D pmc_to_pmu(pmc);
> =20
> -=09if (!test_and_set_bit(pmc->idx,
> -=09=09=09      (unsigned long *)&pmu->reprogram_pmi)) {
> +=09if (!test_and_set_bit(pmc->idx, pmu->reprogram_pmi)) {
>  =09=09__set_bit(pmc->idx, (unsigned long *)&pmu->global_status);
>  =09=09kvm_make_request(KVM_REQ_PMU, pmc->vcpu);
> =20
> @@ -137,7 +135,7 @@ static void pmc_reprogram_counter(struct kvm_pmc *pmc=
, u32 type,
>  =09}
> =20
>  =09pmc->perf_event =3D event;
> -=09clear_bit(pmc->idx, (unsigned long*)&pmc_to_pmu(pmc)->reprogram_pmi);
> +=09clear_bit(pmc->idx, pmc_to_pmu(pmc)->reprogram_pmi);
>  }
> =20
>  void reprogram_gp_counter(struct kvm_pmc *pmc, u64 eventsel)
> @@ -253,16 +251,13 @@ EXPORT_SYMBOL_GPL(reprogram_counter);
>  void kvm_pmu_handle_event(struct kvm_vcpu *vcpu)
>  {
>  =09struct kvm_pmu *pmu =3D vcpu_to_pmu(vcpu);
> -=09u64 bitmask;
>  =09int bit;
> =20
> -=09bitmask =3D pmu->reprogram_pmi;
> -
> -=09for_each_set_bit(bit, (unsigned long *)&bitmask, X86_PMC_IDX_MAX) {
> +=09for_each_set_bit(bit, pmu->reprogram_pmi, X86_PMC_IDX_MAX) {
>  =09=09struct kvm_pmc *pmc =3D kvm_x86_ops->pmu_ops->pmc_idx_to_pmc(pmu, =
bit);
> =20
>  =09=09if (unlikely(!pmc || !pmc->perf_event)) {
> -=09=09=09clear_bit(bit, (unsigned long *)&pmu->reprogram_pmi);
> +=09=09=09clear_bit(bit, pmu->reprogram_pmi);
>  =09=09=09continue;
>  =09=09}
> =20
>=20

Queued, thanks.

Paolo

