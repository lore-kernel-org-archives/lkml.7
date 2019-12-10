Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 441EAC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 09:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 078E62073B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 09:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g9KFzoEo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbfLJJS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 04:18:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53722 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727007AbfLJJS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 04:18:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575969536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ys5nveUnuHlqyfAjmjcLopzAQQGr7aebD6b5Em3ISs8=;
        b=g9KFzoEouBX5U0VdPLF6cLmOl4TrVIbvhcPegKYxEkBwIJiKWmt4Q8/5uUEkkCgxU2tsuE
        DQwLLHJXNls2DPkLKv7bX69heMSDgRoRvfKjPMHcUZmmF7WGlF1h2tzivMrfyPLJjGRIY2
        aIuHksU35Rf3S6vnPWLG32Jmd1h0ME4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383--BG5azkIP3S49yX7a7v6PA-1; Tue, 10 Dec 2019 04:18:54 -0500
Received: by mail-wm1-f70.google.com with SMTP id o135so404449wme.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 01:18:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ys5nveUnuHlqyfAjmjcLopzAQQGr7aebD6b5Em3ISs8=;
        b=YJ9Ht8XZZle89xRPXbS2baz1KhhliWAbhdVQiBp2h4trjwOEvm1IdCaVU3JVGUz+e8
         XHIVlS/NJvgHBPM1Ie9hVCYjNZtQKb46NY0cE0cj3U2sLcUOnGIRNTXJk0bmBtrAteb0
         69BhUsrEsx0xMzkb9Un+j6CR02Ki3rgPMwhfEKYhKsQ044BmfyUJF8GyKslqDUdhLGPM
         L4TnWMkK1J/Jp2kP7NQXBwuSTPB8Jlb5089ljczz+59OMRjAfcObi4E1WL+m2kr1wMYc
         xcF1i4sNX2sCACiXD1Z0j9RYyJyJ6l1AO3JybpF7sBqsZELUTicZCnfT9X9VUw6zXzvE
         QWSw==
X-Gm-Message-State: APjAAAWmZ/Zo7my0+mV5Dz/0pmIsRGUy57nAC+e8LGBZQH6LNbDA42Yn
        LDqpm6prTRJ2+fA7iZXqk6hqYWgfLt/gjSTgAHK+OyztQ1fRN++t2p0D74GCo1FBQKCifykvDmp
        uqTUWheqAJM+zdG9RJNaRQHZc
X-Received: by 2002:a1c:a750:: with SMTP id q77mr3754379wme.76.1575969533787;
        Tue, 10 Dec 2019 01:18:53 -0800 (PST)
X-Google-Smtp-Source: APXvYqw4nJ+vwaF+bCpT4bALJsG39v2xr4nUwAmxvKVeYBNvjHHX20eM5yfU1XaBY4K1oQQjOdJ04Q==
X-Received: by 2002:a1c:a750:: with SMTP id q77mr3754346wme.76.1575969533563;
        Tue, 10 Dec 2019 01:18:53 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9? ([2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9])
        by smtp.gmail.com with ESMTPSA id r6sm2437618wrq.92.2019.12.10.01.18.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2019 01:18:53 -0800 (PST)
Subject: Re: [PATCH v2] KVM: x86: use CPUID to locate host page table reserved
 bits
To:     "Huang, Kai" <kai.huang@intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Cc:     "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <1575474037-7903-1-git-send-email-pbonzini@redhat.com>
 <8f7e3e87-15dc-2269-f5ee-c3155f91983c@amd.com>
 <2f3d8c9b146301183b891d8a441aa4a5c33b4c9d.camel@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c1012d42-6e60-66c9-80ea-f6c26db37172@redhat.com>
Date:   Tue, 10 Dec 2019 10:18:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <2f3d8c9b146301183b891d8a441aa4a5c33b4c9d.camel@intel.com>
Content-Language: en-US
X-MC-Unique: -BG5azkIP3S49yX7a7v6PA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/19 04:53, Huang, Kai wrote:
> Right. Alghouth both MKTME and SME/SEV reduce physical bits, but they treat
> those reduced bits differently: MKTME treats those as keyID thus they can be
> set, but SME/SEV treats those as reserved bits so you cannot set any of them.
> 
> Maybe the naming of shadow_phys_bits is a little bit confusing here. The purpose
> of it was to determine first reserved bits, but not actual physical address bits
> . Therefore for MKTME it should include the keyID bits, but for SME/SEV it
> should not.

Not just the first reserved bit, but _some_ reserved bit such that all
consecutive bits up to bit 51 are reserved.

Paolo

