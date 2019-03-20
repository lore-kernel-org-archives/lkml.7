Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC4C0C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 10:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9453B21850
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 10:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfCTKKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 06:10:55 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41718 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbfCTKKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 06:10:54 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: aratiu)
        with ESMTPSA id 16A2126C024
From:   Adrian Ratiu <adrian.ratiu@collabora.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] selftests/bpf: Add arm target register definitions
Date:   Wed, 20 Mar 2019 12:10:54 +0200
Message-Id: <20190320101054.1880-1-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

eBPF "restricted C" code can be compiled with LLVM/clang using target
triplets like armv7l-unknown-linux-gnueabihf and loaded/run with small
cross-compiled gobpf/elf [1] programs without requiring a full BCC
port which is also undesirable on small embedded systems due to its
size footprint. The only missing pieces are these helper macros which
otherwise have to be redefined by each eBPF arm program.

[1] https://github.com/iovisor/gobpf/tree/master/elf

Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 tools/testing/selftests/bpf/bpf_helpers.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_helpers.h b/tools/testing/selftests/bpf/bpf_helpers.h
index c81fc350f7ad..41f8a4b676a4 100644
--- a/tools/testing/selftests/bpf/bpf_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_helpers.h
@@ -274,6 +274,9 @@ static int (*bpf_skb_adjust_room)(void *ctx, __s32 len_diff, __u32 mode,
 #elif defined(__TARGET_ARCH_s930x)
 	#define bpf_target_s930x
 	#define bpf_target_defined
+#elif defined(__TARGET_ARCH_arm)
+	#define bpf_target_arm
+	#define bpf_target_defined
 #elif defined(__TARGET_ARCH_arm64)
 	#define bpf_target_arm64
 	#define bpf_target_defined
@@ -296,6 +299,8 @@ static int (*bpf_skb_adjust_room)(void *ctx, __s32 len_diff, __u32 mode,
 	#define bpf_target_x86
 #elif defined(__s390x__)
 	#define bpf_target_s930x
+#elif defined(__arm__)
+	#define bpf_target_arm
 #elif defined(__aarch64__)
 	#define bpf_target_arm64
 #elif defined(__mips__)
@@ -333,6 +338,19 @@ static int (*bpf_skb_adjust_room)(void *ctx, __s32 len_diff, __u32 mode,
 #define PT_REGS_SP(x) ((x)->gprs[15])
 #define PT_REGS_IP(x) ((x)->psw.addr)
 
+#elif defined(bpf_target_arm)
+
+#define PT_REGS_PARM1(x) ((x)->uregs[0])
+#define PT_REGS_PARM2(x) ((x)->uregs[1])
+#define PT_REGS_PARM3(x) ((x)->uregs[2])
+#define PT_REGS_PARM4(x) ((x)->uregs[3])
+#define PT_REGS_PARM5(x) ((x)->uregs[4])
+#define PT_REGS_RET(x) ((x)->uregs[14])
+#define PT_REGS_FP(x) ((x)->uregs[11]) /* Works only with CONFIG_FRAME_POINTER */
+#define PT_REGS_RC(x) ((x)->uregs[0])
+#define PT_REGS_SP(x) ((x)->uregs[13])
+#define PT_REGS_IP(x) ((x)->uregs[12])
+
 #elif defined(bpf_target_arm64)
 
 #define PT_REGS_PARM1(x) ((x)->regs[0])
-- 
2.21.0

