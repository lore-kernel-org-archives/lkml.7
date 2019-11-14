Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A414C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 12:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D96E20718
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 12:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CWMhGPaU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbfKNMQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 07:16:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56828 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726469AbfKNMQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 07:16:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573733793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6g3FuiSmJL+Kk/iwiMI9WeS/k56NyXnRD61zjnDeFo8=;
        b=CWMhGPaUV0aKGd4SQk5OlLb7qD4pwJ81W2piEt/dB2oRo6m+w6YeoO2CMqXwDx0U3J6zBB
        r3ob9WqqJCTyY1ZlIxYwYBsQbwuBSYON2zXLRrGo7Ee6jTAHzg1X1+OquUFGCOY2BCXcmV
        O2Wg3FiM8eCEX05YMGNmyPBPDAxvABY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-F_irfEmtNmiIm8ZA6zRiGQ-1; Thu, 14 Nov 2019 07:16:32 -0500
Received: by mail-wm1-f70.google.com with SMTP id i23so3254729wmb.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 04:16:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wbG6hQQW5/T3L1JRr4XcKwwPNPz10SDjCnOLcci1gTs=;
        b=YAFEaxsrwu+2kDoj6/5+8hccqCOGr/LayUXVBBRXSuksmPeIaPmVkgqNfu14im4sAq
         GYftR/Zm9STI+dCJ5TyyJA/n+7fBRSCd4ub0QG/oMGhzv6o4abQY9lmxZGcUq1hfDs35
         2OuSWQuoZ3KmyRlEhSlKwWGvuiSL08sVRG2HAtvrWuHABbZ+XgzaBSvLHvkprWKt82eo
         ZNYVJjG/ZYknDwubwkNjR1G/Ok676ZG2J7xfzfjvu1uv8a1Yecql5hW6bNcvfpUeuVvF
         eHjJqVkrerJ1ACmn/7okvGLNA5ZSOGP9y7JD6dCWw3veyf7OpGjAFwD4Gb4rdXpZJMBT
         Mk3w==
X-Gm-Message-State: APjAAAW4ykmaXqnAeTrF7ZzZaQi9Un4GfFVeHhmCLUGxPNA3If4y9cnf
        tTYEBhWs9NU/ehRiboOJA8Sz1aXkPEUH/UnFf9p9HOpKDGv8k1r0FRocnwhO+9CyGv2YgkaAtUg
        Cwe03s6Kgb1PHi2NjwAxEVEHO
X-Received: by 2002:a1c:7f94:: with SMTP id a142mr7299108wmd.33.1573733791357;
        Thu, 14 Nov 2019 04:16:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqwm8L07aob9pGVI1BqTnXUFu0oi7C7NBJZTfOSxIoMVifSd1LDxfNMr/utRbXLIyyw76nANLw==
X-Received: by 2002:a1c:7f94:: with SMTP id a142mr7299081wmd.33.1573733791064;
        Thu, 14 Nov 2019 04:16:31 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:a15b:f753:1ac4:56dc? ([2001:b07:6468:f312:a15b:f753:1ac4:56dc])
        by smtp.gmail.com with ESMTPSA id w13sm6588216wrm.8.2019.11.14.04.16.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2019 04:16:30 -0800 (PST)
Subject: Re: [PATCH] selftests: kvm: Simplify loop in kvm_create_max_vcpus
 test
To:     Wainer dos Santos Moschetta <wainersm@redhat.com>,
        rkrcmar@redhat.com
Cc:     shuah@kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191112142111.13528-1-wainersm@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <70986b1a-5a04-cbd6-fe1a-fda4d97d5a72@redhat.com>
Date:   Thu, 14 Nov 2019 13:16:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191112142111.13528-1-wainersm@redhat.com>
Content-Language: en-US
X-MC-Unique: F_irfEmtNmiIm8ZA6zRiGQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/19 15:21, Wainer dos Santos Moschetta wrote:
> On kvm_create_max_vcpus test remove unneeded local
> variable in the loop that add vcpus to the VM.
>=20
> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> ---
>  tools/testing/selftests/kvm/kvm_create_max_vcpus.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>=20
> diff --git a/tools/testing/selftests/kvm/kvm_create_max_vcpus.c b/tools/t=
esting/selftests/kvm/kvm_create_max_vcpus.c
> index 231d79e57774..6f38c3dc0d56 100644
> --- a/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
> +++ b/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
> @@ -29,12 +29,9 @@ void test_vcpu_creation(int first_vcpu_id, int num_vcp=
us)
> =20
>  =09vm =3D vm_create(VM_MODE_DEFAULT, DEFAULT_GUEST_PHY_PAGES, O_RDWR);
> =20
> -=09for (i =3D 0; i < num_vcpus; i++) {
> -=09=09int vcpu_id =3D first_vcpu_id + i;
> -
> +=09for (i =3D first_vcpu_id; i < first_vcpu_id + num_vcpus; i++)
>  =09=09/* This asserts that the vCPU was created. */
> -=09=09vm_vcpu_add(vm, vcpu_id);
> -=09}
> +=09=09vm_vcpu_add(vm, i);
> =20
>  =09kvm_vm_free(vm);
>  }
>=20

Queued, thanks.

Paolo

