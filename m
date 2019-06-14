Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46438C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 20:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 099A92184D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 20:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560544237;
	bh=OG2a7VMG5z5jIVJknxckUrEivgArjIq1V+A3jrVfaTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vIAbonyoX9uI06IJsWLbrIMJRTmdt/d7gANgHDKOHGl81WuCrRc609mRKTIie98ws
	 o48tspZEzKBfm13vkHj17x+YUClp1y/aXs990JJon9a/k8y64vfqp7E+qx9Ssy7JJa
	 30QY/r08Co1TdMcBdr2CwPwSne+ooV0prz/Xl9RU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbfFNUaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 16:30:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:53532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727708AbfFNUac (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 16:30:32 -0400
Received: from sasha-vm.mshome.net (unknown [131.107.159.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2AA421851;
        Fri, 14 Jun 2019 20:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560544232;
        bh=OG2a7VMG5z5jIVJknxckUrEivgArjIq1V+A3jrVfaTY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tTy0DqFuTxEDE4iTx3s3hZnXXou0l8cQnJzhAqqcDci8yp/OloNGKP4UQTzF5JxTs
         woy8ESeQy3yUzPTuh0qErC2TaNg88pc1pMXH4RED2akvVZL8JqhxLkqbB0Ily7XVk6
         u5mhNNNLOSBoCXZpL38cK0o9ZESgQrHmOtrI+LbQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Young Xiao <92siuyang@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, sparclinux@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 15/27] sparc: perf: fix updated event period in response to PERF_EVENT_IOC_PERIOD
Date:   Fri, 14 Jun 2019 16:30:04 -0400
Message-Id: <20190614203018.27686-15-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190614203018.27686-1-sashal@kernel.org>
References: <20190614203018.27686-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Young Xiao <92siuyang@gmail.com>

[ Upstream commit 56cd0aefa475079e9613085b14a0f05037518fed ]

The PERF_EVENT_IOC_PERIOD ioctl command can be used to change the
sample period of a running perf_event. Consequently, when calculating
the next event period, the new period will only be considered after the
previous one has overflowed.

This patch changes the calculation of the remaining event ticks so that
they are offset if the period has changed.

See commit 3581fe0ef37c ("ARM: 7556/1: perf: fix updated event period in
response to PERF_EVENT_IOC_PERIOD") for details.

Signed-off-by: Young Xiao <92siuyang@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/sparc/kernel/perf_event.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/sparc/kernel/perf_event.c b/arch/sparc/kernel/perf_event.c
index eceb0215bdee..58ea64a29d5f 100644
--- a/arch/sparc/kernel/perf_event.c
+++ b/arch/sparc/kernel/perf_event.c
@@ -891,6 +891,10 @@ static int sparc_perf_event_set_period(struct perf_event *event,
 	s64 period = hwc->sample_period;
 	int ret = 0;
 
+	/* The period may have been changed by PERF_EVENT_IOC_PERIOD */
+	if (unlikely(period != hwc->last_period))
+		left = period - (hwc->last_period - left);
+
 	if (unlikely(left <= -period)) {
 		left = period;
 		local64_set(&hwc->period_left, left);
-- 
2.20.1

