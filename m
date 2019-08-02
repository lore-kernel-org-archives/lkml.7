Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4475FC32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FF4721849
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564752045;
	bh=H/CvaLx9qSHM45AxIiO3zI7n5QsrUsdQZsskzB+VZNc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QFkxAkjIxe+9uKfJhmH2cBtP1d4c0cBYQvHEeaoFm0LdOK25xTOfaixx79krRFLBT
	 SFsJitydEZ4Uj/9VtVvTSJ5cPBqT9f1IKWJvpCCbLu5aV1hY4e3uO3KhYgvTSDgF4y
	 YIVan0rjQCyeOT+0A1uYWNDhU11EhlisGNO+npPU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393446AbfHBNUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 09:20:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:59104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393420AbfHBNUj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 09:20:39 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22F1A2173E;
        Fri,  2 Aug 2019 13:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564752038;
        bh=H/CvaLx9qSHM45AxIiO3zI7n5QsrUsdQZsskzB+VZNc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pAyBkujlGM2wBPmJCRtbkBl8NNZ5T8U4HqpdjV294DcsCHDYbO0HL2+Www1xGd3Tf
         lJniBTtTpUneCNjiEsUYEbeVf2aiK1aQ0RrHJyCf5W7Rv2c7kwILaof8JpeaA1h2oR
         n/RnfVJIHdVEtwvsi9c6cgTcfpU1FLMRiXBGvVZo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 30/76] allocate_flower_entry: should check for null deref
Date:   Fri,  2 Aug 2019 09:19:04 -0400
Message-Id: <20190802131951.11600-30-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190802131951.11600-1-sashal@kernel.org>
References: <20190802131951.11600-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Navid Emamdoost <navid.emamdoost@gmail.com>

[ Upstream commit bb1320834b8a80c6ac2697ab418d066981ea08ba ]

allocate_flower_entry does not check for allocation success, but tries
to deref the result. I only moved the spin_lock under null check, because
 the caller is checking allocation's status at line 652.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c
index cfaf8f618d1f3..56742fa0c1af6 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c
@@ -67,7 +67,8 @@ static struct ch_tc_pedit_fields pedits[] = {
 static struct ch_tc_flower_entry *allocate_flower_entry(void)
 {
 	struct ch_tc_flower_entry *new = kzalloc(sizeof(*new), GFP_KERNEL);
-	spin_lock_init(&new->lock);
+	if (new)
+		spin_lock_init(&new->lock);
 	return new;
 }
 
-- 
2.20.1

