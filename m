Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB5DC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 13:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9313420850
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 13:55:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732229AbfDJNzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 09:55:48 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6143 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730195AbfDJNzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 09:55:47 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A4B40962C441F931E2CE;
        Wed, 10 Apr 2019 21:55:43 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.408.0; Wed, 10 Apr 2019
 21:55:32 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <paul.burton@mips.com>, <ralf@linux-mips.org>, <jhogan@kernel.org>,
        <ast@kernel.org>, <daniel@iogearbox.net>, <kafai@fb.com>,
        <songliubraving@fb.com>, <yhs@fb.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mips@vger.kernel.org>,
        <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] MIPS: eBPF: Make ebpf_to_mips_reg() static
Date:   Wed, 10 Apr 2019 21:49:23 +0800
Message-ID: <20190410134923.35100-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

Fix sparse warning:

arch/mips/net/ebpf_jit.c:196:5: warning:
 symbol 'ebpf_to_mips_reg' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 arch/mips/net/ebpf_jit.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/mips/net/ebpf_jit.c b/arch/mips/net/ebpf_jit.c
index 3548a69..dfd5a4b 100644
--- a/arch/mips/net/ebpf_jit.c
+++ b/arch/mips/net/ebpf_jit.c
@@ -193,8 +193,9 @@ enum which_ebpf_reg {
  * separate frame pointer, so BPF_REG_10 relative accesses are
  * adjusted to be $sp relative.
  */
-int ebpf_to_mips_reg(struct jit_ctx *ctx, const struct bpf_insn *insn,
-		     enum which_ebpf_reg w)
+static int ebpf_to_mips_reg(struct jit_ctx *ctx,
+			    const struct bpf_insn *insn,
+			    enum which_ebpf_reg w)
 {
 	int ebpf_reg = (w == src_reg || w == src_reg_no_fp) ?
 		insn->src_reg : insn->dst_reg;
-- 
2.7.4


