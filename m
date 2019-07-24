Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28FA3C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04A6322BF3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564033334;
	bh=I3Wqt9c23mGhj+9OrE5ctJWyRvD3B+593rBHj/RbxA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WNdMgv+vKxKoza1kc5oaVBSwy5hfvuLpR1u35ER87HTCMcC3i69JxtjT5AWTLJaQP
	 l6kzVdEz+gDKHy/eoCNEB1UcTn+wS9pFShHouw5cuPRCv45DBXXM8o4yONJrJK4//A
	 9X+Dx0bzIQeVQWuN8ekxZIKHRuBdIxMEnRDO7vno=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404847AbfGYFmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 01:42:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:57082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404830AbfGYFmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 01:42:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33DB621850;
        Thu, 25 Jul 2019 05:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564033329;
        bh=I3Wqt9c23mGhj+9OrE5ctJWyRvD3B+593rBHj/RbxA0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nzVqv3egRW1yQsrFtgjW4ZMDtbLkmoE/xrW2t0qrKczQleoOH52dEpcQbIeI05l4d
         9IDJ2QskZAEsPiFBVjP4cIFRwREftKdM7Dmfab56oo4DclULPCe9erDSFiNEYiL6z2
         QVq7VtlotV+CS6eRYB68Amd5JjCATF59LeOkd7VU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yonglong Liu <liuyonglong@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 129/271] net: hns3: fix a -Wformat-nonliteral compile warning
Date:   Wed, 24 Jul 2019 21:19:58 +0200
Message-Id: <20190724191706.299913954@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191655.268628197@linuxfoundation.org>
References: <20190724191655.268628197@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 4648c6a9d9e8..89ca69fa2b97 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -663,8 +663,7 @@ static u8 *hclge_comm_get_strings(u32 stringset,
 		return buff;
 
 	for (i = 0; i < size; i++) {
-		snprintf(buff, ETH_GSTRING_LEN,
-			 strs[i].desc);
+		snprintf(buff, ETH_GSTRING_LEN, "%s", strs[i].desc);
 		buff = buff + ETH_GSTRING_LEN;
 	}
 
-- 
2.20.1



