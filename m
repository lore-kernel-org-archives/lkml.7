Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8E6C4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 15:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D605206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 15:28:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729559AbfIQP2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 11:28:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56132 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729542AbfIQP2Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 11:28:24 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A367481F13
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 15:28:23 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id t11so1226974wro.10
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 08:28:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=7mnmRgUCgAlAXrxHwhjTLW45iyiMz5FPUKvdpngF3+I=;
        b=a0YuomHJp4WP2geqCaFA/ayijZ4uyZJuR86hU0MfpaG2hvsuaK7Ai76uVFoLx3AbzM
         7O4/z+uIMB4ZO0CS0S63aYpddUW9PaDbWzrOmbZM5qTAyBNeeu6neodot5Iwd7YsKXk0
         J5iNKNgIwtoJkebnwGjZZLdYSR0y8/gEwxW172tgTM8FGWZGY5e2pcYHhvSwD9YkyTmF
         oV4WAedKAyD8XYm0QN44MHJyTX7tNjKlKigxjiGoNLZgKMTw6gbEuyeNIu1UEL6cCnZc
         j4ZCN73urEcRwu7eMLSNIzNvj1Ic3bv3tfxH1oztxC5Ya3tzQxQxcwd5vzyf7gb/Ywl7
         beMw==
X-Gm-Message-State: APjAAAXXgvbeVDZVmVst9rWT0+kDNLHM5ILBAIzTKEkJG156j+cdoRcB
        FzD97rOzD7MSmiOHdIT2Zym5rrOo3woasoAgN3eT68QBZYFUqtR5+p3xF7UuUDpT8XTXa6RAwOO
        WANu0kvfWWvYLqZqqY/UcOxtS
X-Received: by 2002:a5d:6a09:: with SMTP id m9mr3378975wru.12.1568734102267;
        Tue, 17 Sep 2019 08:28:22 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy4pW4zgxABH6kbq9g/jw+pZm3IOziyF8pDsnqSMITDPGieP+H8bXoz+/FldIxghopVjWcUqg==
X-Received: by 2002:a5d:6a09:: with SMTP id m9mr3378931wru.12.1568734101878;
        Tue, 17 Sep 2019 08:28:21 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id u68sm3597043wmu.12.2019.09.17.08.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 08:28:21 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, lantianyu1986@gmail.com,
        rkrcmar@redhat.com, corbet@lwn.net, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, sashal@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, michael.h.kelley@microsoft.com
Subject: Re: [PATCH V4 0/3] KVM/Hyper-V: Add Hyper-V direct tlb flush support
In-Reply-To: <7ea7fa06-f100-1507-8507-1c701877c8ab@redhat.com>
References: <20190822143021.7518-1-Tianyu.Lan@microsoft.com> <7ea7fa06-f100-1507-8507-1c701877c8ab@redhat.com>
Date:   Tue, 17 Sep 2019 17:28:20 +0200
Message-ID: <874l1baqnf.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 22/08/19 16:30, lantianyu1986@gmail.com wrote:
>> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
>> 
>> This patchset is to add Hyper-V direct tlb support in KVM. Hyper-V
>> in L0 can delegate L1 hypervisor to handle tlb flush request from
>> L2 guest when direct tlb flush is enabled in L1.
>> 
>> Patch 2 introduces new cap KVM_CAP_HYPERV_DIRECT_TLBFLUSH to enable
>> feature from user space. User space should enable this feature only
>> when Hyper-V hypervisor capability is exposed to guest and KVM profile
>> is hided. There is a parameter conflict between KVM and Hyper-V hypercall.
>> We hope L2 guest doesn't use KVM hypercall when the feature is
>> enabled. Detail please see comment of new API "KVM_CAP_HYPERV_DIRECT_TLBFLUSH"
>> 
>> Change since v3:
>>        - Update changelog in each patches. 
>> 
>> Change since v2:
>>        - Move hv assist page(hv_pa_pg) from struct kvm  to struct kvm_hv.
>> 
>> Change since v1:
>>        - Fix offset issue in the patch 1.
>>        - Update description of KVM KVM_CAP_HYPERV_DIRECT_TLBFLUSH.
>> 
>> Tianyu Lan (2):
>>   x86/Hyper-V: Fix definition of struct hv_vp_assist_page
>>   KVM/Hyper-V: Add new KVM capability KVM_CAP_HYPERV_DIRECT_TLBFLUSH
>> 
>> Vitaly Kuznetsov (1):
>>   KVM/Hyper-V/VMX: Add direct tlb flush support
>> 
>>  Documentation/virtual/kvm/api.txt  | 13 +++++++++++++
>>  arch/x86/include/asm/hyperv-tlfs.h | 24 ++++++++++++++++++-----
>>  arch/x86/include/asm/kvm_host.h    |  4 ++++
>>  arch/x86/kvm/vmx/evmcs.h           |  2 ++
>>  arch/x86/kvm/vmx/vmx.c             | 39 ++++++++++++++++++++++++++++++++++++++
>>  arch/x86/kvm/x86.c                 |  8 ++++++++
>>  include/uapi/linux/kvm.h           |  1 +
>>  7 files changed, 86 insertions(+), 5 deletions(-)
>> 
>
> Queued, thanks.
>

I had a suggestion how we can get away without the new capability (like
direct tlb flush gets automatically enabled when Hyper-V hypercall page
is activated and we know we can't handle KVM hypercalls any more)
but this can probably be done as a follow-up.

-- 
Vitaly
