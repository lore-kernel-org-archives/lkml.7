Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265A0C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D62F52339E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="it190hsU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfH2IuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 04:50:07 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38495 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbfH2IuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 04:50:05 -0400
Received: by mail-pg1-f195.google.com with SMTP id e11so1232783pga.5;
        Thu, 29 Aug 2019 01:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=llEqJbQquZmg44EVVsIz+rUKn+1paMeV1ggm5tExqbs=;
        b=it190hsUfuvXSmKudgY2NAWTdypFmbgxNqPExPyVrNNFS0MisuUL9cTukpxI8olh9l
         UFmT2BD3K1Vkf/Kdj/pZrsvkHOsCS1Z2nkobny+wyXTG43LbF7JNCuhmdlePewYzBUHG
         XBZCI4fQgeIkafqYzQcG9U0KXkJquef7+a61Nf/IG0mTExZ02Lvr9IDAhYmYJVRNllyL
         zEH+8LKep0lVzXoRyflI3hpv625uucMeNUFOOOnt5TLtJQ1kNKYyvUVW6VF6LgP8c9IE
         klPnqnO/3RK4pTexPkiNRdGRpOawGvmiSn+IXtXBexs3gwAgIzsVv1ByY3uCAa4wdMfe
         6esQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=llEqJbQquZmg44EVVsIz+rUKn+1paMeV1ggm5tExqbs=;
        b=fpLID5M+NDVyt6TFNrnevbKgBSiG2jLfmT6y6BQX0Iu51/YzuEnovSe+8kGc44EpXp
         5cFLZnYqiShmSRqU9lIATmWjnrOZXkplD6eHSj2BJ99x6H3W9nV3d1w7tWTeSGKjeHiN
         C3ulWv2RLhIITCuqZd3JSQ8o/LqUnUsIvkJfdS/gmeWVJH0QOSUFf5C9ZCshtiLfgPon
         ZUeJwxKx5Qyb7fxkpDglxKRs8aXsniGHk6sS5682ihllAIINZ8pYaS5hcHfOrfCuO4/g
         ycABbw0rJdgCGsx3fUR+6hh3uIdnD7Pn7Jf01Oy9rihTKOIy1XcZV4HAobev7pr8+tu9
         JiLg==
X-Gm-Message-State: APjAAAVga2cKjz32PTrKwE8w6PMKOKnRSx2kfk3Hrtn7DNfeRfIzV4Ai
        pxVbg0dq9pljPrmlrT80/55B2GjN
X-Google-Smtp-Source: APXvYqybYVCW4WKSbwOvYFr3ALtr+sJj+BYwgH4cZhlDpcD/yLnjfIWTxgcxAOjUwbQteavkBdSJ3w==
X-Received: by 2002:a17:90a:e392:: with SMTP id b18mr8352385pjz.140.1567068605013;
        Thu, 29 Aug 2019 01:50:05 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.123])
        by smtp.googlemail.com with ESMTPSA id t6sm1591693pjy.18.2019.08.29.01.50.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 29 Aug 2019 01:50:04 -0700 (PDT)
From:   Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v2] cpuidle-haltpoll: Enable kvm guest polling when dedicated physical CPUs are available
Date:   Thu, 29 Aug 2019 16:49:57 +0800
Message-Id: <1567068597-22419-1-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wanpeng Li <wanpengli@tencent.com>

The downside of guest side polling is that polling is performed even 
with other runnable tasks in the host. However, even if poll in kvm 
can aware whether or not other runnable tasks in the same pCPU, it 
can still incur extra overhead in over-subscribe scenario. Now we can 
just enable guest polling when dedicated pCPUs are available.

Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
--
v1 -> v2:
 * export kvm_arch_para_hints to fix haltpoll driver build as module error
 * just disable haltpoll driver instead of both driver and governor 
   since KVM_HINTS_REALTIME is not defined in other arches, and governor 
   doesn't depend on x86, to fix the warning on powerpc

 arch/x86/kernel/kvm.c              | 1 +
 drivers/cpuidle/cpuidle-haltpoll.c | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index f48401b..68463c1 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -711,6 +711,7 @@ unsigned int kvm_arch_para_hints(void)
 {
 	return cpuid_edx(kvm_cpuid_base() | KVM_CPUID_FEATURES);
 }
+EXPORT_SYMBOL_GPL(kvm_arch_para_hints);
 
 static uint32_t __init kvm_detect(void)
 {
diff --git a/drivers/cpuidle/cpuidle-haltpoll.c b/drivers/cpuidle/cpuidle-haltpoll.c
index 9ac093d..7aee38a 100644
--- a/drivers/cpuidle/cpuidle-haltpoll.c
+++ b/drivers/cpuidle/cpuidle-haltpoll.c
@@ -53,7 +53,8 @@ static int __init haltpoll_init(void)
 
 	cpuidle_poll_state_init(drv);
 
-	if (!kvm_para_available())
+	if (!kvm_para_available() ||
+		!kvm_para_has_hint(KVM_HINTS_REALTIME))
 		return 0;
 
 	ret = cpuidle_register(&haltpoll_driver, NULL);
-- 
2.7.4

