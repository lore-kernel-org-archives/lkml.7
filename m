Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D1DC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5F4521655
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FfrYydfF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfKKOq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 09:46:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32413 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726950AbfKKOq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 09:46:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573483617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:openpgp;
        bh=TTG00YjKWUOsl5rhCzwn1XMhrGVfmW5FmkbQYzSqxw0=;
        b=FfrYydfFHoExK37VSKx8D3B+Jck58qhyc3zy8NUjcb4wmfpv+Qok7ui4tLEPGw+yV7ycPx
        MfBoLELLQOt9BSOfpPYBetofsnqWAaQmSJobotKIhqqtVeVnJtqwZOs1lZ/2WuVQJGIuQ5
        7qRym6rxR6smz9UuhgP36+R3bHAy8ac=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-LFO5OSYsM2CoTk2uPiWi_A-1; Mon, 11 Nov 2019 09:46:56 -0500
Received: by mail-wr1-f70.google.com with SMTP id p6so10058742wrs.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 06:46:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jRkkSKwLtbw789qcSoLZDfx7wzSdmL3oq2GXGl90y/M=;
        b=BnGg6oR85wSRrDoUO+8GuTCmcjQj+/8On4blEsbP5wheoJ7ex3OmpWhpa98pybtUhv
         oRLr7H2rlVaWlK7sjyKPLzdUSpRLVM9xFkMgXr75C/bZbj1r9ZQtTUM9wQ+fOOk1Rd7l
         z6O82M/ioxi8hH5Qz3mjnuytgLIGRvKDgeoYVCCSfsWs1tpQMtstQXDvmX08xVdQusl2
         dcLUAPFHWLae5gFhZCtfR1wdlkTwg1vnGha0hA+g+o/uEWzjeyjlOjuMDKhwhJFslBHd
         +mMd/fdvvwGWalT93Z70ApHbjo36XJ9j18xjPL4dZVmjmBax/jgQDdRlF9IUiUCI5arq
         rCvQ==
X-Gm-Message-State: APjAAAVbzue3FKVgmkIX1VC/sNg1BxofDAuRkP5nJrnSm8h7iF61TSMZ
        Fq9RbCQ6okcpXloL9qwsXNTUrHl268lA57OG+10dt+eRV2yCWrLJWDu49RcoMugOh+UHABewcDl
        GnmXCZBkiJM65aANDexemBgca
X-Received: by 2002:adf:9185:: with SMTP id 5mr22369375wri.389.1573483614933;
        Mon, 11 Nov 2019 06:46:54 -0800 (PST)
X-Google-Smtp-Source: APXvYqyjqc/t6JzGynXh2pZeszWWrEVTnuQ1w9EknjY1/ptxdfimEElgI3QDGqXkPhfkULlRqq2r1Q==
X-Received: by 2002:adf:9185:: with SMTP id 5mr22369347wri.389.1573483614614;
        Mon, 11 Nov 2019 06:46:54 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:a0f7:472a:1e7:7ef? ([2001:b07:6468:f312:a0f7:472a:1e7:7ef])
        by smtp.gmail.com with ESMTPSA id c144sm18931831wmd.1.2019.11.11.06.46.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2019 06:46:54 -0800 (PST)
Subject: Re: [PATCH v1 1/3] KVM: VMX: Consider PID.PIR to determine if vCPU
 has pending interrupts
To:     Joao Martins <joao.m.martins@oracle.com>, kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Liran Alon <liran.alon@oracle.com>,
        Jag Raman <jag.raman@oracle.com>
References: <20191106175602.4515-1-joao.m.martins@oracle.com>
 <20191106175602.4515-2-joao.m.martins@oracle.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <67bca655-fea3-4b57-be3c-7dc58026b5d9@redhat.com>
Date:   Mon, 11 Nov 2019 15:46:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191106175602.4515-2-joao.m.martins@oracle.com>
Content-Language: en-US
X-MC-Unique: LFO5OSYsM2CoTk2uPiWi_A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/11/19 18:56, Joao Martins wrote:
> Commit 17e433b54393 ("KVM: Fix leak vCPU's VMCS value into other pCPU")
> introduced vmx_dy_apicv_has_pending_interrupt() in order to determine
> if a vCPU have a pending posted interrupt. This routine is used by
> kvm_vcpu_on_spin() when searching for a a new runnable vCPU to schedule
> on pCPU instead of a vCPU doing busy loop.
>=20
> vmx_dy_apicv_has_pending_interrupt() determines if a
> vCPU has a pending posted interrupt solely based on PID.ON. However,
> when a vCPU is preempted, vmx_vcpu_pi_put() sets PID.SN which cause
> raised posted interrupts to only set bit in PID.PIR without setting
> PID.ON (and without sending notification vector), as depicted in VT-d
> manual section 5.2.3 "Interrupt-Posting Hardware Operation".
>=20
> Therefore, checking PID.ON is insufficient to determine if a vCPU has
> pending posted interrupts and instead we should also check if there is
> some bit set on PID.PIR.
>=20
> Fixes: 17e433b54393 ("KVM: Fix leak vCPU's VMCS value into other pCPU")
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> Signed-off-by: Liran Alon <liran.alon@oracle.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 31ce6bc2c371..18b0bee662a5 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -6141,7 +6141,10 @@ static int vmx_sync_pir_to_irr(struct kvm_vcpu *vc=
pu)
> =20
>  static bool vmx_dy_apicv_has_pending_interrupt(struct kvm_vcpu *vcpu)
>  {
> -=09return pi_test_on(vcpu_to_pi_desc(vcpu));
> +=09struct pi_desc *pi_desc =3D vcpu_to_pi_desc(vcpu);
> +
> +=09return pi_test_on(pi_desc) ||
> +=09=09!bitmap_empty((unsigned long *)pi_desc->pir, NR_VECTORS);
>  }
> =20
>  static void vmx_load_eoi_exitmap(struct kvm_vcpu *vcpu, u64 *eoi_exit_bi=
tmap)

Should we check the bitmap only if SN is false?  We have a precondition
that if SN is clear then non-empty PIR implies ON=3D1 (modulo the small
window in vmx_vcpu_pi_load of course), so that'd be a bit faster.

Paolo

