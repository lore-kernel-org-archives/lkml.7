Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE21ECE58C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 21:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ADE6206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 21:15:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WYNlHkfU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731884AbfJIVPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 17:15:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50816 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730815AbfJIVPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 17:15:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570655712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:openpgp;
        bh=7VmgJlX8pTLTmeUK2iuzqG3qzkbe72v0AjNOA3U4FSc=;
        b=WYNlHkfUJTeuvp9XqqfI/mVvOGdjOqx7gQAxp+np9u0lSvg9RrE/5uJSv2INz/dtbKMcbi
        l7tL41yZ3E8VcmVf2CuUkRfz1oBdsByLfrBFmBOGpxCcpWLLg9MYzgJYQyGsDRroclOQ2y
        7DyRwI1ucAcHgNgpAKAlKXRdSV8YAdk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-92-N3CRLTcIMICC9Ka9iLLLsg-1; Wed, 09 Oct 2019 17:15:11 -0400
Received: by mail-wr1-f70.google.com with SMTP id v17so1662966wru.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 14:15:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i6l3KX7zHJ5HDKx9SqXKsfD5zGuc3xvROj8VyAucjM0=;
        b=dqkSOfANUCcAvEFpq6XW6voHT8cNfe14GBmaVW5PR0RLTaOm63lC9YdNX43CIP4sej
         ARGP42BkwPMp3/U2b2TwVmRYPjZqHaRAkCyIbcZ4ZwADq594rMDoQRaPh7RFEx9f/fto
         kPksPHlfxXQT8g1YyAMSD6kkeECvB1l4nUo9kIutuNPITrQSp9aSvyIfQJPpo6sYK/OV
         UBeHTT8ZnOobfoWcsAYbfgnHuYJGe3Mar1VQuOW/d3GkAgIbvABEAeqw3Q9hcfjXd5rs
         u+h6a+VEQwYq3jmawqA6kwCiqJsYo69gT1IbgAHXebJii4S8HMb6VNEG4YQZ+byy9sAo
         TOwQ==
X-Gm-Message-State: APjAAAXG6QLFOD658K1QxvTwIvvlkvMozQx/jhqt52VJsdIlIHXRQ2YT
        wUgSeoINCOkXCTCRNaPhHToxZrG2ZOs90FmTH3KE527ECCWjp1uMGhpOxZ+JBA/oCM9ewmbxsnj
        Z/uk+Vqks8JotdwhikyDneswu
X-Received: by 2002:a7b:cb54:: with SMTP id v20mr4103776wmj.91.1570655709794;
        Wed, 09 Oct 2019 14:15:09 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyZjJA1LTm5EeJ/fmz3nZAMmXsY1yAaPjxR1Gi2GVNEpEkekFZxvaPx1RlKODkjSwiZVB8kTw==
X-Received: by 2002:a7b:cb54:: with SMTP id v20mr4103761wmj.91.1570655709497;
        Wed, 09 Oct 2019 14:15:09 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:1032:7ea1:7f8f:1e5? ([2001:b07:6468:f312:1032:7ea1:7f8f:1e5])
        by smtp.gmail.com with ESMTPSA id l9sm2821110wme.45.2019.10.09.14.15.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2019 14:15:08 -0700 (PDT)
Subject: Re: [PATCH AUTOSEL 5.3 28/68] KVM: x86: Expose XSAVEERPTR to the
 guest
To:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        kvm@vger.kernel.org
References: <20191009170547.32204-1-sashal@kernel.org>
 <20191009170547.32204-28-sashal@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <05acd554-dd0a-d7cd-e17c-90627fa0ec67@redhat.com>
Date:   Wed, 9 Oct 2019 23:15:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191009170547.32204-28-sashal@kernel.org>
Content-Language: en-US
X-MC-Unique: N3CRLTcIMICC9Ka9iLLLsg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10/19 19:05, Sasha Levin wrote:
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>=20
> [ Upstream commit 504ce1954fba888936c9d13ccc1e3db9b8f613d5 ]
>=20
> I was surprised to see that the guest reported `fxsave_leak' while the
> host did not. After digging deeper I noticed that the bits are simply
> masked out during enumeration.
>=20
> The XSAVEERPTR feature is actually a bug fix on AMD which means the
> kernel can disable a workaround.
>=20
> Pass XSAVEERPTR to the guest if available on the host.
>=20
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  arch/x86/kvm/cpuid.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index fd1b8db8bf242..59b66e343fa5a 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -479,6 +479,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_en=
try2 *entry, u32 function,
> =20
>  =09/* cpuid 0x80000008.ebx */
>  =09const u32 kvm_cpuid_8000_0008_ebx_x86_features =3D
> +=09=09F(XSAVEERPTR) |
>  =09=09F(WBNOINVD) | F(AMD_IBPB) | F(AMD_IBRS) | F(AMD_SSBD) | F(VIRT_SSB=
D) |
>  =09=09F(AMD_SSB_NO) | F(AMD_STIBP) | F(AMD_STIBP_ALWAYS_ON);
> =20
>=20

Yet another example of a patch that shouldn't be stable material (in
this case it's fine, but there can certainly be cases where just adding
a single flag depends on core kernel changes).

Paolo

