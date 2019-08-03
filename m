Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA1B8C31E40
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 06:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D1692087C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 06:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfHCGaI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 02:30:08 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34226 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbfHCGaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 02:30:07 -0400
Received: by mail-wm1-f68.google.com with SMTP id w9so2860878wmd.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 23:30:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k16GciQDdsFXL1/gbaqPADgfBEVZRulBTAenPeqqAmY=;
        b=rc7XyW3ywpjTPkbbZ4vgnEIsQYbr/AtGGA/sT/B17x6ekwRLEoNX3eJm17jIwcs5k8
         rwLdymxOM99eFxOdnjP9BzsPRYXwf+7fk+rafYDnICXHT6WHxvKJuqi9p6V6wz1yC1dF
         ezgiWFb2PF1VXK+/NztCuJpiTKpxPB/cgXAM6uIQqmFnBlCrMPgYLDS5c7tdnImkkrt/
         XEMFmpyHZbvMnSgs34UUsG6p5y6iq52gDJbPcDwzkxFSBWNQPLiQwr2ziyDPJBd1APCV
         TrbKVWUcva/cEHvZ+/qw8CHCG6mKOIik6+JR3q/n8/Pu0ueCCKYtc2CNSkpf1oKPVFgn
         v8KQ==
X-Gm-Message-State: APjAAAWX4ecC+qF7Iy4T+5oMJNGs7S9qLmJnn9Byr7pJQpGsR9UiUbrY
        fGk4UAOR76Qvpm5vghlO1TiTvEFVrN4=
X-Google-Smtp-Source: APXvYqwS/D+b20geKl9iYom06BhFEyIz+muV/nijzcR5qufyNkHyVlr9BYRCDyDFBdrU0znfJ4mHcQ==
X-Received: by 2002:a7b:c202:: with SMTP id x2mr7504795wmi.49.1564813805534;
        Fri, 02 Aug 2019 23:30:05 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:4013:e920:9388:c3ff? ([2001:b07:6468:f312:4013:e920:9388:c3ff])
        by smtp.gmail.com with ESMTPSA id o20sm200895026wrh.8.2019.08.02.23.30.04
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Aug 2019 23:30:05 -0700 (PDT)
Subject: Re: [PATCH 0/3] KVM: x86/mmu: minor MMIO SPTE cleanup
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190801203523.5536-1-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <c2860baa-6ef9-1020-eb6f-886a3b7cda65@redhat.com>
Date:   Sat, 3 Aug 2019 08:30:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190801203523.5536-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/08/19 22:35, Sean Christopherson wrote:
> A few loosely related MMIO SPTE patches to get rid of a bit of cruft that
> has been a source of annoyance when mucking around in the MMIO code.
> 
> No functional changes intended.
> 
> Sean Christopherson (3):
>   KVM: x86: Rename access permissions cache member in struct
>     kvm_vcpu_arch
>   KVM: x86/mmu: Add explicit access mask for MMIO SPTEs
>   KVM: x86/mmu: Consolidate "is MMIO SPTE" code
> 
>  Documentation/virtual/kvm/mmu.txt |  4 ++--
>  arch/x86/include/asm/kvm_host.h   |  2 +-
>  arch/x86/kvm/mmu.c                | 31 +++++++++++++++++--------------
>  arch/x86/kvm/mmu.h                |  2 +-
>  arch/x86/kvm/vmx/vmx.c            |  2 +-
>  arch/x86/kvm/x86.c                |  2 +-
>  arch/x86/kvm/x86.h                |  2 +-
>  7 files changed, 24 insertions(+), 21 deletions(-)
> 

Queued, thanks.

Paolo
