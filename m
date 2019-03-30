Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E4DC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A6802064A
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553907710;
	bh=nLkVCSkqSD/JAwyRnGT/TobpeTGPIsvP9H2N1/Bfgbk=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=x9oj9W7BoZ+5BAiIQ7TSMUuEdJAww5tt1cdtkESCAbQsv2v4Mooo0lpXOlhEpxml4
	 pNl2lKa9HTETXtMtQfbvIC+HGSc09UXj5PhW1BqZUI4Gp+CN3GFY018Yopz3GHVZ1p
	 9cyWY0IZ/DBj5imWMYqOKrYMcT03A9YG5BUjQn1w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731883AbfC3A4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 20:56:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:35358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731280AbfC3Az6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 20:55:58 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0206F2064A;
        Sat, 30 Mar 2019 00:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553907357;
        bh=nLkVCSkqSD/JAwyRnGT/TobpeTGPIsvP9H2N1/Bfgbk=;
        h=From:To:Cc:Subject:Date:From;
        b=YeQ4IwRdwG+kca7ux57e/Y33Uw7oKc041Eo2cmj+s6jZlBe58y6V5E1Ob4bnoEiiZ
         cCRRh/+Sw4kEqgX5o3KhbIlFrYwHbuQDnXI7RwLoKjUnip3WcdEBaqmtOSVPYyUYNA
         hNcGnRP9/eoC0r6U1j4XyZ9npDOBh4GU5HZEsLx0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-snps-arc@lists.infradead.org
Subject: [PATCH AUTOSEL 4.9 01/27] ARC: u-boot args: check that magic number is correct
Date:   Fri, 29 Mar 2019 20:55:27 -0400
Message-Id: <20190330005555.28087-1-sashal@kernel.org>
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
index 1f945d0f40da..208bf2c9e7b0 100644
--- a/arch/arc/kernel/head.S
+++ b/arch/arc/kernel/head.S
@@ -107,6 +107,7 @@ ENTRY(stext)
 	;    r2 = pointer to uboot provided cmdline or external DTB in mem
 	; These are handled later in handle_uboot_args()
 	st	r0, [@uboot_tag]
+	st      r1, [@uboot_magic]
 	st	r2, [@uboot_arg]
 #endif
 
diff --git a/arch/arc/kernel/setup.c b/arch/arc/kernel/setup.c
index 9119bea503a7..9f96120eee6e 100644
--- a/arch/arc/kernel/setup.c
+++ b/arch/arc/kernel/setup.c
@@ -32,6 +32,7 @@ unsigned int intr_to_DE_cnt;
 
 /* Part of U-boot ABI: see head.S */
 int __initdata uboot_tag;
+int __initdata uboot_magic;
 char __initdata *uboot_arg;
 
 const struct machine_desc *machine_desc;
@@ -400,6 +401,8 @@ static inline bool uboot_arg_invalid(unsigned long addr)
 #define UBOOT_TAG_NONE		0
 #define UBOOT_TAG_CMDLINE	1
 #define UBOOT_TAG_DTB		2
+/* We always pass 0 as magic from U-boot */
+#define UBOOT_MAGIC_VALUE	0
 
 void __init handle_uboot_args(void)
 {
@@ -415,6 +418,11 @@ void __init handle_uboot_args(void)
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

