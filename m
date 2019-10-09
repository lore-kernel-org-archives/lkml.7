Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546CEC47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 22:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 299FF218AC
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 22:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VWmNWM2R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732425AbfJIWuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 18:50:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44549 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732302AbfJIWuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 18:50:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570661416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:openpgp;
        bh=CbgpBG69W3Xxb5a6Ssxl5LP9mZoRKPa/mOy1gfjgbK4=;
        b=VWmNWM2RrmcUn42HEv79F3nFra8XUXCipzxTmeKM4ipclSCXdXAuVhvPDoupo5CdGTnDX2
        IEi7FVUsqPSQ3Oz0DfdSXlKUoPuBZaRTcNrPXt6AqIJ92mhQC+8+tIfHtzm0R3Hh/txTCI
        8IXb23faQEASUrUVhIK5mKAo/xHt6rs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-Dy8fMBZjMM6iVR-3T-xWIw-1; Wed, 09 Oct 2019 18:50:12 -0400
Received: by mail-wm1-f72.google.com with SMTP id l3so1707374wmf.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 15:50:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xsA6d1N0yHId/YtP2xKnkBmHpHSNLVq87w9E1zgqoSY=;
        b=NecrMyTJA5ZnfYmiOFOqpz+bOC1Ge7HtxLdXZ+29B5PgvInspHFV2s3TYhl+BxJgqT
         GXEjP7jifgzXPeCLLp40e/zxhpeG8MaZcAckkC4sOnW8VTOuvgDe2z96/iD5Le3myjgL
         3qWPH4xH/Eu17B9ixmYj1qTIJZdZVITxe4DFAwZmYNgvHVxK99OD7RXbS/Vb9iHsiUXU
         8xzFuyQufmdBrapKGdcj94CGTzUKDY/lH7JYe2iLKlZbK+wUE8Ynxcr6PNmz3JrAPo2J
         PLQB+aPR9fcSP57w2p3cfFn3PtLqrWpQBBUXMBTaqYN4Znyrr8zC4mZ/5Mnpudf67o/D
         pwrA==
X-Gm-Message-State: APjAAAVj7a+dpCI6Of9J39U+ICsbu6oUO1VjfnZKa3RWwmKG+Jd0TGIA
        VNlCasOd5uBM3KT68RC2FEKowbelI/E2gZZKOdqcVBfX1lXyddlgceLA53z3b+UoIzstuO6qQCU
        6TNBAwr7yghgFGbqCxaNCeCKS
X-Received: by 2002:a5d:53c2:: with SMTP id a2mr4921129wrw.10.1570661411381;
        Wed, 09 Oct 2019 15:50:11 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy07hu4yFjDInGnWEM/eAkittSfEadjpJ+GUEnHkJRlZCXURorVeclhCVbEO1u3sqOAb5pfZw==
X-Received: by 2002:a5d:53c2:: with SMTP id a2mr4921118wrw.10.1570661411126;
        Wed, 09 Oct 2019 15:50:11 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id o1sm5141619wrs.78.2019.10.09.15.50.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2019 15:50:10 -0700 (PDT)
Subject: Re: [PATCH AUTOSEL 5.3 28/68] KVM: x86: Expose XSAVEERPTR to the
 guest
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, kvm@vger.kernel.org
References: <20191009170547.32204-1-sashal@kernel.org>
 <20191009170547.32204-28-sashal@kernel.org>
 <05acd554-dd0a-d7cd-e17c-90627fa0ec67@redhat.com>
 <20191009214048.irolhz4rwfdiqf2e@linutronix.de>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <7119916d-462e-8ba8-300c-c165d9df045a@redhat.com>
Date:   Thu, 10 Oct 2019 00:50:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191009214048.irolhz4rwfdiqf2e@linutronix.de>
Content-Language: en-US
X-MC-Unique: Dy8fMBZjMM6iVR-3T-xWIw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10/19 23:40, Sebastian Andrzej Siewior wrote:
>>>  =09const u32 kvm_cpuid_8000_0008_ebx_x86_features =3D
>>> +=09=09F(XSAVEERPTR) |
>>>  =09=09F(WBNOINVD) | F(AMD_IBPB) | F(AMD_IBRS) | F(AMD_SSBD) | F(VIRT_S=
SBD) |
>>>  =09=09F(AMD_SSB_NO) | F(AMD_STIBP) | F(AMD_STIBP_ALWAYS_ON);
>>> =20
>>>
>> Yet another example of a patch that shouldn't be stable material (in
>> this case it's fine, but there can certainly be cases where just adding
>> a single flag depends on core kernel changes).
>=20
> Also, taking advantage of this feature requires changes which just
> landed in qemu's master branch.

That's not a big deal, every QEMU supports every kernel and vice versa.

Paolo

