Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9BEC4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 13:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAD8521852
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 13:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbfIQN1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 09:27:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36938 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727782AbfIQN1s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 09:27:48 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 01EA081127
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 13:27:48 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id f23so1250018wmh.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 06:27:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1P0dSGUS+WWJgIEsGv0bzVV8obUlEtzj+cS48y+KeEY=;
        b=ZOj+6+py0cBEpovxYp4+73T8r7qcbh1ToYh5TQxgUj2J0ZNhbeHYoEmTEGz/ulOMkV
         6r+55GHe2zKd0NL+NR57J9jKmdYGJHoz+KwjZhfKGMW8SaWp5svtEZcAs50P7NuWGH1+
         yuztVjwWNbmgVnIL1rvL5UoUt5Ra0805Zp4mV44BX7ClHYgELOuolt46YvQHZs0Td7p6
         UbsY9Bu8+j1iOF3rzYHQdwkbXJnJnBtAk++H/mUIZUiFPmUeGRS6WquXx9kSgOJZRj1B
         vSBW9feXHDGy+xZbigWsl5ZzrR7loa/88IPDYd125J4CVtUmp/QoUECQRcFF70LrKGrQ
         w4fw==
X-Gm-Message-State: APjAAAWgiEmCrTXEswYTqd/YCh3903K8FelxrJxDdMC2xOBYgPZgHov/
        iEbzO5MkAI3a+EsrteP905oAq5wvWSpkptLxVgxoNMoWaa46wusk0VHSANwG0yv99sS9Ni3LXwZ
        7vchvgjvfn/0gqbU/mOQMqJF0
X-Received: by 2002:adf:f303:: with SMTP id i3mr3196354wro.242.1568726866531;
        Tue, 17 Sep 2019 06:27:46 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxFU9EERU1lbrrSdMwmejNG+OkwH4Dchh8n9cZ1MOq5r+sDWbio0dFe9hnBTYw15bHDvn+q+Q==
X-Received: by 2002:adf:f303:: with SMTP id i3mr3196322wro.242.1568726866217;
        Tue, 17 Sep 2019 06:27:46 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c46c:2acb:d8d2:21d8? ([2001:b07:6468:f312:c46c:2acb:d8d2:21d8])
        by smtp.gmail.com with ESMTPSA id 33sm4277057wra.41.2019.09.17.06.27.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2019 06:27:45 -0700 (PDT)
Subject: Re: [PATCH V4 0/3] KVM/Hyper-V: Add Hyper-V direct tlb flush support
To:     lantianyu1986@gmail.com, rkrcmar@redhat.com, corbet@lwn.net,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, vkuznets@redhat.com
References: <20190822143021.7518-1-Tianyu.Lan@microsoft.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <7ea7fa06-f100-1507-8507-1c701877c8ab@redhat.com>
Date:   Tue, 17 Sep 2019 15:27:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190822143021.7518-1-Tianyu.Lan@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/08/19 16:30, lantianyu1986@gmail.com wrote:
> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
> 
> This patchset is to add Hyper-V direct tlb support in KVM. Hyper-V
> in L0 can delegate L1 hypervisor to handle tlb flush request from
> L2 guest when direct tlb flush is enabled in L1.
> 
> Patch 2 introduces new cap KVM_CAP_HYPERV_DIRECT_TLBFLUSH to enable
> feature from user space. User space should enable this feature only
> when Hyper-V hypervisor capability is exposed to guest and KVM profile
> is hided. There is a parameter conflict between KVM and Hyper-V hypercall.
> We hope L2 guest doesn't use KVM hypercall when the feature is
> enabled. Detail please see comment of new API "KVM_CAP_HYPERV_DIRECT_TLBFLUSH"
> 
> Change since v3:
>        - Update changelog in each patches. 
> 
> Change since v2:
>        - Move hv assist page(hv_pa_pg) from struct kvm  to struct kvm_hv.
> 
> Change since v1:
>        - Fix offset issue in the patch 1.
>        - Update description of KVM KVM_CAP_HYPERV_DIRECT_TLBFLUSH.
> 
> Tianyu Lan (2):
>   x86/Hyper-V: Fix definition of struct hv_vp_assist_page
>   KVM/Hyper-V: Add new KVM capability KVM_CAP_HYPERV_DIRECT_TLBFLUSH
> 
> Vitaly Kuznetsov (1):
>   KVM/Hyper-V/VMX: Add direct tlb flush support
> 
>  Documentation/virtual/kvm/api.txt  | 13 +++++++++++++
>  arch/x86/include/asm/hyperv-tlfs.h | 24 ++++++++++++++++++-----
>  arch/x86/include/asm/kvm_host.h    |  4 ++++
>  arch/x86/kvm/vmx/evmcs.h           |  2 ++
>  arch/x86/kvm/vmx/vmx.c             | 39 ++++++++++++++++++++++++++++++++++++++
>  arch/x86/kvm/x86.c                 |  8 ++++++++
>  include/uapi/linux/kvm.h           |  1 +
>  7 files changed, 86 insertions(+), 5 deletions(-)
> 

Queued, thanks.

Paolo
