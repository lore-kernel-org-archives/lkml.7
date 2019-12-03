Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EAF0C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEF3B20848
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575413121;
	bh=+2CN5l6mJ8eMxZslm+VysI6hfxmKHCqxHd9jh/oSp9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GTgCqeNsFtac0dkwU6JYWGxlQ/XYIyGfjQnBi8GZXAK1twPhhnkSgI5938wR8jYQG
	 6kxr4ZxzvEltFmfQUz0JCQF17qxRWv35rd+AS4fmTFU0uB3bzxUfH/aQkndqJbnfUo
	 UnT8vUitqFxLUuOiRX0wuCKMLuQCiI8RRBreHHsA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbfLCWpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:45:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:33640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729020AbfLCWpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:45:13 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74A7D207DD;
        Tue,  3 Dec 2019 22:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575413112;
        bh=+2CN5l6mJ8eMxZslm+VysI6hfxmKHCqxHd9jh/oSp9Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sIrzcLe9U1iAFQhzJa+KgTdu5X84GKAImEHyf6Fx9do5iwdELbZaD5ClHeOZmMt6L
         HPwfCuT0zbfyBiaqyE0BSaHKdZXCwtnO+WPULTK1Z/xeALx1b4YZwpw7o+fHO2utBB
         HMMeEBe4SEXg3AIYi30jgva0G/ec5R0qwnkMJS9I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        John Rutherford <john.rutherford@dektech.com.au>,
        Jon Maloy <jon.maloy@ericsson.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.3 130/135] tipc: fix link name length check
Date:   Tue,  3 Dec 2019 23:36:10 +0100
Message-Id: <20191203213045.578963380@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203213005.828543156@linuxfoundation.org>
References: <20191203213005.828543156@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Rutherford <john.rutherford@dektech.com.au>

[ Upstream commit fd567ac20cb0377ff466d3337e6e9ac5d0cb15e4 ]

In commit 4f07b80c9733 ("tipc: check msg->req data len in
tipc_nl_compat_bearer_disable") the same patch code was copied into
routines: tipc_nl_compat_bearer_disable(),
tipc_nl_compat_link_stat_dump() and tipc_nl_compat_link_reset_stats().
The two link routine occurrences should have been modified to check
the maximum link name length and not bearer name length.

Fixes: 4f07b80c9733 ("tipc: check msg->reg data len in tipc_nl_compat_bearer_disable")
Signed-off-by: John Rutherford <john.rutherford@dektech.com.au>
Acked-by: Jon Maloy <jon.maloy@ericsson.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tipc/netlink_compat.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/tipc/netlink_compat.c
+++ b/net/tipc/netlink_compat.c
@@ -550,7 +550,7 @@ static int tipc_nl_compat_link_stat_dump
 	if (len <= 0)
 		return -EINVAL;
 
-	len = min_t(int, len, TIPC_MAX_BEARER_NAME);
+	len = min_t(int, len, TIPC_MAX_LINK_NAME);
 	if (!string_is_valid(name, len))
 		return -EINVAL;
 
@@ -822,7 +822,7 @@ static int tipc_nl_compat_link_reset_sta
 	if (len <= 0)
 		return -EINVAL;
 
-	len = min_t(int, len, TIPC_MAX_BEARER_NAME);
+	len = min_t(int, len, TIPC_MAX_LINK_NAME);
 	if (!string_is_valid(name, len))
 		return -EINVAL;
 


