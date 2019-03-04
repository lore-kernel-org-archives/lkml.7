Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32EBFC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F238720657
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=scalemp.com header.i=@scalemp.com header.b="ah33a+TW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfCDSoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 13:44:07 -0500
Received: from www.scalemp.com ([169.44.78.149]:59088 "EHLO scalemp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbfCDSoH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 13:44:07 -0500
X-Greylist: delayed 1726 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 Mar 2019 13:44:06 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=scalemp.com
        ; s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
        Message-ID:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=mgZk5sUW457YGdjqHfSipY+wTqvY7YRe2DQUcfr8AlM=; b=ah33a+TWKaAmK3rH9snL7GjmMj
        HtzkVcv2RIhtqhjPIMY2hb0giDhW2RErZPEfvtkzXaHm00STA9GgZoMxVBVnbqUWo9B9tqKVaMnIL
        UXqFGuZ9RrLZqr9n8lWsjzkNliY811UH9oa3/yCvCm1Ia0QqTEa+SxFAb4ukI3/4IA7s=;
Received: from 109-186-230-3.bb.netvision.net.il ([109.186.230.3]:49184 helo=[192.168.2.7])
        by hosting.virtualsmp.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <oren@scalemp.com>)
        id 1h0s7T-000S6w-Cf; Mon, 04 Mar 2019 13:15:19 -0500
From:   Oren Twaig <oren@scalemp.com>
To:     suravee.suthikulpanit@amd.com
Cc:     kvm@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: re: [PATCH] svm: Fix AVIC incomplete IPI emulation
Message-ID: <d53d2240-d1f1-da04-9126-9eb3518d0047@scalemp.com>
Date:   Mon, 4 Mar 2019 20:15:17 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hosting.virtualsmp.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - scalemp.com
X-Get-Message-Sender-Via: hosting.virtualsmp.com: authenticated_id: oren@scalemp.com
X-Authenticated-Sender: hosting.virtualsmp.com: oren@scalemp.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Suravee,

According to AMD's SDM, the target-not-running incomplete
ipi exit is only received if any of the destination cpus had the

not-running bit set in the avic backing page. However, not

before the CPU _already_ set the relevant IRR bit in all these cpus.


In this change, the patch forces KVM to send another interrupt

to the vcpu whether SVM already did that or not. Which means

the vcpu/s, under some conditions, can get an EXTRA interrupt

it never intended to get.


Example:
   1. vcpu B: Is in "not-running" state.
   2. vcpu A: Writes to the ICR to send vector 80 to vcpu B
   3. vcpu A: SVM updates vcpu B IRR with bit 80
   4. vcpu A: SVM exits on incomplete IPI target-not-running exit.
   5. vcpu A: Now stops executing any code @ hypervisor level.
   6. vcpu B: Due to another interrupt (like lapic timer)
      resumes running the guest. While handling interrupts,
      it also handles interrupt vector 80 (as it's in his IRR)
   7. vcpu A: resumes executing the below code and sends
      an _additional_interrupt to vcpu B.

Overall, vcpu B got two interrupts. The second is unwanted and
not documented in the system architecture.

Can you please elaborate more to why the implementation

below conflict with the specifications (which was the code

before this commit) ?


Thanks,
Oren Twaig


 > From    "Suthikulpanit, Suravee" <>
 > Subject    [PATCH] svm: Fix AVIC incomplete IPI emulation
 > Date    Tue, 22 Jan 2019 10:25:13 +0000
 > share
 > From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
 >
 > In case of incomplete IPI with invalid interrupt type, the current
 > SVM driver does not properly emulate the IPI, and fails to boot
 > FreeBSD guests with multiple vcpus when enabling AVIC.
 >
 > Fix this by update APIC ICR high/low registers, which also
 > emulate sending the IPI.
 >
 > Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
 > ---
 > arch/x86/kvm/svm.c | 19 ++++---------------
 > 1 file changed, 4 insertions(+), 15 deletions(-)
 >
 > diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
 > index 2aff835a65ed..8a0c9a1f6ac8 100644
 > --- a/arch/x86/kvm/svm.c
 > +++ b/arch/x86/kvm/svm.c
 > @@ -4504,25 +4504,14 @@ static int 
avic_incomplete_ipi_interception(struct vcpu_svm *svm)
 >          kvm_lapic_reg_write(apic, APIC_ICR, icrl);
 >          break;
 >      case AVIC_IPI_FAILURE_TARGET_NOT_RUNNING: {
 > -        int i;
 > -        struct kvm_vcpu *vcpu;
 > -        struct kvm *kvm = svm->vcpu.kvm;
 >          struct kvm_lapic *apic = svm->vcpu.arch.apic;
 >
          /*
 > -         * At this point, we expect that the AVIC HW has already
 > -         * set the appropriate IRR bits on the valid target
 > -         * vcpus. So, we just need to kick the appropriate vcpu.
 > +         * Update ICR high and low, then emulate sending IPI,
 > +         * which is handled when writing APIC_ICR.
 >           */
 > -        kvm_for_each_vcpu(i, vcpu, kvm) {
 > -            bool m = kvm_apic_match_dest(vcpu, apic,
 > -                             icrl & KVM_APIC_SHORT_MASK,
 > - GET_APIC_DEST_FIELD(icrh),
 > -      icrl & KVM_APIC_DEST_MASK);
 > -
 > -            if (m && !avic_vcpu_is_running(vcpu))
 > - kvm_vcpu_wake_up(vcpu);
 > -        }
 > +        kvm_lapic_reg_write(apic, APIC_ICR2, icrh);
 > +        kvm_lapic_reg_write(apic, APIC_ICR, icrl);
 >          break;
 >      }
 >      case AVIC_IPI_FAILURE_INVALID_TARGET:
 > --
 > 2.17.1
