Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C3CC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 929AD2145D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561370782;
	bh=B9GUuf1SLyExYTmkrwyLfOKmn2kWX9csUu3/dVUz+gc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TZfs2b1ED3bg2GWDGS9yEKNzhpER2+luXotIddhrx30mRoAOBKSdAG/AZEPywxLeU
	 ef5/TYbFaBQmKKju8z2+nNFS7d/UkuJCkysnwbBCd13BmW1MtnzpU8QgQuI0j740hO
	 /4VnlJx19Vl7SAfXnh8QgO0kV2oH34P8xO8UvFNM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730075AbfFXKGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 06:06:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:38406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730065AbfFXKGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 06:06:17 -0400
Received: from localhost (f4.8f.5177.ip4.static.sl-reverse.com [119.81.143.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EEE8208E3;
        Mon, 24 Jun 2019 10:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561370776;
        bh=B9GUuf1SLyExYTmkrwyLfOKmn2kWX9csUu3/dVUz+gc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TtyiRAgqhf+mxWnwxTQvpe9C0Bqb8dM1XVbd5kqULRwarpUQw79dqsCPtGlqZ6RUZ
         VjfkmVm4Iy3VK71+3ZPROdsbiL4HIogk3gOZ2bw28iC/EPwa6YCGGOu49VpVHGpdu9
         mRxwHTItSWIdTpkGmOFYrISFMilRVb9lJOfxZZUk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Young Xiao <92siuyang@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 52/90] sparc: perf: fix updated event period in response to PERF_EVENT_IOC_PERIOD
Date:   Mon, 24 Jun 2019 17:56:42 +0800
Message-Id: <20190624092317.591627603@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190624092313.788773607@linuxfoundation.org>
References: <20190624092313.788773607@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 67b3e6b3ce5d..1ad5911f62b4 100644
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



