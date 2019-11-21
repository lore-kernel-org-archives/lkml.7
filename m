Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B82C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 10:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE6652088F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 10:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z3Oi5VJk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfKUKnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 05:43:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45302 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726358AbfKUKnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 05:43:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574332994;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J3W8i0iOJEXyO2QTbJjCdfj028+OhlnLk7ZsSbSMbcA=;
        b=Z3Oi5VJk9VhLN8pWasgRFUH38sGstTD+XQatcEMYAFIIFid2kfoyJFnbhUJ6opD2jl98mb
        VwkGM6TRjRtkdN3JyF9p7mD0cL0389wzdzHP7zNW8uNzB5xXwntezLX+7RMp8fPX7qmkrI
        jp5OeuS/7CfLAu9rE/O+0eYxFv5+3PU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-HRQeaBoyP3qF7NuTWpMLBg-1; Thu, 21 Nov 2019 05:43:13 -0500
Received: by mail-wr1-f72.google.com with SMTP id a3so1850728wrn.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 02:43:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZIjxSWOpncWMeofwzEZL33olSoz/0WCOZe4bbP5QEmM=;
        b=VnDtiYnzOdvziY3OhQouG5iocXys/QIBKzsXKvvW/YAu3dtZ15rpIy+aCdGXG7gyoE
         0kFoSnj/vqHC0JkIymgUJ/m0ZK7FfeCjQWTqJjg+bXsmD3N3W6++uPBy91E+/6GyIUUX
         UWlYD7G1gWdQve+CweM6LHvs3G8jlLnEjWKdji4ExAf7bqBrp4/OZ9IyOZ+AsYlxFg9a
         Zwc7tpTX3iM1z9bPsNNceIrWoHOBXoKekSrrtVJVPEXTCUAnAj5EnnC9EZN6xhvkyKrm
         ug4DQuHGiVOWPU7sPN07VxhGGltrnNNjfOLTY7cNq8SpVfU2ZuvPCBnkb9ojbpLFBdqz
         gPvw==
X-Gm-Message-State: APjAAAV8X8DHhtouV+YmdtYbxrNga6kNR0gP7sBOO0DTL9rDFNsNdiwJ
        PqsXg2KHdyQqoGNqvQqkOQ6cGL9oWEDF7Tl5o1LIEGCbQJF8WxVH1FdKqyuRE7AWLJCYnL9GF4f
        SD50hwL7sKhihypq67gFS44MX
X-Received: by 2002:a1c:480a:: with SMTP id v10mr9232146wma.138.1574332991584;
        Thu, 21 Nov 2019 02:43:11 -0800 (PST)
X-Google-Smtp-Source: APXvYqyCImg2J7Xc1OsIo0tikTSaBXY2RTIhLUoGtIR2rrRBxjuL0bnlR4mMAMX8ZoqqCoEEP3vZYg==
X-Received: by 2002:a1c:480a:: with SMTP id v10mr9232107wma.138.1574332991282;
        Thu, 21 Nov 2019 02:43:11 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:71a5:6e:f854:d744? ([2001:b07:6468:f312:71a5:6e:f854:d744])
        by smtp.gmail.com with ESMTPSA id u16sm2763530wrr.65.2019.11.21.02.43.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2019 02:43:10 -0800 (PST)
Subject: Re: [PATCH v7 4/9] mmu: spp: Add functions to create/destroy SPP
 bitmap block
To:     Yang Weijiang <weijiang.yang@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jmattson@google.com,
        sean.j.christopherson@intel.com
Cc:     yu.c.zhang@linux.intel.com, alazar@bitdefender.com,
        edwin.zhai@intel.com
References: <20191119084949.15471-1-weijiang.yang@intel.com>
 <20191119084949.15471-5-weijiang.yang@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8ad27209-cc28-0503-da0e-bead63b28a83@redhat.com>
Date:   Thu, 21 Nov 2019 11:43:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191119084949.15471-5-weijiang.yang@intel.com>
Content-Language: en-US
X-MC-Unique: HRQeaBoyP3qF7NuTWpMLBg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/11/19 09:49, Yang Weijiang wrote:
> =20
> +/*
> + * all vcpus share the same SPPT, vcpu->arch.mmu->sppt_root points to sa=
me
> + * SPPT root page, so any vcpu will do.
> + */
> +static struct kvm_vcpu *kvm_spp_get_vcpu(struct kvm *kvm)
> +{
> +=09struct kvm_vcpu *vcpu =3D NULL;
> +=09int idx;

Is this true?  Perhaps you need one with
VALID_PAGE(vcpu->arch.mmu->sppt_root) for kvm_spp_set_permission?

Also, since vcpu->arch.mmu->sppt_root is the same for all vCPUs, perhaps
it should be kvm->arch.sppt_root instead?

If you can get rid of this function, it would be much better (but if you
cannot, kvm_get_vcpu(kvm, 0) should give the same result).

>=20
> +=09if (npages > SUBPAGE_MAX_BITMAP)
> +=09=09return -EFAULT;

This is not needed here, the restriction only applies to the ioctl.

Paolo

