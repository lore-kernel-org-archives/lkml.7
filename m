Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811A6C04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5735F27F27
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LErR/q1C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbfFCJQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 05:16:01 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35000 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728757AbfFCJNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 05:13:07 -0400
Received: by mail-lj1-f194.google.com with SMTP id h11so15468192ljb.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 02:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p2w7Kl57iLHckjKus0ozI/d6mjFcbpIqopjV/HxyM1s=;
        b=LErR/q1Cw7oedcRjmOCVzqcAxs8gPx/T7/buH9Lwg8mSGR8eAtJ2kTcwFRHivjn5Ex
         kEjWaZ0dS19gIlRmtSTi0+74wxiQjf4cTAxf6mfbrFI1L/VVIf/lavH55pIQidTKt0LG
         2bOOWaw3tWlDzpGQXwdZjUkhHrTMpQohW7T04THJ1XaQ294z0vbUDDvwYtL4a72rZ7KG
         7x2a+G2Gwx/2N46KE1z6HifQw3qO52VIzGyZMI0hqpYVvdNJTb4Zob+fSBJTFrWEwMFa
         uMVDaQRSfaZWNnyGyJJqBArLdT7HZuOV1TPrk5K2dQgjo5cyiopk3TKCtcAeZbSyhF7P
         7NYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p2w7Kl57iLHckjKus0ozI/d6mjFcbpIqopjV/HxyM1s=;
        b=attQ9WyYMwZjSEEjMFYbts7xkxVQpd5Dh7NwyieoCpcTFsRbUxEgOW9l78sWziA/3b
         NSLB9CHl3ZTzvlAxoeRZxaE8GXY0fYu+aJyXpW2FxDbBZCNwqnl/EdHVzQiJ4Gyz9zsq
         ojeAcUIefMHO4relPdh55GKAqx1DGS+4NCdTeIUbEZmo1BYq9YxZzC6bBFfa/ud/Hyqz
         Rxs7gs5rqDt7GoPatUSesAsZqUZqpESRp2d0cEfXl9cp0WNX5wCRLo8zcGtL5AVbmbKG
         l9m45MuuSUy9qArwQy7v1iFd8tAlKP0BNGe0T8bMFfUJQ//WDEXcrhvQA6z0b1u3UJe3
         ytOA==
X-Gm-Message-State: APjAAAXbVdBMJLdd/B/TNQYuep8Udjhevtaqyqlbh5Z2sZ8BNKYIAwM9
        Mqboimb71OGRq70RzMRh13xutA==
X-Google-Smtp-Source: APXvYqzH+12IqYjeDa9Cf9SfS3k+UN9FSA/zr7tE4XHHnE6+zYlsVHzadgAxfalAVmWokf3dCikz8w==
X-Received: by 2002:a2e:5b94:: with SMTP id m20mr3452661lje.7.1559553185375;
        Mon, 03 Jun 2019 02:13:05 -0700 (PDT)
Received: from localhost (c-1c3670d5.07-21-73746f28.bbcust.telenor.se. [213.112.54.28])
        by smtp.gmail.com with ESMTPSA id v2sm3030127lfi.52.2019.06.03.02.13.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 02:13:04 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     mark.rutland@arm.com, marc.zyngier@arm.com,
        daniel.lezcano@linaro.org, tglx@linutronix.de
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH 1/3] clocksource/arm_arch_timer: mark arch_counter_get_* as notrace
Date:   Mon,  3 Jun 2019 11:12:56 +0200
Message-Id: <20190603091256.25012-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_FUNCTION_GRAPH_TRACER is enabled we end up in this circular
call trace since function arch_counter_get_cntvct() isn't marked with no
trace:

[   17.914934] Call trace:
[   17.915211]  ftrace_return_to_handler+0x194/0x288
[   17.915551]  return_to_handler+0x1c/0x38
[   17.915855]  trace_clock_local+0x38/0x88
[   17.916159]  function_graph_enter+0xf0/0x258
[   17.916465]  prepare_ftrace_return+0x60/0x90
[   17.916772]  ftrace_graph_caller+0x1c/0x24
[   17.917093]  arch_counter_get_cntvct+0x10/0x30
[   17.917417]  sched_clock+0x70/0x218
[   17.917723]  trace_clock_local+0x38/0x88
[   17.918026]  function_graph_enter+0xf0/0x258
[   17.918332]  prepare_ftrace_return+0x60/0x90
[   17.918649]  ftrace_graph_caller+0x1c/0x24
[   17.918963]  arch_counter_get_cntvct+0x10/0x30
[   17.919286]  sched_clock+0x70/0x218

Rework so that function arch_counter_get_cntvct() is marked with notrace.

Fixes: 0ea415390cd3 ("clocksource/arm_arch_timer: Use arch_timer_read_counter to access stable counters")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/clocksource/arm_arch_timer.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index b2a951a798e2..f4d5bd8fe906 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -149,22 +149,22 @@ u32 arch_timer_reg_read(int access, enum arch_timer_reg reg,
 	return val;
 }
 
-static u64 arch_counter_get_cntpct_stable(void)
+static u64 notrace arch_counter_get_cntpct_stable(void)
 {
 	return __arch_counter_get_cntpct_stable();
 }
 
-static u64 arch_counter_get_cntpct(void)
+static u64 notrace arch_counter_get_cntpct(void)
 {
 	return __arch_counter_get_cntpct();
 }
 
-static u64 arch_counter_get_cntvct_stable(void)
+static u64 notrace arch_counter_get_cntvct_stable(void)
 {
 	return __arch_counter_get_cntvct_stable();
 }
 
-static u64 arch_counter_get_cntvct(void)
+static u64 notrace arch_counter_get_cntvct(void)
 {
 	return __arch_counter_get_cntvct();
 }
@@ -947,7 +947,7 @@ bool arch_timer_evtstrm_available(void)
 	return cpumask_test_cpu(raw_smp_processor_id(), &evtstrm_available);
 }
 
-static u64 arch_counter_get_cntvct_mem(void)
+static u64 notrace arch_counter_get_cntvct_mem(void)
 {
 	u32 vct_lo, vct_hi, tmp_hi;
 
-- 
2.20.1

