Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C975C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CA3A2087C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbfD0M4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 08:56:33 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:49175 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbfD0MxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 08:53:10 -0400
Received: from orion.localdomain ([77.2.90.210]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M72wZ-1hQgsG1F7v-008djg; Sat, 27 Apr 2019 14:52:35 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, andrew@aj.id.au,
        andriy.shevchenko@linux.intel.com, macro@linux-mips.org,
        vz@mleia.com, slemieux.tyco@gmail.com, khilman@baylibre.com,
        liviu.dudau@arm.com, sudeep.holla@arm.com,
        lorenzo.pieralisi@arm.com, davem@davemloft.net, jacmet@sunsite.dk,
        linux@prisktech.co.nz, matthias.bgg@gmail.com,
        linux-mips@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org
Subject: [PATCH 02/41] drivers: tty: serial: dz: include <linux/io.h> instead of <asm/io.h>
Date:   Sat, 27 Apr 2019 14:51:43 +0200
Message-Id: <1556369542-13247-3-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556369542-13247-1-git-send-email-info@metux.net>
References: <1556369542-13247-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:vWpyHvDheL6gbLjo3etBs2JZ/UueJUyOwv5jXuZL9y2wfL1t2Sz
 Q/+Nt5v3237WzwYwrkHtvh8CdRpqwPqpHpcjERpTIKU+EcAYTF+qBG0cw4jXtPhcJu5L1xP
 kkBztdWdJQKAWhxdJmybmuQlVUbgmAr1fvOkc6orv3ghX86g6ax2Ao2WppX1ubS4UHmC3BK
 omfMVJUQwR4EJT11yTj+A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PWTU6h30wog=:g3KXzB9M32PW8Kl8vCIU73
 qJ8Hw/X5UhMxHr5PXZ5NJLP8zF+n5L1AYhbxdz0HkWq3pRijKJD3ZZgMPMXT5AC0MCjgTwTnG
 BKB6ehulTwMDvn0rk/0UWp57hVY8n65jpID29G2/RtuijyesvETIRsoOmsEDDklXWWrpv6Hvq
 J5ApyjRxjwebOu+2DLtzw/iHyVZjoSBSJ3tfl+uRrcbirei0rvO8pIPPAp9hShgt6wvsRCnWy
 69Nm4xD9n73QNYwZz1WgLz31zuE/AXQbiEv14NTsptf7xQB3TMb47qEcLeEIXQttLDlssfrUu
 sUnzAbwiXa9qXMynpyfRG2WmHpKy3Sb57NCyp79kJVZNqzTeWy5rJ580LJtiNOnKV5l0NEl4P
 ft43B9g3QEw0dE2RA1G9sPuGJvuILiXEPeqUqYjhTT+UmVrLG83+OrotnH1YPjhkzWg9WZGyl
 ZsMxaVC5zUJY8olqHlPJl3lfAv4fxzGIBE75jKtOJwB61iyMmTGCbLZT9aUnRGj+9CHDKLe70
 r7+eZMXeXJ9eT1W7HDMQibFCPL6QSTKhCVVawhfq7GZkd2tcZx4GWCO7RGRNgouXD8JVSy7qz
 m5Wbs2AH+EWnYtwKwE+ERMHMsz/tgMtlUXwgbizNPnSQPzD9LYY+Bqrq0DeP+AXy3VjT0jaZn
 /zPlxBehxOKrsnCjM3aDW+YERQBO5njRt7YPdL+ImY78ofqqhgs0vMjuBK7/voIREnYQyHmyR
 QiZRIDUO7YShRpDwljxwkZ//0pWuawyNDeyJ3w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fixing checkpatch warning:

  WARNING: Use #include <linux/io.h> instead of <asm/io.h>
  #55: FILE: dz.c:55:
  +#include <asm/io.h>

Signed-off-by: Enrico Weigelt <info@metux.net>
---
 drivers/tty/serial/dz.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/dz.c b/drivers/tty/serial/dz.c
index 96e35af..fd4f0cc 100644
--- a/drivers/tty/serial/dz.c
+++ b/drivers/tty/serial/dz.c
@@ -52,7 +52,7 @@
 
 #include <linux/atomic.h>
 #include <asm/bootinfo.h>
-#include <asm/io.h>
+#include <linux/io.h>
 
 #include <asm/dec/interrupts.h>
 #include <asm/dec/kn01.h>
-- 
1.9.1

