Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE09C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AA0C20675
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="BIPw+FnR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730190AbfEWJZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 05:25:00 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34645 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbfEWJZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 05:25:00 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4N9OnQ44041542
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 23 May 2019 02:24:49 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4N9OnQ44041542
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1558603490;
        bh=JpXg7PCIBnHg7K2O4YfJbMCa5KbgdTOerhhDxTLIkI0=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=BIPw+FnRrlElXESW/77T/LDSs/24qwyOTvV2uZwM8zeQkBSkgd8do8nCixcottfzz
         MyJX2xpbr81nE5BQDgBD0oaLEFhwth8Nc32ZnUXuVxiow2ne7aiz9TkPii9HeDvjdY
         VHt5zTh6RTasH2iII6WT648qRNqYZn4jtQSRKoUnW0YnMvsmYMgzTsDEJpj780V1Kz
         80JA3vWcM5MXtAFcdjoTpMN5DOQGER3SKxe+B2wgXd4VmJs3k3wbdI8DKAgdRkfSx1
         9xBh4p76NMYNJXzsXrHb9fLbQ3qXvvIeldTOr4WlBghqyffP5PJ5YW+/kcM9SCuUUP
         1zRQgbp84xRQw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4N9OnWU4041539;
        Thu, 23 May 2019 02:24:49 -0700
Date:   Thu, 23 May 2019 02:24:49 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Len Brown <tipbot@zytor.com>
Message-ID: <tip-306a0de329f77537f29022c2982006f9145d782d@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, hpa@zytor.com, mingo@kernel.org,
        tglx@linutronix.de, peterz@infradead.org, len.brown@intel.com
Reply-To: len.brown@intel.com, peterz@infradead.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          mingo@kernel.org
In-Reply-To: <6463bc422b1b05445a502dc505c1d7c6756bda6a.1557769318.git.len.brown@intel.com>
References: <6463bc422b1b05445a502dc505c1d7c6756bda6a.1557769318.git.len.brown@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/topology] x86/topology: Define topology_die_id()
Git-Commit-ID: 306a0de329f77537f29022c2982006f9145d782d
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  306a0de329f77537f29022c2982006f9145d782d
Gitweb:     https://git.kernel.org/tip/306a0de329f77537f29022c2982006f9145d782d
Author:     Len Brown <len.brown@intel.com>
AuthorDate: Mon, 13 May 2019 13:58:48 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 23 May 2019 10:08:31 +0200

x86/topology: Define topology_die_id()

topology_die_id(cpu) is a simple macro for use inside the kernel to get the
die_id associated with the given cpu.

Signed-off-by: Len Brown <len.brown@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/6463bc422b1b05445a502dc505c1d7c6756bda6a.1557769318.git.len.brown@intel.com

---
 arch/x86/include/asm/topology.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index e0232f7042c3..3777dbe9c0ff 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -106,6 +106,7 @@ extern const struct cpumask *cpu_coregroup_mask(int cpu);
 
 #define topology_logical_package_id(cpu)	(cpu_data(cpu).logical_proc_id)
 #define topology_physical_package_id(cpu)	(cpu_data(cpu).phys_proc_id)
+#define topology_die_id(cpu)			(cpu_data(cpu).cpu_die_id)
 #define topology_core_id(cpu)			(cpu_data(cpu).cpu_core_id)
 
 #ifdef CONFIG_SMP
