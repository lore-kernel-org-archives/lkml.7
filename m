Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39263C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AD29206DB
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577640984;
	bh=eT8nQbw1fEvyijJbgQGTWYfh/0VMvBoz56DGwb4sp+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Uk22CQTx8gisyeK6iaMB+XzFBb4ZV9US7+YTet7kQO/YYC9coYUPYMaIQAMJqmOiS
	 HErwSYuOytZjuTztkEPko01loZdkpKpHl7KFH7qQqM7MWSFvwX2otr5t0TRJYnaGt9
	 E7jI0gZEOGX1zMJ2emyt16+2fuGiHdGYj++WfEfU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730037AbfL2RgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:36:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:41552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729783AbfL2RgU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:36:20 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 727B3206DB;
        Sun, 29 Dec 2019 17:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577640979;
        bh=eT8nQbw1fEvyijJbgQGTWYfh/0VMvBoz56DGwb4sp+4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BwUx2adCxuXe3QoXhq0IUo1qbemg05jg94VkFzkCC26lyBnRemjhW5KwIgAYRgYAb
         h7eVEoUX4hXsxlpFHclOjjHFbzbR5uNG8uOrJYrkcon/ChelgbLrN2oKf7w4HBfHjy
         dyHq/6eeQ7zgW5lmbr6+Hj80ov0cs6RjrFJr4Q5s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 179/219] net: ethernet: ti: ale: clean ale tbl on init and intf restart
Date:   Sun, 29 Dec 2019 18:19:41 +0100
Message-Id: <20191229162536.004120213@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229162508.458551679@linuxfoundation.org>
References: <20191229162508.458551679@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Grygorii Strashko <grygorii.strashko@ti.com>

[ Upstream commit 7fe579dfb90fcdf0c7722f33c772d5f0d1bc7cb6 ]

Clean CPSW ALE on init and intf restart (up/down) to avoid reading obsolete
or garbage entries from ALE table.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/ti/cpsw_ale.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/ti/cpsw_ale.c b/drivers/net/ethernet/ti/cpsw_ale.c
index 5766225a4ce1..c245629a38c7 100644
--- a/drivers/net/ethernet/ti/cpsw_ale.c
+++ b/drivers/net/ethernet/ti/cpsw_ale.c
@@ -793,6 +793,7 @@ EXPORT_SYMBOL_GPL(cpsw_ale_start);
 void cpsw_ale_stop(struct cpsw_ale *ale)
 {
 	del_timer_sync(&ale->timer);
+	cpsw_ale_control_set(ale, 0, ALE_CLEAR, 1);
 	cpsw_ale_control_set(ale, 0, ALE_ENABLE, 0);
 }
 EXPORT_SYMBOL_GPL(cpsw_ale_stop);
@@ -877,6 +878,7 @@ struct cpsw_ale *cpsw_ale_create(struct cpsw_ale_params *params)
 					ALE_UNKNOWNVLAN_FORCE_UNTAG_EGRESS;
 	}
 
+	cpsw_ale_control_set(ale, 0, ALE_CLEAR, 1);
 	return ale;
 }
 EXPORT_SYMBOL_GPL(cpsw_ale_create);
-- 
2.20.1



