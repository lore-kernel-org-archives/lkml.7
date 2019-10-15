Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1D6ECE58E
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 09:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C84EC20650
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 09:28:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729870AbfJOJ2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 05:28:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50718 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbfJOJ2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 05:28:40 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D782F80F98
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 09:28:39 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id l12so9830501wrm.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 02:28:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aub9eUM1bMC5A+9eKTkOj7byBw91bMGGa1ow0bZuIKI=;
        b=VcaCj8SawKUFL27+3kg+5PfQQjWOWB1KaEhTvVJJHFEPuw/k4X0gNqFMNdLSxzZPXW
         7LF7dH0JJ9zHIZfQ+2meHHlRd6KLC94MqMMtwOal5p7M6Vdq4RPeaelCLVZkgXLbOrXp
         lCuY3lcmEF4h7fLldQfjJJd8OXRATqvY/zSsTeTwxiI6uSMtuECCFKLlRPy7+QzijyqI
         wSslmU5ZXjcoLSawPMTiJohknGZT9q48pfP7d+EsTzFK4qC7fHHcx6+x2GcNABMq3H7R
         pEJBs8z1ta6yQmQUHXgWUnVBpVQuqsFjOgVla28NdeOKa6YCkbu3CsTtJBK0JaLEP1B5
         yiBA==
X-Gm-Message-State: APjAAAUOMJg96MNBVtHqzYNwir5C5iYm+ltxEAU+w4/LCWkBJctTtmqU
        wALn2LQKqY6+D2gssFodeGcPbaEvDa19iCvTkvfUUkid7FqAaWv20/qzVoi6n+CxQIMiqyciSaW
        mvYP1OTjNLDfoYJlW2c1ZV+ks
X-Received: by 2002:a1c:a784:: with SMTP id q126mr17779309wme.59.1571131718515;
        Tue, 15 Oct 2019 02:28:38 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwL9u0C2kzpM2yvdS1YogOoNAbTP1QenamcQe0oKSrvWrdfOYgMAVNPba0m3+5BPL183ARKVw==
X-Received: by 2002:a1c:a784:: with SMTP id q126mr17779289wme.59.1571131718217;
        Tue, 15 Oct 2019 02:28:38 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d001:591b:c73b:6c41? ([2001:b07:6468:f312:d001:591b:c73b:6c41])
        by smtp.gmail.com with ESMTPSA id n7sm22921225wrt.59.2019.10.15.02.28.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2019 02:28:37 -0700 (PDT)
Subject: Re: [PATCH] KVM: X86: Make fpu allocation a common function
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>
References: <20191014162247.61461-1-xiaoyao.li@intel.com>
 <87y2xn462e.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <d14d22e2-d74c-ed73-b5bb-3ed5eb087deb@redhat.com>
Date:   Tue, 15 Oct 2019 11:28:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87y2xn462e.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/10/19 18:58, Vitaly Kuznetsov wrote:
> Xiaoyao Li <xiaoyao.li@intel.com> writes:
> 
>> They are duplicated codes to create vcpu.arch.{user,guest}_fpu in VMX
>> and SVM. Make them common functions.
>>
>> No functional change intended.
> Would it rather make sense to move this code to
> kvm_arch_vcpu_create()/kvm_arch_vcpu_destroy() instead?
> 

user_fpu could be made percpu too...  That would save a bit of memory
for each vCPU.  I'm holding on Xiaoyao's patch because a lot of the code
he's touching would go away then.

Paolo
