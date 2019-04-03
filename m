Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F02C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E6B920882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfDCEaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 00:30:18 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60230 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbfDCEaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 00:30:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 13D5F15AD;
        Tue,  2 Apr 2019 21:30:18 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.1.97])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B6BCE3F721;
        Tue,  2 Apr 2019 21:30:12 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, will.deacon@arm.com,
        catalin.marinas@arm.com
Cc:     mhocko@suse.com, mgorman@techsingularity.net, james.morse@arm.com,
        mark.rutland@arm.com, robin.murphy@arm.com, cpandya@codeaurora.org,
        arunks@codeaurora.org, dan.j.williams@intel.com, osalvador@suse.de,
        logang@deltatee.com, pasha.tatashin@oracle.com, david@redhat.com,
        cai@lca.pw
Subject: [PATCH 1/6] arm64/mm: Enable sysfs based memory hot add interface
Date:   Wed,  3 Apr 2019 10:00:01 +0530
Message-Id: <1554265806-11501-2-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554265806-11501-1-git-send-email-anshuman.khandual@arm.com>
References: <1554265806-11501-1-git-send-email-anshuman.khandual@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sysfs memory probe interface (/sys/devices/system/memory/probe) can accept
starting physical address of an entire memory block to be hot added into
the kernel. This is in addition to the existing ACPI based interface. This
just enables it with the required config CONFIG_ARCH_MEMORY_PROBE.

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/Kconfig | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7e34b9e..a2418fb 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -266,6 +266,15 @@ config HAVE_GENERIC_GUP
 config ARCH_ENABLE_MEMORY_HOTPLUG
 	def_bool y
 
+config ARCH_MEMORY_PROBE
+	bool "Enable /sys/devices/system/memory/probe interface"
+	depends on MEMORY_HOTPLUG
+	help
+	  This option enables a sysfs /sys/devices/system/memory/probe
+	  interface for testing. See Documentation/memory-hotplug.txt
+	  for more information. If you are unsure how to answer this
+	  question, answer N.
+
 config SMP
 	def_bool y
 
-- 
2.7.4

