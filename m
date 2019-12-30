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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34643C2D0C3
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 07:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 076A22071E
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 07:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="Y4yWol+a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbfL3H3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 02:29:50 -0500
Received: from m15-112.126.com ([220.181.15.112]:49580 "EHLO m15-112.126.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727162AbfL3H3u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 02:29:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=wKGzF3TmELm4mnLJnq
        TJbcvIyjvMxvdD5NnLsPiVBtg=; b=Y4yWol+aivCF2e7svS2KjVL0SXWordsENL
        ete8ATU/F6K6DtVXsnL0nD3D/SwSnAess+BtpnVj3lx/6ReMQQgWAI/rwNaJ2aTP
        Zvvp9XnBLaw6oN+CXIsQCZpx7UFrre9RR1GGaVPx+xVvEwQhLj/0dwGsPIrRg9T1
        heFoU9nR8=
Received: from yingjieb-VirtualBox.int.nokia-sbell.com (unknown [114.87.110.56])
        by smtp2 (Coremail) with SMTP id DMmowADX+Zmnpgle0BNJBA--.64926S2;
        Mon, 30 Dec 2019 15:26:41 +0800 (CST)
From:   yingjie_bai@126.com
To:     Scott Wood <oss@buserror.net>,
        Kumar Gala <galak@kernel.crashing.org>
Cc:     Bai Yingjie <byj.tea@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Diana Craciun <diana.craciun@nxp.com>,
        Jason Yan <yanaijie@huawei.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] powerpc32/booke: consistently return phys_addr_t in __pa()
Date:   Mon, 30 Dec 2019 15:26:19 +0800
Message-Id: <20191230072623.25353-1-yingjie_bai@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: DMmowADX+Zmnpgle0BNJBA--.64926S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gr48uFy7Zw13AFWfJw47Arb_yoWkGFbEya
        s7Aa1kurs5Wr97urnFya48Jr1DJa48GFn09F1xuw17AF4UA3W5Cws7t34kArs8ursrCrZx
        uFW0q343KF92kjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0pnQUUUUUU==
X-Originating-IP: [114.87.110.56]
X-CM-SenderInfo: p1lqwyxlhbutbl6rjloofrz/1tbirxGb91pD8ekldgAAsA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bai Yingjie <byj.tea@gmail.com>

When CONFIG_RELOCATABLE=y is set, VIRT_PHYS_OFFSET is a 64bit variable,
thus __pa() returns as 64bit value.
But when CONFIG_RELOCATABLE=n, __pa() returns 32bit value.

We'd make __pa() consistently return phys_addr_t, even if the upper bits
are known to always be zero in a particular config.

Signed-off-by: Bai Yingjie <byj.tea@gmail.com>
---
 arch/powerpc/include/asm/page.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index 7f1fd41e3065..86332080399a 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -209,7 +209,7 @@ static inline bool pfn_valid(unsigned long pfn)
  */
 #if defined(CONFIG_PPC32) && defined(CONFIG_BOOKE)
 #define __va(x) ((void *)(unsigned long)((phys_addr_t)(x) + VIRT_PHYS_OFFSET))
-#define __pa(x) ((unsigned long)(x) - VIRT_PHYS_OFFSET)
+#define __pa(x) ((phys_addr_t)(unsigned long)(x) - VIRT_PHYS_OFFSET)
 #else
 #ifdef CONFIG_PPC64
 /*
-- 
2.17.1

