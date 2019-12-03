Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D0EC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 13:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBD0B2080A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 13:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575381440;
	bh=Ssn7fg+f8y3AsIfRswh5lUlHR/VHn83rOVQgmUJJTYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=r90a12DEI1GpgJcGOSs4ZZa/0TnMchvUbXbbHQPTXM2iZkhzf2zZk7K2hu78mh+Jc
	 oT/kim/bk40LsupGYFXkxS+AvpFhFxRfQj9I5/dAACC8x/uN23Ng34dBrzVvcY+GMh
	 hf7ieTA7zq4ah0QWIuX9z5nm879phF/wrzbTkbz8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbfLCN5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 08:57:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:35376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727219AbfLCN5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 08:57:17 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB5D3214AF;
        Tue,  3 Dec 2019 13:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575381436;
        bh=Ssn7fg+f8y3AsIfRswh5lUlHR/VHn83rOVQgmUJJTYU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MkfghSENKyVblwDbADdKcSiQ3DVpm8kD/4FryYYJyqRn1foPipJxFJQwAnvCBZUfP
         GYKUvvbYgK/zFhv82S19qRP3W7rlCH7ll6GT583+T8Q5tEZ59L9X8WMBIGhXWMuC6L
         wJ898vDt+xrc25EPum8w0M91hSZQR+nbLZk/Q/So=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Babu Moger <babu.moger@amd.com>, Borislav Petkov <bp@suse.de>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Vineela Tummalapalli <vineela.tummalapalli@intel.com>
Subject: [PATCH 20/23] tools arch x86: Sync asm/cpufeatures.h with the kernel sources
Date:   Tue,  3 Dec 2019 10:56:03 -0300
Message-Id: <20191203135606.24902-21-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191203135606.24902-1-acme@kernel.org>
References: <20191203135606.24902-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To pick up the changes from:

  a25bbc2644f0 ("Merge branches 'x86-cpu-for-linus' and 'x86-fpu-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip")
  db4d30fbb71b ("x86/bugs: Add ITLB_MULTIHIT bug infrastructure")
  1b42f017415b ("x86/speculation/taa: Add mitigation for TSX Async Abort")
  9d40b85bb46a ("x86/cpufeatures: Add feature bit RDPRU on AMD")

These don't cause any changes in tooling, just silences this perf build
warning:

  Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at 'arch/x86/include/asm/cpufeatures.h'
  diff -u tools/arch/x86/include/asm/cpufeatures.h arch/x86/include/asm/cpufeatures.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Babu Moger <babu.moger@amd.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vineela Tummalapalli <vineela.tummalapalli@intel.com>
Link: https://lkml.kernel.org/n/tip-yufg9yt2nbkh45r9xvxnnscq@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/asm/cpufeatures.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index 0652d3eed9bd..e9b62498fe75 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -292,6 +292,7 @@
 #define X86_FEATURE_CLZERO		(13*32+ 0) /* CLZERO instruction */
 #define X86_FEATURE_IRPERF		(13*32+ 1) /* Instructions Retired Count */
 #define X86_FEATURE_XSAVEERPTR		(13*32+ 2) /* Always save/restore FP error pointers */
+#define X86_FEATURE_RDPRU		(13*32+ 4) /* Read processor register at user level */
 #define X86_FEATURE_WBNOINVD		(13*32+ 9) /* WBNOINVD instruction */
 #define X86_FEATURE_AMD_IBPB		(13*32+12) /* "" Indirect Branch Prediction Barrier */
 #define X86_FEATURE_AMD_IBRS		(13*32+14) /* "" Indirect Branch Restricted Speculation */
@@ -399,5 +400,7 @@
 #define X86_BUG_MDS			X86_BUG(19) /* CPU is affected by Microarchitectural data sampling */
 #define X86_BUG_MSBDS_ONLY		X86_BUG(20) /* CPU is only affected by the  MSDBS variant of BUG_MDS */
 #define X86_BUG_SWAPGS			X86_BUG(21) /* CPU is affected by speculation through SWAPGS */
+#define X86_BUG_TAA			X86_BUG(22) /* CPU is affected by TSX Async Abort(TAA) */
+#define X86_BUG_ITLB_MULTIHIT		X86_BUG(23) /* CPU may incur MCE during certain page attribute changes */
 
 #endif /* _ASM_X86_CPUFEATURES_H */
-- 
2.21.0

