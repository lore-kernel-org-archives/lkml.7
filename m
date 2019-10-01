Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6121DC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 08:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 439AD215EA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 08:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729407AbfJAIjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 04:39:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:62806 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727274AbfJAIjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 04:39:09 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8FEF188302
        for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2019 08:39:08 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id a15so5714503wrq.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 01:39:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=V0oWnMG5UzeuD4QEm5neHsBPW9FV4K2Mbr76uGM5/zI=;
        b=EeSn2yQHuMSccWh+e5ERTIk4TR6CDgAXq5/o9aVt8j1Vbv5vq6qpESqs+01cktyEgA
         Deg5XbB1TQAuJx62vDQpGStpQiwS44Zm0m//QBORMRI8zTYzNayr0661dnb6nzl734g1
         NAMz2MkW/Sd6Hm2g0pcwzLhyWhmcsUcY/ptv5LqyQofcVFTTBBzVDcIudJFeh4DmI5n0
         WHWYIMqmpOOdL5rcsot6WRTD/ALmoN4iJeJymyO6O58ZPriXiGkAWnBUZAzzGQS0RsDv
         7WH9p0tavn1V9Ih3xEPpG/cdEw+cm7DSIVGerzLMX2kJTNKFtBQ7Q1ds5zfVZjqz+tFt
         BoHw==
X-Gm-Message-State: APjAAAWEhSucRW25CLQCa6Mql0RJsZ7BkpflmGPUnaZ+nEZPTAI4FDcl
        tCWmda2CVF7x9dc46TGqW0oGCGzba9/C+0aFokF9ky/AxgsSFOigaVYaSKmHpmrfgkMTotIVfxx
        xGuVTZDdpb3d7EbblgV6qZUfK
X-Received: by 2002:adf:94c2:: with SMTP id 60mr1392650wrr.357.1569919146899;
        Tue, 01 Oct 2019 01:39:06 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyQkp8qJFCtpc/jzZ7GBhcO9xjJt5CEQmZ7NIVGjuCO/nB4ek1cLFqBaknBX+bsLTR5KpD9bA==
X-Received: by 2002:adf:94c2:: with SMTP id 60mr1392632wrr.357.1569919146650;
        Tue, 01 Oct 2019 01:39:06 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id w12sm24653712wrg.47.2019.10.01.01.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 01:39:05 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH 1/3] KVM: X86: Add "nopvspin" parameter to disable PV spinlocks
In-Reply-To: <aae59646-be5f-6455-a033-ed29861107ce@oracle.com>
References: <1569759666-26904-1-git-send-email-zhenzhong.duan@oracle.com> <1569759666-26904-2-git-send-email-zhenzhong.duan@oracle.com> <87pnjh3i6i.fsf@vitty.brq.redhat.com> <aae59646-be5f-6455-a033-ed29861107ce@oracle.com>
Date:   Tue, 01 Oct 2019 10:39:05 +0200
Message-ID: <87eezw3lna.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zhenzhong Duan <zhenzhong.duan@oracle.com> writes:

> On 2019/9/30 23:41, Vitaly Kuznetsov wrote:
>> Zhenzhong Duan<zhenzhong.duan@oracle.com>  writes:
>>
>>> There are cases where a guest tries to switch spinlocks to bare metal
>>> behavior (e.g. by setting "xen_nopvspin" on XEN platform and
>>> "hv_nopvspin" on HYPER_V).
>>>
>>> That feature is missed on KVM, add a new parameter "nopvspin" to disable
>>> PV spinlocks for KVM guest.
>>>
>>> This new parameter is also intended to replace "xen_nopvspin" and
>>> "hv_nopvspin" in the future.
>> Any reason to not do it right now? We will probably need to have compat
>> code to support xen_nopvspin/hv_nopvspin too but emit a 'is deprecated'
>> warning.
>
> Sorry the description isn't clear, I'll fix it.
>
> I did the compat work in the other two patches.
> [PATCH 2/3] xen: Mark "xen_nopvspin" parameter obsolete and map it to "nopvspin"
> [PATCH 3/3] x86/hyperv: Mark "hv_nopvspin" parameter obsolete and map it to "nopvspin"
>

For some reason I got CCed only on the first one and moreover, I don't
see e.g PATCH3 on 'linux-hyperv' mailing list.

>>
>>> The global variable pvspin isn't defined as __initdata as it's used at
>>> runtime by XEN guest.
>>>
>>> Refactor the print stuff with pr_* which is preferred.
>> Please do it in a separate patch.
>
> Ok, I'll do that in v2. Thanks for review.

Thanks!

-- 
Vitaly
