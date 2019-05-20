Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1218FC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3909216FD
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558355139;
	bh=AKbEKwcOJ3m1dz7P1Ldurh2Qf2+9jI6jVxDWugo79ek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SK37+31fM2SsjsPrzyBwt1pJD8tEhaZ02popLYAUmxM2fn4U+X0C3m85YsIR8LtgU
	 POX+gz+w1KAqkD292l8dXXyCFMAPGLlQkFce+4T+RQTXvM4f5Mk3ZTD/I5MLUKvY5x
	 6SyE6zRxDyPVXjQcSyVPAq4OEZ+y/KNGPm/Jp5JQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389126AbfETMZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 08:25:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:40758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389115AbfETMZg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 08:25:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7841A20675;
        Mon, 20 May 2019 12:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558355136;
        bh=AKbEKwcOJ3m1dz7P1Ldurh2Qf2+9jI6jVxDWugo79ek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lk/D5ORTVajCEGWEtwxPGrq8UtqBs5ITseb/hcjIpGbVY9tWiae8ndwodBfpGoznR
         /4fnpLyBYzT4/l6eJ5h1NLCF/KYZGAuirriI1TNujcuAQLUGBQVm4b2k5GGeE6WsBF
         gdylh6PXv7m7Z3hrJxdtUt/V8+fPy4YHmqXzS8X8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wanpeng Li <wanpengli@tencent.com>,
        Liran Alon <liran.alon@oracle.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.19 094/105] KVM: lapic: Busy wait for timer to expire when using hv_timer
Date:   Mon, 20 May 2019 14:14:40 +0200
Message-Id: <20190520115253.743557788@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520115247.060821231@linuxfoundation.org>
References: <20190520115247.060821231@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

commit ee66e453db13d4837a0dcf9d43efa7a88603161b upstream.

...now that VMX's preemption timer, i.e. the hv_timer, also adjusts its
programmed time based on lapic_timer_advance_ns.  Without the delay, a
guest can see a timer interrupt arrive before the requested time when
KVM is using the hv_timer to emulate the guest's interrupt.

Fixes: c5ce8235cffa0 ("KVM: VMX: Optimize tscdeadline timer latency")
Cc: <stable@vger.kernel.org>
Cc: Wanpeng Li <wanpengli@tencent.com>
Reviewed-by: Liran Alon <liran.alon@oracle.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/lapic.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -1449,7 +1449,7 @@ static void apic_timer_expired(struct kv
 	if (swait_active(q))
 		swake_up_one(q);
 
-	if (apic_lvtt_tscdeadline(apic))
+	if (apic_lvtt_tscdeadline(apic) || ktimer->hv_timer_in_use)
 		ktimer->expired_tscdeadline = ktimer->tscdeadline;
 }
 


