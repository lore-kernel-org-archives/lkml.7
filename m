Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2440AC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2F5F21D80
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570696868;
	bh=2HvateZSYWcAz2uKEoIRos3EHzRl5YVxC6aMRhzY4jE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Zd+ORhatH6TJSGpv9lTQkQHGQq8QfBhuTnObngVn/dwwCVTrQdmo0cPSflYrAcVbO
	 mxQ2EFIvoH7m24S2eEEeu58xJMIrK2YmmfNJCPwuzeaYWcf2+KrPNoG5CDbND0Lc/c
	 yfBEdnGwU1FbCy/PMA2Uno8Y9u9EdrtDiwSo6eNY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388258AbfJJIlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 04:41:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:45308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388242AbfJJIlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 04:41:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F3542054F;
        Thu, 10 Oct 2019 08:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570696862;
        bh=2HvateZSYWcAz2uKEoIRos3EHzRl5YVxC6aMRhzY4jE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=voJ//uUfiEr+eN/J8oym23rzI5RUjG/PzTycM48AY4SwNywJmExpI+g2Yq0Vfg+UA
         6vi+V7Cb90BHunKE5C4eUKwfyVxrawDjtoisU/vukY5drHA0jxeI9XxWv0YF/zWSKR
         1KiBARrIRIZLMVyyVa9zJ7gpihn9yKqdedT/4Syc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, loobinliu@tencent.com,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>
Subject: [PATCH 5.3 078/148] Revert "locking/pvqspinlock: Dont wait if vCPU is preempted"
Date:   Thu, 10 Oct 2019 10:35:39 +0200
Message-Id: <20191010083616.068230431@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191010083609.660878383@linuxfoundation.org>
References: <20191010083609.660878383@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wanpeng Li <wanpengli@tencent.com>

commit 89340d0935c9296c7b8222b6eab30e67cb57ab82 upstream.

This patch reverts commit 75437bb304b20 (locking/pvqspinlock: Don't
wait if vCPU is preempted).  A large performance regression was caused
by this commit.  on over-subscription scenarios.

The test was run on a Xeon Skylake box, 2 sockets, 40 cores, 80 threads,
with three VMs of 80 vCPUs each.  The score of ebizzy -M is reduced from
13000-14000 records/s to 1700-1800 records/s:

          Host                Guest                score

vanilla w/o kvm optimizations     upstream    1700-1800 records/s
vanilla w/o kvm optimizations     revert      13000-14000 records/s
vanilla w/ kvm optimizations      upstream    4500-5000 records/s
vanilla w/ kvm optimizations      revert      14000-15500 records/s

Exit from aggressive wait-early mechanism can result in premature yield
and extra scheduling latency.

Actually, only 6% of wait_early events are caused by vcpu_is_preempted()
being true.  However, when one vCPU voluntarily releases its vCPU, all
the subsequently waiters in the queue will do the same and the cascading
effect leads to bad performance.

kvm optimizations:
[1] commit d73eb57b80b (KVM: Boost vCPUs that are delivering interrupts)
[2] commit 266e85a5ec9 (KVM: X86: Boost queue head vCPU to mitigate lock waiter preemption)

Tested-by: loobinliu@tencent.com
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: loobinliu@tencent.com
Cc: stable@vger.kernel.org
Fixes: 75437bb304b20 (locking/pvqspinlock: Don't wait if vCPU is preempted)
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/locking/qspinlock_paravirt.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/locking/qspinlock_paravirt.h
+++ b/kernel/locking/qspinlock_paravirt.h
@@ -269,7 +269,7 @@ pv_wait_early(struct pv_node *prev, int
 	if ((loop & PV_PREV_CHECK_MASK) != 0)
 		return false;
 
-	return READ_ONCE(prev->state) != vcpu_running || vcpu_is_preempted(prev->cpu);
+	return READ_ONCE(prev->state) != vcpu_running;
 }
 
 /*


