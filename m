Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF58C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 720FB2087C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552049525;
	bh=EOrS9wXtQMBjgSaJ/4fwjB5+3lCjBZqva3cTNmJRubw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QaYpEozgFdjQvkBO5QaYjN80m20EVHczZcK5lO8jhg6jzygUEiKibMWPy4R/G4PKi
	 dD8RztnGfjbmnTCFWpThD49ddxNFApdNKY1V0Zw+6joe7rqNGM1KoytY1/+TcpXRkn
	 AA06aeCaYxNepACuiiWY7c6ofCDC45/4sEChKE7o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbfCHMwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:52:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:55496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726876AbfCHMwC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:52:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB3322085A;
        Fri,  8 Mar 2019 12:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552049522;
        bh=EOrS9wXtQMBjgSaJ/4fwjB5+3lCjBZqva3cTNmJRubw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZJMcg39G2pfHf+zZHLIL+716FU0WWp1uu4ffnmH3NywsNdYonXW+HPZ1suOvVyMR+
         +VgIXAw4iQCaEcCPL/y0CWOOzLsWbvbrCGUrIvSBV41vB1BElQKrtBsAddfPYOCNId
         8f2u4Q5iXRgMNZxGYgNZsidqOae7qddrAb8pGBho=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Erik Hugne <erik.hugne@gmail.com>,
        Jon Maloy <jon.maloy@ericsson.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.0 28/46] tipc: fix RDM/DGRAM connect() regression
Date:   Fri,  8 Mar 2019 13:50:01 +0100
Message-Id: <20190308124904.091703817@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308124902.257040783@linuxfoundation.org>
References: <20190308124902.257040783@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Erik Hugne <erik.hugne@gmail.com>

[ Upstream commit 0e63208915a8d7590d0a6218dadb2a6a00ac705a ]

Fix regression bug introduced in
commit 365ad353c256 ("tipc: reduce risk of user starvation during link
congestion")

Only signal -EDESTADDRREQ for RDM/DGRAM if we don't have a cached
sockaddr.

Fixes: 365ad353c256 ("tipc: reduce risk of user starvation during link congestion")
Signed-off-by: Erik Hugne <erik.hugne@gmail.com>
Signed-off-by: Jon Maloy <jon.maloy@ericsson.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tipc/socket.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -1333,7 +1333,7 @@ static int __tipc_sendmsg(struct socket
 
 	if (unlikely(!dest)) {
 		dest = &tsk->peer;
-		if (!syn || dest->family != AF_TIPC)
+		if (!syn && dest->family != AF_TIPC)
 			return -EDESTADDRREQ;
 	}
 


