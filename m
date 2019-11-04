Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D416BCA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 11:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFD4C21D7D
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 11:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbfKDLTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 06:19:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48088 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727976AbfKDLTk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 06:19:40 -0500
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A24B486663
        for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2019 11:19:39 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id v6so975875wrm.18
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 03:19:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IyB/9FjVy0L8r3UgW28zHK/5BLov7tJmvoQB43XUc5U=;
        b=T6rYl+k6CTvMfEaWIjoouQvkBNZo1PU0a5n5lupASqchCog9rONLZfGsJkgCyYACRJ
         1Uk2n84t0UGZ4U/OssYY0yfEeDrcVuD0lVuu8m+FwaxgzzsoQkiMUMEIxWh2fx71Ek91
         MSUCwzfoZjoxI3vckBz0YlcYIXip1bFjBkZQeY/fSCXVDD0aTXllLIer6GflLEa4lLPo
         Ek4vcxZLKJy6CpsJO65Xw/4axa8s017vXTZBUXH8i7VtvczQL4dMDe8WOLMlpSu2sx43
         tHBZEf3b3boyssX5HrDPihmydebMHaqcOp+ONB8gPKfCyuO8cGJs1FQxlrPLuI7HZnCd
         Akcw==
X-Gm-Message-State: APjAAAVc49gdBJChrdAOmubnfqC9QGAzYHvqwmeQAlI13Y3aHMwI4PsL
        CL+aB9vZ6K/FWSLTzNqXRg01iiWN8CRkD2uu4UgXZrGFzsYa9V5uxPv/J5RfuaXtYaHuwhsC6oI
        vrj0AyjrhLjE9LYjqZPgtPdgU
X-Received: by 2002:adf:cf11:: with SMTP id o17mr22563005wrj.284.1572866378274;
        Mon, 04 Nov 2019 03:19:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqwVKUPV8W60run1lYhxWK79IIU0DtaJkMmOqyowGnPFh+KCscVP6nwt1b1fryS4H5d9uC+blA==
X-Received: by 2002:adf:cf11:: with SMTP id o17mr22562979wrj.284.1572866377969;
        Mon, 04 Nov 2019 03:19:37 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:4051:461:136e:3f74? ([2001:b07:6468:f312:4051:461:136e:3f74])
        by smtp.gmail.com with ESMTPSA id a206sm23814056wmf.15.2019.11.04.03.19.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2019 03:19:37 -0800 (PST)
Subject: Re: [PATCH 1/2] KVM: Fix NULL-ptr defer after kvm_create_vm fails
To:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
References: <1572848879-21011-1-git-send-email-wanpengli@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <6a3217bc-cc01-38db-f994-b501110b14bf@redhat.com>
Date:   Mon, 4 Nov 2019 12:19:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1572848879-21011-1-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/11/19 07:27, Wanpeng Li wrote:
> Commit 9121923c457d ("kvm: Allocate memslots and buses before calling kvm_arch_init_vm") 
> moves memslots and buses allocations around, however, if kvm->srcu/irq_srcu fails 
> initialization, NULL will be returned instead of error code, NULL will not be intercepted 
> in kvm_dev_ioctl_create_vm() and be deferenced by kvm_coalesced_mmio_init(), this patch 
> fixes it.

This is not enough, as syzkaller also reported an incorrect synchronize_srcu
that was also reported by syzkaller:

     wait_for_completion+0x29c/0x440 kernel/sched/completion.c:136
     __synchronize_srcu+0x197/0x250 kernel/rcu/srcutree.c:921
     synchronize_srcu_expedited kernel/rcu/srcutree.c:946 [inline]
     synchronize_srcu+0x239/0x3e8 kernel/rcu/srcutree.c:997
     kvm_page_track_unregister_notifier+0xe7/0x130 arch/x86/kvm/page_track.c:212
     kvm_mmu_uninit_vm+0x1e/0x30 arch/x86/kvm/mmu.c:5828
     kvm_arch_destroy_vm+0x4a2/0x5f0 arch/x86/kvm/x86.c:9579
     kvm_create_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:702 [inline]

I'm thinking of something like this (not tested yet):

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index d6f0696d98ef..e22ff63e5b1a 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -645,6 +645,11 @@ static struct kvm *kvm_create_vm(unsigned long type)
 
 	BUILD_BUG_ON(KVM_MEM_SLOTS_NUM > SHRT_MAX);
 
+	if (init_srcu_struct(&kvm->srcu))
+		goto out_err_no_srcu;
+	if (init_srcu_struct(&kvm->irq_srcu))
+		goto out_err_no_irq_srcu;
+
 	for (i = 0; i < KVM_ADDRESS_SPACE_NUM; i++) {
 		struct kvm_memslots *slots = kvm_alloc_memslots();
 
@@ -675,11 +680,6 @@ static struct kvm *kvm_create_vm(unsigned long type)
 	INIT_HLIST_HEAD(&kvm->irq_ack_notifier_list);
 #endif
 
-	if (init_srcu_struct(&kvm->srcu))
-		goto out_err_no_srcu;
-	if (init_srcu_struct(&kvm->irq_srcu))
-		goto out_err_no_irq_srcu;
-
 	r = kvm_init_mmu_notifier(kvm);
 	if (r)
 		goto out_err;
@@ -693,10 +693,6 @@ static struct kvm *kvm_create_vm(unsigned long type)
 	return kvm;
 
 out_err:
-	cleanup_srcu_struct(&kvm->irq_srcu);
-out_err_no_irq_srcu:
-	cleanup_srcu_struct(&kvm->srcu);
-out_err_no_srcu:
 	hardware_disable_all();
 out_err_no_disable:
 	kvm_arch_destroy_vm(kvm);
@@ -706,6 +702,10 @@ static struct kvm *kvm_create_vm(unsigned long type)
 		kfree(kvm_get_bus(kvm, i));
 	for (i = 0; i < KVM_ADDRESS_SPACE_NUM; i++)
 		kvm_free_memslots(kvm, __kvm_memslots(kvm, i));
+	cleanup_srcu_struct(&kvm->irq_srcu);
+out_err_no_irq_srcu:
+	cleanup_srcu_struct(&kvm->srcu);
+out_err_no_srcu:
 	kvm_arch_free_vm(kvm);
 	mmdrop(current->mm);
 	return ERR_PTR(r);

Paolo
