Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56D9C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 18:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9840320675
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 18:32:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BR7x3x90"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbfEBSct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 14:32:49 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35379 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfEBSct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 14:32:49 -0400
Received: by mail-pf1-f193.google.com with SMTP id t87so965017pfa.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 11:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=93c55uhr4KFGF95BkRemJ3knn+tMaubaMhwZFRLRXyQ=;
        b=BR7x3x90tpA0KZFNAitTfhjS1qplr4LpXzdvRCOHwFsakQ7p4g8+DisaRgPLRBmfHR
         2HI5DZW4Nr/seQW7j67Z5l68jgNwhu2J7r6yvkHLwJ5YZgFhHALh/ow4VRZeC7LwQFxk
         HMN6deHYkyLeVgyRQ3kOHnTXVYWdh3p3Pq6vY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=93c55uhr4KFGF95BkRemJ3knn+tMaubaMhwZFRLRXyQ=;
        b=D6onT4gSmDCMtKizjmSLAwD18NTOtTgOcLtkPm5YITVrG3wG0LZ0ep65KwR1iEgpjK
         UccKW9IpZMGGT2tlO1WkZWRviMSh74Z5KngIU+/SFHciOm1S1dDOOeVnM79OjHlqvoUS
         HIUg1m/AcnWHBp4U20pGa2s8uedGF/Z2YzGsA3eFAYPvrs9vlEWbwnKr8XGFw6iaMkAt
         mZwGnuPPzquqncjBTiGT33ZIFoZduuTmNQAmDGpdf/okeK8KDzjwy99DTZZ26EcWkcVq
         Wp2ezdk1y/CIPyN7zFeOqw2OtflYbCkJ8U7BXMLQ0m04iUxlca5fLNlw9nW8d2d7V4vP
         EXmQ==
X-Gm-Message-State: APjAAAXH8F0YNbyLgaeDzbTS0WvQ9pq5gSDm0W0D+ItaWHMOmuQHOTrW
        zL8Qjc5YCgnN2KzzQ4Xc/WUV9A==
X-Google-Smtp-Source: APXvYqzOG3Iud4yqTJfLgrP/J9PSYnjxJFAsqN3VfssLJ4G8hndLNeozzfAGi1vq6o1D6P6OQGv/qA==
X-Received: by 2002:a63:c64c:: with SMTP id x12mr5476408pgg.379.1556821968507;
        Thu, 02 May 2019 11:32:48 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id k12sm14531027pfk.86.2019.05.02.11.32.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 11:32:47 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] thermal: cpu_cooling: Actually trace CPU load in thermal_power_cpu_get_power
Date:   Thu,  2 May 2019 11:32:38 -0700
Message-Id: <20190502183238.182058-1-mka@chromium.org>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CPU load values passed to the thermal_power_cpu_get_power
tracepoint are zero for all CPUs, unless, unless the
thermal_power_cpu_limit tracepoint is enabled too:

  irq/41-rockchip-98    [000] ....   290.972410: thermal_power_cpu_get_power:
  cpus=0000000f freq=1800000 load={{0x0,0x0,0x0,0x0}} dynamic_power=4815

vs

  irq/41-rockchip-96    [000] ....    95.773585: thermal_power_cpu_get_power:
  cpus=0000000f freq=1800000 load={{0x56,0x64,0x64,0x5e}} dynamic_power=4959
  irq/41-rockchip-96    [000] ....    95.773596: thermal_power_cpu_limit:
  cpus=0000000f freq=408000 cdev_state=10 power=416

There seems to be no good reason for omitting the CPU load information
depending on another tracepoint. My guess is that the intention was to
check whether thermal_power_cpu_get_power is (still) enabled, however
'load_cpu != NULL' already indicates that it was at least enabled when
cpufreq_get_requested_power() was entered, there seems little gain
from omitting the assignment if the tracepoint was just disabled, so
just remove the check.

Fixes: 6828a4711f99 ("thermal: add trace events to the power allocator governor")
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/thermal/cpu_cooling.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index f7c1f49ec87f..b437804e099b 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -458,7 +458,7 @@ static int cpufreq_get_requested_power(struct thermal_cooling_device *cdev,
 			load = 0;
 
 		total_load += load;
-		if (trace_thermal_power_cpu_limit_enabled() && load_cpu)
+		if (load_cpu)
 			load_cpu[i] = load;
 
 		i++;
-- 
2.21.0.593.g511ec345e18-goog

