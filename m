Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38D8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 06:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73F1A2085A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 06:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w979PRkQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfCNGnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 02:43:37 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38664 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727300AbfCNGng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 02:43:36 -0400
Received: by mail-pf1-f196.google.com with SMTP id n125so3181020pfn.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 23:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ebmk+NLAtdOtjqPKJKqOvCw/VBxQ6uvDNPKAjmLO1T0=;
        b=w979PRkQFqk+b+Jq9kZ/k9zDrSk4aW4Kp02xZ0LyM2CQg/LAlLvJnjWrJYbLVN4FXT
         FiVieIId0tuArOO45TNRxJTV5cP9UbhZCFsJsm7/DvhUoM7JYmZWA9kY5mtStUBV9cQq
         i98pkDc3/c/Ztwj8N8pgBKUR71SLSnTAmdeUd5JFGaqj2F4JyrA40JHj8au9ZO3LfFfc
         88ZH2JZDu7haUROjDW7YeMUZxoekMnMO/oBNTOPUdRgjQfuXXuYna/B9lnOT6NJ6IF+L
         tkkA46K3qSF/tXVALRKguiwBBij+LsIL7oEHWnUJyPCK4xPzicDfaD36aiaoYt2a3QLF
         EEbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ebmk+NLAtdOtjqPKJKqOvCw/VBxQ6uvDNPKAjmLO1T0=;
        b=ckxOey7rMcUJATya79K4OFsUsA1l+GsmqmmXMeTqU0Os6pK+J1UpdCRs5R99Mte/1e
         w4KRPFqFFIT2f6Ox9g2tGHAIqiGrUIufrRLCc/z5wFmK+3dyOUfqSPh4Aw2T+D6M4lwa
         wUUOH4OVd2j+SFLxBChgrl+//1n+KItV/dEfPfPcQ9xqddeNwOQQI8RiKgMqMCZwhvzx
         08GGFDNR9TJsOZQS7twUk7L8JJUZl3xevynfwT1bfDzhIXofjXv+ztsotFWQlUoSP+3W
         A6iCkDPTeOxiEjSXh+OrV+k0MNX6ziyiuLv1YptRCbRE9UP5/pbu0IyOqgb9Yc434POY
         2zeA==
X-Gm-Message-State: APjAAAUPbZ8vGPp9RhcFlrEPog49NyBmkVmvMv8w/+byHaXFrwkG1CxD
        xe6LTGRAJiDsieN/xH6sqicrFQ==
X-Google-Smtp-Source: APXvYqxdp7sRcU+LU7YkCmhXl977z6+p7v379LWu6cziYiQfhfJspurAB04t+oPamlU9aOMPdKasOw==
X-Received: by 2002:a17:902:361:: with SMTP id 88mr50056390pld.78.1552545815420;
        Wed, 13 Mar 2019 23:43:35 -0700 (PDT)
Received: from localhost ([122.166.134.37])
        by smtp.gmail.com with ESMTPSA id g24sm1674461pfd.7.2019.03.13.23.43.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 23:43:34 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] KVM: x86: Update cpufreq transition notifier to handle multiple CPUs
Date:   Thu, 14 Mar 2019 12:12:52 +0530
Message-Id: <adcf2b6e181d2ad2ab1b7038ba898eb4f4e53906.1552545525.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <cover.1552545525.git.viresh.kumar@linaro.org>
References: <cover.1552545525.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cpufreq core currently calls the cpufreq transition notifier
callback once for each affected CPU. This is going to change soon and
the cpufreq core will call the callback only once for each cpufreq
policy. The callback must look at the newly added field in struct
cpufreq_freqs, "cpus", which contains policy->related_cpus (both
online/offline CPUs) and perform per-cpu actions for them if any.

This patch updates kvmclock_cpufreq_notifier() to use the new "cpus"
field and perform the per-cpu activity for all online CPUs in this
cpumask.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/x86/kvm/x86.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 941f932373d0..24eb6123391d 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6648,10 +6648,8 @@ static void kvm_hyperv_tsc_notifier(void)
 }
 #endif
 
-static int kvmclock_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
-				     void *data)
+static void __kvmclock_cpufreq_notifier(struct cpufreq_freqs *freq, int cpu)
 {
-	struct cpufreq_freqs *freq = data;
 	struct kvm *kvm;
 	struct kvm_vcpu *vcpu;
 	int i, send_ipi = 0;
@@ -6695,17 +6693,12 @@ static int kvmclock_cpufreq_notifier(struct notifier_block *nb, unsigned long va
 	 *
 	 */
 
-	if (val == CPUFREQ_PRECHANGE && freq->old > freq->new)
-		return 0;
-	if (val == CPUFREQ_POSTCHANGE && freq->old < freq->new)
-		return 0;
-
-	smp_call_function_single(freq->cpu, tsc_khz_changed, freq, 1);
+	smp_call_function_single(cpu, tsc_khz_changed, freq, 1);
 
 	spin_lock(&kvm_lock);
 	list_for_each_entry(kvm, &vm_list, vm_list) {
 		kvm_for_each_vcpu(i, vcpu, kvm) {
-			if (vcpu->cpu != freq->cpu)
+			if (vcpu->cpu != cpu)
 				continue;
 			kvm_make_request(KVM_REQ_CLOCK_UPDATE, vcpu);
 			if (vcpu->cpu != smp_processor_id())
@@ -6727,8 +6720,24 @@ static int kvmclock_cpufreq_notifier(struct notifier_block *nb, unsigned long va
 		 * guest context is entered kvmclock will be updated,
 		 * so the guest will not see stale values.
 		 */
-		smp_call_function_single(freq->cpu, tsc_khz_changed, freq, 1);
+		smp_call_function_single(cpu, tsc_khz_changed, freq, 1);
 	}
+}
+
+static int kvmclock_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
+				     void *data)
+{
+	struct cpufreq_freqs *freq = data;
+	int cpu;
+
+	if (val == CPUFREQ_PRECHANGE && freq->old > freq->new)
+		return 0;
+	if (val == CPUFREQ_POSTCHANGE && freq->old < freq->new)
+		return 0;
+
+	for_each_cpu_and(cpu, freq->cpus, cpu_online_mask)
+		__kvmclock_cpufreq_notifier(freq, cpu);
+
 	return 0;
 }
 
-- 
2.21.0.rc0.269.g1a574e7a288b

