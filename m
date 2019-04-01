Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6E7C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D9D121939
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138506;
	bh=Q9z6vPI0tP0u4ZBPtR8Q0zwE2ZQ2fjstHnyVknfUc6I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h7F4UbMVha8UCZSKbidltWmVgKC6yUbctmYKVySKomZHtwAuKBhOglLMmKpdOThtR
	 SCYk+H9C/vu51nmVshsmaoqNV72DtWiDZxrJIvfJf52JDaPtiFHupqaQo1z1w2R0b+
	 hF2Ls33r5HuiEF6RznilxqhK6iD7zaPuQqd6vPyI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729242AbfDARIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:08:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:54882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729613AbfDARIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:08:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 194CF21929;
        Mon,  1 Apr 2019 17:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138500;
        bh=Q9z6vPI0tP0u4ZBPtR8Q0zwE2ZQ2fjstHnyVknfUc6I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uWW+V8reu8BfwSDU7L9p1TAKjmh608aYnoOIsn7y0hAd4mMWNVYx2RpbiVj+UNgOG
         MtjMPMoHwhMkAbnpPWOM/lQOduZKaCA4niBg5VNCPr16k7bVV9ZS5ijFPVfKVevlvY
         M0qnxidyM8SNUUi1ZmCDbHahs+oy3tEehLtfboBw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kohji Okuno <okuno.kohji@jp.panasonic.com>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 5.0 047/146] ARM: imx6q: cpuidle: fix bug that CPU might not wake up at expected time
Date:   Mon,  1 Apr 2019 19:00:59 +0200
Message-Id: <20190401170052.555886143@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170048.449559024@linuxfoundation.org>
References: <20190401170048.449559024@linuxfoundation.org>
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

From: Kohji Okuno <okuno.kohji@jp.panasonic.com>

commit 91740fc8242b4f260cfa4d4536d8551804777fae upstream.

In the current cpuidle implementation for i.MX6q, the CPU that sets
'WAIT_UNCLOCKED' and the CPU that returns to 'WAIT_CLOCKED' are always
the same. While the CPU that sets 'WAIT_UNCLOCKED' is in IDLE state of
"WAIT", if the other CPU wakes up and enters IDLE state of "WFI"
istead of "WAIT", this CPU can not wake up at expired time.
 Because, in the case of "WFI", the CPU must be waked up by the local
timer interrupt. But, while 'WAIT_UNCLOCKED' is set, the local timer
is stopped, when all CPUs execute "wfi" instruction. As a result, the
local timer interrupt is not fired.
 In this situation, this CPU will wake up by IRQ different from local
timer. (e.g. broacast timer)

So, this fix changes CPU to return to 'WAIT_CLOCKED'.

Signed-off-by: Kohji Okuno <okuno.kohji@jp.panasonic.com>
Fixes: e5f9dec8ff5f ("ARM: imx6q: support WAIT mode using cpuidle")
Cc: <stable@vger.kernel.org>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/mach-imx/cpuidle-imx6q.c |   27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

--- a/arch/arm/mach-imx/cpuidle-imx6q.c
+++ b/arch/arm/mach-imx/cpuidle-imx6q.c
@@ -16,30 +16,23 @@
 #include "cpuidle.h"
 #include "hardware.h"
 
-static atomic_t master = ATOMIC_INIT(0);
-static DEFINE_SPINLOCK(master_lock);
+static int num_idle_cpus = 0;
+static DEFINE_SPINLOCK(cpuidle_lock);
 
 static int imx6q_enter_wait(struct cpuidle_device *dev,
 			    struct cpuidle_driver *drv, int index)
 {
-	if (atomic_inc_return(&master) == num_online_cpus()) {
-		/*
-		 * With this lock, we prevent other cpu to exit and enter
-		 * this function again and become the master.
-		 */
-		if (!spin_trylock(&master_lock))
-			goto idle;
+	spin_lock(&cpuidle_lock);
+	if (++num_idle_cpus == num_online_cpus())
 		imx6_set_lpm(WAIT_UNCLOCKED);
-		cpu_do_idle();
-		imx6_set_lpm(WAIT_CLOCKED);
-		spin_unlock(&master_lock);
-		goto done;
-	}
+	spin_unlock(&cpuidle_lock);
 
-idle:
 	cpu_do_idle();
-done:
-	atomic_dec(&master);
+
+	spin_lock(&cpuidle_lock);
+	if (num_idle_cpus-- == num_online_cpus())
+		imx6_set_lpm(WAIT_CLOCKED);
+	spin_unlock(&cpuidle_lock);
 
 	return index;
 }


