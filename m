Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A59C010A3
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 11:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63EB6206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 11:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730661AbfKELUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 06:20:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:13490 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730599AbfKELUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 06:20:41 -0500
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A0F2D81F0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2019 11:20:40 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id p6so12153676wrs.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 03:20:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5janaQiAy9etIrtoTKNZEMcekAz7aNQTX2gwL6KQh/I=;
        b=OJhujwKZjUgf4n0kfZuQdM8oFYj5yeSm48y9P0KHZ/KyhUnZ8SUew1q2Y8kBtc3abK
         JRL64NRbqb4zEXH2gF2Tw+uXBr1geI++cuakxnxCLSoUsV/LzuQxoQD+cb7NDJsn9fgM
         9trfGVh8nQA8swVI+pvBgEOWUsr2+tIQIAvIyfPsR9q5eilupOyZdANNtEpcgN5pYNqp
         kk8NvPG9ZWPAfSVhCRtcpIccjku8DQSuxvkiF2CmvoxBfsdXLSBKmo6YDzE93SPPB104
         fTrIvL0JmJ3or/kyQ6SvGv0v3vcV1jgiKWnlfubt+CJZBxWTnOWtQjqIV3ALMawqysBx
         1klg==
X-Gm-Message-State: APjAAAX5RO0ByXwFw6+emp4isrTR0mqqdEGNNYVWwWkzK4xQB+Xq8ISG
        eZuTHIIAd5dNDafh4traNYkAEaCXU9Qmd1vZYa1lNL7tzuS9IUriW2ul4rzkByFabrMEsxXDJjG
        5QqU9nu/GC40FpbLtqzjA5fdU
X-Received: by 2002:a1c:9dd3:: with SMTP id g202mr3873317wme.43.1572952838952;
        Tue, 05 Nov 2019 03:20:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqxsuia9tBKGpWgRmg+Z8P0Q9Irh3IwgwLmy64+8eNcq2e+aQvZmXii8Lt/Qm9y1etzxctpS9A==
X-Received: by 2002:a1c:9dd3:: with SMTP id g202mr3873296wme.43.1572952838688;
        Tue, 05 Nov 2019 03:20:38 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:4051:461:136e:3f74? ([2001:b07:6468:f312:4051:461:136e:3f74])
        by smtp.gmail.com with ESMTPSA id s9sm2146939wmj.22.2019.11.05.03.20.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2019 03:20:38 -0800 (PST)
Subject: Re: [PATCH] KVM: X86: Dynamically allocating MSR number
 lists(msrs_to_save[], emulated_msrs[], msr_based_features[])
To:     Xiaoyao Li <xiaoyao.li@intel.com>,
        Chenyi Qiang <chenyi.qiang@intel.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20191105092031.8064-1-chenyi.qiang@intel.com>
 <8ab7565c-df06-b5a5-d02d-899ba976414b@redhat.com>
 <6ed393eb-6402-ffe2-a652-c4fe51c9d301@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <75a63a8d-6d80-7749-a5c7-da7a43c2f53c@redhat.com>
Date:   Tue, 5 Nov 2019 12:20:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <6ed393eb-6402-ffe2-a652-c4fe51c9d301@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/11/19 12:11, Xiaoyao Li wrote:
> On 11/5/2019 6:41 PM, Paolo Bonzini wrote:
>> On 05/11/19 10:20, Chenyi Qiang wrote:
>>> The three msr number lists(msrs_to_save[], emulated_msrs[] and
>>> msr_based_features[]) are global arrays of kvm.ko, which are
>>> initialized/adjusted (copy supported MSRs forward to override the
>>> unsupported MSRs) when installing kvm-{intel,amd}.ko, but it doesn't
>>> reset these three arrays to their initial value when uninstalling
>>> kvm-{intel,amd}.ko. Thus, at the next installation, kvm-{intel,amd}.ko
>>> will initialize the modified arrays with some MSRs lost and some MSRs
>>> duplicated.
>>>
>>> So allocate and initialize these three MSR number lists dynamically when
>>> installing kvm-{intel,amd}.ko and free them when uninstalling.
>>
>> I don't understand.  Do you mean insmod/rmmod when you say
>> installing/uninstalling? Global data must be reloaded from the ELF file
>> when insmod is executed.
> 
> Yes, we mean insmod/rmmod.
> The problem is that these three MSR arrays belong to kvm.ko but not
> kvm-{intel,amd}.ko. When we rmmod kvm_intel.ko, it does nothing to them.

Ok, thanks for the explanation.

Paolo
