Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC67C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21A1A21783
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574142427;
	bh=J3QJJyB1MLGclnznM8gAQWis/pWXjNNKzkTmxtMWMpU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1eqT459MbVLrXdaBHZ6E+Jeal05DzQoAR6zZbvctJ1dT1BuV3KluN7C5FkNlX7M54
	 PO9UfhDQhegaB+tZYQqNp58Z/GBoKSTPAfCW10oHmyOa/SKA+BNhOmid9ahmFWB3/c
	 Vp23Y9SylmSkSgmWDvL7K7rl7Y23ENXKJFzaAmLQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731200AbfKSFrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:47:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:43342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731195AbfKSFrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:47:04 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3493222F2;
        Tue, 19 Nov 2019 05:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574142423;
        bh=J3QJJyB1MLGclnznM8gAQWis/pWXjNNKzkTmxtMWMpU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LGeZGNWp46A22ND3rlglY8Q6Zq659ksh3COh8JHRIbm+/DSyA61Vu1Wion+Mo4RNi
         XKScuqN8jqWjJOURqJuac1yyrPWTU+8n4VjMqDhiDcgOip9QRutIQPp/wBzu1AB1Cs
         r+vGX0GaymkGKomcbMRMCJ+O26HhZkIUPS/mBvs0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 075/239] of: make PowerMac cache node search conditional on CONFIG_PPC_PMAC
Date:   Tue, 19 Nov 2019 06:17:55 +0100
Message-Id: <20191119051313.975899868@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051255.850204959@linuxfoundation.org>
References: <20191119051255.850204959@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Herring <robh@kernel.org>

[ Upstream commit f6707fd6241e483f6fea2caae82d876e422bb11a ]

Cache nodes under the cpu node(s) is PowerMac specific according to the
comment above, so make the code enforce that.

Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/of/base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index ce8a6e0c9b6a9..41b254be02954 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1837,7 +1837,7 @@ struct device_node *of_find_next_cache_node(const struct device_node *np)
 	/* OF on pmac has nodes instead of properties named "l2-cache"
 	 * beneath CPU nodes.
 	 */
-	if (!strcmp(np->type, "cpu"))
+	if (IS_ENABLED(CONFIG_PPC_PMAC) && !strcmp(np->type, "cpu"))
 		for_each_child_of_node(np, child)
 			if (!strcmp(child->type, "cache"))
 				return child;
-- 
2.20.1



