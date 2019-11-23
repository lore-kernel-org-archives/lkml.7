Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA6BC432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 10:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E61920706
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 10:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eMF/Emd+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfKWK2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 05:28:53 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28686 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726141AbfKWK2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 05:28:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574504931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:openpgp;
        bh=4tanX7i7KcH5r5sp86+hzp4NVa2zdCctCVhumJRLPOU=;
        b=eMF/Emd+UdenxO8dAq89QwCucmfhOT3iiKWdn0NC/VcZF8A4w6KZy5GslOYNjgWrKs6bp0
        YDKCA2n5H5eYiAKKXbFb4IUNHrDi7KoG/FXQqkvTctNntIJ5KvLRqWTz7dRIuI1CYfLTmH
        xWehoVXawiMIz1yKzM8OxRRpXar9SxQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-oAgNIKIEMV6XarlZraLOcg-1; Sat, 23 Nov 2019 05:28:49 -0500
Received: by mail-wm1-f69.google.com with SMTP id m68so4590244wme.7
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2019 02:28:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kQ6hGferHGL1L9ZhEoN6QHHY4p/q+t8P9KyFKfImRlM=;
        b=MBAF2amvYq/yukFjUSpjCtKGxCIfS1XRGJPg2wb6dyztntdqYaeCT6BeibDLjgUPA1
         4wYIsJcL7bDcUxx/0uW306vF11mvHpdKXUf1wiksBJx5DhhIN7tLhxY7/XaZJPOsSmb8
         TDPuKmZe9p3s91yJxPYJAWLApMa/D/GGYnQD9Yf6wX4SzxgpVYJi0s2Sg3lSQMSScvNf
         D0kJBRmr9CRTONsRNlE/RIy0TOgW5mVPakji6YT1fixMV15kPRrJ+m2cuuftI4icJJtz
         CofVBDq/qdkNG/4tOFZuD57q8hAyr9KQu1kcUGS2O0NPuHKnpYl6Nx2T4X4SrqfASZbY
         +Nng==
X-Gm-Message-State: APjAAAXrjQLKQQV4/ZEK6XZjISN2QUptd1bYsyPIoxA1AaQJRGAyVD7e
        O+hMRzXMDWfSxZ/cF8aF9v/0ulnyLPk2SQO2GkWUw3b3d60+AWq03Q9hNeskb8rS4XBp6FXJ7uK
        G7jA/+DpsGIxdW93gRWmDeiQz
X-Received: by 2002:a7b:c84b:: with SMTP id c11mr19268146wml.158.1574504928501;
        Sat, 23 Nov 2019 02:28:48 -0800 (PST)
X-Google-Smtp-Source: APXvYqy4xCz0dXTtexlA9Uc6i/YILe7MVHjojQkEJS0nbbNGxD8iTzmKHbIesOw080i43k7qZDM+8A==
X-Received: by 2002:a7b:c84b:: with SMTP id c11mr19268125wml.158.1574504928227;
        Sat, 23 Nov 2019 02:28:48 -0800 (PST)
Received: from [192.168.42.104] (mob-109-112-4-118.net.vodafone.it. [109.112.4.118])
        by smtp.gmail.com with ESMTPSA id y6sm1695912wrn.21.2019.11.23.02.28.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Nov 2019 02:28:47 -0800 (PST)
Subject: Re: [PATCH] KVM: x86: Remove a spurious export of a static function
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191122201549.18321-1-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <48aa2a88-560f-fa16-746f-d7398dafa086@redhat.com>
Date:   Sat, 23 Nov 2019 11:28:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191122201549.18321-1-sean.j.christopherson@intel.com>
Content-Language: en-US
X-MC-Unique: oAgNIKIEMV6XarlZraLOcg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/11/19 21:15, Sean Christopherson wrote:
> A recent change inadvertantly exported a static function, which results
> in modpost throwing a warning.  Fix it.
>=20
> Fixes: cbbaa2727aa3 ("KVM: x86: fix presentation of TSX feature in ARCH_C=
APABILITIES")
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/x86.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index a256e09f321a..3e9ab2d1ea77 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -1329,7 +1329,6 @@ static u64 kvm_get_arch_capabilities(void)
> =20
>  =09return data;
>  }
> -EXPORT_SYMBOL_GPL(kvm_get_arch_capabilities);
> =20
>  static int kvm_get_msr_feature(struct kvm_msr_entry *msr)
>  {
>=20

Queued, thanks.

Paolo

