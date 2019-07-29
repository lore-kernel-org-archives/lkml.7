Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F50C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 00:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 739542070D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 00:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="pYgV+stV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbfG2AaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 20:30:12 -0400
Received: from gateway20.websitewelcome.com ([192.185.64.36]:42435 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726238AbfG2AaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 20:30:11 -0400
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 021BE400C50D0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 18:26:45 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id rtYJhREQc4FKprtYJhbCEM; Sun, 28 Jul 2019 19:30:11 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=aUbewr3BJ25RAJjku2qXb/TH5xCdAT0sVUaiISEs7mo=; b=pYgV+stVXPILhGH4w0k4qGwUnR
        4nlSLwBNHczmz2/c82+w2d1UN5+F4R+mvodG+ethfvGkbqy9cFvMtKThlCAL5is7Gcm1Q6Ao4mmb8
        T15EHgbA0JuMpRdzixbm/wqL6WHztR3TMZI76YRfOyvU1cWY9GwzbavRg7Z1sq34etrZkrUn2kAlO
        kIyrjUyGRGZs6qFkH2rekdT8Uarq5awmYZQ5Ph90Op27n8SzYJ+DgK25z3Hq7rMRnmEiywPY3i9tx
        ccnGS2s/iYXmqQBpIm/Qdz8IlA0atPUfSTwHYPT2T2ThQKPU+sUE7gE/0r9jnDxBCLwadepPp5ktH
        /o63tONQ==;
Received: from [187.192.11.120] (port=40096 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hrtYH-003zbX-U2; Sun, 28 Jul 2019 19:30:10 -0500
Date:   Sun, 28 Jul 2019 19:30:09 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Douglas Miller <dougmill@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] net: ehea: Mark expected switch fall-through
Message-ID: <20190729003009.GA25425@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.192.11.120
X-Source-L: No
X-Exim-ID: 1hrtYH-003zbX-U2
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.192.11.120]:40096
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 52
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark switch cases where we are expecting to fall through.

This patch fixes the following warning:

drivers/net/ethernet/ibm/ehea/ehea_main.c: In function 'ehea_mem_notifier':
include/linux/printk.h:311:2: warning: this statement may fall through [-Wimplicit-fallthrough=]
  printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/ibm/ehea/ehea_main.c:3253:3: note: in expansion of macro 'pr_info'
   pr_info("memory offlining canceled");
   ^~~~~~~
drivers/net/ethernet/ibm/ehea/ehea_main.c:3256:2: note: here
  case MEM_ONLINE:
  ^~~~

Notice that, in this particular case, the code comment is
modified in accordance with what GCC is expecting to find.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/net/ethernet/ibm/ehea/ehea_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/ehea/ehea_main.c b/drivers/net/ethernet/ibm/ehea/ehea_main.c
index 4138a8480347..cca71ba7a74a 100644
--- a/drivers/net/ethernet/ibm/ehea/ehea_main.c
+++ b/drivers/net/ethernet/ibm/ehea/ehea_main.c
@@ -3251,7 +3251,7 @@ static int ehea_mem_notifier(struct notifier_block *nb,
 	switch (action) {
 	case MEM_CANCEL_OFFLINE:
 		pr_info("memory offlining canceled");
-		/* Fall through: re-add canceled memory block */
+		/* Fall through - re-add canceled memory block */
 
 	case MEM_ONLINE:
 		pr_info("memory is going online");
-- 
2.22.0

