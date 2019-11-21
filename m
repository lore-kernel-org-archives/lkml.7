Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B729C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 09:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2D8F20748
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 09:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hwTNm9U8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfKUJNa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 04:13:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34031 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726014AbfKUJNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 04:13:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574327609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:openpgp;
        bh=3M6485oZ3h2+O4ro7A8gi/zi3MfoBr4gqzDpttvkg3w=;
        b=hwTNm9U8d7LF4/Ltpp3OYtxfdDJmT224eQGgnbkGBNoNLoOXs4HohsiYsqSPIdzrR51BXz
        bxLzeO1wlisghQCl80ZzqwnCuRjDz0S4ORvaJS5fEE5iThKyYbQ2lfVseA/PayR2l6JZkf
        A3Ly9AxYg2ohsX12aw6JZo/T9WhcqVY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-mOY-q8esMcat8U_H6oA_2g-1; Thu, 21 Nov 2019 04:13:26 -0500
Received: by mail-wr1-f70.google.com with SMTP id m17so1684653wrb.20
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 01:13:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MnY5vul8wqjyLuAl8HVVCWFLRgO+5Onvt2EnbAjuSA4=;
        b=Oc9PrZRh2d1R3nBixr92UFfKM6W76MErx6EPB68RAabpHymcbh3soz0ueMWGxLZZw5
         kDAxmfo+dexUq5OGYeQb5XsGs7P2zvtPbmBkrAWoCetgLF+vmM0arz5fkUmNe3uhPU4l
         g9nlIwDCvKorXsIx8sEYFwWuUPUxA8oKdJPgUZkw0XMN9g5hT0l+ESUYzfFvOg36h1pw
         PHLxcv/zysbmZkcv6yu/pQicW8BiC2Vglwqalw8PpNbgc3xacht+0tesNlIqyNXhxkgi
         l1y5VyOEFXu3yEIwt3EeE1fAu3BuXsEYxZMmiu0u6+Z87PB3FCPZ6u6+t8CWHbMmIJ0Q
         aNgw==
X-Gm-Message-State: APjAAAW9/CQ7HOcum1ew0mSYfGGS2iiN+kkoqFDEpfbGYJ7PS1DhBLo9
        hOCSLMTJF9CfKKfG55OG3hMlwMzCLc1K+uvOUAAqOlRlWDa+rz8+ugQVLC3nB08YfGa+gPyj5y8
        UR3ZRYiBPEnaQgI5MiAw/9EWv
X-Received: by 2002:adf:dd0a:: with SMTP id a10mr8457529wrm.299.1574327605108;
        Thu, 21 Nov 2019 01:13:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqy3ZNKHYrKi1bUru69IXv71nFYLjTNHMigtS0mfIn48c69BczlnVWv1kLAz4F0q7IesX+op8w==
X-Received: by 2002:adf:dd0a:: with SMTP id a10mr8457488wrm.299.1574327604841;
        Thu, 21 Nov 2019 01:13:24 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:71a5:6e:f854:d744? ([2001:b07:6468:f312:71a5:6e:f854:d744])
        by smtp.gmail.com with ESMTPSA id s11sm2484895wrr.43.2019.11.21.01.13.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2019 01:13:23 -0800 (PST)
Subject: Re: [PATCH -next] KVM: x86: remove set but not used variable 'called'
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Mao Wenan <maowenan@huawei.com>, rkrcmar@redhat.com,
        sean.j.christopherson@intel.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20191119030640.25097-1-maowenan@huawei.com>
 <87o8x8gjr5.fsf@vitty.brq.redhat.com> <20191119121423.GB5604@kadam>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <61f534ca-7575-6716-10ec-ac5c92258452@redhat.com>
Date:   Thu, 21 Nov 2019 10:13:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191119121423.GB5604@kadam>
Content-Language: en-US
X-MC-Unique: mOY-q8esMcat8U_H6oA_2g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/11/19 13:14, Dan Carpenter wrote:
>> Better expressed as=20
>>
>> Fixes: 7ee30bc132c6 ("KVM: x86: deliver KVM IOAPIC scan request to targe=
t vCPUs")
>
> There is sort of a debate about this whether the Fixes tag should be
> used if it's only a cleanup.

The other debate is whether this is a cleanup, since the build is broken
with -Werror.  I agree that code cleanups generally don't deserve Fixes
tags, but this patch IMHO does.

Paolo

