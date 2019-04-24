Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F7C8C282E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35403218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556128239;
	bh=Bj+f6e7aWxeEh/jYabrRzcDu3Hk3uLM9zqT0oc+BO9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0z0eIcCVQreGCIIrwpjaD04fKH5w31s1iPjjblUrMU6eb2iPMwFrE82Ntl6MifF+5
	 Z6+5dqloj3amkeReYhtOpq408xwd2OfZbALoCEPRS0VtjRrba6E1grFo2fGB2O6DHG
	 cLkDlrLpONL/dLqqJLiT7xNj+6ju9l7i/t1OKfWI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390815AbfDXR33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:29:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:55704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390411AbfDXR3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:29:23 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F18E21904;
        Wed, 24 Apr 2019 17:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126962;
        bh=Bj+f6e7aWxeEh/jYabrRzcDu3Hk3uLM9zqT0oc+BO9Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hY2wS5mLccsfluubdmtKrIzAR1ngjLjv81VDhqZJMc2uSUYu8qdwGQOaW+51sH+QP
         cyiPueqBqxuN31eOtNJBRhn0lVRrFako6zLR7WofnhdV5E7yI7FHbzMo0znaSAV3BG
         qzen6hEuRk6ZRctpdQlp5vDL8al1d+zz9ZhQ154I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jon Maloy <jon.maloy@ericsson.com>,
        Hoang Le <hoang.h.le@dektech.com.au>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 10/96] tipc: missing entries in name table of publications
Date:   Wed, 24 Apr 2019 19:09:15 +0200
Message-Id: <20190424170920.511222827@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170919.829037226@linuxfoundation.org>
References: <20190424170919.829037226@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hoang Le <hoang.h.le@dektech.com.au>

[ Upstream commit d1841533e54876f152a30ac398a34f47ad6590b1 ]

When binding multiple services with specific type 1Ki, 2Ki..,
this leads to some entries in the name table of publications
missing when listed out via 'tipc name show'.

The problem is at identify zero last_type conditional provided
via netlink. The first is initial 'type' when starting name table
dummping. The second is continuously with zero type (node state
service type). Then, lookup function failure to finding node state
service type in next iteration.

To solve this, adding more conditional to marked as dirty type and
lookup correct service type for the next iteration instead of select
the first service as initial 'type' zero.

Acked-by: Jon Maloy <jon.maloy@ericsson.com>
Signed-off-by: Hoang Le <hoang.h.le@dektech.com.au>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tipc/name_table.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/tipc/name_table.c
+++ b/net/tipc/name_table.c
@@ -908,7 +908,8 @@ static int tipc_nl_service_list(struct n
 	for (; i < TIPC_NAMETBL_SIZE; i++) {
 		head = &tn->nametbl->services[i];
 
-		if (*last_type) {
+		if (*last_type ||
+		    (!i && *last_key && (*last_lower == *last_key))) {
 			service = tipc_service_find(net, *last_type);
 			if (!service)
 				return -EPIPE;


