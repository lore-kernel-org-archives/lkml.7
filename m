Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A62C3A59B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 08:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DD5220880
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 08:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="eimec7yu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbfHQIkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Aug 2019 04:40:24 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44479 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbfHQIkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 04:40:23 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x7H8eAKh3184729
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 17 Aug 2019 01:40:10 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x7H8eAKh3184729
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1566031211;
        bh=L+ePIe7v6+koOGHVExA53FMzqQm7TQc96yfOl1tYPi0=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=eimec7yupCa67r9VO30kecBKdQ+K4K/h3IWMPy0CAbtD4LRSBi1Ams0GFItXwcxAa
         fdqRbEUeszwpQRu5GHsWKn0wnxr38OayfNq+XcNXr0zT+JoMtXWW5NsEyqEg2QV3cB
         xdn4tVPdUM3ckrXkvWEmi+dH+WMfYSoUT7wC0je3IYtzBZPfyt9OIllcXO1t5eYJ5Q
         BXMahoaOPEy/qBsL/re0KLlcscB4lST+/mQZYBvqDGoPdViEaoWBBK9mO3SUjsXV6j
         yirnmXVNGmrweerHbZy3Bt3f7Vgd/ECk47/+R1A09DZttYM0YCGIhY15365k4Y6y7f
         X5q80KtzbGwZg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x7H8e9YV3184726;
        Sat, 17 Aug 2019 01:40:09 -0700
Date:   Sat, 17 Aug 2019 01:40:09 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Rahul Tanwar <tipbot@zytor.com>
Message-ID: <tip-bba10c5cab4ddd8725a7998e064fc72c9770c667@git.kernel.org>
Cc:     mingo@redhat.com, bp@suse.de, andriy.shevchenko@intel.com,
        ricardo.neri-calderon@linux.intel.com, tony.luck@intel.com,
        rafael.j.wysocki@intel.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, hdegoede@redhat.com,
        mingo@kernel.org, hpa@zytor.com, x86@kernel.org,
        rahul.tanwar@linux.intel.com
Reply-To: andriy.shevchenko@intel.com, mingo@redhat.com, bp@suse.de,
          tony.luck@intel.com, ricardo.neri-calderon@linux.intel.com,
          tglx@linutronix.de, linux-kernel@vger.kernel.org,
          rafael.j.wysocki@intel.com, mingo@kernel.org, x86@kernel.org,
          hpa@zytor.com, rahul.tanwar@linux.intel.com, hdegoede@redhat.com
In-Reply-To: <f7a0e142faa953a53d5f81f78055e1b3c793b134.1565940653.git.rahul.tanwar@linux.intel.com>
References: <f7a0e142faa953a53d5f81f78055e1b3c793b134.1565940653.git.rahul.tanwar@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cleanups] x86/cpu: Use constant definitions for CPU models
Git-Commit-ID: bba10c5cab4ddd8725a7998e064fc72c9770c667
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

Commit-ID:  bba10c5cab4ddd8725a7998e064fc72c9770c667
Gitweb:     https://git.kernel.org/tip/bba10c5cab4ddd8725a7998e064fc72c9770c667
Author:     Rahul Tanwar <rahul.tanwar@linux.intel.com>
AuthorDate: Fri, 16 Aug 2019 16:18:57 +0800
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Sat, 17 Aug 2019 10:34:09 +0200

x86/cpu: Use constant definitions for CPU models

Replace model numbers with their respective macro definitions when
comparing CPU models.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: alan@linux.intel.com
Cc: cheol.yong.kim@intel.com
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: qi-ming.wu@intel.com
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/f7a0e142faa953a53d5f81f78055e1b3c793b134.1565940653.git.rahul.tanwar@linux.intel.com
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
