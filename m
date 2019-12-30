Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87072C2D0C3
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 07:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B1A92071E
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 07:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="VD5hLato"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfL3H3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 02:29:46 -0500
Received: from m15-112.126.com ([220.181.15.112]:49581 "EHLO m15-112.126.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727140AbfL3H3q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 02:29:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=vU+RIQU99tLLOuwhH/
        qRLw9WA7dqokBIOu2WkzLFIto=; b=VD5hLato0ACBgrDwX1+zpd3lqPhlvDC3X+
        090iFO+ua8DcuvpwwcEn5FRlm9RfQZOt1U2wdKWGdNFourdBDd7P+S4FvbLoRdq4
        dMpHJa9nVnrCpDRQ5tVK+CNu4WxWEBgulgsVu5xww24PrKNsroWSChg9yFPTF20D
        PkJQ0P/nQ=
Received: from yingjieb-VirtualBox.int.nokia-sbell.com (unknown [114.87.110.56])
        by smtp2 (Coremail) with SMTP id DMmowADX+Zmnpgle0BNJBA--.64926S3;
        Mon, 30 Dec 2019 15:26:47 +0800 (CST)
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
        Thomas Gleixner <tglx@linutronix.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] powerpc/mpc85xx: also write addr_h to spin table for 64bit boot entry
Date:   Mon, 30 Dec 2019 15:26:20 +0800
Message-Id: <20191230072623.25353-2-yingjie_bai@126.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191230072623.25353-1-yingjie_bai@126.com>
References: <20191230072623.25353-1-yingjie_bai@126.com>
X-CM-TRANSID: DMmowADX+Zmnpgle0BNJBA--.64926S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7ArWfKr43Xr43ArW5JFy8AFb_yoW8Xry8pF
        ykGrnxtrZ5Kr1rAa17JF4IgrZ0yFsIg3yUW347AasI93W3Xr9FyF4DZry3XF4kWrWqkFyr
        Zr4ayF1qyrsrWa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jmiifUUUUU=
X-Originating-IP: [114.87.110.56]
X-CM-SenderInfo: p1lqwyxlhbutbl6rjloofrz/1tbigReb91pD-Gt1SwAAsK
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
 arch/powerpc/platforms/85xx/smp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
index 8c7ea2486bc0..e241516ae013 100644
--- a/arch/powerpc/platforms/85xx/smp.c
+++ b/arch/powerpc/platforms/85xx/smp.c
@@ -252,6 +252,13 @@ static int smp_85xx_start_cpu(int cpu)
 	out_be64((u64 *)(&spin_table->addr_h),
 		__pa(ppc_function_entry(generic_secondary_smp_init)));
 #else
+	/*
+	 * We need also to write addr_h to spin table for systems
+	 * in which their physical memory start address was configured
+	 * to above 4G, otherwise the secondary core can not get
+	 * correct entry to start from.
+	 */
+	out_be32(&spin_table->addr_h, __pa(__early_start) >> 32);
 	out_be32(&spin_table->addr_l, __pa(__early_start));
 #endif
 	flush_spin_table(spin_table);
-- 
2.17.1

