Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22512C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 14:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 057FD20815
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 14:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbfJHOjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 10:39:05 -0400
Received: from mail.loongson.cn ([114.242.206.163]:43927 "EHLO
        mail.loongson.cn" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfJHOjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 10:39:05 -0400
Received: from linux.loongson.cn (unknown [10.20.41.27])
        by mail (Coremail) with SMTP id QMiowPDxv2CAn5xdu7sLAA--.72S2;
        Tue, 08 Oct 2019 22:38:56 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     paul.burton@mips.com, ralf@linux-mips.org, jhogan@kernel.org
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: generic: Use __initconst for const init data
Date:   Tue,  8 Oct 2019 22:38:53 +0800
Message-Id: <1570545533-12718-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: QMiowPDxv2CAn5xdu7sLAA--.72S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKw1rKrW8uryxGFWkuF15urg_yoWkCwb_uw
        s2yF18Gr1rCrWY9FsFvw15Ja4IkaySvF9rA34kKan8A3s3tF15Cw4q9r13Jry8WFZ0yry5
        JF4rXa45Cr17ujkaLaAFLSUrUUUUYb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb6AYjsxI4VW3JwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_JFC_Wr1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4
        A2jsIEc7CjxVAFwI0_GcCE3s1ln4kS14v26r1q6r43M2AIxVAIcxkEcVAq07x20xvEncxI
        r21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87
        Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7xvr2IY
        c2Ij64vIr40E4x8a64kEw24lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I
        8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jw0_GFylx2IqxVAqx4xG67AKxVWU
        JVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7V
        AKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j
        6r4UMIIF0xvE42xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIx
        AIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU51GQDUUUUU=
        =
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following checkpatch errors:

$ ./scripts/checkpatch.pl --no-tree -f arch/mips/generic/init.c
ERROR: Use of const init definition must use __initconst
+static __initdata const void *fdt;

ERROR: Use of const init definition must use __initconst
+static __initdata const struct mips_machine *mach;

ERROR: Use of const init definition must use __initconst
+static __initdata const void *mach_match_data;

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/mips/generic/init.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/generic/init.c b/arch/mips/generic/init.c
index d5b8c47..1de215b 100644
--- a/arch/mips/generic/init.c
+++ b/arch/mips/generic/init.c
@@ -20,9 +20,9 @@
 #include <asm/smp-ops.h>
 #include <asm/time.h>
 
-static __initdata const void *fdt;
-static __initdata const struct mips_machine *mach;
-static __initdata const void *mach_match_data;
+static __initconst const void *fdt;
+static __initconst const struct mips_machine *mach;
+static __initconst const void *mach_match_data;
 
 void __init prom_init(void)
 {
-- 
2.1.0


