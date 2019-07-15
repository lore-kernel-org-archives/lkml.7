Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE9FC76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A02E2081C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563200063;
	bh=FHM3ABfh/RUD+fZcA9PBQ27KnHYDHp3MQWzw8dG8eb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yWcjW180GBZxpD+hdLVoQmqUrlGJSRzbhnWf/Rk9RGRCwQfXvaQfGCB9J0EPdA5Nw
	 FK1hW6Tvw/+8B87BTqqIjms/N0vc5X5MTGdu4cNSnkNiMEIwrf2SoWD6mvOajAGdFN
	 XDI3h6toWC1Sp/41WlPUsLhwW2mgVH3EXS6HrnMg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389332AbfGOOOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 10:14:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:55858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389307AbfGOOOS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 10:14:18 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7253212F5;
        Mon, 15 Jul 2019 14:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563200057;
        bh=FHM3ABfh/RUD+fZcA9PBQ27KnHYDHp3MQWzw8dG8eb8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k3YBtfeBumUBaRTTgHOGxOzF4Gg6WmLRJvCqOzzykEbsUikpmooYofnYzIy18HyCN
         4/FmI0JrgGcQdGHebnZgaluzte00417Ygpq6F1cvnD0ZNBixfUL/r2N1UBXBmxQ45e
         stWYOEYTm5XeGGYcI4Ra4cJPe6uEBV2/OQzc+LXc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yonglong Liu <liuyonglong@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.1 173/219] net: hns3: fix a -Wformat-nonliteral compile warning
Date:   Mon, 15 Jul 2019 10:02:54 -0400
Message-Id: <20190715140341.6443-173-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715140341.6443-1-sashal@kernel.org>
References: <20190715140341.6443-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yonglong Liu <liuyonglong@huawei.com>

[ Upstream commit 18d219b783da61a6cc77581f55fc4af2fa16bc36 ]

When setting -Wformat=2, there is a compiler warning like this:

hclge_main.c:xxx:x: warning: format not a string literal and no
format arguments [-Wformat-nonliteral]
strs[i].desc);
^~~~

This patch adds missing format parameter "%s" to snprintf() to
fix it.

Fixes: 46a3df9f9718 ("Add HNS3 Acceleration Engine & Compatibility Layer Support")
Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 6d4d5a470163..563eefa20003 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -550,8 +550,7 @@ static u8 *hclge_comm_get_strings(u32 stringset,
 		return buff;
 
 	for (i = 0; i < size; i++) {
-		snprintf(buff, ETH_GSTRING_LEN,
-			 strs[i].desc);
+		snprintf(buff, ETH_GSTRING_LEN, "%s", strs[i].desc);
 		buff = buff + ETH_GSTRING_LEN;
 	}
 
-- 
2.20.1

