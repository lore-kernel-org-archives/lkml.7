Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B3DC04AB6
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 02:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDAA921019
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 02:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u5iwkDqn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfE2CUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 22:20:42 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33193 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfE2CUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 22:20:42 -0400
Received: by mail-pf1-f193.google.com with SMTP id z28so564897pfk.0;
        Tue, 28 May 2019 19:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2Yv4K1hvNpR1+8DJIElCyNMLM6mZWuYhgbyhs82Pwy0=;
        b=u5iwkDqn/7K1GBHkfYzQ6ohCsd80jlRZIQL7NT5PE3xEOQsIS3czAim4X1myyKuVYB
         icmZlTZGffyuWWfEQlLOB36V3jCiO3Ha3iPRWFQSHli1ONp5HT65vHEaNNMYUd/qMF/L
         bKNGxM7iBNcqevO415eDA8rAFrLxdmeoEaFJwYs3OtZnIYsNuxQtFESUsqFvWrUOI3pS
         VIw9nBbg74YcE8NSTNJgN7QpX0gzxQCW48gU1A83TsuWr9vrP3lISPf9tF+ivk7EGQgz
         CH5rBYq8i4bNotc+9dHGcfRvslh64Az2F+v6HThaI8Y7I6VvxBDwCZCvUbqpPd7t15nd
         6Khg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2Yv4K1hvNpR1+8DJIElCyNMLM6mZWuYhgbyhs82Pwy0=;
        b=gUdxyG+l+nGU9NABioWsr3V2vbRmdX05QUAwYMFPhTOFOUtqNE9zgoyHrv4Ly7ypDp
         eD2dZ0uznfJKKlrQsTC/wUWkcQUZStuSbKVoLCq9Tf/jKBbddX3lP3EeajEqgeQOAgy6
         oMGQIaeYPpTijfs87jpvHwGjQO1k4cyj4tsLSItNy2NrpPDIXFSXfDcsmlXRAUHYhPJI
         fhPKE5EVzQxOztnX8xrH/hMCSIlWyX/L7gGUMd54NFbgVOjhn8gCctDisxXvdqBwYp27
         DZCxoIkB7ycLpiEYuFX6eOcxu0e1n0PPF6/Q/Qn4M188Wz70II3IFT6pbBfit5j/lTdD
         DxuQ==
X-Gm-Message-State: APjAAAWQaSpYmfctt7aYWwct480FVzhr1FDe1gKPqH3Xb24rwwvl0kNP
        PqxVgSkFHt1ek9XrGS0z1RI=
X-Google-Smtp-Source: APXvYqxNIh7asWkaREFXSQyA9gzgUpdhqaCuM1hUeTel87H1TZ9MSDm+yPKtXf3g1oCTKcJPLTwlyA==
X-Received: by 2002:a17:90a:718c:: with SMTP id i12mr9515577pjk.32.1559096441748;
        Tue, 28 May 2019 19:20:41 -0700 (PDT)
Received: from xy-data.openstacklocal (ecs-159-138-22-150.compute.hwclouds-dns.com. [159.138.22.150])
        by smtp.gmail.com with ESMTPSA id d6sm3623820pjo.32.2019.05.28.19.20.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 May 2019 19:20:41 -0700 (PDT)
From:   Young Xiao <92siuyang@gmail.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Cc:     Young Xiao <92siuyang@gmail.com>
Subject: [PATCH] sparc: perf: fix updated event period in response to PERF_EVENT_IOC_PERIOD
Date:   Wed, 29 May 2019 10:21:48 +0800
Message-Id: <1559096508-25847-1-git-send-email-92siuyang@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PERF_EVENT_IOC_PERIOD ioctl command can be used to change the
sample period of a running perf_event. Consequently, when calculating
the next event period, the new period will only be considered after the
previous one has overflowed.

This patch changes the calculation of the remaining event ticks so that
they are offset if the period has changed.

See commit 3581fe0ef37c ("ARM: 7556/1: perf: fix updated event period in
response to PERF_EVENT_IOC_PERIOD") for details.

Signed-off-by: Young Xiao <92siuyang@gmail.com>
---
 arch/sparc/kernel/perf_event.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/sparc/kernel/perf_event.c b/arch/sparc/kernel/perf_event.c
index 6de7c68..a58ae9c 100644
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
2.7.4

