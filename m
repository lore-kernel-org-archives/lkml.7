Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530FDC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19D2A2064A
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553908018;
	bh=Cnm2drekI2UIFzyTYy+xxttYtGtC17ggs2OhgNG5AyM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sPh8UdekEhn1zwxZqc0cWsGTD+GEUkuwVcTDxuqFoGTYrCZ2apulO9rBbvQk2rAxa
	 Qic9P4KOwsZ26HV4qB61zefatp0jDgf6cn3tREpqwqgPxBzsu5NGl+EQV6aJV9kP5d
	 6+7pCE2JeP5PqTsSjbFinfEJOabnzunLKUek6rYc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731596AbfC3BG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 21:06:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:60336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731276AbfC3Ax3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 20:53:29 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7665218AC;
        Sat, 30 Mar 2019 00:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553907208;
        bh=Cnm2drekI2UIFzyTYy+xxttYtGtC17ggs2OhgNG5AyM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CxgT/6T4/rqyxON1HfAeY10WPoROB54sLdoPJkuWokDEsh3PUchEvK6PKw4t62a7+
         lSGLaLVxMWsecaaXvupIyR/Mvf2nJRSjMciQb0V3Qp/1NF7YxrK1098bwTY8/I24eC
         zLHhnb10q+q/MWF2y6wHZjMSB4T/QbfL4VUHeMNU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 17/52] thermal/intel_powerclamp: fix __percpu declaration of worker_data
Date:   Fri, 29 Mar 2019 20:52:24 -0400
Message-Id: <20190330005301.26868-17-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330005301.26868-1-sashal@kernel.org>
References: <20190330005301.26868-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

[ Upstream commit aa36e3616532f82a920b5ebf4e059fbafae63d88 ]

This variable is declared as:
	static struct powerclamp_worker_data * __percpu worker_data;
In other words, a percpu pointer to struct ...

But this variable not used like so but as a pointer to a percpu
struct powerclamp_worker_data.

So fix the declaration as:
	static struct powerclamp_worker_data __percpu *worker_data;

This also quiets Sparse's warnings from __verify_pcpu_ptr(), like:
  494:49: warning: incorrect type in initializer (different address spaces)
  494:49:    expected void const [noderef] <asn:3> *__vpp_verify
  494:49:    got struct powerclamp_worker_data *

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/intel_powerclamp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/intel_powerclamp.c b/drivers/thermal/intel_powerclamp.c
index cde891c54cde..ea1aa7dbe42c 100644
--- a/drivers/thermal/intel_powerclamp.c
+++ b/drivers/thermal/intel_powerclamp.c
@@ -101,7 +101,7 @@ struct powerclamp_worker_data {
 	bool clamping;
 };
 
-static struct powerclamp_worker_data * __percpu worker_data;
+static struct powerclamp_worker_data __percpu *worker_data;
 static struct thermal_cooling_device *cooling_dev;
 static unsigned long *cpu_clamping_mask;  /* bit map for tracking per cpu
 					   * clamping kthread worker
-- 
2.19.1

