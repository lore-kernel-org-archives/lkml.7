Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85059CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 12:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 591AC20873
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 12:15:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NS7ZKy/C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbfJUMPb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 08:15:31 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46952 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728639AbfJUMP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 08:15:29 -0400
Received: by mail-pg1-f194.google.com with SMTP id e15so7694979pgu.13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 05:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=OV9GCJs4s7auzZpPSYG5QvReU/tq3thTyE+8LoeVN7Y=;
        b=NS7ZKy/CJRKKWW9c979mMVqT188CSGr/jWJ+67EpTmxEJt+UAyi1cRDiv1812fo/pS
         u3kaC56+efRbFQ80M9Ze3QN6VK4AEJ71gDz1wks2LVQ5aeBAEZhtqQybfLA0rfejtnbO
         gbegVPOHbbj8LkvtYQKiZsyIT1jQdUs508eV9I+O/wCi+/Y1F79VBbJ3Kk5q+QPsm5S9
         yYr4rExC53BA5VhyEJ8J8zwxQlS+B54pnEQWaMHdrE6mR0TXgqOpo+wcs+bONBYSo5gz
         kzoWjNtfmJnAmCD6kSw736Gvvjv6RjVD9mmRHy8gmg0H20Gn54q66uExxKiFnaYTa1d1
         5OnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=OV9GCJs4s7auzZpPSYG5QvReU/tq3thTyE+8LoeVN7Y=;
        b=O4LGyAHbVp74WM4U3cLfFGM/cTZfPxF1LWeWqdAujerI2dy2/V/LX/R5xeU+80CP1v
         SCz7uae0hIyVjpw93RHizAJHw8CHSTnbqVXTcVfFSEtHdz+1BqmpKQJUDXo2bKb1io9L
         YzlHx0DjbxvTfXxp63cE87OguSV1YQftm+dGaCFQJbpCfBWF+pW2XVfZVaI4q0om9Z3D
         EJ7Rx2JgDUioeBqdhjo2FcLpDFemoEvhgPa4QxAvhk8eEly1YYJe5Xcmm0ZKKXiECROC
         my/PorsNUzXK4me9OkU/eQl1xrs0Fva1pwiAW3IF+eL7ucCGoJM6egJyne6CojBLUXA3
         Gx8A==
X-Gm-Message-State: APjAAAVuP18Relp9RE05e7DyOtDf3oAF+mkePeZ32ImYEWW2zUAGcLUG
        3KbLamGYBUg+x6QrRcD5jtl9exnBHHAmuw==
X-Google-Smtp-Source: APXvYqzNjdZjeH7TQCvvsCQr2viFo8Wmk1yaKRPtWsE+Sq3U4TjGWSFMCUSBrZ07XjV/Nnpi5dCUNA==
X-Received: by 2002:a17:90b:144:: with SMTP id em4mr29096753pjb.8.1571660128323;
        Mon, 21 Oct 2019 05:15:28 -0700 (PDT)
Received: from localhost ([49.248.62.222])
        by smtp.gmail.com with ESMTPSA id u3sm14514404pfn.134.2019.10.21.05.15.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Oct 2019 05:15:27 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        sudeep.holla@arm.com, bjorn.andersson@linaro.org,
        edubezval@gmail.com, agross@kernel.org, tdas@codeaurora.org,
        swboyd@chromium.org, ilina@codeaurora.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Ben Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH v5 2/6] thermal: Initialize thermal subsystem earlier
Date:   Mon, 21 Oct 2019 17:45:11 +0530
Message-Id: <f8ff0ab4a8e9c2eca5a26fb2256365b26cb326ce.1571656015.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1571656014.git.amit.kucheria@linaro.org>
References: <cover.1571656014.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1571656014.git.amit.kucheria@linaro.org>
References: <cover.1571656014.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the thermal framework is built-in, in order to facilitate
thermal mitigation as early as possible in the boot cycle, move the
thermal framework initialization to core_initcall.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/thermal_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index cced0638b686f..69fcd54f8a83e 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1537,4 +1537,4 @@ static int __init thermal_init(void)
 	mutex_destroy(&poweroff_lock);
 	return result;
 }
-fs_initcall(thermal_init);
+core_initcall(thermal_init);
-- 
2.17.1

