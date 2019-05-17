Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D82B7C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 20:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DEB120657
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 20:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbfEQUMm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 16:12:42 -0400
Received: from mga07.intel.com ([134.134.136.100]:51061 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727018AbfEQUMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 16:12:42 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 May 2019 13:12:41 -0700
X-ExtLoop1: 1
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.36])
  by orsmga007.jf.intel.com with ESMTP; 17 May 2019 13:12:41 -0700
Date:   Fri, 17 May 2019 13:12:41 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH 4/4] KVM: nVMX: Fix using __this_cpu_read() in
 preemptible context
Message-ID: <20190517201241.GK15006@linux.intel.com>
References: <1558082990-7822-1-git-send-email-wanpengli@tencent.com>
 <1558082990-7822-4-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1558082990-7822-4-git-send-email-wanpengli@tencent.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2019 at 04:49:50PM +0800, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
>  BUG: using __this_cpu_read() in preemptible [00000000] code: qemu-system-x86/4590
>   caller is nested_vmx_enter_non_root_mode+0xebd/0x1790 [kvm_intel]
>   CPU: 4 PID: 4590 Comm: qemu-system-x86 Tainted: G           OE     5.1.0-rc4+ #1
>   Call Trace:
>    dump_stack+0x67/0x95
>    __this_cpu_preempt_check+0xd2/0xe0
>    nested_vmx_enter_non_root_mode+0xebd/0x1790 [kvm_intel]
>    nested_vmx_run+0xda/0x2b0 [kvm_intel]
>    handle_vmlaunch+0x13/0x20 [kvm_intel]
>    vmx_handle_exit+0xbd/0x660 [kvm_intel]
>    kvm_arch_vcpu_ioctl_run+0xa2c/0x1e50 [kvm]
>    kvm_vcpu_ioctl+0x3ad/0x6d0 [kvm]
>    do_vfs_ioctl+0xa5/0x6e0
>    ksys_ioctl+0x6d/0x80
>    __x64_sys_ioctl+0x1a/0x20
>    do_syscall_64+0x6f/0x6c0
>    entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> Accessing per-cpu variable should disable preemption, this patch extends the 
> preemption disable region for __this_cpu_read().
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---

Fixes: 52017608da33 ("KVM: nVMX: add option to perform early consistency checks via H/W")

and probably

Cc: stable@vger.kernel.org

Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>
