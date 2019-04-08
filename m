Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD29C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF2DE213F2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BuC3WILA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfDHKk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 06:40:58 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40844 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfDHKk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 06:40:58 -0400
Received: by mail-pl1-f193.google.com with SMTP id b3so7097533plr.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 03:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7RA93DYth6ZqPFk65ekRc5aoo+shtaEtme9cGdrMV3w=;
        b=BuC3WILA75dhB2xy0FnlDu9pCluKApD+wt7/KF2ULd8vDGb2umgI//PiOAoPZkB/ee
         bYWaUx6iL6wIFGcVKqVx9MXzMNFo5484Yh8sD3Ri81XVo9XJ6lRXJa6muLVTb8dQyKda
         CC5kyhOJxiLYm6w5wvnU0iuHUM0oQFJyz00IJrnzrnDYzATcJSZ3cH6lG1R5dJ/5qhSS
         PX+vl3h97iz6vtNiiFWHsKNed8Xyko7MW6nlFG9CQgL38B5siqcEMYfE3/FzV+mgzJRQ
         IlCTekj8+cmfsvhbgrOtBDzq3qTG1DdIf9XIieqcfV4P+55jl8H+NIS0CyYhfoEu0J6W
         5dEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7RA93DYth6ZqPFk65ekRc5aoo+shtaEtme9cGdrMV3w=;
        b=Rgk0zAjVi8C7zeMkVxQmCS+G2/Lj5zG6FqCD7bWFYcKWFWKKxAGnXxT6X15xM4jHz+
         HnxQeLgT0OMVOy1NZjgapUg1/47662r1g/o28T/vHUCS+8Vodx9wa9kMQTAKMSplHnyM
         GCY6qHb6qqzgVfYRqtvu8zEnI3nUvUMgCL7Otj+fW9R3ASYlYyTFV7e4wbtLf4j2pvzQ
         lsJoM6sUiZTPtpkfa8WhWxOIVeZtAqo2XAIgQl1v+Cgk5yv0HLhZuOd+lfJzm2J2fOC9
         BZIQCOvZVVUXSYV0DlH65YpUqMahwfbMOrT9dPUZ/Ww3DbYYFG8qvDrFTPeLVkx3cbhG
         Z+CA==
X-Gm-Message-State: APjAAAUaeKxY05jd9BoYxcRzq13K0mvSdqGHaD3nFuBIs/jhhGn5hJDh
        Klfjot+50YekReW3gj3w37o=
X-Google-Smtp-Source: APXvYqwRy1eKS0fjXbjIE9tPcZauPqSJnB3BKy5yqefR/HvEBwr4yc36QGk/hOIlz1gDP8VwXsE3WA==
X-Received: by 2002:a17:902:e684:: with SMTP id cn4mr28650216plb.71.1554720057256;
        Mon, 08 Apr 2019 03:40:57 -0700 (PDT)
Received: from momoga.taipei.internal (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id 17sm40141650pgz.52.2019.04.08.03.40.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 03:40:56 -0700 (PDT)
From:   You-Sheng Yang <vicamo@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Pavel Tatashin <pasha.tatashin@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>,
        Daniel Vacek <neelx@redhat.com>,
        Mike Travis <mike.travis@hpe.com>,
        Xiaoming Gao <gxm.linux.kernel@gmail.com>
Cc:     You-Sheng Yang <vicamo.yang@canonical.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Chuanhua Lei <chuanhua.lei@linux.intel.com>,
        Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/tsc: mark tsc reliable on CoffeeLake
Date:   Mon,  8 Apr 2019 18:40:10 +0800
Message-Id: <20190408104012.26791-1-vicamo@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: You-Sheng Yang <vicamo.yang@canonical.com>

On Intel CoffeeLake it's observed tsc is always marked unstable
unexpectedly after entering idle state Package C10(PC10), and then clock
source is switched to hpet. This patch marks tsc as reliable when CPUID
matches CoffeeLake.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=203183
Signed-off-by: You-Sheng Yang <vicamo.yang@canonical.com>
---
 arch/x86/kernel/tsc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index aab0c82e0a0d..2abbadc9cff0 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1161,6 +1161,16 @@ static void __init check_system_tsc_reliable(void)
 #endif
 	if (boot_cpu_has(X86_FEATURE_TSC_RELIABLE))
 		tsc_clocksource_reliable = 1;
+
+	/*
+	 * On Intel CoffeeLake, tsc may be marked unstable unexpectedly after
+	 * entering PC10.
+	 */
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL &&
+	    (boot_cpu_data.x86_model == INTEL_FAM6_KABYLAKE_MOBILE ||
+	     boot_cpu_data.x86_model == INTEL_FAM6_KABYLAKE_DESKTOP) &&
+	    boot_cpu_data.x86_stepping >= 0x0a)
+		tsc_clocksource_reliable = 1;
 }
 
 /*
-- 
2.20.1

