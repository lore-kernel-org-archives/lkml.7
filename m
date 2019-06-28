Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F2CDC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 05:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D67D92070D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 05:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="s6xZq0ze"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfF1FZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 01:25:35 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38481 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfF1FZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 01:25:35 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5S5P5Ei616394
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 27 Jun 2019 22:25:06 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5S5P5Ei616394
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561699507;
        bh=dN3aAWE0wvlajftEFy0qc+z/I60HJK0GsN08cShALp8=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=s6xZq0zeH05eyON0Bt7lAVBEau1hR2QL7EIHaXehqlq7LfL5XKtt0lAd9cf03lxML
         eAMCYn/1j7wFRn0KcmqMOwW3ANYNcsTnNduxr1YJu0lzOu5vRD71q1FTM93dTyzO7+
         CbrpoEznBDSsZQIj9P37k6WYKTUTSB6zLrF5OSllJ6v51Wwp8s/Szcus38Tpn1ObyO
         WMIArSoPBvdrhZTLRufZC1wQyBKSdsb2PVaWWLhyFbasw4s8xq8qoICocOqk5W/Sqk
         thq2Fdyu+Ep444hgNGeFTww3kyOHJyVwba5AccmJZRo9AWltSMT+6JDSuZ3XKUga/u
         umUfdHHIbluqg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5S5P4qj616385;
        Thu, 27 Jun 2019 22:25:04 -0700
Date:   Thu, 27 Jun 2019 22:25:04 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ricardo Neri <tipbot@zytor.com>
Message-ID: <tip-1e03bff3600101bd9158d005e4313132e55bdec8@git.kernel.org>
Cc:     hdegoede@redhat.com, tony.luck@intel.com,
        andriy.shevchenko@intel.com, andi.kleen@intel.com,
        alan.cox@intel.com, ricardo.neri-calderon@linux.intel.com,
        gregkh@linuxfoundation.org, mohammad.etemadi@intel.com,
        ak@linux.intel.com, mail@jordan-borgner.de, mingo@kernel.org,
        hpa@zytor.com, andriy.shevchenko@linux.intel.com, bp@suse.de,
        ravi.v.shankar@intel.com, tglx@linutronix.de,
        rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org,
        ricardo.neri@intel.com, pfeiner@google.com
Reply-To: mail@jordan-borgner.de, ak@linux.intel.com,
          mohammad.etemadi@intel.com, gregkh@linuxfoundation.org,
          ricardo.neri-calderon@linux.intel.com, alan.cox@intel.com,
          andi.kleen@intel.com, andriy.shevchenko@intel.com,
          tony.luck@intel.com, hdegoede@redhat.com, ricardo.neri@intel.com,
          pfeiner@google.com, linux-kernel@vger.kernel.org,
          rafael.j.wysocki@intel.com, tglx@linutronix.de, bp@suse.de,
          ravi.v.shankar@intel.com, hpa@zytor.com,
          andriy.shevchenko@linux.intel.com, mingo@kernel.org
In-Reply-To: <1561689337-19390-2-git-send-email-ricardo.neri-calderon@linux.intel.com>
References: <1561689337-19390-2-git-send-email-ricardo.neri-calderon@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cpu] x86/cpu/intel: Clear cache self-snoop capability in
 CPUs with known errata
Git-Commit-ID: 1e03bff3600101bd9158d005e4313132e55bdec8
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

Commit-ID:  1e03bff3600101bd9158d005e4313132e55bdec8
Gitweb:     https://git.kernel.org/tip/1e03bff3600101bd9158d005e4313132e55bdec8
Author:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
AuthorDate: Thu, 27 Jun 2019 19:35:36 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 28 Jun 2019 07:20:48 +0200

x86/cpu/intel: Clear cache self-snoop capability in CPUs with known errata

Processors which have self-snooping capability can handle conflicting
memory type across CPUs by snooping its own cache. However, there exists
CPU models in which having conflicting memory types still leads to
unpredictable behavior, machine check errors, or hangs.

Clear this feature on affected CPUs to prevent its use.

Suggested-by: Alan Cox <alan.cox@intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@suse.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jordan Borgner <mail@jordan-borgner.de>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: Mohammad Etemadi <mohammad.etemadi@intel.com>
Cc: Ricardo Neri <ricardo.neri@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Peter Feiner <pfeiner@google.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Link: https://lkml.kernel.org/r/1561689337-19390-2-git-send-email-ricardo.neri-calderon@linux.intel.com

---
 arch/x86/kernel/cpu/intel.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index f17c1a714779..8d6d92ebeb54 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -66,6 +66,32 @@ void check_mpx_erratum(struct cpuinfo_x86 *c)
 	}
 }
 
+/*
+ * Processors which have self-snooping capability can handle conflicting
+ * memory type across CPUs by snooping its own cache. However, there exists
+ * CPU models in which having conflicting memory types still leads to
+ * unpredictable behavior, machine check errors, or hangs. Clear this
+ * feature to prevent its use on machines with known erratas.
+ */
+static void check_memory_type_self_snoop_errata(struct cpuinfo_x86 *c)
+{
+	switch (c->x86_model) {
+	case INTEL_FAM6_CORE_YONAH:
+	case INTEL_FAM6_CORE2_MEROM:
+	case INTEL_FAM6_CORE2_MEROM_L:
+	case INTEL_FAM6_CORE2_PENRYN:
+	case INTEL_FAM6_CORE2_DUNNINGTON:
+	case INTEL_FAM6_NEHALEM:
+	case INTEL_FAM6_NEHALEM_G:
+	case INTEL_FAM6_NEHALEM_EP:
+	case INTEL_FAM6_NEHALEM_EX:
+	case INTEL_FAM6_WESTMERE:
+	case INTEL_FAM6_WESTMERE_EP:
+	case INTEL_FAM6_SANDYBRIDGE:
+		setup_clear_cpu_cap(X86_FEATURE_SELFSNOOP);
+	}
+}
+
 static bool ring3mwait_disabled __read_mostly;
 
 static int __init ring3mwait_disable(char *__unused)
@@ -304,6 +330,7 @@ static void early_init_intel(struct cpuinfo_x86 *c)
 	}
 
 	check_mpx_erratum(c);
+	check_memory_type_self_snoop_errata(c);
 
 	/*
 	 * Get the number of SMT siblings early from the extended topology
