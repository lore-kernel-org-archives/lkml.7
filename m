Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEEA3C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 10:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9667F205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 10:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yf5rHw02"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfKUKD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 05:03:58 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20234 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726822AbfKUKD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 05:03:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574330636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CYOAB7bV5ap3IHHQiJdevHwX5dASFlE1sJd2aJRoNcU=;
        b=Yf5rHw02VfW8MY5N8GTB1pb9Ol1byJAK8PEqopwn+a+rnU6GrGVUDgsxFoC4iMu7nKd4tz
        LdD4QhEa9ZYF5NWh4cpH9R4GjEoejIpuaxmOML41ovYmTP0x2TbbQp0UmANXnbLKFb3kjj
        ANh9iuT2tT3gt4TfXBzGtil6DcwBGJo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-pbhyvHzEOEefiC3MN2laOQ-1; Thu, 21 Nov 2019 05:03:54 -0500
Received: by mail-wr1-f69.google.com with SMTP id u14so1765790wrq.19
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 02:03:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gUJQbhj/e5tGevDSbtGQG/RunMX4COKzOc4f2GEZTdM=;
        b=WSdo9hTkZKndFX/nrUMMZWkFc9quPuAbwPqrpTWFqtRyAVIlFGHd9Wx5iuGbRz23x6
         g+OkLClUeaaNfg4cTpQPh1CXd5CxFlcEKDff0id1cyEGGHjY110M3a/1C/l+Ahm/f6EU
         tBQ9zm6xgdTTU22aWWsraHsBh4//8f4xJyyBVN+MjihWHineWx2SM+f7tP+zLDtCdaUV
         btCfrQy2HsGfFFTFUQtiFbBwskmgBcsTLrXXuhESF46rXAeLstzAgVgpr4PxGASK8Lja
         0Su2uVKjgFBPRkx93L5PAYg95/2wyPOW0gDb5Zlo7ppMQ7xNhpRjbnMGmJSSTVdujV5Y
         9yEw==
X-Gm-Message-State: APjAAAWlZIybYL5GvMRCPbMcGskUwjYH3KPD1oGxo7MCvdAP186HZ5fz
        x+w3dOUFD46bHFZsA91PRbZAyY8RuV7h+yTCwZNONpYHcEBsKaXmYiXh7nzybCG00rpOwZecc9F
        m5DA9Tj7FMA21wz32OqjJfPZ8
X-Received: by 2002:a1c:6854:: with SMTP id d81mr9192490wmc.75.1574330633488;
        Thu, 21 Nov 2019 02:03:53 -0800 (PST)
X-Google-Smtp-Source: APXvYqxQZVVYwUMQnwyyspkBy0Yv+aj/pMZsjBnKogboxTJ33w5oRqIEJS2hl8TAWVFzYZQl+7zUJw==
X-Received: by 2002:a1c:6854:: with SMTP id d81mr9192459wmc.75.1574330633198;
        Thu, 21 Nov 2019 02:03:53 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:71a5:6e:f854:d744? ([2001:b07:6468:f312:71a5:6e:f854:d744])
        by smtp.gmail.com with ESMTPSA id b15sm2587300wrx.77.2019.11.21.02.03.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2019 02:03:52 -0800 (PST)
Subject: Re: [PATCH v7 5/9] x86: spp: Introduce user-space SPP IOCTLs
To:     Yang Weijiang <weijiang.yang@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jmattson@google.com,
        sean.j.christopherson@intel.com
Cc:     yu.c.zhang@linux.intel.com, alazar@bitdefender.com,
        edwin.zhai@intel.com
References: <20191119084949.15471-1-weijiang.yang@intel.com>
 <20191119084949.15471-6-weijiang.yang@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f8cd7d7c-7ffd-3ee4-bf5f-203f9a030fef@redhat.com>
Date:   Thu, 21 Nov 2019 11:03:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191119084949.15471-6-weijiang.yang@intel.com>
Content-Language: en-US
X-MC-Unique: pbhyvHzEOEefiC3MN2laOQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/11/19 09:49, Yang Weijiang wrote:
> +=09case KVM_INIT_SPP: {
> +=09=09r =3D kvm_vm_ioctl_init_spp(kvm);
> +=09=09break;
> +=09}
>  =09default:
>  =09=09r =3D -ENOTTY;
>  =09}
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 9460830de536..700f0825336d 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -1257,6 +1257,9 @@ struct kvm_vfio_spapr_tce {
>  =09=09=09=09=09struct kvm_userspace_memory_region)
>  #define KVM_SET_TSS_ADDR          _IO(KVMIO,   0x47)
>  #define KVM_SET_IDENTITY_MAP_ADDR _IOW(KVMIO,  0x48, __u64)
> +#define KVM_SUBPAGES_GET_ACCESS   _IOR(KVMIO,  0x49, __u64)
> +#define KVM_SUBPAGES_SET_ACCESS   _IOW(KVMIO,  0x4a, __u64)
> +#define KVM_INIT_SPP              _IOW(KVMIO,  0x4b, __u64)

You also need to define a capability and return a value for it in
kvm_vm_ioctl_check_extension.  We could return SUBPAGE_MAX_BITMAP (now
KVM_SUBPAGE_MAX_PAGES).  And instead of introducing KVM_INIT_SPP, you
can then use KVM_ENABLE_CAP on the new capability.

Paolo

