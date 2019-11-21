Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3317AC43215
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 14:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0993C206CB
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 14:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FRf4Yq58"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfKUO2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 09:28:30 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56172 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726396AbfKUO23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 09:28:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574346507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qunIedvZoqaKok1Es37xOr2zxDWhnBKGE2xiOqEdTbQ=;
        b=FRf4Yq58sva/1XDXJgU7CLjMuEkMXREQJPLr8uXTByWhOIxe0vCIHP0ucTxKMpPA9+NA5v
        K9NIgt6rMmgr2ppZL1fOGeF/7/vB538fP9ctMgXQX50T815w/jI03hX+7T0MyfizN3WtiO
        EAZkEHDtpGB3Kak30caENyRdYqIQhrw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-3DTjo0eGPaaL_vwr6N1Opw-1; Thu, 21 Nov 2019 09:28:26 -0500
Received: by mail-wm1-f72.google.com with SMTP id g13so4273975wme.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 06:28:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JDhlodKbBGR2xq2l8pd8Qh2cvnVa+E6rf/WWc4SNwIY=;
        b=mtZcVR7hICkOpKB1AShvVzPZmROe7hRf4396FiqYW/3/NQZdStgaYctyAhjKw2TUo1
         ln8SFDZuYIYVi3ZA41TAxJv+PXbHLvZ6AIAqtpLrjUvwxE9OFLuyECgEimigQElprrHI
         L58WHTyo8nAAGomyuwiNe/BCzqpIBlJAnuwRJjVvliIaMb5qDXcHh0jSSS1kvsyGL/jS
         1OC5zAk86m/61Hei9/dcijxCoZaE5H8zXrGiLqQsIq/4NANePzFUklDmcRB/cf13eIiH
         r1wlMOCAmEYw4NJKlVmWN5L6n262hzXeIoQkwkRZJHz0c62hYiDDHOsrDYrLAE1dWaSi
         zWSw==
X-Gm-Message-State: APjAAAUzaDxHG9eWAHV7+nx+qWTyFsN8q4WfjhgPROKjPoWraQnAbawr
        svhQhrD26WPGsXXRu+LA+BG7ioguBFgMeJsGfvy4YLy0gVw0CRXyWO8oevSxe9wPpptIx+mqEGV
        0Ts/B7Gp2v48tqbqG2JCGh1lu
X-Received: by 2002:a05:600c:a:: with SMTP id g10mr10512011wmc.69.1574346505605;
        Thu, 21 Nov 2019 06:28:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqzUVQZfjhyuJakG9KLQtcyAWuccYrKFRy9I3c7KAp6hgXeIJo3EZCpQIagT3pe6x+eRjFMZrw==
X-Received: by 2002:a05:600c:a:: with SMTP id g10mr10511889wmc.69.1574346504369;
        Thu, 21 Nov 2019 06:28:24 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:71a5:6e:f854:d744? ([2001:b07:6468:f312:71a5:6e:f854:d744])
        by smtp.gmail.com with ESMTPSA id a8sm2973417wme.11.2019.11.21.06.28.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2019 06:28:23 -0800 (PST)
Subject: Re: [PATCH] KVM: nVMX: expose "load IA32_PERF_GLOBAL_CTRL" controls
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <1574343138-32015-1-git-send-email-pbonzini@redhat.com>
Message-ID: <d7c8232e-30b5-ca50-d5c4-34aed3210d31@redhat.com>
Date:   Thu, 21 Nov 2019 15:28:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1574343138-32015-1-git-send-email-pbonzini@redhat.com>
Content-Language: en-US
X-MC-Unique: 3DTjo0eGPaaL_vwr6N1Opw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/19 14:32, Paolo Bonzini wrote:
> These controls have always been supported (or at least have been
> supported for longer than nested_vmx_setup_ctls_msrs has existed),
> so we should advertise them to userspace.
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Nevermind, they're actually very new (lesson learnt: cut-and-paste of
commit messages is bad, especially if it leads to incorrect Cc to
stable).  Sending v2 at once...

Paolo

> ---
>  arch/x86/kvm/vmx/nested.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 4aea7d304beb..4b4ce6a804ff 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -5982,6 +5982,7 @@ void nested_vmx_setup_ctls_msrs(struct nested_vmx_m=
srs *msrs, u32 ept_caps,
>  #ifdef CONFIG_X86_64
>  =09=09VM_EXIT_HOST_ADDR_SPACE_SIZE |
>  #endif
> +=09=09VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL |
>  =09=09VM_EXIT_LOAD_IA32_PAT | VM_EXIT_SAVE_IA32_PAT;
>  =09msrs->exit_ctls_high |=3D
>  =09=09VM_EXIT_ALWAYSON_WITHOUT_TRUE_MSR |
> @@ -6001,6 +6002,7 @@ void nested_vmx_setup_ctls_msrs(struct nested_vmx_m=
srs *msrs, u32 ept_caps,
>  #ifdef CONFIG_X86_64
>  =09=09VM_ENTRY_IA32E_MODE |
>  #endif
> +=09=09VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL |
>  =09=09VM_ENTRY_LOAD_IA32_PAT;
>  =09msrs->entry_ctls_high |=3D
>  =09=09(VM_ENTRY_ALWAYSON_WITHOUT_TRUE_MSR | VM_ENTRY_LOAD_IA32_EFER);
>=20

