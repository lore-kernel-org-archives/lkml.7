Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC827C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 08:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B78C32133F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 08:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfHPITQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 04:19:16 -0400
Received: from mga11.intel.com ([192.55.52.93]:1567 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726575AbfHPITQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 04:19:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Aug 2019 01:19:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,391,1559545200"; 
   d="scan'208";a="179617797"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by orsmga003.jf.intel.com with ESMTP; 16 Aug 2019 01:19:11 -0700
From:   Rahul Tanwar <rahul.tanwar@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        tony.luck@intel.com, x86@kernel.org
Cc:     andriy.shevchenko@intel.com, alan@linux.intel.com,
        ricardo.neri-calderon@linux.intel.com, rafael.j.wysocki@intel.com,
        linux-kernel@vger.kernel.org, qi-ming.wu@intel.com,
        cheol.yong.kim@intel.com, rahul.tanwar@intel.com,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [PATCH v2 1/3] x86/cpu: Use constant definitions for CPU type
Date:   Fri, 16 Aug 2019 16:18:57 +0800
Message-Id: <f7a0e142faa953a53d5f81f78055e1b3c793b134.1565940653.git.rahul.tanwar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1565940653.git.rahul.tanwar@linux.intel.com>
References: <cover.1565940653.git.rahul.tanwar@linux.intel.com>
In-Reply-To: <cover.1565940653.git.rahul.tanwar@linux.intel.com>
References: <cover.1565940653.git.rahul.tanwar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace direct values usage with constant definitions when access CPU models.

Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 arch/x86/kernel/cpu/intel.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 8d6d92ebeb54..66de4b84c369 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -265,9 +265,9 @@ static void early_init_intel(struct cpuinfo_x86 *c)
 	/* Penwell and Cloverview have the TSC which doesn't sleep on S3 */
 	if (c->x86 == 6) {
 		switch (c->x86_model) {
-		case 0x27:	/* Penwell */
-		case 0x35:	/* Cloverview */
-		case 0x4a:	/* Merrifield */
+		case INTEL_FAM6_ATOM_SALTWELL_MID:
+		case INTEL_FAM6_ATOM_SALTWELL_TABLET:
+		case INTEL_FAM6_ATOM_SILVERMONT_MID:
 			set_cpu_cap(c, X86_FEATURE_NONSTOP_TSC_S3);
 			break;
 		default:
-- 
2.11.0

