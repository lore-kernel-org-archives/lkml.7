Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC452C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 08:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90B01222C3
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 08:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DXIF5TwH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729580AbfIZImq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 04:42:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22948 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726393AbfIZImq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 04:42:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569487363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:openpgp;
        bh=1z+xvVMawTHS8E7IV5HtLpWm+mC44JoWwY3oLMaHguc=;
        b=DXIF5TwHBlxDPlarq+2l2oreddjUeaU77EK+YNxBnB7JzqKaW/4uHUuRuOvwuBf9OBuZ9W
        Gw/NgW28C6l9SPLP0t2mM4S/MoC7oBHYz4NGOXhbSLmromkRPxgVLK0HOQHB5fkEMU/Zov
        DXflM3dO6KDNW+GC6FuHlrP2oZ4KUAM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-110-b__KOa_0OYWeDrzqTvzekw-1; Thu, 26 Sep 2019 04:42:41 -0400
Received: by mail-wm1-f72.google.com with SMTP id q9so816886wmj.9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 01:42:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o+SEWE7G4AdORNcTi1tw9YQZ4tXXB3xOkXrkeIS3AkM=;
        b=hTtIKUNLN/BsPf3qySDeCJ9hZCsqmRotRrV1XmBHaeCh0D4plHOgYI2lj1nysZUL1z
         yIrklpTe1eA4cvASjciaGk3ugh+k4qAS+zCvolgsGkKGpBXpCj/8wu6/7rdRxDApTAGK
         s57Jj2KOj6f/nuJyhI0fbVdqKuDUPT2b4ZdlaA1QwIAVL9R574UIRe7gobYzaSi2rIDk
         r4SqzimlAEaUBTsqrCYPobgukcN+8rQspI8cgRAV1CARkuwyvolkcTsJy6nXkiXJwG2Q
         vN9FNWbl9zclkzsTTKa94P+al2+TGOyJXNIlWiEjuyKa68omCn19hpCcN/ik7yDgKguQ
         M9kQ==
X-Gm-Message-State: APjAAAU2T1Kyw88fcJSlOn9xH0iTpH5vY5JoN1V1C037OvrL7BvcHMqh
        Tm8R3fP+8JRsPC9lQOwtyNjY2NFXX076ToC8gJpzJnimBVuN04bhSI0t3t8fAcAVik0Q9ISHvd7
        hRRscLxdJrB0kHtF/EgaOI1RG
X-Received: by 2002:a5d:49c3:: with SMTP id t3mr1846740wrs.151.1569487360022;
        Thu, 26 Sep 2019 01:42:40 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwBct3zOdHtdxrLlHsSLaUksk4VXWTnA45yCTfyFmUAYZ2XJdu6WLhVoVo+g2mejNtS0AOt3w==
X-Received: by 2002:a5d:49c3:: with SMTP id t3mr1846722wrs.151.1569487359724;
        Thu, 26 Sep 2019 01:42:39 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9520:22e6:6416:5c36? ([2001:b07:6468:f312:9520:22e6:6416:5c36])
        by smtp.gmail.com with ESMTPSA id l10sm2461090wrh.20.2019.09.26.01.42.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2019 01:42:39 -0700 (PDT)
Subject: Re: [PATCH] KVM: nVMX: cleanup and fix host 64-bit mode checks
To:     Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        Jim Mattson <jmattson@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
References: <1569429286-35157-1-git-send-email-pbonzini@redhat.com>
 <CALMp9eTBPTnsRDipdGDgmugWgfFEjQ2wd_9-JY0ZeM9YG2fBjg@mail.gmail.com>
 <3460bd57-6fdd-f73c-9ce0-c97d4cc85f63@oracle.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <1543003a-9a2f-2a52-444a-d55bde6b8e2f@redhat.com>
Date:   Thu, 26 Sep 2019 10:42:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <3460bd57-6fdd-f73c-9ce0-c97d4cc85f63@oracle.com>
Content-Language: en-US
X-MC-Unique: b__KOa_0OYWeDrzqTvzekw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/09/19 01:55, Krish Sadhukhan wrote:
>=20
>=20
> On 09/25/2019 09:47 AM, Jim Mattson wrote:
>> On Wed, Sep 25, 2019 at 9:34 AM Paolo Bonzini <pbonzini@redhat.com>
>> wrote:
>>> KVM was incorrectly checking vmcs12->host_ia32_efer even if the "load
>>> IA32_EFER" exit control was reset.=C2=A0 Also, some checks were not usi=
ng
>>> the new CC macro for tracing.
>>>
>>> Cleanup everything so that the vCPU's 64-bit mode is determined
>>> directly from EFER_LMA and the VMCS checks are based on that, which
>>> matches section 26.2.4 of the SDM.
>>>
>>> Cc: Sean Christopherson <sean.j.christopherson@intel.com>
>>> Cc: Jim Mattson <jmattson@google.com>
>>> Cc: Krish Sadhukhan <krish.sadhukhan@oracle.com>
>>> Fixes: 5845038c111db27902bc220a4f70070fe945871c
>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>> ---
>>> =C2=A0 arch/x86/kvm/vmx/nested.c | 53
>>> ++++++++++++++++++++---------------------------
>>> =C2=A0 1 file changed, 22 insertions(+), 31 deletions(-)
>>>
>>> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
>>> index 70d59d9304f2..e108847f6cf8 100644
>>> --- a/arch/x86/kvm/vmx/nested.c
>>> +++ b/arch/x86/kvm/vmx/nested.c
>>> @@ -2664,8 +2664,26 @@ static int nested_vmx_check_host_state(struct
>>> kvm_vcpu *vcpu,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 CC(!kvm_pat_valid(vmcs12->host_ia32_pat)))
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>>>
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ia32e =3D (vmcs12->vm_exit_contro=
ls &
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 VM_EXIT_HOST_ADDR_SPACE_SIZE) !=3D 0;
>>> +#ifdef CONFIG_X86_64
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ia32e =3D !!(vcpu->arch.efer & EF=
ER_LMA);
>>> +#else
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (CC(vmcs12->vm_entry_controls =
& VM_ENTRY_IA32E_MODE))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return -EINVAL;
>> This check is redundant, since it is checked in the else block below.
>=20
> Should we be re-using is_long_mode() instead of duplicating the code ?

Of course!  I have already pushed the patch, but I will send a follow up.

Paolo

