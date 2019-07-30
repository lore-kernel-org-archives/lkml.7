Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3272C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 19:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ED8D2067D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 19:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729400AbfG3T30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 15:29:26 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:51295 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727169AbfG3T3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 15:29:25 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N63i4-1iPTqd44Km-016M4N; Tue, 30 Jul 2019 21:26:44 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: [PATCH v5 01/29] fix compat handling of FICLONERANGE, FIDEDUPERANGE and FS_IOC_FIEMAP
Date:   Tue, 30 Jul 2019 21:25:12 +0200
Message-Id: <20190730192552.4014288-2-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190730192552.4014288-1-arnd@arndb.de>
References: <20190730192552.4014288-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:qXlr0d++2tj+pUFKeftKl2b9BAfEzIV3K/6V1jGgO84qalNDcjH
 wcCAJdjvc9xpj3/KOMCBEBqHuh+hgqGHN2PClurDOIfZPLAtN39bciMqT5Od9PdfywyWZ5A
 c2Vc62ISn+PYhK6YrkwChE2ndNdQXTs+Epe3KbFPLlc/f6zSCUJyhRKppzyByJ32xTPHgcs
 m4jv16XTipzzRDwyK4fjQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:R4vNWzY+q/k=:yTSOyq6A0kE9G8v6NREzxV
 nfh0DkcjUdtiwsYrz17bzXoYRz/QfCCnAIj/ju417izpnJQ0mfLiF7wGKYYcIuL5d9I0A1VF7
 7bsI3H7Yo2tA7k+u0nUGtcUZPn36WdOeGZB5w1TNO7Cfv00mHSZ/CjsG7184gJYfz7o7Jc3Et
 gpk6ROSYbSx2QmCaJRP9+QWCQjRumCNPrI08bb0C/ugS/YsKOYqlD3HZVMiLodZGMEyWe0FPu
 IbAjnGqIArJRP4HYbarSNF9uEYsk6baDoP+mH0u1LINvgo0BQFTlAWGFDykgI2IlMlkX7l3u6
 3F235Ys5+2YemeLYnAlyXFMfE9EJuX7sl7YDxpV0s0PFNBpexTuAsKqBXayVwIv4dS/4kQAhX
 e7gat5ch5vSF4i089Ihzq1t7E3vspLofC7AmmltXOQEnWwWwanZh5j4L5LLn581ao8rB0tKU9
 UPNiEfd2MQQi4LeSuhcEEmdv2KneMf1WGhN2ApXTQLz8+Fjhi8hiO263eaFii950OocJd6aWP
 5UvThB78l1KCn6/mNr3MYXomwpcS81p6+LCgQlWjv5Me5UZVtk2dz3AEp+PS3pwBFL8LVHHOe
 tS7Jx4qKzvhYmuOUEgtiphYe3+Ak7JqwhYRNhtdekpW7cbW6PKzjs/xHpiGrP8uo+/pvF6/KD
 vSOs2gw20zh926HOU6ajHEKTNAGAbqTvAiPgK2AOgDenXTNihUn/tUEj7onAtVH74FwtUUyRJ
 6Wq/TAKxWvrMt56qQ310LCGGl65D3I56dqe0VA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Unlike FICLONE, all of those take a pointer argument; they do need
compat_ptr() applied to arg.

Fixes: d79bdd52d8be7 54dbc15172375 ceac204e1da94
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/compat_ioctl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index 6e30949d9f77..31104486fc8b 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -1035,10 +1035,11 @@ COMPAT_SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd,
 #endif
 
 	case FICLONE:
+		goto do_ioctl;
 	case FICLONERANGE:
 	case FIDEDUPERANGE:
 	case FS_IOC_FIEMAP:
-		goto do_ioctl;
+		goto found_handler;
 
 	case FIBMAP:
 	case FIGETBSZ:
-- 
2.20.0

