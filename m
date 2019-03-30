Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B35FC4360F
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E169206DD
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553907052;
	bh=fpdcRjayh6oL3S9Dpm1LRC1Q8PZ9WXwm+cSMuiSVaew=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=xBZqh+Bys+zm5gMdmB5dmjT0RDW04jMLnc8FllBAjYYg1pkEzSX7Nh1pzl5Vy/qBJ
	 /1FnU3NH+gi3GBXqkCh7ZcWRb2+sC60hHxxhzKVG6BmjrRkvzeHk7LHHIT7BRz8k8h
	 qFK4DdNBNvj2Sbg5YKC0csodW4BqNdfzHLLA7sPM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730416AbfC3Auu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 20:50:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:57400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730162AbfC3Auu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 20:50:50 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 119C8206DD;
        Sat, 30 Mar 2019 00:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553907049;
        bh=fpdcRjayh6oL3S9Dpm1LRC1Q8PZ9WXwm+cSMuiSVaew=;
        h=From:To:Cc:Subject:Date:From;
        b=GmYy6iKdSbtLFXMv1cxo1+CkZDGyIa2usOsli3OlRBuwK/bY5MB7U1UiMfMRfKLHZ
         +b9k2R4Ne56UsurGDq4GJmpZvHiTCqBDMguHVxABlgvoftrG8HnztL7Yo0Yxynq0av
         Z8BI2YSbpF9mBYofecgk2ueWuQ9YCYpt5RhAthPI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 01/67] ARC: u-boot args: check that magic number is correct
Date:   Fri, 29 Mar 2019 20:49:41 -0400
Message-Id: <20190330005047.25998-1-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>

[ Upstream commit edb64bca50cd736c6894cc6081d5263c007ce005 ]

In case of devboards we really often disable bootloader and load
Linux image in memory via JTAG. Even if kernel tries to verify
uboot_tag and uboot_arg there is sill a chance that we treat some
garbage in registers as valid u-boot arguments in JTAG case.
E.g. it is enough to have '1' in r0 to treat any value in r2 as
a boot command line.

So check that magic number passed from u-boot is correct and drop
u-boot arguments otherwise. That helps to reduce the possibility
of using garbage as u-boot arguments in JTAG case.

We can safely check U-boot magic value (0x0) in linux passed via
r1 register as U-boot pass it from the beginning. So there is no
backward-compatibility issues.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arc/kernel/head.S  | 1 +
 arch/arc/kernel/setup.c | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/arch/arc/kernel/head.S b/arch/arc/kernel/head.S
index 30e090625916..a72bbda2f7aa 100644
--- a/arch/arc/kernel/head.S
+++ b/arch/arc/kernel/head.S
@@ -106,6 +106,7 @@ ENTRY(stext)
 	;    r2 = pointer to uboot provided cmdline or external DTB in mem
 	; These are handled later in handle_uboot_args()
 	st	r0, [@uboot_tag]
+	st      r1, [@uboot_magic]
 	st	r2, [@uboot_arg]
 
 	; setup "current" tsk and optionally cache it in dedicated r25
diff --git a/arch/arc/kernel/setup.c b/arch/arc/kernel/setup.c
index 7b2340996cf8..7b3a7b3b380c 100644
--- a/arch/arc/kernel/setup.c
+++ b/arch/arc/kernel/setup.c
@@ -36,6 +36,7 @@ unsigned int intr_to_DE_cnt;
 
 /* Part of U-boot ABI: see head.S */
 int __initdata uboot_tag;
+int __initdata uboot_magic;
 char __initdata *uboot_arg;
 
 const struct machine_desc *machine_desc;
@@ -497,6 +498,8 @@ static inline bool uboot_arg_invalid(unsigned long addr)
 #define UBOOT_TAG_NONE		0
 #define UBOOT_TAG_CMDLINE	1
 #define UBOOT_TAG_DTB		2
+/* We always pass 0 as magic from U-boot */
+#define UBOOT_MAGIC_VALUE	0
 
 void __init handle_uboot_args(void)
 {
@@ -511,6 +514,11 @@ void __init handle_uboot_args(void)
 		goto ignore_uboot_args;
 	}
 
+	if (uboot_magic != UBOOT_MAGIC_VALUE) {
+		pr_warn(IGNORE_ARGS "non zero uboot magic\n");
+		goto ignore_uboot_args;
+	}
+
 	if (uboot_tag != UBOOT_TAG_NONE &&
             uboot_arg_invalid((unsigned long)uboot_arg)) {
 		pr_warn(IGNORE_ARGS "invalid uboot arg: '%px'\n", uboot_arg);
-- 
2.19.1

