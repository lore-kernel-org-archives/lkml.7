Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 173BBC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 22:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD56824676
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 22:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="idHt01tO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfLSWit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 17:38:49 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:45176 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbfLSWis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 17:38:48 -0500
Received: by mail-pg1-f202.google.com with SMTP id q1so4007445pge.12
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 14:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=nvazpb4jw88w4OfNslVwqIeFJNyWKvTS2T+KBCPseG4=;
        b=idHt01tOF7Z0+B6Qj4OinGDSJXQwVD7PlZs4aFq7eEzyBWrf9/QRVy/nnYHGAHpUur
         4EtlT7ahOScHmQ6EjiMChgE0mq2hWPKcoZahe0iCqQhByskVDPd4VLlWmay+ENvuowok
         WP8VdOVxBYaLILyVJRb347znk2/mRIOQafVvfJhWvU6M9+Oaf2XBBMSbeU4MF2uNqX3g
         izSqxIAJrprkN7TH3Dt8Fu+hyOHhDVsBkfkB4H1C0JvN+bJ2zJ7YSKeqzTamFTasHOdB
         ipcXQmB/m+G0fS4fCDIbqMV5un6odeaeTMQfO23ZX1FTscdYWF726ffVGiEp86AGgs4A
         eFQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=nvazpb4jw88w4OfNslVwqIeFJNyWKvTS2T+KBCPseG4=;
        b=HGdYmSLWTzbqr5kg+sRtZ1L5lRgAg1MH77687Vv13PaO+DWXMwB4mkm/hAyWXz5eiZ
         v3Ad0vhkxgX6pbxP4G9kZKW5x6UfoGdFuv28XBbv5pt/V4HoH339yeir6ymxORVCtIZH
         AN1Sq0yyZ9gRsRqOi5NLPZFbjub0kQSv0o3V83rsI4ngeDHy0V3QcW1YzdF5kaU4AP/E
         QymRAl5U+9xc5+H47Xd7S787lnLQq7dl7Nd7JQ9NYhPNHkiqWgUjIo3jNCUJ/sZMDZ8G
         ttHBDz6aD77V79by+cypQaktmnyBs7Z2M9rOEdZ0LDnG+5fp4PFCKOlVp5ktPTBePUIA
         JHHw==
X-Gm-Message-State: APjAAAUrLm0JiGKnrrQ/CrdOvA0TIeev61hT5LFS70cH+nddZRUAnJuj
        mleK1YeU4Vfb6yrE5Wwz9m7GtLHK46VnFw==
X-Google-Smtp-Source: APXvYqwmr9epiNS49aYJQZzVdjz/ElCZmA3BGuKBLDqfCNVSZQqtj/yLnY2HtgAPLHyqpTa/pvzZIHtUhW+SaA==
X-Received: by 2002:a63:7311:: with SMTP id o17mr10902166pgc.29.1576795127866;
 Thu, 19 Dec 2019 14:38:47 -0800 (PST)
Date:   Thu, 19 Dec 2019 14:38:34 -0800
Message-Id: <20191219223834.233692-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH] x86/resctrl: Fix potential memory leak
From:   Shakeel Butt <shakeelb@google.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>
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
RDT_RESOURCE_L3 or RDT_RESOURCE_L2. Fix that.

Fixes: 99adde9b370de ("x86/intel_rdt: Enable L2 CDP in MSR IA32_L2_QOS_CFG")
Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
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

