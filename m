Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11893C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5C472070B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139915;
	bh=oc8cJxJ1CYckBNkYhNCCdOZA1tBEkjfynyNTR4LkVoQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2KBH1I3W/kX/5EfgIawrlSm986SaNfTt1TPszuJpXertgnHsNj/YXSff2dKAz/Ha1
	 SIiKO9CKrhMJieiwwIWAOxTMrL+FdvNV9Q1HkRSaeXW3/zgQCdks+zPYMjVtzlOjyh
	 QUWXBWB6j9GntTD+pHDjNQE+Oq3a21DRWtDbZJso=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387414AbfDARby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:31:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:39564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387396AbfDARbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:31:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4D2D2070B;
        Mon,  1 Apr 2019 17:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139911;
        bh=oc8cJxJ1CYckBNkYhNCCdOZA1tBEkjfynyNTR4LkVoQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0NNgqNVpbk6/YLrHUEMgaSUpl+VEGnLK1RwjJolypqLjjSG9UNoErunf2SB0SXIrh
         MvV4kbvyUVVGr8wJyjD9pE5Q710uWtDLswg/x/II0ydBWf4hWZoWYGYaciSG+my9fX
         kh6zrmxy4z8bvJRD/VDWGlvbhsfk81yeScQzrWmA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lorenzo Colitti <lorenzo@google.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 051/131] net: diag: support v4mapped sockets in inet_diag_find_one_icsk()
Date:   Mon,  1 Apr 2019 19:02:01 +0200
Message-Id: <20190401170056.587242301@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170051.645954551@linuxfoundation.org>
References: <20190401170051.645954551@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 7c1306723ee916ea9f1fa7d9e4c7a6d029ca7aaf ]

Lorenzo reported that we could not properly find v4mapped sockets
in inet_diag_find_one_icsk(). This patch fixes the issue.

Reported-by: Lorenzo Colitti <lorenzo@google.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Lorenzo Colitti <lorenzo@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/inet_diag.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index ab9f8a66615d..386443e780da 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -366,13 +366,20 @@ int inet_diag_dump_one_icsk(struct inet_hashinfo *hashinfo,
 				 req->id.idiag_dport, req->id.idiag_src[0],
 				 req->id.idiag_sport, req->id.idiag_if);
 #if IS_ENABLED(CONFIG_IPV6)
-	else if (req->sdiag_family == AF_INET6)
-		sk = inet6_lookup(net, hashinfo,
-				  (struct in6_addr *)req->id.idiag_dst,
-				  req->id.idiag_dport,
-				  (struct in6_addr *)req->id.idiag_src,
-				  req->id.idiag_sport,
-				  req->id.idiag_if);
+	else if (req->sdiag_family == AF_INET6) {
+		if (ipv6_addr_v4mapped((struct in6_addr *)req->id.idiag_dst) &&
+		    ipv6_addr_v4mapped((struct in6_addr *)req->id.idiag_src))
+			sk = inet_lookup(net, hashinfo, req->id.idiag_dst[3],
+					 req->id.idiag_dport, req->id.idiag_src[3],
+					 req->id.idiag_sport, req->id.idiag_if);
+		else
+			sk = inet6_lookup(net, hashinfo,
+					  (struct in6_addr *)req->id.idiag_dst,
+					  req->id.idiag_dport,
+					  (struct in6_addr *)req->id.idiag_src,
+					  req->id.idiag_sport,
+					  req->id.idiag_if);
+	}
 #endif
 	else
 		goto out_nosk;
-- 
2.19.1



