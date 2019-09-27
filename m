Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F4EC388F3
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 12:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D77D820673
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 12:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbfI0MMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 08:12:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38200 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbfI0MMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 08:12:19 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BDE22C05975D
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 12:12:18 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id r21so2145932wme.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 05:12:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=1BKH6Vd2y0kjt5qb+nb7wXA/qqVsC/VTzacnT15CY10=;
        b=IkFgFEKMxE/QYdGLWwiirwhqQtBFrkoV+vNNfwS2LBJmzV6AWJGzrvd7igijZOUJrk
         UyCWSH2yjmxbyGtuD7/8JH5ocTV+qt1dFBhvP+FyNfw5nNw/e4Eini+TG3p4oZh7JPXp
         rLoy+iOclar1+Z7CLiR5/hNW34Gwy0MdYhwKT6snhQG72HtsbwNNDQC9O9+YGQK1vict
         6gfOt3z6gYvZDC7HccWT1QJQV7I+oFHERkqKu90BePuauwVy5UYhpCxF3wsaKglnbBih
         1FV1a/q9Y4Vsb6l6dBRaIISmfgItQ4yteVJ5dPbH3k960GqQypwkPrWdNaGCux8SB//X
         +azg==
X-Gm-Message-State: APjAAAUkr2Q8WSrt5sy8uMLecnr6+psryRTv1fXGDfh+GSERUHkffqao
        F+aG4qWMreaE5N8CGMhB5aWpLf8uH3dgQ+vu/eAc3kXGnWF8QbPBYhhYLadQVqcQGJl0UydTbk/
        OKGJpK0fGPblWUpsVcHZg9o2m
X-Received: by 2002:adf:f58c:: with SMTP id f12mr2689598wro.38.1569586337498;
        Fri, 27 Sep 2019 05:12:17 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxSk514eVf6BTYDMpnjdeyawo4kXOVNU56dKCoFHmvIyY7JVO1ee097ZFa9WRpTPQgMqrYSNA==
X-Received: by 2002:adf:f58c:: with SMTP id f12mr2689586wro.38.1569586337260;
        Fri, 27 Sep 2019 05:12:17 -0700 (PDT)
Received: from vitty.brq.redhat.com ([95.82.135.182])
        by smtp.gmail.com with ESMTPSA id a13sm6204997wrf.73.2019.09.27.05.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 05:12:16 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Reto Buerki <reet@codelabs.ch>
Subject: Re: [PATCH 0/2] KVM: nVMX: Bug fix for consuming stale vmcs02.GUEST_CR3
In-Reply-To: <20190926214302.21990-1-sean.j.christopherson@intel.com>
References: <20190926214302.21990-1-sean.j.christopherson@intel.com>
Date:   Fri, 27 Sep 2019 14:12:15 +0200
Message-ID: <87o8z65468.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Reto Buerki reported a failure in a nested VMM when running with HLT
> interception disabled in L1.  When putting L2 into HLT, KVM never actually
> enters L2 and instead cancels the nested run and pretends that VM-Enter to
> L2 completed and then exited on HLT (which KVM intercepted).  Because KVM
> never actually runs L2, KVM skips the pending MMU update for L2 and so
> leaves a stale value in vmcs02.GUEST_CR3.  If the next wake event for L2
> triggers a nested VM-Exit, KVM will refresh vmcs12->guest_cr3 from
> vmcs02.GUEST_CR3 and consume the stale value.
>
> Fix the issue by unconditionally writing vmcs02.GUEST_CR3 during nested
> VM-Enter instead of deferring the update to vmx_set_cr3(), and skip the
> update of GUEST_CR3 in vmx_set_cr3() when running L2.  I.e. make the
> nested code fully responsible for vmcs02.GUEST_CR3.
>
> I really wanted to go with a different fix of handling this as a one-off
> case in the HLT flow (in nested_vmx_run()), and then following that up
> with a cleanup of VMX's CR3 handling, e.g. to do proper dirty tracking
> instead of having the nested code do manual VMREADs and VMWRITEs.  I even
> went so far as to hide vcpu->arch.cr3 (put CR3 in vcpu->arch.regs), but
> things went south when I started working through the dirty tracking logic.
>
> Because EPT can be enabled *without* unrestricted guest, enabling EPT
> doesn't always mean GUEST_CR3 really is the guest CR3 (unlike SVM's NPT).
> And because the unrestricted guest handling of GUEST_CR3 is dependent on
> whether the guest has paging enabled, VMX can't even do a clean handoff
> based on unrestricted guest.  In a nutshell, dynamically handling the
> transitions of GUEST_CR3 ownership in VMX is a nightmare, so fixing this
> purely within the context of nested VMX turned out to be the cleanest fix.
>
> Sean Christopherson (2):
>   KVM: nVMX: Always write vmcs02.GUEST_CR3 during nested VM-Enter
>   KVM: VMX: Skip GUEST_CR3 VMREAD+VMWRITE if the VMCS is up-to-date
>

Series:
Tested-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly
