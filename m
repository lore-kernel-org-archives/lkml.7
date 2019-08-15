Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB3CC3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 14:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B59A22086C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 14:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732300AbfHOODf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 10:03:35 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33563 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732334AbfHOODf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 10:03:35 -0400
Received: by mail-wr1-f65.google.com with SMTP id u16so2353246wrr.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 07:03:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=P6jtmJQJAOxQmjY3PzD+zR33iq9AQ8OzIHihVYNbvtU=;
        b=ifl6rCnO2Dv/9auJxn5GlKeaWTvupWDKCJYlwQChNBDy6wSKENrKCAHZH20F40XTlj
         szPFLA8RwXitFKGe7K3KzLVW2HITw/17MliS4niZO28mlAstc8h+6O/4TTHtX51mvg27
         a5hf2MjhYxAZeDoFAlc69KM2mC0wwzmhj/kw3wtJ0D55Cpmrnk3Ikg9xGxhRNxV4BQe7
         tPeGtIizcdxsDTmTkPwy1bZWO4/HUhopHMHAj0ltFcnCPUdfwuZMfXYyT/Vcv0GVocv0
         08LNdYQufZPn6gAAs/XiFNz6yNQyr02rCwCVUkH1DxehzZjisUb0vGptWYqnZYCCuGyl
         p97w==
X-Gm-Message-State: APjAAAU1ypWkZa+NVZGIvrnsC+uSYg+Nh7xvIHEH+Td4Pc7fudI/WQtZ
        xmhm01Q3MiUi3k61V0uef9ECHA==
X-Google-Smtp-Source: APXvYqz3n13iAarvnk398GKr173OsqGUtiGpYz002s0J1/siYVBnI9MVpRe8PGn9JMKu1I5a55aTDw==
X-Received: by 2002:adf:f204:: with SMTP id p4mr5874439wro.317.1565877813345;
        Thu, 15 Aug 2019 07:03:33 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id t198sm2803371wmt.39.2019.08.15.07.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 07:03:32 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Yang Weijiang <weijiang.yang@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org, mst@redhat.com,
        rkrcmar@redhat.com, jmattson@google.com, yu.c.zhang@intel.com,
        alazar@bitdefender.com, pbonzini@redhat.com,
        sean.j.christopherson@intel.com
Subject: Re: [PATCH RESEND v4 5/9] KVM: VMX: Add init/set/get functions for SPP
In-Reply-To: <20190815134329.GA11449@local-michael-cet-test>
References: <20190814070403.6588-1-weijiang.yang@intel.com> <20190814070403.6588-6-weijiang.yang@intel.com> <87a7cbapdw.fsf@vitty.brq.redhat.com> <20190815134329.GA11449@local-michael-cet-test>
Date:   Thu, 15 Aug 2019 16:03:31 +0200
Message-ID: <87o90q8r0s.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yang Weijiang <weijiang.yang@intel.com> writes:

> After looked into the issue and others, I feel to make SPP co-existing
> with nested VM is not good, the major reason is, L1 pages protected by
> SPP are transparent to L1 VM, if it launches L2 VM, probably the
> pages would be allocated to L2 VM, and that will bother to L1 and L2.
> Given the feature is new and I don't see nested VM can benefit
> from it right now, I would like to make SPP and nested feature mutually
> exclusive, i.e., detecting if the other part is active before activate one
> feature,what do you think of it? 

I was mostly worried about creating a loophole (if I understand
correctly) for guests to defeat SPP protection: just launching a nested
guest and giving it a protected page. I don't see a problem if we limit
SPP to non-nested guests as step 1: we, however, need to document this
side-effect of the ioctl. Also, if you decide to do this enforecement,
I'd suggest you forbid VMLAUCH/VMRESUME and not VMXON as kvm module
loads in linux guests automatically when the hardware is suitable.

Thanks,

-- 
Vitaly
