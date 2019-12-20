Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C09C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 16:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3B562465E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 16:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AA6HXEH0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbfLTQoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 11:44:17 -0500
Received: from mail-qk1-f202.google.com ([209.85.222.202]:34070 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727181AbfLTQoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 11:44:17 -0500
Received: by mail-qk1-f202.google.com with SMTP id u10so6299406qkk.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 08:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=/f+oXlzEWRUoceqZjEqo089iCdd+GiRSxh3puxAQyIA=;
        b=AA6HXEH0mbuZrPSTE3VoFO1InPAO3sTivMPyhoxWpOE0uiPG3BoSvnYfg1q9Rf1Q7l
         kuYEdD93cg2B8b97eXEIrTVxDbQXnQv+4pZRj438Kw9ug6RgVLh/bcRb4qr+TMgOHz2C
         Krwj+rq8Dmp5PIcWVAPx/KtExnRo39DOvcJ8Kygn8JHPcw8QwcXhEfNlF8aiplm/8Vhc
         yiJa1LnX7SH7PjEUnUajXHwzKBpSdzrfi/Des53kraalT9daM22IJzuoYggJGlngDzNH
         KeY8BEW5k7/vEau7B+P42QPozbKqu3WZd80Z4HMnID4mWaniUHW+RQ7ZryVVw6L9Y33E
         Pzgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=/f+oXlzEWRUoceqZjEqo089iCdd+GiRSxh3puxAQyIA=;
        b=OczUdDvmhegIJSJFYbOtESj0CDT0jS341nEZUizScn/HmREbFbJjqGHblBpJek1RNv
         f1punTIX4rS8CUdg9K+3Wz61hKMOpHyxmbNjMpCbkiWmuFzetjepYNeNW02YFWCkDFVS
         9LEwIyhQiDimq+x3rtDYmKRa0/1u9bSQvNYSJeICKKj2FOBLYCNhKJzFMv3VDGhPwlNA
         KOLUl92lpwhkbz6HjwtGU46gMY25BHm++PLZXJ2yr9p0mFEzErlnrbX4jHnNW2jOaRra
         WnZ9CyZYugWL2xE5QPiGPsWM8Zuli8HTeDxi3p817Xvn+wstyxwqNkJPtkMK+OkMVvgg
         mlLA==
X-Gm-Message-State: APjAAAXpZBSDRBNWtJk/iESiOhjgM5BqURUJa693k+W7R5SWVBEx3AzX
        A1EvjTNhlyKkIZRpnw9iRMUHY0S9p+B2QQ==
X-Google-Smtp-Source: APXvYqx0Uie3HrKi3LR9xHjPp6g0MXEjtCw7cMW7zExH3G5b+DTzz+zjyX8g5QtJJ14AeH2uIQlBUV/eU+Y5kA==
X-Received: by 2002:ac8:46da:: with SMTP id h26mr12511505qto.167.1576860256406;
 Fri, 20 Dec 2019 08:44:16 -0800 (PST)
Date:   Fri, 20 Dec 2019 08:43:58 -0800
Message-Id: <20191220164358.177202-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v2] x86/resctrl: Fix potential memory leak
From:   Shakeel Butt <shakeelb@google.com>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The set_cache_qos_cfg() is leaking memory when the given level is not
RDT_RESOURCE_L3 or RDT_RESOURCE_L2. However at the moment, this function
is called with only valid levels but to make it more robust and future
proof, we should be handling the error path gracefully.

Fixes: 99adde9b370de ("x86/intel_rdt: Enable L2 CDP in MSR IA32_L2_QOS_CFG")
Signed-off-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Fenghua Yu <fenghua.yu@intel.com>
---
Changes since v1:
- Updated the commit message


 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 2e3b06d6bbc6..a0c279c7f4b9 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1748,8 +1748,10 @@ static int set_cache_qos_cfg(int level, bool enable)
 		update = l3_qos_cfg_update;
 	else if (level == RDT_RESOURCE_L2)
 		update = l2_qos_cfg_update;
-	else
+	else {
+		free_cpumask_var(cpu_mask);
 		return -EINVAL;
+	}
 
 	r_l = &rdt_resources_all[level];
 	list_for_each_entry(d, &r_l->domains, list) {
-- 
2.24.1.735.g03f4e72817-goog

