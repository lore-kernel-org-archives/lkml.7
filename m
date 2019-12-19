Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A509C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 22:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F048D24676
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 22:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UELwUgkI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbfLSWTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 17:19:54 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34159 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbfLSWTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 17:19:51 -0500
Received: by mail-wr1-f68.google.com with SMTP id t2so7565592wrr.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 14:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xIw0nWMVvmMwb4Q12xq9FnKNnehOct3euxpTG4ta6kw=;
        b=UELwUgkIqMLM8KbzghW/nxo2zlVq5P1wRHZQUzemcp1Mo4En6J69er+/z19UrnXzq7
         4HWSjAk+mRtSYwkLpV0E70UgihbarSN4mbe41sDDk/fTL33TfqmA44/eiUmYo4Werjy2
         Z1NmTMYj1xIYm1jjYDhBQ2bjLvrH42FibRjvlf7t5WV5ZxJYLRs3uDjkNtVKqyVsPozN
         r91Aht9GVlVNOPAPNvxZTCeLr0vtxmeHo9ROBM2yXck7D7JMjjyH6T9hfg2E2NDELFT+
         HpB9sxM+GD5/Arv6Y63UTZ4J6zEZ1BXoI6+M79zEvpj7O0THPCzg4N97UOuxdqx4bSks
         jnOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xIw0nWMVvmMwb4Q12xq9FnKNnehOct3euxpTG4ta6kw=;
        b=ocap/CY00h7zw6mv3NQ/xTZ+2j5ma/tMBSEKKbLHqFIMOwC4TXn7nkrOpaLc5f3olW
         1IDyuPbTFhzCD2YliFbeNgiV74ZEmGQgCuYE7RO2zI1AMQaEGAZYULsEXLMh2ibXwJZH
         gTv1yVFvB9kNaq7AyrrmvdCMxWzzrsG+P97vKYmNbDlNZYUmifmnbYpdEkeFIv6cweVI
         sKXCQ/S+/HHagdMDuuBcyef39lmp8PIQOowPEg+Q2/JEYSOPj77VnvgCC7yfk5TcqhVu
         hYlNK3q0ds6Fi89pLKMtvHBbjvH+r5QtAQB6KfSezxnwNk7++GheA/AzV2VRaJvHQPeD
         tbMg==
X-Gm-Message-State: APjAAAUqHc2ho9GFAkWbMR6fsqivpnJiGOl6gb/y8OSY2DuypRU2RGRi
        ad0T/Mr9RYmUBrY3abmQmvhuFEhBgoc=
X-Google-Smtp-Source: APXvYqzilQIba81xsMAm/XzNo8yOiToCMG0j4CoenolEuzgNB9N7sIv8+//Szr3GBzVBI0YM7rAOzQ==
X-Received: by 2002:adf:ef49:: with SMTP id c9mr11527564wrp.292.1576793989331;
        Thu, 19 Dec 2019 14:19:49 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:58d:4e9b:2833:86c3])
        by smtp.gmail.com with ESMTPSA id n189sm8161765wme.33.2019.12.19.14.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 14:19:48 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-pm@vger.kernel.org (open list:CPU IDLE TIME MANAGEMENT FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] thermal: cpuidle: Register cpuidle cooling device
Date:   Thu, 19 Dec 2019 23:19:28 +0100
Message-Id: <20191219221932.15930-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191219221932.15930-1-daniel.lezcano@linaro.org>
References: <20191219221932.15930-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cpuidle driver can be used as a cooling device by injecting idle
cycles. The DT binding for the idle state added an optional

When the property is set, register the cpuidle driver with the idle
state node pointer as a cooling device. The thermal framework will do
the association automatically with the thermal zone via the
cooling-device defined in the device tree cooling-maps section.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/dt_idle_states.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/cpuidle/dt_idle_states.c b/drivers/cpuidle/dt_idle_states.c
index d06d21a9525d..34bd65197342 100644
--- a/drivers/cpuidle/dt_idle_states.c
+++ b/drivers/cpuidle/dt_idle_states.c
@@ -8,6 +8,7 @@
 
 #define pr_fmt(fmt) "DT idle-states: " fmt
 
+#include <linux/cpu_cooling.h>
 #include <linux/cpuidle.h>
 #include <linux/cpumask.h>
 #include <linux/errno.h>
@@ -205,6 +206,13 @@ int dt_init_idle_driver(struct cpuidle_driver *drv,
 			err = -EINVAL;
 			break;
 		}
+
+		if (of_find_property(state_node, "#cooling-cells", NULL)) {
+			err = cpuidle_of_cooling_register(state_node, drv);
+			if (err)
+				break;
+		}
+
 		of_node_put(state_node);
 	}
 
-- 
2.17.1

