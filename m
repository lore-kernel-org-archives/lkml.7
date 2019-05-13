Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A880C46470
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 07:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5362B20C01
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 07:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TpA7ix/A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbfEMHKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 03:10:51 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37060 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbfEMHKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 03:10:51 -0400
Received: by mail-pl1-f195.google.com with SMTP id p15so5989026pll.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 00:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qMN/PlIc+xmZknm4ZqYo+axnKC9jbJCwqU2FWCmq5tE=;
        b=TpA7ix/AxkIP//ju6JW85dhgRAha590VihGIGmoBF2SkyfAtmzH1DpkcuPdN/C1dkd
         69Y/qYxUl4sToYu2B+lOUt4FOVICFz8JIdMeLonHnW6UDAx0L9i/dVqI7onkUmDn0Fn4
         RFs+tlshjjkWIXEhNm8dxasP2DXPtAi4Zy4+FcTuAK/ykNTlhhS0t1RWQ/Yx3bARdjIp
         k9tWzD4xq1aUC7FdMkImZbq5mzrTlqg56IF8ngufEKkTMCBvX0y08Urj9s9EwqI+yWa5
         oXF3YM+psdEgoy7D2LcRCH9gv6IUoT7mMddWbwK7VCnmv58RFPcXJpTF4liZUOqZV9LF
         XVqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qMN/PlIc+xmZknm4ZqYo+axnKC9jbJCwqU2FWCmq5tE=;
        b=psFPzKAZwzgLv9eBmjkNmWABJBGFoeFKhY1aYpR7Ud0X7uBeouBdqIHLHuKI3fLuPq
         9wJrwQLFms5TM1q38xOcN0LsvKH6pHaEH/9HjFk+dspaYsWFCmhA4QQOts9Kjo9W2MbN
         NB8IBr8siwgYqD9aVbqNtKrTrqs9fwwDOQp4fvbfdOy7J4nFY0zNOxrHQ0/KqewSSVQL
         jxJfPfEkgASQNTJc3rvLdZeuUancaS6fuwO/PpO3Lc8ez5qdlmBuRVnG7FgCxjRSRnGY
         03F4LGb6mxYszJiKQYg5ogXAeCr3CcSoN2VCUDGRypCMeXsR+vdFbNESEMBAPVqtIacl
         SV1w==
X-Gm-Message-State: APjAAAWWl3WB7Z8gKBi5esJVdU7aPKSyz7iMsFWtBi6KPDQZKS2ylPsD
        1BCfpeM2y2rNead6a5QpMPFDUQ==
X-Google-Smtp-Source: APXvYqxYSXh4d9qVBzkIKRwNZleSCdZccazd+LCiWhQxXNw5jk9FFMd4MdJ98iVfPYIPkDFctdOwRg==
X-Received: by 2002:a17:902:9a9:: with SMTP id 38mr29138342pln.10.1557731449961;
        Mon, 13 May 2019 00:10:49 -0700 (PDT)
Received: from localhost ([122.172.118.99])
        by smtp.gmail.com with ESMTPSA id g72sm29732723pfg.63.2019.05.13.00.10.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 00:10:48 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: Update MAINTAINERS to include schedutil governor
Date:   Mon, 13 May 2019 12:40:33 +0530
Message-Id: <f2badd7ec3afa227410a9f57401bf5ce04aff692.1557731248.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

List cpufreq maintainers as well for schedutil governor apart from
scheduler maintainers.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4244dd341eb7..7d4417d862a6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4093,7 +4093,9 @@ F:	Documentation/admin-guide/pm/intel_pstate.rst
 F:	Documentation/cpu-freq/
 F:	Documentation/devicetree/bindings/cpufreq/
 F:	drivers/cpufreq/
+F:	kernel/sched/cpufreq*.c
 F:	include/linux/cpufreq.h
+F:	include/linux/sched/cpufreq.h
 F:	tools/testing/selftests/cpufreq/
 
 CPU FREQUENCY DRIVERS - ARM BIG LITTLE
-- 
2.21.0.rc0.269.g1a574e7a288b

