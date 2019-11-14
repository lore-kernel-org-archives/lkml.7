Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37405C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 12:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F8CD20715
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 12:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gtzQsQ8T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbfKNMQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 07:16:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42491 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726339AbfKNMQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 07:16:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573733784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k5zYUiU+g7WjuH6/6S9d3SsIOHZGX/0lXuRO2F2b2zQ=;
        b=gtzQsQ8TvSPwv93pBvdC1JdpjaDSxEkSm4tzmjOYzfHmxCDO4HYqLII78WRgRGQc4LjEtF
        aZ9bp2OtUaH36EGLUVCPJBZIcu08RE/FDWwCxn68LdmRPkwe7mgAzQ4vkjSMaq1Mkus0bD
        SP45oRzZHbq6xHRcIfLlpQYjSutzErA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-q1C-QkRmNvWliKV66UOxHw-1; Thu, 14 Nov 2019 07:16:23 -0500
Received: by mail-wr1-f71.google.com with SMTP id 4so4307208wrf.19
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 04:16:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k5zYUiU+g7WjuH6/6S9d3SsIOHZGX/0lXuRO2F2b2zQ=;
        b=NvQx2dNh1MW/u5CdDuj442yrBKiaAj5kuZFtoIt0RvB9e9yB8qLL5t6QLv8xXGynrX
         +PSj4pwIPBa8CU3f+x8G9IlA0P7Z2wORuBgC02yIvlc31gcu2DMRct+Vjj4tyZM0MW6w
         /bjcjHZ+kc+N3OxKVhFWr5M/JnsdGpQrKuGn5tijCvR6slzM5Yke1/fqn27U38IzZXNA
         S4dB75Y+jbLIzSZKdyjxP5UK60zJPRoNsgxErJJ18htcqy7WhHMslIyJbKbXzYKw4q7x
         HzlBB1Wv3nAv1pVZXRcJmqQzPCCvLzmTNcUDFTa4/JSjUXAPOjyZJwz+/tgW8IiXYYnu
         ChWA==
X-Gm-Message-State: APjAAAXwwa9MTbGycuTQmEQ/fM4hEJJSvdgwbLnI6l0wyMRZdSyzEZnO
        rVXQlLo7OPBiQo835FYx22rwQYt5vXOKf2nvOu7NdmVTVbQmU3t8niBzvCUOC8Sbnt38S51U5I0
        P5jrbV3O+GyxFayfTEZHo0yCC
X-Received: by 2002:adf:fad1:: with SMTP id a17mr955472wrs.328.1573733781806;
        Thu, 14 Nov 2019 04:16:21 -0800 (PST)
X-Google-Smtp-Source: APXvYqzz5g+kyx23kgyTEuyGc6yicSZ4gGEGPYNBpJi/bvdemWwfLS7ljePZ6vQ6ZO5YNNmD4Dn6dA==
X-Received: by 2002:adf:fad1:: with SMTP id a17mr955449wrs.328.1573733781522;
        Thu, 14 Nov 2019 04:16:21 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:a15b:f753:1ac4:56dc? ([2001:b07:6468:f312:a15b:f753:1ac4:56dc])
        by smtp.gmail.com with ESMTPSA id l1sm6959625wrw.33.2019.11.14.04.16.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2019 04:16:21 -0800 (PST)
Subject: Re: [PATCH] KVM: x86/mmu: Take slots_lock when using
 kvm_mmu_zap_all_fast()
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191113193032.12912-1-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1b46d531-6423-3ccc-fc5f-df6fbaa02557@redhat.com>
Date:   Thu, 14 Nov 2019 13:16:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191113193032.12912-1-sean.j.christopherson@intel.com>
Content-Language: en-US
X-MC-Unique: q1C-QkRmNvWliKV66UOxHw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/11/19 20:30, Sean Christopherson wrote:
> Failing to take slots_lock when toggling nx_huge_pages allows multiple
> instances of kvm_mmu_zap_all_fast() to run concurrently, as the other
> user, KVM_SET_USER_MEMORY_REGION, does not take the global kvm_lock.
> Concurrent fast zap instances causes obsolete shadow pages to be
> incorrectly identified as valid due to the single bit generation number
> wrapping, which results in stale shadow pages being left in KVM's MMU
> and leads to all sorts of undesirable behavior.

Indeed the current code fails lockdep miserably, but isn't the whole
body of kvm_mmu_zap_all_fast() covered by kvm->mmu_lock?  What kind of
badness can happen if kvm->slots_lock isn't taken?

Paolo

