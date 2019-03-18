Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F25F7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 07:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFC5C2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 07:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552894471;
	bh=gZK/oQQyMg7LNOvSl8TXPpLQkaVJcRwcuBuQ2Sv23Qg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DTVzjppNuYRclYyytwzdxAgsTp+LWn9hBrs4JOoXDm2OSkS9nCYIxOLjtpZjOj0Pl
	 euZf97FZ85zo0Cx4iUkZUxBzn0aXFWj6UfgiLHqAp/vQWuwOI0iWhSeWFicWC7QIXl
	 GrEDRIBhlLmv/1alHn3hEJBTvHaHOzE3fPjtkzpE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbfCRHeQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 03:34:16 -0400
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:40880 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726135AbfCRHeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 03:34:14 -0400
Received: by wens.csie.org (Postfix, from userid 1000)
        id F24A35F9F2; Mon, 18 Mar 2019 15:34:11 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     linux-sunxi@googlegroups.com, Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] nvmem: sunxi_sid: Read out SID for randomness without looping
Date:   Mon, 18 Mar 2019 15:33:49 +0800
Message-Id: <20190318073354.12151-2-wens@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190318073354.12151-1-wens@kernel.org>
References: <20190318073354.12151-1-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

Since the reg_read callbacks already support arbitrary, but 4-byte
aligned. offsets and lengths into the SID, there is no need for another
for loop just to use it to read 1 byte at a time.

Read out the whole SID block in one go.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/nvmem/sunxi_sid.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
index 570a2e354f30..704c35edf796 100644
--- a/drivers/nvmem/sunxi_sid.c
+++ b/drivers/nvmem/sunxi_sid.c
@@ -154,7 +154,7 @@ static int sunxi_sid_probe(struct platform_device *pdev)
 	struct resource *res;
 	struct nvmem_device *nvmem;
 	struct sunxi_sid *sid;
-	int i, size;
+	int size;
 	char *randomness;
 	const struct sunxi_sid_cfg *cfg;
 
@@ -189,8 +189,7 @@ static int sunxi_sid_probe(struct platform_device *pdev)
 	if (!randomness)
 		return -ENOMEM;
 
-	for (i = 0; i < size; i++)
-		econfig.reg_read(sid, i, &randomness[i], 1);
+	econfig.reg_read(sid, 0, randomness, size);
 
 	add_device_randomness(randomness, size);
 	kfree(randomness);
-- 
2.20.1

