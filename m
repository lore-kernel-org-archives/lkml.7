Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF6EC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 13:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 428A2217D8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 13:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563198790;
	bh=xreHO6Z6IC8Sp8Jv8DN16vrGkDA9QP35HThQbNuZKdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Lpaq7ZfXQu8cf5VXjXe/ak2owEoRrPUZToqLXYAvy+0DnraytgyWTtn/NaY1reJuF
	 7vaMhQsbiwxOOtFqHzL6aVWz8bsnJ2zjfkM17miqu4HO4kqLb55aWWICt6e0J0Cg05
	 CKZ5LBlVqL7HtxeKN74Aaj3MlojOU2QNYt/ZJbYE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732296AbfGONxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 09:53:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:49368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731699AbfGONxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 09:53:03 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C30882083D;
        Mon, 15 Jul 2019 13:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563198783;
        bh=xreHO6Z6IC8Sp8Jv8DN16vrGkDA9QP35HThQbNuZKdI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n3emwXzZO9+3XDljZFIV6JrWRTsYp40/bU1QHWDFaceWfRYHMrDvzGDdJaMnTozKB
         KiHOP1cTLFnZpDcKkwd5FfdEwne04i3fRd1YLZeS7+qOfFpR6mbE2lII40B8WjgZkU
         U6aR5AWBJXycBeTcfK2KwDuu0XDX3e7Pa2h0DVwU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        alexander.shishkin@linux.intel.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.2 102/249] perf/x86: Add Intel Ice Lake NNPI uncore support
Date:   Mon, 15 Jul 2019 09:44:27 -0400
Message-Id: <20190715134655.4076-102-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715134655.4076-1-sashal@kernel.org>
References: <20190715134655.4076-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>

[ Upstream commit 5f4318c1b1d23a9290e4def78ee76017c288bf60 ]

Intel Ice Lake uncore support already included IMC PCI ID but ICL-NNPI
CPUID is missing so add it to fix the probe function.

Fixes: e39875d15ad6 ("perf/x86: add Intel Icelake uncore support")
Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: alexander.shishkin@linux.intel.com
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Len Brown <lenb@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>
Link: https://lkml.kernel.org/r/20190614081701.13828-1-rajneesh.bhardwaj@linux.intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/events/intel/uncore.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 9e3fbd47cb56..089bfcdf2f7f 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1400,6 +1400,7 @@ static const struct x86_cpu_id intel_uncore_match[] __initconst = {
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_KABYLAKE_MOBILE, skl_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_KABYLAKE_DESKTOP, skl_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_ICELAKE_MOBILE, icl_uncore_init),
+	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_ICELAKE_NNPI, icl_uncore_init),
 	{},
 };
 
-- 
2.20.1

