Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6657CC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DA412449A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559186097;
	bh=bp0ei9CW8GOV5s+gfcafVPBBEVYM5qxBTDtOvGL7eX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h4buH/YZEd96LHaWiPOjVpcp2AeZQwvYy33bvP/q1MNd58mQnWqjDR9BF35065wBG
	 n2Ad8205qxNR5lZZ8hoWnEgUtrNN9SrViqLQRKUD6D7996NjMToXm3UBxwS6O3Ef7T
	 /gQsZk+qaC5V/eyBMXThjjl4m8efYCoOnQJ8HhZg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729266AbfE3DO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:14:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:54138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728924AbfE3DMQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:12:16 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73C89244D4;
        Thu, 30 May 2019 03:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185936;
        bh=bp0ei9CW8GOV5s+gfcafVPBBEVYM5qxBTDtOvGL7eX4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gXldf4WlfGOxBI6WJqVMtbq7hwGjUhUrlaFjQh4SCF+8R5Zu8tcBzrLuV0yafMroS
         OevDDg332PJf1xnKR5pzkZGuLByaeHvDo0qYcveX7nBbmlrXkJA0UCCpwyFbDTbGXH
         LRczojIIGUmUrIZs/ooS+Ush6MF4Kq3dT1AF4FLw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aditya Pakki <pakki001@umn.edu>,
        Mukesh Ojha <mojha@codeaurora.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 292/405] thunderbolt: Fix to check the return value of kmemdup
Date:   Wed, 29 May 2019 20:04:50 -0700
Message-Id: <20190530030555.624507762@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.291644921@linuxfoundation.org>
References: <20190530030540.291644921@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit fd21b79e541e4666c938a344f3ad2df74b4f5120 ]

uuid in add_switch is allocted via kmemdup which can fail. The patch
logs the error and cleans up the allocated memory for switch.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thunderbolt/icm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
index e3fc920af6825..8b7f9131e9d12 100644
--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -473,6 +473,11 @@ static void add_switch(struct tb_switch *parent_sw, u64 route,
 		goto out;
 
 	sw->uuid = kmemdup(uuid, sizeof(*uuid), GFP_KERNEL);
+	if (!sw->uuid) {
+		tb_sw_warn(sw, "cannot allocate memory for switch\n");
+		tb_switch_put(sw);
+		goto out;
+	}
 	sw->connection_id = connection_id;
 	sw->connection_key = connection_key;
 	sw->link = link;
-- 
2.20.1



