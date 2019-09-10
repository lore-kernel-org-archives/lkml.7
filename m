Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8FFC49ED9
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 17:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D25120872
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 17:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437029AbfIJRSn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 13:18:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45314 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387907AbfIJRSm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 13:18:42 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 22B95882F2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 17:18:42 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id j10so9284816wrb.16
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 10:18:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZuYfhbb8Z3aRapTv3k5IPcJghNBswcS6futL7Li8nHM=;
        b=MzFU48cKVeHIoPDaEvHxEeo5qirMKsITPG7XHZJTD+AryS6onoAr944mnTSXGtyKaa
         Kx9o/eH+vReNW/aPZdz5GgHCLMBTZmiiHfM9jaNX818qHMuhJBwkXD72iqJ0OCCW7kp6
         qawy+6ktCWLMbtyBlfknNT6KW7AJE4vWRMRu/4uW4AoHb3X+DKW/VSmN5zPHMToluQrf
         4/8aqg/VLvG83Pbs71iOJtvEQd4wYdflLjqrA8aK1jKtZXBDyHfM2bPW9JSD+8ch/1/D
         lRkv9/63Gp/qkwHmQ372roDYBLo3UXrs5+qFm3rO+BkgYU5abJ6AQ47XuPDXg0tTFgf/
         YZIw==
X-Gm-Message-State: APjAAAWM7xaTRwDrLxSjZfLWOdB/rPEkbXPsNLAesFE/uVOj3epwPLFj
        eSsytTQaPGfVR/QZIgM7HSThUQNr+I+kXpkd3mNMUGF9f1MvxcD9NzrgROuEBl2S7/nVbuWL04L
        EdOQFIRGxuMz2NrfMDL69p4Vo
X-Received: by 2002:adf:ebd0:: with SMTP id v16mr19039442wrn.352.1568135920582;
        Tue, 10 Sep 2019 10:18:40 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzYjKMgs5O889hJHkbRLK9ngJgaS8XcoAuY+Os0MVZLwwO9DHPaW3BKOh6dklif3M9ClGYfhQ==
X-Received: by 2002:adf:ebd0:: with SMTP id v16mr19039422wrn.352.1568135920337;
        Tue, 10 Sep 2019 10:18:40 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:1435:25df:c911:3338? ([2001:b07:6468:f312:1435:25df:c911:3338])
        by smtp.gmail.com with ESMTPSA id l1sm21649073wrb.1.2019.09.10.10.18.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2019 10:18:39 -0700 (PDT)
Subject: Re: [PATCH 0/2] KVM: x86: Refactor MSR related helpers
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190905212255.26549-1-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <96c13fa0-2547-99e2-caad-bcf3fb73806a@redhat.com>
Date:   Tue, 10 Sep 2019 19:18:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190905212255.26549-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/09/19 23:22, Sean Christopherson wrote:
> Refactor x86's MSR accessors to reduce the amount of boilerplate code
> required to get/set an MSR, and consolidate the RDMSR/WRMSR emulation
> for VMX and SVM since the code is functionally identical.
> 
> Sean Christopherson (2):
>   KVM: x86: Refactor up kvm_{g,s}et_msr() to simplify callers
>   KVM: x86: Add kvm_emulate_{rd,wr}msr() to consolidate VXM/SVM code
> 
>  arch/x86/include/asm/kvm_host.h |   6 +-
>  arch/x86/kvm/svm.c              |  34 +-------
>  arch/x86/kvm/vmx/nested.c       |  22 ++---
>  arch/x86/kvm/vmx/vmx.c          |  33 +-------
>  arch/x86/kvm/x86.c              | 138 ++++++++++++++++++++------------
>  5 files changed, 100 insertions(+), 133 deletions(-)
> 

Queued, thanks.

Paolo
