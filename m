Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B844C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBFCC2087C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555353994;
	bh=qSU1JFafiex7WrACYNvmwOpa6VwgG/nKSFa0Vi9mmZ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F9/Zhq7qNeYhK30gu6YsWRij0lUfA1NofF6GaQW69gP38zRof+vYz06NOwhQurwtW
	 JTogo7HAnqhrTbrTn2UGBLsKXthmH6bt201x7IgN6CtIGYl21VuuR7FLaeb4IXiV/2
	 tlTOgfvk7XRSLBlnn18pmwtqbC44w8cjRvhpzBp8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbfDOSqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 14:46:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:49232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728618AbfDOSqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 14:46:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0388218D3;
        Mon, 15 Apr 2019 18:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555353990;
        bh=qSU1JFafiex7WrACYNvmwOpa6VwgG/nKSFa0Vi9mmZ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KYrROF/7ckKh3vL8/yPrgig3a7zAurJy8T6lhU5pfcd1PJgz8f9W5igzdcylVWlnR
         NuMkUG256u0Su81/W8ApJCqfxyGTFF0gEnrphuGOmCnudNO6ZdUlLQWM07oqA4ilzZ
         FtqENaX4LqavYXydarljcAM8rODY0Oa+bCEBuvYQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 30/76] powerpc/pseries: Query hypervisor for count cache flush settings
Date:   Mon, 15 Apr 2019 20:43:54 +0200
Message-Id: <20190415183715.494619540@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183707.712011689@linuxfoundation.org>
References: <20190415183707.712011689@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit ba72dc171954b782a79d25e0f4b3ed91090c3b1e upstream.

Use the existing hypercall to determine the appropriate settings for
the count cache flush, and then call the generic powerpc code to set
it up based on the security feature flags.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/include/asm/hvcall.h      | 2 ++
 arch/powerpc/platforms/pseries/setup.c | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
index 9d978102bf0d..9587d301db55 100644
--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -316,10 +316,12 @@
 #define H_CPU_CHAR_BRANCH_HINTS_HONORED	(1ull << 58) // IBM bit 5
 #define H_CPU_CHAR_THREAD_RECONFIG_CTRL	(1ull << 57) // IBM bit 6
 #define H_CPU_CHAR_COUNT_CACHE_DISABLED	(1ull << 56) // IBM bit 7
+#define H_CPU_CHAR_BCCTR_FLUSH_ASSIST	(1ull << 54) // IBM bit 9
 
 #define H_CPU_BEHAV_FAVOUR_SECURITY	(1ull << 63) // IBM bit 0
 #define H_CPU_BEHAV_L1D_FLUSH_PR	(1ull << 62) // IBM bit 1
 #define H_CPU_BEHAV_BNDS_CHK_SPEC_BAR	(1ull << 61) // IBM bit 2
+#define H_CPU_BEHAV_FLUSH_COUNT_CACHE	(1ull << 58) // IBM bit 5
 
 #ifndef __ASSEMBLY__
 #include <linux/types.h>
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 91ade7755823..adb09ab87f7c 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -475,6 +475,12 @@ static void init_cpu_char_feature_flags(struct h_cpu_char_result *result)
 	if (result->character & H_CPU_CHAR_COUNT_CACHE_DISABLED)
 		security_ftr_set(SEC_FTR_COUNT_CACHE_DISABLED);
 
+	if (result->character & H_CPU_CHAR_BCCTR_FLUSH_ASSIST)
+		security_ftr_set(SEC_FTR_BCCTR_FLUSH_ASSIST);
+
+	if (result->behaviour & H_CPU_BEHAV_FLUSH_COUNT_CACHE)
+		security_ftr_set(SEC_FTR_FLUSH_COUNT_CACHE);
+
 	/*
 	 * The features below are enabled by default, so we instead look to see
 	 * if firmware has *disabled* them, and clear them if so.
@@ -525,6 +531,7 @@ void pseries_setup_rfi_flush(void)
 		 security_ftr_enabled(SEC_FTR_L1D_FLUSH_PR);
 
 	setup_rfi_flush(types, enable);
+	setup_count_cache_flush();
 }
 
 static void __init pSeries_setup_arch(void)
-- 
2.19.1



