Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02645C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 12:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4B1120828
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 12:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbfH0MiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 08:38:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51114 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726539AbfH0MiW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 08:38:22 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B5CE2811DC
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 12:38:21 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id d65so1017303wmd.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 05:38:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=mhQh216D8KPUhpQBQ77haDbZ+wPiEolIAFs33u9E+Zo=;
        b=CjUdb4jBJeuwtBt3PaLYWNr/Nyzs//ITuieyLg8n0ddqYadnocNsfQbea7fV5JD4mS
         U8ih95P8bHV6AioiYcU2pvcGlW4Sa+Uy4fBYFNwELJ7pUPkbQGGUbwhxKvaesXE2JrW7
         btLgCfKTN5wRsMQnZGfci+3Z+4gPynid9gMGyVuky2/S+bxFyz5IpWFcM168KHTFxrMF
         CBhtoJQsKpn40ge6XCxQo2U9Wx0xv0fLymbhvCQWH9wyYSyIkX4yJ5YPBKrfreDQQVhn
         6zYVNO+o+jW6FS7e4Xhs+kN4E9jOdMfrHwdBl16PqIdNAT0or5FtmxWKPIad3jaPojAZ
         4/+Q==
X-Gm-Message-State: APjAAAVk98sIZZ/hSZUL59K4lAd8x4kjhasN18C4CUMoN+uc7vKmYl2h
        G+pEUbXpynLxeXeOjzQFVZnrhkmvhR1V1ZOR3PHtV1+aKArD9rfN+k11nLPZiQD8baNm+6Lmj//
        vWewsple+WPwvOFePTmF50D7r
X-Received: by 2002:adf:f481:: with SMTP id l1mr25892221wro.123.1566909500323;
        Tue, 27 Aug 2019 05:38:20 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwI/jOubxVQ3m1X/ohXNC7Qj8WcNWE6wblvwS3EBzKXpryhrcDiEf/YNoTuRfvbBF8ToWpKXQ==
X-Received: by 2002:adf:f481:: with SMTP id l1mr25892187wro.123.1566909500126;
        Tue, 27 Aug 2019 05:38:20 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id x10sm16906584wrn.39.2019.08.27.05.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 05:38:19 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Tianyu Lan <lantianyu1986@gmail.com>
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>, kvm <kvm@vger.kernel.org>,
        linux-doc@vger.kernel.org, linux-hyperv@vger.kernel.org,
        "linux-kernel\@vger kernel org" <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>, corbet@lwn.net,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        michael.h.kelley@microsoft.com
Subject: Re: [PATCH V3 0/3] KVM/Hyper-V: Add Hyper-V direct tlb flush support
In-Reply-To: <CAOLK0pzXPG9tBnQoKGTSNHMwXXrEQ4zZH1uWn2F2mQ2ddVcoFA@mail.gmail.com>
References: <20190819131737.26942-1-Tianyu.Lan@microsoft.com> <87ftlnm7o8.fsf@vitty.brq.redhat.com> <CAOLK0pzXPG9tBnQoKGTSNHMwXXrEQ4zZH1uWn2F2mQ2ddVcoFA@mail.gmail.com>
Date:   Tue, 27 Aug 2019 14:38:18 +0200
Message-ID: <87v9uilr5x.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tianyu Lan <lantianyu1986@gmail.com> writes:

> On Tue, Aug 27, 2019 at 2:41 PM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>>
>> lantianyu1986@gmail.com writes:
>>
>> > From: Tianyu Lan <Tianyu.Lan@microsoft.com>
>> >
>> > This patchset is to add Hyper-V direct tlb support in KVM. Hyper-V
>> > in L0 can delegate L1 hypervisor to handle tlb flush request from
>> > L2 guest when direct tlb flush is enabled in L1.
>> >
>> > Patch 2 introduces new cap KVM_CAP_HYPERV_DIRECT_TLBFLUSH to enable
>> > feature from user space. User space should enable this feature only
>> > when Hyper-V hypervisor capability is exposed to guest and KVM profile
>> > is hided. There is a parameter conflict between KVM and Hyper-V hypercall.
>> > We hope L2 guest doesn't use KVM hypercall when the feature is
>> > enabled. Detail please see comment of new API
>> > "KVM_CAP_HYPERV_DIRECT_TLBFLUSH"
>>
>> I was thinking about this for awhile and I think I have a better
>> proposal. Instead of adding this new capability let's enable direct TLB
>> flush when KVM guest enables Hyper-V Hypercall page (writes to
>> HV_X64_MSR_HYPERCALL) - this guarantees that the guest doesn't need KVM
>> hypercalls as we can't handle both KVM-style and Hyper-V-style
>> hypercalls simultaneously and kvm_emulate_hypercall() does:
>>
>>         if (kvm_hv_hypercall_enabled(vcpu->kvm))
>>                 return kvm_hv_hypercall(vcpu);
>>
>> What do you think?
>>
>> (and instead of adding the capability we can add kvm.ko module parameter
>> to enable direct tlb flush unconditionally, like
>> 'hv_direct_tlbflush=-1/0/1' with '-1' being the default (autoselect
>> based on Hyper-V hypercall enablement, '0' - permanently disabled, '1' -
>> permanenetly enabled)).
>>
>
> Hi Vitaly::
>      Actually, I had such idea before. But user space should check
> whether hv tlb flush
> is exposed to VM before enabling direct tlb flush. If no, user space
> should not direct
> tlb flush for guest since Hyper-V will do more check for each
> hypercall from nested
> VM with enabling the feauter..

If TLB Flush enlightenment is not exposed to the VM at all there's no
difference if we enable direct TLB flush in eVMCS or not: the guest
won't be using 'TLB Flush' hypercall and will do TLB flushing with
IPIs. And, in case the guest enables Hyper-V hypercall page, it is
definitelly not going to use KVM hypercalls so we can't break these.

-- 
Vitaly
