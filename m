Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51571C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25676214E0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UNQigh/y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfKKOut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 09:50:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44129 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726973AbfKKOus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 09:50:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573483847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:openpgp;
        bh=/Y+HzRAUFsvF1UeJYBbnveE27mBFQ3aDExiHToOSyEQ=;
        b=UNQigh/yQDjYEzjM77SoRHq/q1mDGWRIKY3ADNT/AHOJcrZKgAfmGSL/jIPiA14nAJXkeS
        6rMMbjqpijL6lBxInfFNgiEgpj/kck9rT1HsT71bwE3ABnYJwLjzL2b9y8wFIZjcmaUQdA
        WzDY+EHsCkyPp/ZNzDxzjuMNCjbix8c=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-kz7m4YPsMceyz22T28-RUA-1; Mon, 11 Nov 2019 09:50:44 -0500
Received: by mail-wm1-f69.google.com with SMTP id 2so8490871wmd.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 06:50:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iaFA4bHv7jp36SejhQlPRd3q9YGfxhKuzIJmkD+93Io=;
        b=ho3SuxRdeXPeNQ5hjj8Ol//sNdq0aSV8TZu2IJsgA5UuxreZxy151l92Pb+fwa6JXt
         l6cJPKnWwm/ZrlJl6G6HwyQlfZoAJcZ3lznDevXmVDAxFOKgDsDlYMNvl+EEQLjJ4Kk+
         Bgu03xI0QBn+4uInNvoZeyjJx6QZ1xBF1YT6ABkbB2XrXaKjoKWBbN2XOxK18TAffJSF
         EpyR5TWUNEsXL0OryU9uzsM+j8ML6YYXbchqc1ZlAwkCI6Oiu97DNUf536Qe0YIbewxj
         vajiBpo0/l80ht4282GAwuqSSJKh05Yu9O7ZVysRDW2v3a3p8pKqDifI6UbahZmkZZll
         A6vQ==
X-Gm-Message-State: APjAAAVg/OjerOjS5tz+CpIlOd7SvLzLxBBnzTw2IclHBo7zpe4jf3Mh
        ni78jLGO3LLlqnmxNK4DxwM60zAXfhIJH793fwmLdI9fEevDnrJVuOZGhZJoAWOAyLpoh5Np4zC
        /CbvBK79aXdore1S8bTgFXr/c
X-Received: by 2002:a1c:3cc4:: with SMTP id j187mr21452276wma.95.1573483843233;
        Mon, 11 Nov 2019 06:50:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqyRwEQKjjsoIXFVPG/PbMwIt90Q3xXl7n2S/Gz45ULYs6aT865MpeUzZYI6Iq8zWHEBX+0ncA==
X-Received: by 2002:a1c:3cc4:: with SMTP id j187mr21452248wma.95.1573483842965;
        Mon, 11 Nov 2019 06:50:42 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:a0f7:472a:1e7:7ef? ([2001:b07:6468:f312:a0f7:472a:1e7:7ef])
        by smtp.gmail.com with ESMTPSA id v184sm21048418wme.31.2019.11.11.06.50.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2019 06:50:42 -0800 (PST)
Subject: Re: [PATCH v1 2/3] KVM: VMX: Do not change PID.NDST when loading a
 blocked vCPU
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
 <20191106175602.4515-3-joao.m.martins@oracle.com>
 <15c8c821-25ff-eb62-abd3-8d7d69650744@redhat.com>
 <314a4120-036c-e954-bc9f-e57dee3bbb7c@oracle.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <49912d14-1f79-2658-9471-4193807ad667@redhat.com>
Date:   Mon, 11 Nov 2019 15:50:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <314a4120-036c-e954-bc9f-e57dee3bbb7c@oracle.com>
Content-Language: en-US
X-MC-Unique: kz7m4YPsMceyz22T28-RUA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/19 15:48, Joao Martins wrote:
>>>
>>> Fixes: c112b5f50232 ("KVM: x86: Recompute PID.ON when clearing PID.SN")
>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>> Signed-off-by: Liran Alon <liran.alon@oracle.com>
>> Something wrong in the SoB line?
>>
> I can't spot any mistake; at least it looks chained correctly for me. Wha=
t's the
> issue you see with the Sob line?

Liran's line after yours is confusing.  Did he help with the analysis or
anything like that?

Paolo

> The only thing I forgot was a:
>=20
> Tested-by: Nathan Ni <nathan.ni@oracle.com>
>=20
>> Otherwise looks good.
> If you want I can resubmit the series with the Tb and Jag Rb, unless you =
think
> it's OK doing on commit? Otherwise I can resubmit.

