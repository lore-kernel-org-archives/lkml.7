Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E82C3C43215
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFAAA222A4
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574141798;
	bh=UcedAKmJKOMClQiJe28VF5OGfa6QxtsLch4F49QvOxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ypos3AuvNSjlTNuf+Y1qb0xjX6fmUD9Mf2nFzpmplUHTf/yppn9Tia99rTYBl9Iys
	 IeMnmXizJk7uQMYdz0/B9PfyBUrIKPPEaSsqLXQRtea+RNoB8rQCkjoXxpcRyP0i7d
	 HoohxDQPNQPOIDIeY2WWIClLht8bxs9sSOirUoUU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729365AbfKSFgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:36:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:57982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729978AbfKSFgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:36:35 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D53E222A4;
        Tue, 19 Nov 2019 05:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574141795;
        bh=UcedAKmJKOMClQiJe28VF5OGfa6QxtsLch4F49QvOxk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rPpEfRKZ4xO/tt7MLLCfFDp9dFmZL81FvBEM5sMYT0+8YFGM+JS+z4uUVssZugbJ7
         ssUi3TV/7uBwqmEMue6rZj5E11T+hPy8LZ6tXmsy7n68Hh08WnUV+n6CITtbn5d5E3
         QLSaekVczx/XEy+4QPVQlyrvJV5CJDUJJmTAJBd4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jian Shen <shenjian15@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 284/422] net: hns3: Fix parameter type for q_id in hclge_tm_q_to_qs_map_cfg()
Date:   Tue, 19 Nov 2019 06:18:01 +0100
Message-Id: <20191119051417.388279921@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051400.261610025@linuxfoundation.org>
References: <20191119051400.261610025@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian Shen <shenjian15@huawei.com>

[ Upstream commit 32c7fbc8ffd752c6aa05d2dd7c13b0f0aa00ddaa ]

So far all the places calling hclge_tm_q_to_qs_map_cfg() are assigning
an u16 type value to "q_id", and in the processing of
hclge_tm_q_to_qs_map_cfg(), it also converts the "q_id" to le16.

The max tqp number for pf can be more than 256, we should use "u16" to
store the queue id, instead of "u8", which may cause data lost.

Fixes: 848440544b41 ("net: hns3: Add support of TX Scheduler & Shaper to HNS3 driver")
Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
index 11e9259ca0407..0d45d045706c7 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
@@ -298,7 +298,7 @@ static int hclge_tm_qs_to_pri_map_cfg(struct hclge_dev *hdev,
 }
 
 static int hclge_tm_q_to_qs_map_cfg(struct hclge_dev *hdev,
-				    u8 q_id, u16 qs_id)
+				    u16 q_id, u16 qs_id)
 {
 	struct hclge_nq_to_qs_link_cmd *map;
 	struct hclge_desc desc;
-- 
2.20.1



