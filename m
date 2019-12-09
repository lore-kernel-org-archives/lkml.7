Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FB1C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 10:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45947206D5
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 10:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=iluvatar.ai header.i=@iluvatar.ai header.b="F3HhOdnr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbfLIKAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 05:00:06 -0500
Received: from owa.iluvatar.ai ([103.91.158.24]:16133 "EHLO smg.iluvatar.ai"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727200AbfLIKAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 05:00:06 -0500
X-Greylist: delayed 901 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Dec 2019 05:00:04 EST
X-AuditID: 0a650161-78bff700000078a3-9f-5dee2de096fb
Received: from owa.iluvatar.ai (s-10-101-1-102.iluvatar.local [10.101.1.102])
        by smg.iluvatar.ai (Symantec Messaging Gateway) with SMTP id 7B.F0.30883.0ED2EED5; Mon,  9 Dec 2019 19:20:00 +0800 (HKT)
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=iluvatar.ai; s=key_2018;
        c=relaxed/relaxed; t=1575884707; h=from:subject:to:date:message-id;
        bh=4XY6KZy5NFgqtGCerKi26yFsh/3MiJ6OzvRR3Z9dvrw=;
        b=F3HhOdnrOFHJ8EUYcI6dCcUMs7jE6v9RPJHfkluSmPDlJdvhE52A0KDst39yd9GhXefhAyENZtK
        Kwg5vNp32vDRDm+xPvY3oUS+BLPha5JVUM8oF6fUGQZS3L+eZP6HgfkkkNUJjxpKJEuHZec8Axclt
        yLUCLplrfBkOxIQoQco=
Received: from hsj-Precision-5520.iluvatar.local (10.101.199.253) by
 S-10-101-1-102.iluvatar.local (10.101.1.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1415.2; Mon, 9 Dec 2019 17:45:07 +0800
From:   Huang Shijie <sjhuang@iluvatar.ai>
To:     <jbaron@akamai.com>
CC:     <linux-kernel@vger.kernel.org>, <1537577747@qq.com>,
        Huang Shijie <sjhuang@iluvatar.ai>
Subject: [PATCH] lib/dynamic_debug: make better dynamic log output
Date:   Mon, 9 Dec 2019 17:44:37 +0800
Message-ID: <20191209094437.14866-1-sjhuang@iluvatar.ai>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.101.199.253]
X-ClientProxiedBy: S-10-101-1-102.iluvatar.local (10.101.1.102) To
 S-10-101-1-102.iluvatar.local (10.101.1.102)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJLMWRmVeSWpSXmKPExsXClcqYpvtA912sQXeHscXkqwfYLGYsPs5q
        cXnXHDYHZo/JRxYwe9x6tpbV4/MmuQDmKC6blNSczLLUIn27BK6M9ubcghdsFat67jA2MJ5m
        7WLk4JAQMJFo+lzQxcjFISRwglHi2NtHbF2MnBzMAhISB1+8YAZJsAi8ZZLYeXQ3K0RVK5PE
        xBU3mECq2AQ0JOaeuMsMMklEQFzi/XxXiOZYibld+8DCwgJOEnv3RoCEWQRUJBb+OcgCYvMK
        WEgs37CAGcSWEJCXWL3hADNEXFDi5MwnLCCtQgIKEi9WakGUKEks2TuLCcIulPj+8i7LBEaB
        WUgunYWkewEj0ypG/uLcdL3MnNKyxJLEIr3EzE2MkPBL3MF4o/Ol3iFGAQ5GJR7eCYFvY4VY
        E8uKK3MPMUpwMCuJ8C6Z+CpWiDclsbIqtSg/vqg0J7X4EKM0B4uSOK/Qv6cxQgLpiSWp2amp
        BalFMFkmDk6pBqapbo3Vs7r8Ofw6Yp6GGUrN+rDkptTd5c6bL6Uf5Jy+a/2+VWJTsk1WPUu/
        xdCy1u1bE5NyetHs+IvcvdOUfmfmX6z6v3Yv0+/arODc3fzR/ruzandZ2IUaHGQsEUlyDDz7
        MZqF9elplUvs86M+ZXKzvDArDG9d8PdTTabuvg+BO+Nbo52SF69fenzKBZtI8XsbXJR7r+lX
        GOjM+SzL5rPk0qq9VitsHWb/ttC1K1PMtgoyU7I9FvRbIvTz1euncpuXvdS8Hphyeu6eM9Ui
        DApJ3o+Llhls7V0RO11qnt+M5PVT1J3EDE6fFuK6ca5e6NfkXCbBKe92aR1YNlvPJKnH48k5
        cZZz1aam33cnRyixFGckGmoxFxUnAgB4aCFhvAIAAA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver strings and device name is not changed for the driver's dynamic
log output. But the dynamic_emit_prefix() which contains the function names
may changed when the function names are changed.

So the patch makes the better dynamic log output.

Signed-off-by: Huang Shijie <sjhuang@iluvatar.ai>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index c60409138e13..8cfcdd5bd1ff 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -590,8 +590,8 @@ void __dynamic_dev_dbg(struct _ddebug *descriptor,
 		char buf[PREFIX_SIZE];
 
 		dev_printk_emit(LOGLEVEL_DEBUG, dev, "%s%s %s: %pV",
-				dynamic_emit_prefix(descriptor, buf),
 				dev_driver_string(dev), dev_name(dev),
+				dynamic_emit_prefix(descriptor, buf),
 				&vaf);
 	}
 
-- 
2.17.1

