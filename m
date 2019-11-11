Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A2DC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 15:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAB0321655
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 15:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O2EKXZ6u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfKKP6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 10:58:36 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:45614 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726857AbfKKP6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 10:58:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573487914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:openpgp;
        bh=/zG3yoOFQ60fgDUu8iKgwOvLofe+T2ZT+OEjsdj3fPg=;
        b=O2EKXZ6u1/DY7o3DsNRk4yZY0zXVtoqxeX0NQJOyb1N+/PsTCcvHQNyw+MKuQb9USPtDQ3
        lD0oUbMOjmz5X/GvAeR1mRmmaEg+LiHHcNGsyn2KGrkbG7pBGlWmveDbVP3RuGzT6vfN3k
        kJ1ER5boN2fWiffRdQaNmD8wU7mbVK0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-c_KtEQboPJ27eSAl31xmyA-1; Mon, 11 Nov 2019 10:58:33 -0500
Received: by mail-wr1-f71.google.com with SMTP id k15so2924039wrp.22
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 07:58:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F+pHRgddGzkdWCbCt4gYbg2WEhYZkSyJrPGHwvy6a9c=;
        b=rbEWZEmgsxPuhpkwqpfsj0JOfSXoL1UDJnsOpos203StFMilmo3R+2WE/svAlqZhZ8
         qi0VQYKAU4EDz8HVx8pukZpxmAEXUYk+sM6kIAfiNYp1N0POr3YEgbgFV8XOo6MCMVWJ
         81a3EDrBOHu7lkAlFjh2Ltvd72ZYgbZtw2ONTHUWZCZz4R44dPTe4mcOcYdbIBnsjpeo
         xYuxSSi9+5gySZo6iP6QWDWynI1RTEJSWfcACTSU0s/tJYafsUTA7vs89L9jB+qGbk6t
         C7wOJAnRfxGqJjpaXkdesRKkogcT+Jriw2Dh/pJBOdilOez32T0xX8JPt5aPzgIqXhjx
         c/5A==
X-Gm-Message-State: APjAAAUUt+bReojEL7jryAqRComjw1pfquHedodUdXQfKcCKH7HkzVim
        Nk5MgarH+DptaA8xSmDKZd3HYA/o9Hi9+F3L9n6L+bSQz3nBmXDyVDDn4xRm1ZWSe4cxchxPRBR
        fD+TiCq9nC8oTF4dqwevlbiOw
X-Received: by 2002:a5d:4684:: with SMTP id u4mr16878024wrq.352.1573487912239;
        Mon, 11 Nov 2019 07:58:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqxw608qPouIK70cqcZgnAxYAHqrbWvSLLa0LOs7sqcaAEh0bFhnzAfOp3FrLOC4KyShX/8xbw==
X-Received: by 2002:a5d:4684:: with SMTP id u4mr16877997wrq.352.1573487911940;
        Mon, 11 Nov 2019 07:58:31 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:a0f7:472a:1e7:7ef? ([2001:b07:6468:f312:a0f7:472a:1e7:7ef])
        by smtp.gmail.com with ESMTPSA id w17sm8727264wrt.45.2019.11.11.07.58.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2019 07:58:31 -0800 (PST)
Subject: Re: [PATCH v1 1/3] KVM: VMX: Consider PID.PIR to determine if vCPU
 has pending interrupts
To:     Joao Martins <joao.m.martins@oracle.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Liran Alon <liran.alon@oracle.com>,
        Jag Raman <jag.raman@oracle.com>
References: <20191106175602.4515-1-joao.m.martins@oracle.com>
 <20191106175602.4515-2-joao.m.martins@oracle.com>
 <67bca655-fea3-4b57-be3c-7dc58026b5d9@redhat.com>
 <030dd147-8c4f-d6e3-85a8-ee743ce4d5b0@oracle.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <5ee4c4ae-9d22-d560-bb61-e5f40b56da2e@redhat.com>
Date:   Mon, 11 Nov 2019 16:58:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <030dd147-8c4f-d6e3-85a8-ee743ce4d5b0@oracle.com>
Content-Language: en-US
X-MC-Unique: c_KtEQboPJ27eSAl31xmyA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/19 15:59, Joao Martins wrote:
>> Should we check the bitmap only if SN is false?
                                            ^^^^^

Of course it should be skipped if SN is false, as you correctly say below.

>> We have a precondition
>> that if SN is clear then non-empty PIR implies ON=3D1 (modulo the small
>> window in vmx_vcpu_pi_load of course), so that'd be a bit faster.
> Makes sense;
>=20
> The bitmap check was really meant for SN=3D1.
>=20
> Should SN=3D0 we would be saving ~22-27 cycles as far as I micro-benchmar=
ked a few
> weeks ago. Now that you suggest it, it would be also good for older platf=
orms too.

Or even newer platforms if they don't use VT-d.

Paolo

