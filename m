Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE414C10F05
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE20F21852
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139125;
	bh=Ke8jW1ZlHA9oZ0Ee6iTxgd+6xftHt32sI5lq0CU2q/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yGaX7ojQ0m2Bjm1t2YYGkznDdMoRw5QbZrXpyAv6nqqSuE+YbJhANSotpZz9EBBDv
	 krhHBPUZFTtPOPiIQQtx9aqtsRPj2XhqrWHRQ9rTKI7TvhuOkKnzLadMtbcGqcYZYF
	 NJNLNmlbD6g9Ucg1ol60/T27Q83oVVf/cY45P7z0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731413AbfDARSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:18:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:46134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728594AbfDARSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:18:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F33E218FF;
        Mon,  1 Apr 2019 17:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139120;
        bh=Ke8jW1ZlHA9oZ0Ee6iTxgd+6xftHt32sI5lq0CU2q/A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=heWD6KHsXixO4YdyJRVd/gvPR4zyQ18iB1xzNVSfgIM5swTafDIalo87rvuW6hotK
         SEHvIuVAYryAG7KBVD2QCwe6XdjCvPpdEUI+ooj/xppKjLcO0G7uQvn7Q4hpQUZ4F9
         +abWwvJXAc5X6aQ/qf85KOVL6778fBLWSMCF0EeE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Maxime Coquelin <maxime.coquelin@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Don Zickus <dzickus@redhat.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: [PATCH 4.19 120/134] watchdog: Respect watchdog cpumask on CPU hotplug
Date:   Mon,  1 Apr 2019 19:02:36 +0200
Message-Id: <20190401170055.561424856@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170044.243719205@linuxfoundation.org>
References: <20190401170044.243719205@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit 7dd47617114921fdd8c095509e5e7b4373cc44a1 upstream.

The rework of the watchdog core to use cpu_stop_work broke the watchdog
cpumask on CPU hotplug.

The watchdog_enable/disable() functions are now called unconditionally from
the hotplug callback, i.e. even on CPUs which are not in the watchdog
cpumask. As a consequence the watchdog can become unstoppable.

Only invoke them when the plugged CPU is in the watchdog cpumask.

Fixes: 9cf57731b63e ("watchdog/softlockup: Replace "watchdog/%u" threads with cpu_stop_work")
Reported-by: Maxime Coquelin <maxime.coquelin@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Don Zickus <dzickus@redhat.com>
Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/alpine.DEB.2.21.1903262245490.1789@nanos.tec.linutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/watchdog.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -547,13 +547,15 @@ static void softlockup_start_all(void)
 
 int lockup_detector_online_cpu(unsigned int cpu)
 {
-	watchdog_enable(cpu);
+	if (cpumask_test_cpu(cpu, &watchdog_allowed_mask))
+		watchdog_enable(cpu);
 	return 0;
 }
 
 int lockup_detector_offline_cpu(unsigned int cpu)
 {
-	watchdog_disable(cpu);
+	if (cpumask_test_cpu(cpu, &watchdog_allowed_mask))
+		watchdog_disable(cpu);
 	return 0;
 }
 


