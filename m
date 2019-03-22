Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C2BC10F03
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B4932054F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257358;
	bh=DPznJgemzeVkxeeFLwwBKz7+zIos2vbJFKx9ohJjI4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pESrSj22KTyLXkTEbNTCSDdx97bH7RouMZtSw/A9hTvU2uaCKD1YsZtq+En3K1cSO
	 y7DSazns4LpCNvsfkqj0SLa8gPs1W0VOge0ZPMl9OtBd/oP1PlTQXPOpBQWCgXrjQ3
	 83eBmu1sBBKPmZYJ04VptFene2pSjjvOfpf+VCPs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391023AbfCVMWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:22:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:33700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390662AbfCVMWd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:22:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0252A218A1;
        Fri, 22 Mar 2019 12:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257352;
        bh=DPznJgemzeVkxeeFLwwBKz7+zIos2vbJFKx9ohJjI4A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pwShzJtcvJFwzAE2lAiUASFEG08vbydYfvOorNMAtAao1wtiaIOk8tiEGQsZot9qk
         HfcLlHQNRUWky7CW/BV65QRchQxx9HtD6am0VS/VRAoVtfaghunGPFlIa3Hgh6nR9J
         T8n7Y3JdQMhDAW0sk5mKqkzbROIMNm3YVWDN4WtA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Dominique Martinet <asmadeus@codewreck.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5.0 207/238] x86/kvmclock: set offset for kvm unstable clock
Date:   Fri, 22 Mar 2019 12:17:06 +0100
Message-Id: <20190322111310.446706040@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pavel Tatashin <pasha.tatashin@soleen.com>

commit b5179ec4187251a751832193693d6e474d3445ac upstream.

VMs may show incorrect uptime and dmesg printk offsets on hypervisors with
unstable clock. The problem is produced when VM is rebooted without exiting
from qemu.

The fix is to calculate clock offset not only for stable clock but for
unstable clock as well, and use kvm_sched_clock_read() which substracts
the offset for both clocks.

This is safe, because pvclock_clocksource_read() does the right thing and
makes sure that clock always goes forward, so once offset is calculated
with unstable clock, we won't get new reads that are smaller than offset,
and thus won't get negative results.

Thank you Jon DeVree for helping to reproduce this issue.

Fixes: 857baa87b642 ("sched/clock: Enable sched clock early")
Cc: stable@vger.kernel.org
Reported-by: Dominique Martinet <asmadeus@codewreck.org>
Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/kvmclock.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -104,12 +104,8 @@ static u64 kvm_sched_clock_read(void)
 
 static inline void kvm_sched_clock_init(bool stable)
 {
-	if (!stable) {
-		pv_ops.time.sched_clock = kvm_clock_read;
+	if (!stable)
 		clear_sched_clock_stable();
-		return;
-	}
-
 	kvm_sched_clock_offset = kvm_clock_read();
 	pv_ops.time.sched_clock = kvm_sched_clock_read;
 


