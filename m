Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A403C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 11:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E38EB21850
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 11:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FnbBvw6r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbfKSL7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 06:59:02 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35014 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727255AbfKSL7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 06:59:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574164739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WNk7YwivNmBzTn4XAkmjNVLEoNEllKj//e1z8yJUxjE=;
        b=FnbBvw6rgyvrhA3csz3ATvNzX+r4gr7YA+U/e5rWVzM6gwsz7V+tIBKVB15SSMiMIICoCO
        DAORAMC8C5Mar5/qgUHzmHeE0lcmU2t6dunODDjy6EY0KvctF5hjfwCVZRrgiSZm4fhuQm
        217XAvC6sw0gW95JAcP1pZY9T/2gcPg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-LjKOufdvNpKc3rFOhWMXLQ-1; Tue, 19 Nov 2019 06:58:56 -0500
Received: by mail-wm1-f70.google.com with SMTP id f14so2143996wmc.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 03:58:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=yA4apHy1PY+sWWp6DFYpM/EfZ8tIiKSEcg1QvrGG96M=;
        b=FWNiw7hLtaMHZR0bIQeeNAOJ2O1kRA4HhDY1rFuFDjk1G/H5H0dc9GDtSPQAgrLrMZ
         R+ceqyL0JDl296QzYlhHbPr6qV1LBHeb2UwkwS+CxWGil/dKCIQ+aK5plPc8//LrnV94
         +p/5gzsUwlhZ1SZH+V64agQCPPslwJWXi7igJp5SWXgF3WeMgQkT2QZ5FvYX5VWPHmc9
         uAnVxtIvWGQroVAPnnU9C81nAc0UuCn+EfmDENu7hvoo57ilEEB0MvA6HChgSbd66ZOs
         xldOIjhm42kgoFxb7tyyJYaY8wJNS3oy1igjBy4IP3E/3/LL5b/oQb0zgJnHN/aH22F4
         VO1Q==
X-Gm-Message-State: APjAAAXcrUpqfAOtafcrzGoaAnqyLxJdIow/Lx4kmpus75XASdFRmcxi
        HfBLtvV1SxErXNmn6uf5Ls6Hk8uTuJMKEqiBdQYEQes7ODl3f9fZS14j5MPlBQX5myC7ySAE4hw
        ++pgd2+Z0Ctz06o9jTA5zT/mI
X-Received: by 2002:a1c:f20c:: with SMTP id s12mr4811513wmc.37.1574164735670;
        Tue, 19 Nov 2019 03:58:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqwPvUClyKVAjFSwfYlymJ1AsJYdK5NmB51fvFtMn2o5bJnNnKM1MEvX4/tn/DqMYfIgcEOnpg==
X-Received: by 2002:a1c:f20c:: with SMTP id s12mr4811487wmc.37.1574164735432;
        Tue, 19 Nov 2019 03:58:55 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id j22sm29535555wrd.41.2019.11.19.03.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 03:58:54 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Mao Wenan <maowenan@huawei.com>, pbonzini@redhat.com,
        rkrcmar@redhat.com, sean.j.christopherson@intel.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Mao Wenan <maowenan@huawei.com>
Subject: Re: [PATCH -next] KVM: x86: remove set but not used variable 'called'
In-Reply-To: <20191119030640.25097-1-maowenan@huawei.com>
References: <20191119030640.25097-1-maowenan@huawei.com>
Date:   Tue, 19 Nov 2019 12:58:54 +0100
Message-ID: <87o8x8gjr5.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
X-MC-Unique: LjKOufdvNpKc3rFOhWMXLQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mao Wenan <maowenan@huawei.com> writes:

> Fixes gcc '-Wunused-but-set-variable' warning:
>
> arch/x86/kvm/x86.c: In function kvm_make_scan_ioapic_request_mask:
> arch/x86/kvm/x86.c:7911:7: warning: variable called set but not
> used [-Wunused-but-set-variable]
>
> It is not used since commit 7ee30bc132c6 ("KVM: x86: deliver KVM
> IOAPIC scan request to target vCPUs")

Better expressed as=20

Fixes: 7ee30bc132c6 ("KVM: x86: deliver KVM IOAPIC scan request to target v=
CPUs")

>
> Signed-off-by: Mao Wenan <maowenan@huawei.com>
> ---
>  arch/x86/kvm/x86.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 0d0a682..870f0bc 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -7908,12 +7908,11 @@ void kvm_make_scan_ioapic_request_mask(struct kvm=
 *kvm,
>  =09=09=09=09       unsigned long *vcpu_bitmap)
>  {
>  =09cpumask_var_t cpus;
> -=09bool called;
> =20
>  =09zalloc_cpumask_var(&cpus, GFP_ATOMIC);
> =20
> -=09called =3D kvm_make_vcpus_request_mask(kvm, KVM_REQ_SCAN_IOAPIC,
> -=09=09=09=09=09     vcpu_bitmap, cpus);
> +=09kvm_make_vcpus_request_mask(kvm, KVM_REQ_SCAN_IOAPIC,
> +=09=09=09=09    vcpu_bitmap, cpus);

IMHO as kvm_make_vcpus_request_mask() returns value it would probably
make sense to explicitly show that we're not interested in the result,

(void)kvm_make_vcpus_request_mask()

> =20
>  =09free_cpumask_var(cpus);
>  }

--=20
Vitaly

