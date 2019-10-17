Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39ECFA3730
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 09:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A56662089C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 09:48:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408692AbfJQJsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 05:48:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53692 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393860AbfJQJsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 05:48:52 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 350DE2A09DA
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 09:48:51 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id o188so871837wmo.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 02:48:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=fulMV+toG6g3eSzWv6dizQDXtOUtM0UaAnY8lyzO4+w=;
        b=em/UWNAOFFrTxcoOVbYv+FIsvyzK3Jh7s0n9PqEkm7hnhpkqPowjD/n/O2s+zcyaKe
         V+T2Gm9gm3Hvgr5I81E2UzbUDOPbIDfR8X7WaySUzTLZ+iDVG+4pcRE4iBhb2MWNwoU+
         BiIJRfl6p0bBaP7aOS4BNOjr0FcJ72GLKJ31MuhojGKSxIENnvjZhoaQw0hYGe8trMEH
         iOjTBvMWhGuHS2OE8oOyY3eI99GE5a1dBWCKfomeRtazr6bEIuWII9fg7kqVs9xGrIXC
         7eKVXBuGmzR0OuE89+BSU/ri11fwKlbDzgsjeT9CQ+BUYiLcP0IVEklSHMPKaXAcp5CB
         VwBg==
X-Gm-Message-State: APjAAAXt8h7nLMLH7OBOfbhX/Dl38dgAhJpmapqPLDXUl2T2qW2Xe65r
        quvXeStJ2BGI6ZCig0WmDgqVg7IkAZNy/jDi2pii80PJHpIXYQLXxLPgZgoHWXnJfNTOMc+nIYi
        h121/vLquibTQDaBBjfRKRaRa
X-Received: by 2002:a1c:a784:: with SMTP id q126mr1990782wme.59.1571305729873;
        Thu, 17 Oct 2019 02:48:49 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz6+utTLAGkxHY41AD+u4w7d0GVfoTtd9+W82zHGNyobcnEv8oi1KJDn6bNKlNyci+bK9572g==
X-Received: by 2002:a1c:a784:: with SMTP id q126mr1990764wme.59.1571305729627;
        Thu, 17 Oct 2019 02:48:49 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id b62sm2305917wmc.13.2019.10.17.02.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 02:48:49 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     linmiaohe <linmiaohe@huawei.com>
Cc:     "x86\@kernel.org" <x86@kernel.org>,
        "kvm\@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mingfangsen <mingfangsen@huawei.com>,
        "pbonzini\@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar\@redhat.com" <rkrcmar@redhat.com>,
        "sean.j.christopherson\@intel.com" <sean.j.christopherson@intel.com>,
        "wanpengli\@tencent.com" <wanpengli@tencent.com>,
        "jmattson\@google.com" <jmattson@google.com>,
        "joro\@8bytes.org" <joro@8bytes.org>,
        "tglx\@linutronix.de" <tglx@linutronix.de>,
        "mingo\@redhat.com" <mingo@redhat.com>,
        "bp\@alien8.de" <bp@alien8.de>, "hpa\@zytor.com" <hpa@zytor.com>
Subject: Re: [PATCH] KVM: SVM: Fix potential wrong physical id in avic_handle_ldr_update
In-Reply-To: <7db9f15500ab486b897bf1a7fa7e7161@huawei.com>
References: <7db9f15500ab486b897bf1a7fa7e7161@huawei.com>
Date:   Thu, 17 Oct 2019 11:48:48 +0200
Message-ID: <87tv873dof.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

linmiaohe <linmiaohe@huawei.com> writes:

> Vitaly Kuznetsov <vkuznets@redhat.com> writes:
>
>>> Guest physical APIC ID may not equal to vcpu->vcpu_id in some case.
>>> We may set the wrong physical id in avic_handle_ldr_update as we 
>>> always use vcpu->vcpu_id.
>
> Hi, Vitaly, thanks for your reply.
> Do you think there may be a wrong physical id in
> avic_handle_ldr_update too ?

Honestly I'm not sure, however, as we need to put physical id to LDR
we'd rather get it from LAPIC then assume that it's == vcpu_id so I
think your patch makes sense even if it fixes a theoretical issue.

But I may be missing something important about AVIC.

>
>>>
>>> @@ -4591,6 +4591,8 @@ static int avic_handle_ldr_update(struct kvm_vcpu *vcpu)
>>>  	int ret = 0;
>>>  	struct vcpu_svm *svm = to_svm(vcpu);
>>>  	u32 ldr = kvm_lapic_get_reg(vcpu->arch.apic, APIC_LDR);
>>> +	u32 apic_id_reg = kvm_lapic_get_reg(vcpu->arch.apic, APIC_ID);
>>> +	u32 id = (apic_id_reg >> 24) & 0xff;
>>
>>If we reach here than we're guaranteed to be in xAPIC mode, right? Could you maybe export and use kvm_xapic_id() here then (and in
>>avic_handle_apic_id_update() too)?
>>
>
> I think we're guaranteed to be in xAPIC mode when we reach here. I would have a try to export
> and use use kvm_xapic_id here and in avic_handle_apic_id_update too.
> Thanks for your suggestion.
>
> Have a nice day.
> Best wishes.

-- 
Vitaly
