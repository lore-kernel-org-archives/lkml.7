Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF64C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C748821924
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568787863;
	bh=A69Jht1zH/TeEhUEjrbF0DH5gnBHOQ+QcX81PPTzpYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nV3E4tC9vS0vesnn8PgaQVRn/Q9Eq8pW3yFWuRGnz921W9qTNhkHs5sjEpvNpvx9J
	 0tRBFrZ5JiRSh0DAfVKVCfd5v8GESXHIRCgVG7CRzeiShD/Bf0C2wI78fDOZgVr0uH
	 9+7FwkHm1wUOc57bgP3vQJqZudSkw7YMCs7RjsEs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbfIRGYX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 02:24:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:44702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729815AbfIRGYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 02:24:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9955821925;
        Wed, 18 Sep 2019 06:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568787856;
        bh=A69Jht1zH/TeEhUEjrbF0DH5gnBHOQ+QcX81PPTzpYI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bmreQzRJ7xloIlpzlmxlNcNL5OBh0u4yb59R0pH0ciseoj/oOPlRQHHXR7EG2mJAV
         Zuubxu1RGnoDFQkif4+H6PW6AGkcRqCD+HdYzUwgcsjwGTd41t6eMH1wPOsaUvYUVo
         RFqei8th+77G6pM6MqeNtFy7seiuOS8rYD3l2ByU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.2 01/85] bridge/mdb: remove wrong use of NLM_F_MULTI
Date:   Wed, 18 Sep 2019 08:18:19 +0200
Message-Id: <20190918061234.167205349@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190918061234.107708857@linuxfoundation.org>
References: <20190918061234.107708857@linuxfoundation.org>
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Dichtel <nicolas.dichtel@6wind.com>

[ Upstream commit 94a72b3f024fc7e9ab640897a1e38583a470659d ]

NLM_F_MULTI must be used only when a NLMSG_DONE message is sent at the end.
In fact, NLMSG_DONE is sent only at the end of a dump.

Libraries like libnl will wait forever for NLMSG_DONE.

Fixes: 949f1e39a617 ("bridge: mdb: notify on router port add and del")
CC: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/bridge/br_mdb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -437,7 +437,7 @@ static int nlmsg_populate_rtr_fill(struc
 	struct nlmsghdr *nlh;
 	struct nlattr *nest;
 
-	nlh = nlmsg_put(skb, pid, seq, type, sizeof(*bpm), NLM_F_MULTI);
+	nlh = nlmsg_put(skb, pid, seq, type, sizeof(*bpm), 0);
 	if (!nlh)
 		return -EMSGSIZE;
 


