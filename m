Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 859ACC3A5A4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 06:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F4C4206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 06:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbfH0Gls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 02:41:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59104 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726071AbfH0Gls (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 02:41:48 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 67A8F2D6A0F
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 06:41:47 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id g5so460124wmh.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 23:41:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=R3N0Ux8sXWlDkwBv6LnZ39XXekdpR8uOz0RxueTkq8c=;
        b=C5vudQQJTR0i5F+Pw090O/f5YQbbatqNEOPJ4wQsa9w82eUF1g7QqWCD038bW4Dh4X
         chB7/KSML3z8fYrbyrrhKxPqnoVFp/xAf4c3UQNllmzx9ZDXCWHohWfjxg5j2cXVbtRR
         4yNis/dVzrVrVq+0jDx9nyRuzi1IcbtW9U9bR1QU8Lr4sJib3D+x2RVJK6CTYnaxqX/E
         iVQs3+byjermX/byIPdhfbYOHzgZ7lFj8lmnzFmztHvU3Uw2FKAQYH/UT8IVQD7/4CHO
         oyGNypfh8a3YSV9+C1sdUEGmGB1210k/p+NuNJEFB50xufsqPNx9ZFoA1l+3Hch7jFZT
         Vs7Q==
X-Gm-Message-State: APjAAAXnjH6OSXz+smOzS4JZdS+L5l2dWENP6nruC3GrwMwiEFP2ZUlk
        J8abeKdB6eT9YU5bKe/4UBNqROLbqqOuDZWPW2l92C1TdfO4U/y/+4tzAZ5a7N7fyOSMjAA9fD6
        3YEZ7nLlQVJ/PSKtTIc9Ruopq
X-Received: by 2002:a1c:6145:: with SMTP id v66mr27541199wmb.42.1566888106053;
        Mon, 26 Aug 2019 23:41:46 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy2GI0NmyS361uOvgSgC8vAQPveBM+fESLiQwCenbAGMgIf/+ayRt++zlV0fLjGFgWERAv3gA==
X-Received: by 2002:a1c:6145:: with SMTP id v66mr27541156wmb.42.1566888105812;
        Mon, 26 Aug 2019 23:41:45 -0700 (PDT)
Received: from vitty.brq.redhat.com (ip-89-176-161-20.net.upcbroadband.cz. [89.176.161.20])
        by smtp.gmail.com with ESMTPSA id 39sm42348076wrc.45.2019.08.26.23.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 23:41:45 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     lantianyu1986@gmail.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, pbonzini@redhat.com,
        rkrcmar@redhat.com, corbet@lwn.net, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, sashal@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, michael.h.kelley@microsoft.com
Subject: Re: [PATCH V3 0/3] KVM/Hyper-V: Add Hyper-V direct tlb flush support
In-Reply-To: <20190819131737.26942-1-Tianyu.Lan@microsoft.com>
References: <20190819131737.26942-1-Tianyu.Lan@microsoft.com>
Date:   Tue, 27 Aug 2019 08:41:43 +0200
Message-ID: <87ftlnm7o8.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lantianyu1986@gmail.com writes:

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
> enabled. Detail please see comment of new API
> "KVM_CAP_HYPERV_DIRECT_TLBFLUSH"

I was thinking about this for awhile and I think I have a better
proposal. Instead of adding this new capability let's enable direct TLB
flush when KVM guest enables Hyper-V Hypercall page (writes to
HV_X64_MSR_HYPERCALL) - this guarantees that the guest doesn't need KVM
hypercalls as we can't handle both KVM-style and Hyper-V-style
hypercalls simultaneously and kvm_emulate_hypercall() does:

	if (kvm_hv_hypercall_enabled(vcpu->kvm))
		return kvm_hv_hypercall(vcpu);

What do you think?

(and instead of adding the capability we can add kvm.ko module parameter
to enable direct tlb flush unconditionally, like
'hv_direct_tlbflush=-1/0/1' with '-1' being the default (autoselect
based on Hyper-V hypercall enablement, '0' - permanently disabled, '1' -
permanenetly enabled)).

-- 
Vitaly
