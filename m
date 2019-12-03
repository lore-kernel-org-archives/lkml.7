Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FFDC432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 09:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A971D206E0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 09:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iTkUhZcw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbfLCJZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 04:25:19 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28369 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725774AbfLCJZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 04:25:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575365117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/I8RoZB7HxxHtNAPWRVDK9HEHCVNsmOjnJke2ajqDM0=;
        b=iTkUhZcwz8LQ3STqwWTH5bDwzm2zpwkt3NcjetvUpAolmMK8ogF28J7Ikr5fgdyXb2U+XF
        PGbNDFRebuWKNMbcrMpwKqtYNRPDC2XbkNsWAjgkSdY7s/fdAH97npVV8HMY1J7i0GBkeJ
        YN516g1jCk85mQfH8B6KETf4c+Nme/M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-5J8t3HomMduur_xMWDv3ng-1; Tue, 03 Dec 2019 04:25:16 -0500
Received: by mail-wm1-f72.google.com with SMTP id l11so1149364wmi.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 01:25:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=0g5Aa2bIudfU/XFfP7AfbfIOG+59B11fV9VXQfZXGs4=;
        b=CuynDD+832hBo4q/GmET3zEIiXmuhfcPNumZp/QQ1r9u+s6YvD8i2JGlcTudLABn9Z
         eD6zcUqp1xgmKXiBrghzhhPwjr5Q4nKh9vZ+ku2HtZyiAbRsrMwjoFGiHWpEQfgsINpX
         zMgNLnKyb1Tjiz8EPJWDFRjdajXLclTRS/rvn0dpoJjO2PDvEPTt/sdwYpvq1In8qfYZ
         t6nBk+zLFSIh9JPXQUspCCNah3ucg+22oS+KxO6ne/4dXsMPxlT6HP8oFCVZmG0hf+ru
         hrWNRW3xKu6EYhKNbJ5o1EDCNCbGUiLg7dE07qCqu1IDDSVv4E+IHnx6ccMN//qZ7eak
         AD/A==
X-Gm-Message-State: APjAAAXKp13KKFbLIzOh+qdHsZ9nUWMtpLOQzfCDRBjM491LoHACp43a
        dcwQFNPAMwK3jZLxwNUlycbEGCVLxCe8YxpVogUsmVK3Zl861x9F1ioU7xioiZt1Yex7lM3OxfE
        dzMqnX3gHiqTc3GkjZVI2qrDJ
X-Received: by 2002:a5d:438c:: with SMTP id i12mr4123165wrq.196.1575365114861;
        Tue, 03 Dec 2019 01:25:14 -0800 (PST)
X-Google-Smtp-Source: APXvYqzzEWXwWzryTExqHKw8nJKWRk8EEzSfa7nZJtQ7apF/mzzDLVtxzY2DrxKGbUUeWpobgKr7ug==
X-Received: by 2002:a5d:438c:: with SMTP id i12mr4123146wrq.196.1575365114666;
        Tue, 03 Dec 2019 01:25:14 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id u10sm2196064wmd.1.2019.12.03.01.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 01:25:14 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org
Cc:     Nitesh Narayan Lal <nitesh@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        peterx@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] KVM: X86: Fix kvm_bitmap_or_dest_vcpus() to use irq shorthand
In-Reply-To: <20191202201314.543-2-peterx@redhat.com>
References: <20191202201314.543-1-peterx@redhat.com> <20191202201314.543-2-peterx@redhat.com>
Date:   Tue, 03 Dec 2019 10:25:13 +0100
Message-ID: <875zixdame.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
X-MC-Unique: 5J8t3HomMduur_xMWDv3ng-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Xu <peterx@redhat.com> writes:

> The 3rd parameter of kvm_apic_match_dest() is the irq shorthand,
> rather than the irq delivery mode.
>
> Fixes: 7ee30bc132c683d06a6d9e360e39e483e3990708

Better expressed as

Fixes: 7ee30bc132c6 ("KVM: x86: deliver KVM IOAPIC scan request to target v=
CPUs")

> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  arch/x86/kvm/lapic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index cf9177b4a07f..1eabe58bb6d5 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -1151,7 +1151,7 @@ void kvm_bitmap_or_dest_vcpus(struct kvm *kvm, stru=
ct kvm_lapic_irq *irq,
>  =09=09=09if (!kvm_apic_present(vcpu))
>  =09=09=09=09continue;
>  =09=09=09if (!kvm_apic_match_dest(vcpu, NULL,
> -=09=09=09=09=09=09 irq->delivery_mode,
> +=09=09=09=09=09=09 irq->shorthand,
>  =09=09=09=09=09=09 irq->dest_id,
>  =09=09=09=09=09=09 irq->dest_mode))
>  =09=09=09=09continue;

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

--=20
Vitaly

