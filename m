Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7EEC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 18:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9205E21479
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 18:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbfE0SIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 14:08:01 -0400
Received: from gateway36.websitewelcome.com ([192.185.179.26]:35452 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726346AbfE0SIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 14:08:01 -0400
X-Greylist: delayed 1224 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 May 2019 14:08:00 EDT
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id 69E0740169CE6
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 12:07:56 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id VJihhWBMZ90onVJihhZbJD; Mon, 27 May 2019 12:47:35 -0500
X-Authority-Reason: nr=8
Received: from [189.250.47.159] (port=36866 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hVJig-002gpt-Nl; Mon, 27 May 2019 12:47:34 -0500
Date:   Mon, 27 May 2019 12:47:33 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] unicode: replace strncpy() by strscpy()
Message-ID: <20190527174733.GA29547@embeddedor>
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
X-Source-IP: 189.250.47.159
X-Source-L: No
X-Exim-ID: 1hVJig-002gpt-Nl
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.47.159]:36866
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 7
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The strncpy() function is being deprecated. Replace it by the safer
strscpy() and fix the following Coverity warning:

"Calling strncpy with a maximum size argument of 12 bytes on destination
array version_string of size 12 bytes might leave the destination string
unterminated."

Notice that, unlike strncpy(), strscpy() always null-terminates the
destination string.

Addresses-Coverity-ID: 1445547 ("Buffer not null terminated")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 fs/unicode/utf8-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/unicode/utf8-core.c b/fs/unicode/utf8-core.c
index 6afab4fdce90..a367041468cf 100644
--- a/fs/unicode/utf8-core.c
+++ b/fs/unicode/utf8-core.c
@@ -131,7 +131,7 @@ static int utf8_parse_version(const char *version, unsigned int *maj,
 		{0, NULL}
 	};
 
-	strncpy(version_string, version, sizeof(version_string));
+	strscpy(version_string, version, sizeof(version_string));
 
 	if (match_token(version_string, token, args) != 1)
 		return -EINVAL;
-- 
2.21.0

