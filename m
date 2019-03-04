Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C03C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 03:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AB1E20823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 03:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbfCDDsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 22:48:17 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:26786 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725938AbfCDDsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 22:48:16 -0500
X-IronPort-AV: E=Sophos;i="5.58,438,1544457600"; 
   d="scan'208";a="55838131"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 04 Mar 2019 11:48:14 +0800
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (unknown [10.167.33.85])
        by cn.fujitsu.com (Postfix) with ESMTP id D2F1A46BA6D1;
        Mon,  4 Mar 2019 11:48:01 +0800 (CST)
Received: from ubuntu.g08.fujitsu.local (10.167.226.33) by
 G08CNEXCHPEKD03.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 4 Mar 2019 11:48:16 +0800
From:   Su Yanjun <suyj.fnst@cn.fujitsu.com>
To:     <steffen.klassert@secunet.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <suyj.fnst@cn.fujitsu.com>
Subject: [PATCH] net: xfrm: Fix potential oops in xfrm_user_rcv_msg and array out of bounds
Date:   Sun, 3 Mar 2019 22:47:39 -0500
Message-ID: <1551671259-21311-1-git-send-email-suyj.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.226.33]
X-yoursite-MailScanner-ID: D2F1A46BA6D1.AFAD6
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: suyj.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When i review xfrm_user.c code, i found some potentical bug in it.

In xfrm_user_rcvmsg if type parameter from user space is set to
XFRM_MSG_MAX or  XFRM_MSG_NEWSADINFO or XFRM_MSG_NEWSPDINFO. It will cause
xfrm_user_rcv_msg  referring to null entry in xfrm_dispatch array.

Signed-off-by: Su Yanjun <suyj.fnst@cn.fujitsu.com>
---
 net/xfrm/xfrm_user.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index a131f9f..d832783 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -2630,11 +2630,13 @@ static int xfrm_user_rcv_msg(struct sk_buff *skb, struct nlmsghdr *nlh,
 		return -EOPNOTSUPP;
 
 	type = nlh->nlmsg_type;
-	if (type > XFRM_MSG_MAX)
+	if (type >= XFRM_MSG_MAX)
 		return -EINVAL;
 
 	type -= XFRM_MSG_BASE;
 	link = &xfrm_dispatch[type];
+	if (!link)
+		return -EOPNOTSUPP;
 
 	/* All operations require privileges, even GET */
 	if (!netlink_net_capable(skb, CAP_NET_ADMIN))
-- 
2.7.4



