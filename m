Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15ED3C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 03:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA6DB208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 03:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732867AbfJJDns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 23:43:48 -0400
Received: from shells.gnugeneration.com ([66.240.222.126]:58588 "EHLO
        shells.gnugeneration.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbfJJDnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 23:43:47 -0400
Received: by shells.gnugeneration.com (Postfix, from userid 1000)
        id 5D12F1A40556; Wed,  9 Oct 2019 20:43:47 -0700 (PDT)
Date:   Wed, 9 Oct 2019 20:43:47 -0700
From:   Vito Caputo <vcaputo@pengaru.com>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] af_unix: __unix_find_socket_byname() cleanup
Message-ID: <20191010034347.ohjmoivd7f426znd@shells.gnugeneration.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove pointless return variable dance.

Appears vestigial from when the function did locking as seen in
unix_find_socket_byinode(), but locking is handled in
unix_find_socket_byname() for __unix_find_socket_byname().

Signed-off-by: Vito Caputo <vcaputo@pengaru.com>
---
 net/unix/af_unix.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 67e87db5877f..c853ad0875f4 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -284,11 +284,9 @@ static struct sock *__unix_find_socket_byname(struct net *net,
 
 		if (u->addr->len == len &&
 		    !memcmp(u->addr->name, sunname, len))
-			goto found;
+			return s;
 	}
-	s = NULL;
-found:
-	return s;
+	return NULL;
 }
 
 static inline struct sock *unix_find_socket_byname(struct net *net,
-- 
2.11.0

