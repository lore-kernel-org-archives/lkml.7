Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D788CC4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 15:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7C8321924
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 15:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbfIQPL2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 11:11:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41400 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728802AbfIQPL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 11:11:27 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E52A9859FB
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 15:11:26 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id j3so1434625wrn.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 08:11:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=UCW+cy1gbNKZ9koPx/jd8y10g+OI2SWde/uEhyQmkDs=;
        b=JpeU6ZN7wa3tHL5i5kiXWdkt1qCeoSiq27yZzjcosVbY3CqGbbtwXQB86EWFNZRsrv
         pPrs2i4WfZTjgCPmbpal7r7TdXX86Y1eAPdJ1hu3GnZZs/vcbbNUo5QY8rp/7QPLpcPa
         CmqA0lcfsR1ktIGh0LK62U7CEO9BULj7pIarWSh9wh8Xe7qvJlEzVgfTW+Rp9qrF0cqu
         ceBV6++hmsvC4Rc/2eVPxBcVF4NqIBLMwchpcpAiYuHW9KzdIUjB3FRbPhNnjAGRFGUi
         xdEjzJGnmWIpqmzbAUFIrUSzjpuJRQa+UYWwOLN/GjEVdrX41Ys+NoCTf5aWKNw3jH0l
         V/jw==
X-Gm-Message-State: APjAAAXcK5EEl0af21rLRpYX/NGbvPYAPH96HAgKWb/lI18u5j2cCkkk
        lZuzcXI39Vqn43Cxi9kDuuLEpOvrhx5mTAVNK4PVVFqG6Y8a1vc2EeqeHI9YCEFpmcDVAzWc9LQ
        tAFeG/GHjYFPc+dOgK10jDsRP
X-Received: by 2002:a1c:99d4:: with SMTP id b203mr3688896wme.148.1568733085632;
        Tue, 17 Sep 2019 08:11:25 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwAs+pbI8E5ScMA+lIaanE//5Cw2DWJWcdVtcoEQjhifshIhHTCoaNtTepCoM2VYkqxtr6HPQ==
X-Received: by 2002:a1c:99d4:: with SMTP id b203mr3688873wme.148.1568733085393;
        Tue, 17 Sep 2019 08:11:25 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id c6sm3239891wrm.71.2019.09.17.08.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 08:11:24 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Jim Mattson <jmattson@google.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-hyperv@vger.kernel.org,
        the arch/x86 maintainers <x86@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra \(Intel\)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Roman Kagan <rkagan@virtuozzo.com>
Subject: Re: [PATCH 1/3] cpu/SMT: create and export cpu_smt_possible()
In-Reply-To: <CALMp9eQP7Dup+mMuAiShNtH754R_Wwuvf63hezygh3TGR=a9rg@mail.gmail.com>
References: <20190916162258.6528-1-vkuznets@redhat.com> <20190916162258.6528-2-vkuznets@redhat.com> <CALMp9eQP7Dup+mMuAiShNtH754R_Wwuvf63hezygh3TGR=a9rg@mail.gmail.com>
Date:   Tue, 17 Sep 2019 17:11:23 +0200
Message-ID: <87blvjarfo.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Mattson <jmattson@google.com> writes:

> On Mon, Sep 16, 2019 at 9:23 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>>
>> KVM needs to know if SMT is theoretically possible, this means it is
>> supported and not forcefully disabled ('nosmt=force'). Create and
>> export cpu_smt_possible() answering this question.
>
> It seems to me that KVM really just wants to know if the scheduler can
> be trusted to avoid violating the invariant expressed by the Hyper-V
> enlightenment, NoNonArchitecturalCoreSharing. It is possible to do
> that even when SMT is enabled, if the scheduler is core-aware.
> Wouldn't it be better to implement a scheduler API that told you
> exactly what you wanted to know, rather than trying to infer the
> answer from various breadcrumbs?

(I know not that much about scheduler so please bear with me)

Having a trustworthy scheduler not placing unrelated (not exposed as
sibling SMT threads to a guest or vCPUs from different guests) on
sibling SMT threads when it's not limited with affinity is definitely a
good thing. We, however, also need to know if vCPU pinning is planned
for the guest: like when QEMU vCPU threads are created they're not
pinned, however, libvirt pins them if needed before launching the
guest. So 'NoNonArchitecturalCoreSharing' can also be set in two cases:
- No vCPU pinning is planned but the scheduler is aware of the problem
(I'm not sure it is nowadays)
- The upper layer promises to do the right pinning.

This patch series, however, doesn't go that deep, it only covers the
simplest case: SMT is unavailable or forcefully disabled. I'll try to
learn more about scheduler though.

-- 
Vitaly
