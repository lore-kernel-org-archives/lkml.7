Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 416BDC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05E0620643
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555612128;
	bh=zLI++sCPZGQ0OVaOT8taVqSvFLBfVMw3J5bK9CinC3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UCU2wkVTodcBCsoaUp0BlPptpeI7sFUb8cEd7WZqiSbeYHtZY0QHhiTLbduJvj07N
	 O/Q17C8MeoiLtllwPYXnQfv5GKefirwbqnc2d4E/Ke/oD7913LUorFnwkExpwCBOgT
	 ntu6Oiti+MVdn2i1I8jhAD+XdTz3Nb0s/1EMZ83o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391042AbfDRS2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:28:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:59682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390266AbfDRSDK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:03:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E81F721872;
        Thu, 18 Apr 2019 18:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610590;
        bh=zLI++sCPZGQ0OVaOT8taVqSvFLBfVMw3J5bK9CinC3g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RJOhh6Q588hF011LhyTO3AwOtFVw+3TZJUOR8gsowrVmk2tzddmdCiWv+DMjLxd4e
         9qSZkmUoiRFHUbY2wVTCyDWWyA4tN7Jf7ZFKL/KVJ4jKRxt/gxRva9qPTxSQxDss0q
         hJJVebkjjl90GqjhHRNZaH4CePa0EqnS+Xf6qwzc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 01/92] ARC: u-boot args: check that magic number is correct
Date:   Thu, 18 Apr 2019 19:56:19 +0200
Message-Id: <20190418160430.489483154@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160430.325165109@linuxfoundation.org>
References: <20190418160430.325165109@linuxfoundation.org>
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 709649e5f9bc..6b8d106e0d53 100644
--- a/arch/arc/kernel/setup.c
+++ b/arch/arc/kernel/setup.c
@@ -35,6 +35,7 @@ unsigned int intr_to_DE_cnt;
 
 /* Part of U-boot ABI: see head.S */
 int __initdata uboot_tag;
+int __initdata uboot_magic;
 char __initdata *uboot_arg;
 
 const struct machine_desc *machine_desc;
@@ -433,6 +434,8 @@ static inline bool uboot_arg_invalid(unsigned long addr)
 #define UBOOT_TAG_NONE		0
 #define UBOOT_TAG_CMDLINE	1
 #define UBOOT_TAG_DTB		2
+/* We always pass 0 as magic from U-boot */
+#define UBOOT_MAGIC_VALUE	0
 
 void __init handle_uboot_args(void)
 {
@@ -448,6 +451,11 @@ void __init handle_uboot_args(void)
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



