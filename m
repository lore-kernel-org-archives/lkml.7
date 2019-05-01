Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4360C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 04:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A18F420866
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 04:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556684763;
	bh=k1Jv58Df73YZhzI+gHs65MvR/WrxoEvI2Or//tv2pU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:List-ID:
	 From;
	b=EWEVQEvhQ5PQ0c7ZIVYJk4pNktjENVmEV3Porzxyt7tWwc/CLS4ccJkIGX9UTFXZc
	 /w8n2IaCAGT44RVit0PvG6Gza9UGmJM4aROOlzd9jiTdL3r35yO5eEQ2+xGFL3gTa7
	 4TFMuWSBIfQMOENwRP06bn1gfQgDhmOz9qLm+21Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbfEAE0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 00:26:02 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35388 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbfEAEYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 00:24:38 -0400
Received: by mail-io1-f68.google.com with SMTP id r18so14121213ioh.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 21:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=uD3OvFcls30SXN52XBWKTLWJTDIBIfXTSrwZineFKm8=;
        b=g6Qo2DhocXBthkfzHjb5lXWzSD2Rg61uT1VPPiyZmosOuPUCtNw/L7rlkgjhjFeawF
         AYy6RKE7m2aJoljKCiWbwtjFjbi5pqNovdknBJi9O020X2Z1tJdX3FMYHH5Fri697UHf
         w3Rfk26XjZ91vPbizxJILLB2Tey1S/qU5wHuiFtmVWeeB+a3F9oUIaMpkRIRM3D/+/8i
         dRFcHJT11Xi12wIYidmJhPivJC4VAFhdpCgrsPc4N7mJU5ZBuHrwPYRo9cek05hkHTGx
         RDT5lIzwP2Kqmm65DweyHwMqZqjOkbtCpwz3G+ogiuYQnMoDYJTE+MUMQId0oruLCG1R
         v01A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=uD3OvFcls30SXN52XBWKTLWJTDIBIfXTSrwZineFKm8=;
        b=TRhUtCl4abav+5ss1sZmNiDVxiDHiLmRu5M166d7unYjF5tEQb9kT9alrF1uxo50d5
         H3Ddwh3R4xnW+nzVHnwLxRq9YPy7p7csjm08RsvFPo2pvAjYnFEt95Od8C1lfvAiHh/F
         ZL8B7e03QTyFjTAEquzL/yO4zp2K4JqWSdMqfzFxTLOhmATetN3mZtmaxDwxEqBmdp/w
         LwNjWvPUszkIMImGlg+zbMKNleWBsqWrdMQBIEJUUQMSBzUzj/E2C2ihjVKHnZDRCorv
         1i4uHnR39Gu7taDRAm9KvVqYrE1/fOPkHpetPKM+JSZha5m56pg+55nGFIbswUInbky3
         7SpA==
X-Gm-Message-State: APjAAAXTbH42pvTmNG1eSCoRPHp1aWyW+dAT9gaBLUuuZXJpr8I8a+Wv
        ZpOGKUAkkP7T8iUn/s2lNhg=
X-Google-Smtp-Source: APXvYqyQhAzojkHBWUoRpPkxj27UOO7RtOpy8g6IcIXUi0BCJp5H+z+RAP5y/mIXodO24dbhzA6r2Q==
X-Received: by 2002:a5e:8216:: with SMTP id l22mr17088870iom.269.1556684677910;
        Tue, 30 Apr 2019 21:24:37 -0700 (PDT)
Received: from nuc8.lan (h69-131-112-51.cntcnh.dsl.dynamic.tds.net. [69.131.112.51])
        by smtp.gmail.com with ESMTPSA id b8sm2569728itb.20.2019.04.30.21.24.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 21:24:37 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
Subject: [PATCH 03/18] x86 smpboot: Rename match_die() to match_pkg()
Date:   Wed,  1 May 2019 00:24:12 -0400
Message-Id: <44a39ba11153106d2b029d9cffee1b062bdbce4b.1556657368.git.len.brown@intel.com>
X-Mailer: git-send-email 2.18.0-rc0
In-Reply-To: <6f53f0e494d743c79e18f6e3a98085711e6ddd0c.1556657368.git.len.brown@intel.com>
References: <6f53f0e494d743c79e18f6e3a98085711e6ddd0c.1556657368.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Len Brown <len.brown@intel.com>

Syntax only, no functional or semantic change.

This routine matches packages, not die, so name it thus.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/kernel/smpboot.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index ce1a67b70168..3f8bbfb26c18 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -455,7 +455,7 @@ static bool match_llc(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
  * multicore group inside a NUMA node.  If this happens, we will
  * discard the MC level of the topology later.
  */
-static bool match_die(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
+static bool match_pkg(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
 {
 	if (c->phys_proc_id == o->phys_proc_id)
 		return true;
@@ -546,7 +546,7 @@ void set_cpu_sibling_map(int cpu)
 	for_each_cpu(i, cpu_sibling_setup_mask) {
 		o = &cpu_data(i);
 
-		if ((i == cpu) || (has_mp && match_die(c, o))) {
+		if ((i == cpu) || (has_mp && match_pkg(c, o))) {
 			link_mask(topology_core_cpumask, cpu, i);
 
 			/*
@@ -570,7 +570,7 @@ void set_cpu_sibling_map(int cpu)
 			} else if (i != cpu && !c->booted_cores)
 				c->booted_cores = cpu_data(i).booted_cores;
 		}
-		if (match_die(c, o) && !topology_same_node(c, o))
+		if (match_pkg(c, o) && !topology_same_node(c, o))
 			x86_has_numa_in_package = true;
 	}
 
-- 
2.18.0-rc0

