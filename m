Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C5D3C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 22:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC8D0214E0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 22:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T8TeLpSY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbfKKWoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 17:44:24 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53113 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726912AbfKKWoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 17:44:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573512262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:openpgp;
        bh=2dlEs3B9QjoIQ3vj+lubsfex7szbCACGKPMb3p+Czto=;
        b=T8TeLpSYqPZ5pkExqBEhDAa8tOedUg3TKOy57jearfK24353wz3B4JiRxl3clIqOmP0xzb
        KmKn7QTUNB98PhfQq/NLRTNI/zw4P46yMKrjwSqQas7dnjVrcP1qK4V/PDq1riTqqttM5e
        NyZ8/l8a+lqH+zvNe0FFU+EyZdiGYAc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-FoCS-q7oOMaMUxAA1z1LTw-1; Mon, 11 Nov 2019 17:44:21 -0500
Received: by mail-wm1-f72.google.com with SMTP id f191so525979wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 14:44:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oDHcaNKg+MVKKIoR8GaTvy2X86pPKZmfAppo1Zlc7qw=;
        b=AyETBLur8juvbaDXW64qPxxMKN44JumY7hsTMhPh+XGyLn9qPOiarXY0dx0l2wW7LJ
         LmvjdypBM/ohcCHowACa5V7XD2I2IaFSj4PkBm4lixsyqvBWDOQUY4OAFR+tf1meI8uJ
         KquPzBGDjGNpfFO2HIqQcE5p7OlLIVgWbVTz9yCOh1+0rq9Za0WNr7Fdj7m0P8sKBH5c
         xASwevk6vC5zDS8H5capuTZAV9Uj3zp3edBz2SkAnhWYwgYbmHbiJEecdW20bCsK4a8j
         aon49cSi7kXfJf67X+Izws5MSdYpDbUROjdVhh1fx84S+szEfPXWP55Y6OlNW51Ccwdj
         yGMQ==
X-Gm-Message-State: APjAAAUCiZ3fAA7fhKRcBQjyiK81kSAggYBDoxZZAWhL3Y2KccjW4uut
        OL3to1nERLG8Z8+jB1lHc229CI/5QaT/Fru5LCkS5GLEN2NbODPBWv10X4h8V3/AmwH1ZkzYsDg
        Ide6CGMCKBRdPVBS7Ct1Lhj9I
X-Received: by 2002:a7b:c4c8:: with SMTP id g8mr1031932wmk.36.1573512259982;
        Mon, 11 Nov 2019 14:44:19 -0800 (PST)
X-Google-Smtp-Source: APXvYqylExp9fqprV0HMqzRh0m3EQNiJPxPxcH+zpzMfy7NcGW4ftBU3C7w7MKJYBKlMNMicPfk9oQ==
X-Received: by 2002:a7b:c4c8:: with SMTP id g8mr1031913wmk.36.1573512259625;
        Mon, 11 Nov 2019 14:44:19 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:8c9d:1a6f:4730:367c? ([2001:b07:6468:f312:8c9d:1a6f:4730:367c])
        by smtp.gmail.com with ESMTPSA id 65sm35272538wrs.9.2019.11.11.14.44.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2019 14:44:19 -0800 (PST)
Subject: Re: [patch V2 04/16] x86/tss: Fix and move VMX BUILD_BUG_ON()
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linuxfoundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20191111220314.519933535@linutronix.de>
 <20191111223051.865129706@linutronix.de>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <cf3eeec6-8540-2ad8-8d51-17c8f4d4f37b@redhat.com>
Date:   Mon, 11 Nov 2019 23:44:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191111223051.865129706@linutronix.de>
Content-Language: en-US
X-MC-Unique: FoCS-q7oOMaMUxAA1z1LTw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/19 23:03, Thomas Gleixner wrote:
> The BUILD_BUG_ON(IO_BITMAP_OFFSET - 1 =3D=3D 0x67) in the VMX code is bog=
us in
> two aspects:
>=20
> 1) This wants to be in generic x86 code simply to catch issues even when
>    VMX is disabled in Kconfig.
>=20
> 2) The IO_BITMAP_OFFSET is not the right thing to check because it makes
>    asssumptions about the layout of tss_struct. Nothing requires that the
>    I/O bitmap is placed right after x86_tss, which is the hardware mandat=
ed
>    tss structure. It pointlessly makes restrictions on the struct
>    tss_struct layout.
>=20
> The proper thing to check is:
>=20
>     - Offset of x86_tss in tss_struct is 0
>     - Size of x86_tss =3D=3D 0x68
>=20
> Move it to the other build time TSS checks and make it do the right thing=
.
>=20
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> ---
> V2: New patch
> ---
>  arch/x86/kvm/vmx/vmx.c       |    8 --------
>  arch/x86/mm/cpu_entry_area.c |    8 ++++++++
>  2 files changed, 8 insertions(+), 8 deletions(-)
>=20
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -1338,14 +1338,6 @@ void vmx_vcpu_load_vmcs(struct kvm_vcpu
>  =09=09=09    (unsigned long)&get_cpu_entry_area(cpu)->tss.x86_tss);
>  =09=09vmcs_writel(HOST_GDTR_BASE, (unsigned long)gdt);   /* 22.2.4 */
> =20
> -=09=09/*
> -=09=09 * VM exits change the host TR limit to 0x67 after a VM
> -=09=09 * exit.  This is okay, since 0x67 covers everything except
> -=09=09 * the IO bitmap and have have code to handle the IO bitmap
> -=09=09 * being lost after a VM exit.
> -=09=09 */
> -=09=09BUILD_BUG_ON(IO_BITMAP_OFFSET - 1 !=3D 0x67);
> -
>  =09=09rdmsrl(MSR_IA32_SYSENTER_ESP, sysenter_esp);
>  =09=09vmcs_writel(HOST_IA32_SYSENTER_ESP, sysenter_esp); /* 22.2.3 */
> =20
> --- a/arch/x86/mm/cpu_entry_area.c
> +++ b/arch/x86/mm/cpu_entry_area.c
> @@ -161,6 +161,14 @@ static void __init setup_cpu_entry_area(
>  =09BUILD_BUG_ON((offsetof(struct tss_struct, x86_tss) ^
>  =09=09      offsetofend(struct tss_struct, x86_tss)) & PAGE_MASK);
>  =09BUILD_BUG_ON(sizeof(struct tss_struct) % PAGE_SIZE !=3D 0);
> +=09/*
> +=09 * VMX changes the host TR limit to 0x67 after a VM exit. This is
> +=09 * okay, since 0x67 covers the size of struct x86_hw_tss. Make sure
> +=09 * that this is correct.
> +=09 */
> +=09BUILD_BUG_ON(offsetof(struct tss_struct, x86_tss) !=3D 0);
> +=09BUILD_BUG_ON(sizeof(struct x86_hw_tss) !=3D 0x68);
> +
>  =09cea_map_percpu_pages(&cea->tss, &per_cpu(cpu_tss_rw, cpu),
>  =09=09=09     sizeof(struct tss_struct) / PAGE_SIZE, tss_prot);
> =20
>=20
>=20

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

