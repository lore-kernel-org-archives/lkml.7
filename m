Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C97C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEF6E2166E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574888717;
	bh=2Luct6aeUchWiuAqbQk8IOpLZN3/QWd0Ogx29N2hSO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2cnB7mYbI9MveyDg1u0e+ByM9zowbYNywSIJmTgxgrpJp/r+Rkf35hqmJrjHUmeZP
	 frWI4CXrXG1bsbeRMwJFDnXypeeSp8O2m587n6u+FcxQp+DQhxKsjLT9zl+/wQDa5Y
	 Q6EYvacHwa8+plhFn+D/htshB6ocR2mofLKuyJds=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732260AbfK0VFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:05:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:58884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731672AbfK0VFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 16:05:12 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AE6920637;
        Wed, 27 Nov 2019 21:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574888711;
        bh=2Luct6aeUchWiuAqbQk8IOpLZN3/QWd0Ogx29N2hSO4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Eaet1UpaG4YLiimeUvXzBgUP9dnkbz2GTLMfl44OTmD5mtz06/qzexaL8upyp213E
         P/ItXIyP4fL/jGWIHgKEH8qE7VKSlaGhRIteS02kfX7U6E1jBiH2Krc7zgS126wN3J
         vYDnBryBzu1G10O9UG1+yiinntdM5DPLWC9TiTyQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Huazhong Tan <tanhuazhong@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 187/306] net: hns3: bugfix for is_valid_csq_clean_head()
Date:   Wed, 27 Nov 2019 21:30:37 +0100
Message-Id: <20191127203128.927710566@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203114.766709977@linuxfoundation.org>
References: <20191127203114.766709977@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huazhong Tan <tanhuazhong@huawei.com>

[ Upstream commit 6d71ec6cbf74ac9c2823ef751b1baa5b889bb3ac ]

The HEAD pointer of the hardware command queue maybe equal to the command
queue's next_to_use in the driver, so that does not belong to the invalid
HEAD pointer, since the hardware may not process the command in time,
causing the HEAD pointer to be too late to update. The variables' name
in this function is unreadable, so give them a more readable one.

Fixes: 3ff504908f95 ("net: hns3: fix a dead loop in hclge_cmd_csq_clean")
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c   | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
index 68026a5ad7e77..690f62ed87dca 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
@@ -24,15 +24,15 @@ static int hclge_ring_space(struct hclge_cmq_ring *ring)
 	return ring->desc_num - used - 1;
 }
 
-static int is_valid_csq_clean_head(struct hclge_cmq_ring *ring, int h)
+static int is_valid_csq_clean_head(struct hclge_cmq_ring *ring, int head)
 {
-	int u = ring->next_to_use;
-	int c = ring->next_to_clean;
+	int ntu = ring->next_to_use;
+	int ntc = ring->next_to_clean;
 
-	if (unlikely(h >= ring->desc_num))
-		return 0;
+	if (ntu > ntc)
+		return head >= ntc && head <= ntu;
 
-	return u > c ? (h > c && h <= u) : (h > c || h <= u);
+	return head >= ntc || head <= ntu;
 }
 
 static int hclge_alloc_cmd_desc(struct hclge_cmq_ring *ring)
-- 
2.20.1



