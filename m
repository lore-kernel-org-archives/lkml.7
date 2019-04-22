Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E9EC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 16:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7A35214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 16:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbfDVQdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 12:33:45 -0400
Received: from gateway30.websitewelcome.com ([192.185.145.3]:31509 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727334AbfDVQdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 12:33:45 -0400
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id 32F691B522
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 11:33:44 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id Ibt2hJL5rYTGMIbt2hPm1C; Mon, 22 Apr 2019 11:33:44 -0500
X-Authority-Reason: nr=8
Received: from [189.250.104.103] (port=39318 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hIbt1-001f7W-A9; Mon, 22 Apr 2019 11:33:43 -0500
Date:   Mon, 22 Apr 2019 11:33:42 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] gdbstub: Replace strcpy() by strscpy()
Message-ID: <20190422163342.GA682@embeddedor>
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
X-Exim-ID: 1hIbt1-001f7W-A9
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.104.103]:39318
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 19
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The strcpy() function is being deprecated. Replace it by the safer
strscpy() and fix the following Coverity warning:

"You might overrun the 1024-character fixed-size string remcom_in_buffer
by copying cmd without checking the length."

Addresses-Coverity-ID: 138999 ("Copy into fixed size buffer")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 kernel/debug/gdbstub.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/debug/gdbstub.c b/kernel/debug/gdbstub.c
index 7510dc687c0d..316cc599dc09 100644
--- a/kernel/debug/gdbstub.c
+++ b/kernel/debug/gdbstub.c
@@ -1094,10 +1094,10 @@ int gdbstub_state(struct kgdb_state *ks, char *cmd)
 		return error;
 	case 's':
 	case 'c':
-		strcpy(remcom_in_buffer, cmd);
+		strscpy(remcom_in_buffer, cmd, sizeof(remcom_in_buffer));
 		return 0;
 	case '$':
-		strcpy(remcom_in_buffer, cmd);
+		strscpy(remcom_in_buffer, cmd, sizeof(remcom_in_buffer));
 		gdbstub_use_prev_in_buf = strlen(remcom_in_buffer);
 		gdbstub_prev_in_buf_pos = 0;
 		return 0;
-- 
2.21.0

