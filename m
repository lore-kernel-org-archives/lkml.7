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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4857C32771
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 04:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 996F42071A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 04:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="Yf4wf6+a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbgAFEcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 23:32:05 -0500
Received: from m15-114.126.com ([220.181.15.114]:56267 "EHLO m15-114.126.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727446AbgAFEcC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 23:32:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=qdq1RXBhcHvJu8+kiJ
        YoTY6cikTHn4SeTY2dHZs3ha4=; b=Yf4wf6+aaZCi5sW2Z6AuXYOt69+vhGw1lR
        Gsrx3dh7q5BV3zEDviM3bZrHpJW5R76swlb8xDm7T0teST5ZkbV4OS/suN17a1ub
        YKXw0LkUiyxLEwZ94736BCRS2etIM8Oz32C3jxD30558Lq6h3gX5cqlr6kemg09d
        lZgSvHUZc=
Received: from yingjieb-VirtualBox.int.nokia-sbell.com (unknown [223.104.212.216])
        by smtp7 (Coremail) with SMTP id DsmowADHfD_ItxJeAqb_BA--.16223S2;
        Mon, 06 Jan 2020 12:30:13 +0800 (CST)
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
        Nicholas Piggin <npiggin@gmail.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] powerpc32/booke: consistently return phys_addr_t in __pa()
Date:   Mon,  6 Jan 2020 12:29:53 +0800
Message-Id: <20200106042957.26494-1-yingjie_bai@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: DsmowADHfD_ItxJeAqb_BA--.16223S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gr48uF43Kr1xZF4xAFWxXrb_yoWkKFcEya
        ykCa1vgrs5Wr97u3ZFya4rXwnrAr95CFn0ga4fuw17AF4UCF1UCwn7tw1kAws8CrsrCrZx
        uFW0q343Kas2kjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU86nQUUUUUU==
X-Originating-IP: [223.104.212.216]
X-CM-SenderInfo: p1lqwyxlhbutbl6rjloofrz/1tbimRWc91pD-oMzJQABsU
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bai Yingjie <byj.tea@gmail.com>

When CONFIG_RELOCATABLE=y is set, VIRT_PHYS_OFFSET is a 64bit variable,
thus __pa() returns as 64bit value.
But when CONFIG_RELOCATABLE=n, __pa() returns 32bit value.

When CONFIG_PHYS_64BIT is set, __pa() should consistently return as
64bit value irrelevant to CONFIG_RELOCATABLE.
So we'd make __pa() consistently return phys_addr_t, which is 64bit
when CONFIG_PHYS_64BIT is set.

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

