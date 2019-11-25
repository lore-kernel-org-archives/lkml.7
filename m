Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF12C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 15:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 211E120740
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 15:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="b/WZZMCD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728524AbfKYPSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 10:18:42 -0500
Received: from m15-112.126.com ([220.181.15.112]:53516 "EHLO m15-112.126.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727785AbfKYPSl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 10:18:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=5WrnMnd6SLO8+2ax4Q
        ZOP4APwycvcmz4bvINZCCXEKA=; b=b/WZZMCD66fo2YPdU5hzVY+kir06onvw0R
        BbCSjMmCubOW5ZKQgxmOTFtuCMQyQIJiPYtGWIicB0oHgliSn7HiWlre02p3C0xc
        0GLzPGYdcuG3iZoZP0P1phgcnQdHmla2bBzrHOE4HIZHszCEkntSHm1y8tvkLQjr
        PgXTruwt4=
Received: from localhost.localdomain (unknown [183.192.13.68])
        by smtp2 (Coremail) with SMTP id DMmowAA3o+B08NtdNlfzAQ--.21587S2;
        Mon, 25 Nov 2019 23:17:17 +0800 (CST)
From:   yingjie_bai@126.com
To:     Scott Wood <oss@buserror.net>,
        Kumar Gala <galak@kernel.crashing.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Bai Yingjie <byj.tea@gmail.com>
Subject: [PATCH] powerpc/mpc85xx: also write addr_h to spin table for 64bit boot entry
Date:   Mon, 25 Nov 2019 23:15:43 +0800
Message-Id: <1574694943-7883-1-git-send-email-yingjie_bai@126.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: DMmowAA3o+B08NtdNlfzAQ--.21587S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ArWfKryxWFWruF47Wr18AFb_yoW8XFykpa
        4xGrnxtrZ5Kr1rZa12yF4IgrZ0yFsxu3yUW347AasI93W3Xr9xAF4DZry3WF1kWrWqkFWr
        Zr4ayFyqyrsrWa7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07bn5rcUUUUU=
X-Originating-IP: [183.192.13.68]
X-CM-SenderInfo: p1lqwyxlhbutbl6rjloofrz/1tbipB1491pD-LHSuQAAsJ
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bai Yingjie <byj.tea@gmail.com>

CPU like P4080 has 36bit physical address, its DDR physical
start address can be configured above 4G by LAW registers.

For such systems in which their physical memory start address was
configured higher than 4G, we need also to write addr_h into the spin
table of the target secondary CPU, so that addr_h and addr_l together
represent a 64bit physical address.
Otherwise the secondary core can not get correct entry to start from.

This should do no harm for normal case where addr_h is all 0.

Signed-off-by: Bai Yingjie <byj.tea@gmail.com>
---
 arch/powerpc/platforms/85xx/smp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
index 8c7ea2486bc0..f12cdd1e80ff 100644
--- a/arch/powerpc/platforms/85xx/smp.c
+++ b/arch/powerpc/platforms/85xx/smp.c
@@ -252,6 +252,14 @@ static int smp_85xx_start_cpu(int cpu)
 	out_be64((u64 *)(&spin_table->addr_h),
 		__pa(ppc_function_entry(generic_secondary_smp_init)));
 #else
+	/*
+	 * We need also to write addr_h to spin table for systems
+	 * in which their physical memory start address was configured
+	 * to above 4G, otherwise the secondary core can not get
+	 * correct entry to start from.
+	 * This does no harm for normal case where addr_h is all 0.
+	 */
+	out_be32(&spin_table->addr_h, __pa(__early_start) >> 32);
 	out_be32(&spin_table->addr_l, __pa(__early_start));
 #endif
 	flush_spin_table(spin_table);
-- 
2.17.1

