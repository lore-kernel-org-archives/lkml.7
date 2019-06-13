Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6670CC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A24920449
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pRF9N3So"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403973AbfFMQbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:31:35 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46470 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730872AbfFMIYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:24:32 -0400
Received: by mail-ot1-f68.google.com with SMTP id z23so18126217ote.13;
        Thu, 13 Jun 2019 01:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hre5nLnQQ4+A+DOQUGwhGs4eP3NR7SZY3z519Isz6r8=;
        b=pRF9N3SoqV2BY+AmHElxf1CtkA1Axlc62AD4B05PeeXvimpYB/CDzBaaFVDbZRm92d
         Jly5Sn8+cdibdwnMKRN6y8a6PkNM44LlxPogHVLbyIg4boG3OB9qYLYrhQQnDWDZqkQI
         zDAwkYiGXHnxKnvLy0vjNAei+2jSzbSRALM1D+wLfBKSiPqlc4xrMOm+8nI/V2Bnsa1G
         XaNjidfGFdmtJwYN3qzTvB0yhhIQj2dtnJRBO4K2noYX/K8FIVcFmVwWKDLHPWg+/v+5
         z6KNUc3oBvc2Posb4cofGPLNIA0U5ilz/3/JacGPqp3p2Rn019VjM3lxFThbopYWRy+T
         9KAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hre5nLnQQ4+A+DOQUGwhGs4eP3NR7SZY3z519Isz6r8=;
        b=fsKaUg7i/B4kTVmOAVTBa/SGg9prmFnvqP2fODStOhyBJH5IuoOewz+WfNud8HiGPU
         ety54g4kvcVlhnMqTXTNZvwpq9+b7zypPjlNdicAHwGXB8MbZproH4AFDH1w0cHyw6ye
         L0zEBgmpPtSJfKnLn2CGH90t0nJerBy7797FV9puwlO+lrxxCfHUMiiWjWRVYhj5aQr8
         o0PE2Rn4DfYhSP40F27dgkljC1vPfzNLEtSkWPrwlwY+5Sa/Uz6kB/ecEPbuLitTPBFt
         sr2arSI8H0oQQR/74syrXvEGwnSblcd94KvosuknMuUsmvyAB/KjmEabMAb2dXxhjgHV
         8xEQ==
X-Gm-Message-State: APjAAAUK87Tc9fpT5mWAaM62GNFTcbrbY66hGRMV186uVi1EpT95YHhR
        /2gNQCw6sRNOpWexTJ6NofodAL6GZBLJTFZNhGfpbFZg
X-Google-Smtp-Source: APXvYqztUUQ/fEd0e7CbsTrEqLOhnU6toGGPnqT+2NQSRh4cFn9qi2j8JDqKl8tnlCyQW/85XXk/ZMefjUalMEQEDtI=
X-Received: by 2002:a9d:62c4:: with SMTP id z4mr27109972otk.56.1560414271922;
 Thu, 13 Jun 2019 01:24:31 -0700 (PDT)
MIME-Version: 1.0
References: <1560255429-7105-1-git-send-email-wanpengli@tencent.com> <a078b29ebc0a2323c89b5877bf2ba4005eef3485.camel@redhat.com>
In-Reply-To: <a078b29ebc0a2323c89b5877bf2ba4005eef3485.camel@redhat.com>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Thu, 13 Jun 2019 16:25:13 +0800
Message-ID: <CANRm+CxTNBAEpay=Gf25vV_aCtzRrtgz1N5CtGEwu_kg=F51+Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] KVM: LAPIC: Implement Exitless Timer
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jun 2019 at 15:59, Maxim Levitsky <mlevitsk@redhat.com> wrote:
>
> On Tue, 2019-06-11 at 20:17 +0800, Wanpeng Li wrote:
> > Dedicated instances are currently disturbed by unnecessary jitter due
> > to the emulated lapic timers fire on the same pCPUs which vCPUs resident.
> > There is no hardware virtual timer on Intel for guest like ARM. Both
> > programming timer in guest and the emulated timer fires incur vmexits.
> > This patchset tries to avoid vmexit which is incurred by the emulated
> > timer fires in dedicated instance scenario.
> >
> > When nohz_full is enabled in dedicated instances scenario, the unpinned
> > timer will be moved to the nearest busy housekeepers after commit 444969223c8
> > ("sched/nohz: Fix affine unpinned timers mess"). However, KVM always makes
> > lapic timer pinned to the pCPU which vCPU residents, the reason is explained
> > by commit 61abdbe0 (kvm: x86: make lapic hrtimer pinned). Actually, these
> > emulated timers can be offload to the housekeeping cpus since APICv
> > is really common in recent years. The guest timer interrupt is injected by
> > posted-interrupt which is delivered by housekeeping cpu once the emulated
> > timer fires.
> >
> > The host admin should fine tuned, e.g. dedicated instances scenario w/
> > nohz_full cover the pCPUs which vCPUs resident, several pCPUs surplus
> > for housekeeping, disable mwait/hlt/pause vmexits to occupy the pCPUs,
> > fortunately preemption timer is disabled after mwait is exposed to
> > guest which makes emulated timer offload can be possible.
> > ~3% redis performance benefit can be observed on Skylake server.
>
> I don't yet know the kvm well enough to review this patch series, but overall I really like the idea.

Thank you. :)

> I researched this area some time ago, to see what can be done to reduce the number of vmexits,
> to an absolute minimum.
>
> I have one small question, just out of curiosity.
>
> Why do you require mwait in the guest to be enabled?
>
> If I understand it correctly, you say
> that when mwait in the guest is disabled, then vmx preemption timer will be used,
> and thus it will handle the apic timer?

Actually we don't have this restriction in v3, the patchset
description need to update. The lapic timer which guest use can be
emulated by software(a hrtimer on host) or VT-x hardware (VMX
preemption timer). VMX preemption timer triggers vmexit when the timer
fires on the same pCPU which vCPU is running on, so the injection
vmexit can't be avoided. The hrtimer on host is used to emulate the
lapic timer when VMX preemption timer is disabled. After commit
9642d18eee2cd(nohz: Affine unpinned timers to housekeepers), unpinned
timers will be moved to nearest busy housekeepers, which means that we
can offload the hrtimer to the housekeeping cpus instead of running on
the pCPU which vCPU residents, the timer fires on the housekeeping
cpus and be injected by posted-interrupt to the vCPU w/o incur
vmexits. In patchset v3, the preemption timer will be disarmed if
lapic timer is injected by posted-interrupt. VMX preemption timer stop
working in C-states deeper than C2, that's why I utilize mwait expose
before. (commit 386c6ddbda1 X86/VMX: Disable VMX preemption timer if
MWAIT is not intercepted)

Regards,
Wanpeng Li
