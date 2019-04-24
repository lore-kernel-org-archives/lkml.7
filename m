Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1789BC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3DED218FE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556117421;
	bh=IoJr28PEMz5n/Dhgxj2n0LUIpvdjDkq8BuvPvwiB3O0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=JHNEXt9B1f2HSoffyN3rK22bJ/5D8fVdT75usIexHxN0hSZ8QxEIT22znFRq9sbPl
	 073w4NRx1uQ6vHnHzVTXkGE+YwIVy4+T+r65IqUN6CSMfNK2VIHcObN09x8YkKcUgR
	 gavjGqNane+/ZmBBseZwCmu35T6B2OHI++Fh1RsQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732545AbfDXOuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:50:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:49512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732529AbfDXOuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:50:16 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8966721904;
        Wed, 24 Apr 2019 14:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556117416;
        bh=IoJr28PEMz5n/Dhgxj2n0LUIpvdjDkq8BuvPvwiB3O0=;
        h=From:To:Cc:Subject:Date:From;
        b=GQC8lRBu5EDHy4vb/Gaj9FeVOB+18XqArPA25kxoK4zCtDTBpdTsJo78/YTlx14LS
         0TjuJQmxX7QM8yd1NzSCFA6rgpxj3BsqcFarMPrH3sZqCz0OsVyuy8d1sYuNO51n1B
         vL4T9bpNULBy6IM+rhtQRrGaJp3LDku+wgYNwsy8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>, Jiri Kosina <jkosina@suse.cz>,
        Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 01/28] HID: logitech: check the return value of create_singlethread_workqueue
Date:   Wed, 24 Apr 2019 10:49:45 -0400
Message-Id: <20190424145012.30886-1-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kangjie Lu <kjlu@umn.edu>

[ Upstream commit 6c44b15e1c9076d925d5236ddadf1318b0a25ce2 ]

create_singlethread_workqueue may fail and return NULL. The fix checks if it is
NULL to avoid NULL pointer dereference.  Also, the fix moves the call of
create_singlethread_workqueue earlier to avoid resource-release issues.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-logitech-hidpp.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 2e2515a4c070..3198faf5cff4 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -1282,6 +1282,13 @@ static int hidpp_ff_init(struct hidpp_device *hidpp, u8 feature_index)
 		kfree(data);
 		return -ENOMEM;
 	}
+	data->wq = create_singlethread_workqueue("hidpp-ff-sendqueue");
+	if (!data->wq) {
+		kfree(data->effect_ids);
+		kfree(data);
+		return -ENOMEM;
+	}
+
 	data->hidpp = hidpp;
 	data->feature_index = feature_index;
 	data->version = version;
@@ -1326,7 +1333,6 @@ static int hidpp_ff_init(struct hidpp_device *hidpp, u8 feature_index)
 	/* ignore boost value at response.fap.params[2] */
 
 	/* init the hardware command queue */
-	data->wq = create_singlethread_workqueue("hidpp-ff-sendqueue");
 	atomic_set(&data->workqueue_size, 0);
 
 	/* initialize with zero autocenter to get wheel in usable state */
-- 
2.19.1

