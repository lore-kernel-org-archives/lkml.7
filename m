Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF49C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 01:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5846320659
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 01:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ario+ujY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbfKLBeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 20:34:02 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46410 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbfKLBeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 20:34:02 -0500
Received: by mail-ot1-f68.google.com with SMTP id n23so12915891otr.13;
        Mon, 11 Nov 2019 17:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nCXnq6KfTcW48HdT/UVgMIRXRm8X+Lrr6IQKnNcG3B8=;
        b=Ario+ujY8q3eOROTO8GLVkJJ9yLO2y/AkEe4/OrjczRsfMg0o6vljnEDoZiBp6QwWa
         YR5IZ5uW48wzJ/GrXjaw+fdVR0GpefkE8QpIcXNUw6N1Ry4yF6NkgCneKBRpuWf35szD
         xvbRESTqqUXBMBBTCYYEX8SQncXTOjpLPFaFRatHB38sfSK8MNULTNYYoy3K533Erm9H
         ZUGWdo95SMoWIJidYue9zO0CWzpL9AipHzsXrJ7yPz0VPC79LsGeAHyjPiSn9NC9DSgT
         txut7L+czczUhDe4Eh2LA1ljqU5AfnFZ1HS29MQc2wvkJ9EI7+XqYCHuIYe69RssAlac
         KHVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nCXnq6KfTcW48HdT/UVgMIRXRm8X+Lrr6IQKnNcG3B8=;
        b=B9gvA/MGzw5gYuQcoJ7WB72yZOkAZKI8+1HuFzupfkxLC73WdKuiYoO4+ARjd7dU+G
         jSvMrLZJ4ZGX/ZjHlR0eK62hBosRFA/hEALSEV/PlZ8km0E3JiyQlFc7PaGczWEhTL5i
         UnirqFPtUxjKcXhhNiAADn7J5bnQG0pYGEIWrYBukWOdbgorl8ikIHCSk0EIkIjPpLNJ
         jfKIkDskJTsrYicqVrPCgK98N1KtvcAzWU3/h7kpUcTtgmCyp/wjndInpEE4usK6OqwM
         SmODu2PMaIwfJxxxGX43LUTBe/UsOEDaZSt7/ikw7gzkVYZZjzVM9T0XlRVmuhyZ9Rnq
         lgSw==
X-Gm-Message-State: APjAAAXCTRL0gw/1ob6ZGEfbZBFZb4Q/OiDQEg8dqmn0zzNE6+mlea3e
        N2XXz+5ZUFw7FijEDp0olrRAjAS4sOUR+FVqNmGvTg4w
X-Google-Smtp-Source: APXvYqzkVdUE6QtSEFwy+i0dXIH0hPJL/YC3OsSpujqIYP7Ot8Bw7/ZFVzGAwtzFYU6mhje2mluc5BIIGwaELV5pKtg=
X-Received: by 2002:a9d:b83:: with SMTP id 3mr22827187oth.56.1573522439777;
 Mon, 11 Nov 2019 17:33:59 -0800 (PST)
MIME-Version: 1.0
References: <1573283135-5502-1-git-send-email-wanpengli@tencent.com> <4418c734-68e1-edaf-c939-f24d041acf2e@redhat.com>
In-Reply-To: <4418c734-68e1-edaf-c939-f24d041acf2e@redhat.com>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Tue, 12 Nov 2019 09:33:49 +0800
Message-ID: <CANRm+CzK_h2E9XWFipkNpAALLCBcM2vrUkdBpumwmT9AP09hfA@mail.gmail.com>
Subject: Re: [PATCH 1/2] KVM: X86: Single target IPI fastpath
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Nov 2019 at 05:59, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 09/11/19 08:05, Wanpeng Li wrote:
> > From: Wanpeng Li <wanpengli@tencent.com>
> >
> > This patch tries to optimize x2apic physical destination mode, fixed delivery
> > mode single target IPI by delivering IPI to receiver immediately after sender
> > writes ICR vmexit to avoid various checks when possible.
> >
> > Testing on Xeon Skylake server:
> >
> > The virtual IPI latency from sender send to receiver receive reduces more than
> > 330+ cpu cycles.
> >
> > Running hackbench(reschedule ipi) in the guest, the avg handle time of MSR_WRITE
> > caused vmexit reduces more than 1000+ cpu cycles:
> >
> > Before patch:
> >
> >   VM-EXIT    Samples  Samples%     Time%    Min Time    Max Time   Avg time
> > MSR_WRITE    5417390    90.01%    16.31%      0.69us    159.60us    1.08us
> >
> > After patch:
> >
> >   VM-EXIT    Samples  Samples%     Time%    Min Time    Max Time   Avg time
> > MSR_WRITE    6726109    90.73%    62.18%      0.48us    191.27us    0.58us
>
> Do you have retpolines enabled?  The bulk of the speedup might come just
> from the indirect jump.

Adding 'mitigations=off' to the host grub parameter:

Before patch:

    VM-EXIT    Samples  Samples%     Time%    Min Time    Max Time   Avg time
MSR_WRITE    2681713    92.98%    77.52%      0.38us     18.54us
0.73us ( +-   0.02% )

After patch:

    VM-EXIT    Samples  Samples%     Time%    Min Time    Max Time   Avg time
MSR_WRITE    2953447    92.48%    62.47%      0.30us     59.09us
0.40us ( +-   0.02% )

Actually, this is not the first attempt to add shortcut for MSR writes
which performance sensitive, the other effort is tscdeadline timer
from Isaku Yamahata, https://patchwork.kernel.org/cover/10541035/ ,
ICR and TSCDEADLINE MSR writes cause the main MSR write vmexits in our
product observation, multicast IPIs are not as common as unicast IPI
like RESCHEDULE_VECTOR and CALL_FUNCTION_SINGLE_VECTOR etc. As far as
I know, something similar to this patch has already been deployed in
some cloud companies private kvm fork.

    Wanpeng
