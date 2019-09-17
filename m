Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065EBC4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 14:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C883221852
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 14:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vl+iO5Ps"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbfIQO7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 10:59:03 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36977 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727315AbfIQO7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 10:59:03 -0400
Received: by mail-io1-f65.google.com with SMTP id b19so8369946iob.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 07:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4N/btWkhdRtAkLwnNEi3JvgTHWUB7am8sFUWn4QTMHo=;
        b=Vl+iO5Psm3owdP69GO+WOZQtnoLDGAdiMyy8AlEs6zj4KE57ayqKDns6d5FrJn5ROq
         IGhwt1lh/vRUdyTt+CFCXnyKqmikSQqVhZXIEOj2KHwNr6k0Xuwx51HzaNHP8+vLH9rn
         QxW4R+EVLL/5PivNA1qKPwAUzPWQ2jRsKoE9rxXNAtD8q3PcuUO9CR38EFV/4XMqqSnF
         W7PTBHS/61nGVwhiw6EBQvCwO9ZxJq7pnVSmcp/9howaygFWPLKfe/DeMe9slMlkiwXm
         f4jbaxLXZjDlgut4uJnT0u08GS7ZjP/PxosvoKtce/aPB6MMWEEQ8LBRv5MQpTwzzR6s
         w6yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4N/btWkhdRtAkLwnNEi3JvgTHWUB7am8sFUWn4QTMHo=;
        b=JbTIYkOdtTrGIlxPMW777/Dh06rSEL7slo+3xDmz8Ry7a8953YN5fAuBuN6gUgvE8Z
         wwUMFMPCPwR0hPrjtKUQXyEpTFWA4WqRtS40vsOJXPRF5rRspaG9JZ++iI2xLblMjtuX
         IMQx9VfhvHzz0pW2b4lcmgRxYCuzxWmQe0Kjp5QqfWgFHis6aIb6nNGct9xKgSdP3PY7
         ZXS4H3OFsbFukhGrBNddxlmyZyPbfoBbE6Dx9f2fl0q2+pfPKAhpRr6k8WDvtR0G+zSD
         SwLkaDCffzENyEX3l8I4S62UqLRWFE824/cm/py7CJ6tUOs2aF34v3d3ohEdLN1mQg1d
         RpaA==
X-Gm-Message-State: APjAAAWvaE5uUvaLcHJiyZ6D3zHmxAmZX1An0D4PD+Lx+8hDqx84BQH/
        8/EG2FpyCDdmtlPfBMnKh7X4Necgq8nKu6aMeTpPTg==
X-Google-Smtp-Source: APXvYqz9DvHQNg9JiUWZur8kh4NHVWmxIc5OJSKjAK0NEC6eFvWeXKcUfTuQH1pek1NBrEZiHfP0dJlLdiC+XjpI0K0=
X-Received: by 2002:a05:6602:115:: with SMTP id s21mr3306650iot.122.1568732342359;
 Tue, 17 Sep 2019 07:59:02 -0700 (PDT)
MIME-Version: 1.0
References: <1568708186-20260-1-git-send-email-wanpengli@tencent.com>
In-Reply-To: <1568708186-20260-1-git-send-email-wanpengli@tencent.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 17 Sep 2019 07:58:51 -0700
Message-ID: <CALMp9eSNTvHsSn55iNfF1tUAdAihz_2d5-Hac1H6TnvHyos-SQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] KVM: Fix coalesced mmio ring buffer out-of-bounds access
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, stable@vger.kernel.org,
        Matt Delco <delco@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 1:16 AM Wanpeng Li <kernellwp@gmail.com> wrote:
>
> From: Wanpeng Li <wanpengli@tencent.com>
>
> Reported by syzkaller:
>
>         #PF: supervisor write access in kernel mode
>         #PF: error_code(0x0002) - not-present page
>         PGD 403c01067 P4D 403c01067 PUD 0
>         Oops: 0002 [#1] SMP PTI
>         CPU: 1 PID: 12564 Comm: a.out Tainted: G           OE     5.3.0-rc4+ #4
>         RIP: 0010:coalesced_mmio_write+0xcc/0x130 [kvm]
>         Call Trace:
>          __kvm_io_bus_write+0x91/0xe0 [kvm]
>          kvm_io_bus_write+0x79/0xf0 [kvm]
>          write_mmio+0xae/0x170 [kvm]
>          emulator_read_write_onepage+0x252/0x430 [kvm]
>          emulator_read_write+0xcd/0x180 [kvm]
>          emulator_write_emulated+0x15/0x20 [kvm]
>          segmented_write+0x59/0x80 [kvm]
>          writeback+0x113/0x250 [kvm]
>          x86_emulate_insn+0x78c/0xd80 [kvm]
>          x86_emulate_instruction+0x386/0x7c0 [kvm]
>          kvm_mmu_page_fault+0xf9/0x9e0 [kvm]
>          handle_ept_violation+0x10a/0x220 [kvm_intel]
>          vmx_handle_exit+0xbe/0x6b0 [kvm_intel]
>          vcpu_enter_guest+0x4dc/0x18d0 [kvm]
>          kvm_arch_vcpu_ioctl_run+0x407/0x660 [kvm]
>          kvm_vcpu_ioctl+0x3ad/0x690 [kvm]
>          do_vfs_ioctl+0xa2/0x690
>          ksys_ioctl+0x6d/0x80
>          __x64_sys_ioctl+0x1a/0x20
>          do_syscall_64+0x74/0x720
>          entry_SYSCALL_64_after_hwframe+0x49/0xbe
>         RIP: 0010:coalesced_mmio_write+0xcc/0x130 [kvm]
>
> Both the coalesced_mmio ring buffer indexs ring->first and ring->last are
> bigger than KVM_COALESCED_MMIO_MAX from the testcase, array out-of-bounds
> access triggers by ring->coalesced_mmio[ring->last].phys_addr = addr;
> assignment. This patch fixes it by mod indexs by KVM_COALESCED_MMIO_MAX.
>
> syzkaller source: https://syzkaller.appspot.com/x/repro.c?x=134b2826a00000
>
> Reported-by: syzbot+983c866c3dd6efa3662a@syzkaller.appspotmail.com
> Cc: stable@vger.kernel.org
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
>  virt/kvm/coalesced_mmio.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/virt/kvm/coalesced_mmio.c b/virt/kvm/coalesced_mmio.c
> index 5294abb..cff1ec9 100644
> --- a/virt/kvm/coalesced_mmio.c
> +++ b/virt/kvm/coalesced_mmio.c
> @@ -73,6 +73,8 @@ static int coalesced_mmio_write(struct kvm_vcpu *vcpu,
>
>         spin_lock(&dev->kvm->ring_lock);
>
> +       ring->first = ring->first % KVM_COALESCED_MMIO_MAX;
> +       ring->last = ring->last % KVM_COALESCED_MMIO_MAX;

I don't think this is sufficient, since the memory that ring points to
is shared with userspace. Userspace can overwrite your corrected
values with illegal ones before they are used. Not exactly a TOCTTOU
issue, since there isn't technically a 'check' here, but the same
idea.

>         if (!coalesced_mmio_has_room(dev)) {
>                 spin_unlock(&dev->kvm->ring_lock);
>                 return -EOPNOTSUPP;
> --
> 2.7.4
>
