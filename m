Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF51C32767
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 04:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0020C2071A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 04:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="oYMjMuac"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbgAFEcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 23:32:02 -0500
Received: from m15-114.126.com ([220.181.15.114]:56266 "EHLO m15-114.126.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727432AbgAFEcB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 23:32:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=cWQkz6qx21BS5TQBK7
        +VbOfvvvchtkcRVBlxJ7ItxpI=; b=oYMjMuacVpmXv0xRnkdTGU2dd/l+KHkrqk
        4dLwIRLBkG+NvsYIUp57IWUKRzR5wgcFzS2U9TUpLZ66Nl5BYciX7d1i/BA1JRB8
        D+scuBb9G1rduN+iR+NIEvV3oNt2tAKt98lM2kqLMv6XTYGjn916pTA6NM+14K+a
        TA/UL8jjQ=
Received: from yingjieb-VirtualBox.int.nokia-sbell.com (unknown [223.104.212.216])
        by smtp7 (Coremail) with SMTP id DsmowADHfD_ItxJeAqb_BA--.16223S3;
        Mon, 06 Jan 2020 12:30:20 +0800 (CST)
From:   yingjie_bai@126.com
To:     Scott Wood <oss@buserror.net>,
        Kumar Gala <galak@kernel.crashing.org>
Cc:     Bai Yingjie <byj.tea@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Jason Yan <yanaijie@huawei.com>,
        Diana Craciun <diana.craciun@nxp.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] powerpc/mpc85xx: also write addr_h to spin table for 64bit boot entry
Date:   Mon,  6 Jan 2020 12:29:54 +0800
Message-Id: <20200106042957.26494-2-yingjie_bai@126.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200106042957.26494-1-yingjie_bai@126.com>
References: <20200106042957.26494-1-yingjie_bai@126.com>
X-CM-TRANSID: DsmowADHfD_ItxJeAqb_BA--.16223S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7ArWfKr43Gw4UuFy5KryUKFg_yoW8Xr45pF
        ykGFnxtrZ5Kr1rZa12qF40grZ0yF4Sg3yjg347AasI93W3Xr9FyF4kZry3XF4kWrWDKFWr
        Zr4ayFZ0kwsrXa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jDL0nUUUUU=
X-Originating-IP: [223.104.212.216]
X-CM-SenderInfo: p1lqwyxlhbutbl6rjloofrz/1tbimRWc91pD-oMzJQACsX
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

Signed-off-by: Bai Yingjie <byj.tea@gmail.com>
---
 arch/powerpc/platforms/85xx/smp.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
index 8c7ea2486bc0..48f7d96ae37d 100644
--- a/arch/powerpc/platforms/85xx/smp.c
+++ b/arch/powerpc/platforms/85xx/smp.c
@@ -252,6 +252,15 @@ static int smp_85xx_start_cpu(int cpu)
 	out_be64((u64 *)(&spin_table->addr_h),
 		__pa(ppc_function_entry(generic_secondary_smp_init)));
 #else
+#ifdef CONFIG_PHYS_ADDR_T_64BIT
+	/*
+	 * We need also to write addr_h to spin table for systems
+	 * in which their physical memory start address was configured
+	 * to above 4G, otherwise the secondary core can not get
+	 * correct entry to start from.
+	 */
+	out_be32(&spin_table->addr_h, __pa(__early_start) >> 32);
+#endif
 	out_be32(&spin_table->addr_l, __pa(__early_start));
 #endif
 	flush_spin_table(spin_table);
-- 
2.17.1

