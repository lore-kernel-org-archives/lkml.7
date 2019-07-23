Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC33C76190
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 06:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5009D223A1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 06:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ukFG103P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388187AbfGWGO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 02:14:57 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41415 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388175AbfGWGOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 02:14:53 -0400
Received: by mail-pf1-f195.google.com with SMTP id m30so18586972pff.8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 23:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pE9tUu3P/8w1bftggmV11VxGbS0rl+eqvKACn21icvM=;
        b=ukFG103PF/bL7cLvjS/DEUm8Y+TFfzbryVSM7lnY7E2JAgqNadFQXZ+zzONmjxQRvN
         /UNtFxcDJE9E6GT1fFhmaNEdT0U6LY+fM7OLyuzdFbiF9pq/AOtrPPYgpCD7pQyMpqT8
         RxNXI3sOAH+3hgE3B2gEyn6lDVa9opE8HSLJBn14tv10YYA8aPxKAtF8dkorCTcbJOLV
         JO7eYBtRjWSkQ5J09nJfN2iaEb1vbuaov0kgzMGIN6hiJzic3uaEe2jgeHQrAJIqdUZn
         DjqcHIFUYDCeqAjsTvjUIo5ZGlM7ySIuaLaeWa7YvtT2/mQ9Y+PamXkRp5Yyii2rH4zi
         ipuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pE9tUu3P/8w1bftggmV11VxGbS0rl+eqvKACn21icvM=;
        b=f6cqaZn8RLUwlvcZCkuCVRfgmL/45zz/8M0Zwh/sF7C5RyQp+ePOQtgroi06aeHeFp
         qDLL0AZo3W28zoyobVExEZtbYuY2WdHfOx8RVcjzmLEYD4BPVDwP/t8PSnF4JBkPG7rl
         x5R/kYnYYuho1xsTN1AyY8TvjT1OffU6goBlRGZdYxckpXKO+7GrJKwauvwioM4w30yT
         kIESaTewqpygbQLzpn6Ff//8NEg+iklM/SXShP2yrj8QPCtRZxeKdcVKKXQt5D89sBOp
         /Iopcic5VxGyExsSJaaSL/Kb1VoNlNU7mt4fXubcFDmL+lf7o9MS72iKtm6svs5SR8EX
         x3bg==
X-Gm-Message-State: APjAAAVE5+iGUZQ8vfC9Qiex13iPj51eI6Cqz1Fe1vKeXj9V1jXHeJEk
        unHBmqX2ipl3BZnUX6cm9hKS8Q==
X-Google-Smtp-Source: APXvYqwGQ+U0AMsik4H8UPxZf/Ydr0V0LliUR9Neva7b1FE5jVZtVNnSanLdcxXeoCgYKlNZL4RE1w==
X-Received: by 2002:aa7:90d8:: with SMTP id k24mr4051781pfk.115.1563862492359;
        Mon, 22 Jul 2019 23:14:52 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id f3sm65402869pfg.165.2019.07.22.23.14.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 23:14:51 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 10/10] Documentation: cpufreq: Update policy notifier documentation
Date:   Tue, 23 Jul 2019 11:44:10 +0530
Message-Id: <c90b601734b9828aeb93b8317205aff791660a2d.1563862014.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <cover.1563862014.git.viresh.kumar@linaro.org>
References: <cover.1563862014.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update documentation with the recent policy notifier updates.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/cpu-freq/core.txt | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/Documentation/cpu-freq/core.txt b/Documentation/cpu-freq/core.txt
index 55193e680250..ed577d9c154b 100644
--- a/Documentation/cpu-freq/core.txt
+++ b/Documentation/cpu-freq/core.txt
@@ -57,19 +57,11 @@ transition notifiers.
 2.1 CPUFreq policy notifiers
 ----------------------------
 
-These are notified when a new policy is intended to be set. Each
-CPUFreq policy notifier is called twice for a policy transition:
+These are notified when a new policy is created or removed.
 
-1.) During CPUFREQ_ADJUST all CPUFreq notifiers may change the limit if
-    they see a need for this - may it be thermal considerations or
-    hardware limitations.
-
-2.) And during CPUFREQ_NOTIFY all notifiers are informed of the new policy
-   - if two hardware drivers failed to agree on a new policy before this
-   stage, the incompatible hardware shall be shut down, and the user
-   informed of this.
-
-The phase is specified in the second argument to the notifier.
+The phase is specified in the second argument to the notifier.  The phase is
+CPUFREQ_CREATE_POLICY when the policy is first created and it is
+CPUFREQ_REMOVE_POLICY when the policy is removed.
 
 The third argument, a void *pointer, points to a struct cpufreq_policy
 consisting of several values, including min, max (the lower and upper
-- 
2.21.0.rc0.269.g1a574e7a288b

