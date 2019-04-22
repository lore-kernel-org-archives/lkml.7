Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 314E8C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 16:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDA8420896
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 16:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbfDVQVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 12:21:08 -0400
Received: from gateway32.websitewelcome.com ([192.185.145.171]:49764 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726098AbfDVQVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 12:21:08 -0400
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id D8D7CDB41D
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 11:21:07 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id Ibgph4uUN2qH7IbgphPjAo; Mon, 22 Apr 2019 11:21:07 -0500
X-Authority-Reason: nr=8
Received: from [189.250.104.103] (port=39224 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hIbgp-001XBY-05; Mon, 22 Apr 2019 11:21:07 -0500
Date:   Mon, 22 Apr 2019 11:21:06 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] kdb: kdb_support: replace strcpy() by strscpy()
Message-ID: <20190422162106.GA28977@embeddedor>
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
X-Source-IP: 189.250.104.103
X-Source-L: No
X-Exim-ID: 1hIbgp-001XBY-05
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.104.103]:39224
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 11
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The strcpy() function is being deprecated. Replace it by the safer
strscpy() and fix the following Coverity warning:

"You might overrun the 129-character fixed-size string ks_namebuf
by copying name without checking the length."

Addresses-Coverity-ID: 138995 ("Copy into fixed size buffer")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 kernel/debug/kdb/kdb_support.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/debug/kdb/kdb_support.c b/kernel/debug/kdb/kdb_support.c
index 50bf9b119bad..b8e6306e7e13 100644
--- a/kernel/debug/kdb/kdb_support.c
+++ b/kernel/debug/kdb/kdb_support.c
@@ -192,7 +192,7 @@ int kallsyms_symbol_complete(char *prefix_name, int max_len)
 
 	while ((name = kdb_walk_kallsyms(&pos))) {
 		if (strncmp(name, prefix_name, prefix_len) == 0) {
-			strcpy(ks_namebuf, name);
+			strscpy(ks_namebuf, name, sizeof(ks_namebuf));
 			/* Work out the longest name that matches the prefix */
 			if (++number == 1) {
 				prev_len = min_t(int, max_len-1,
-- 
2.21.0

