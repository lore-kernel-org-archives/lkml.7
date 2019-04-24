Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722F4C282E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 376B6218FD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556117124;
	bh=5E8ghuCRDC6tBp9SP1QbYoJ2EdMunqEPTBkuiYdcQ00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FTxNgC66NZ4UoWY4QT809uSfvPiY4lMO6pwGHMMFVOt7klEGnFqhf+m8ia8oq7FEv
	 0Kbb783wZXISu9YzTat5LYMYlckDzjRMr8u04u/8/KgJmmcQKY+uF1aAVbco395PtB
	 2kku1tT09OWigCw3C9U+qS7YRmlgw8Eibq+qrgCc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731492AbfDXOjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:39:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:41704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731250AbfDXOjS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:39:18 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD4B820684;
        Wed, 24 Apr 2019 14:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556116757;
        bh=5E8ghuCRDC6tBp9SP1QbYoJ2EdMunqEPTBkuiYdcQ00=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R0cWwW2vn5vfvLEGDss15u/A/mC/g2D0SmF+beR7TqoNH6Kddfb8i8S4J03g9QFE7
         cpJkvTy2crbIFC3w+gPz8+v/L/7aZQBB7hlooOAWsgRitVcp9Rdx9tTmbzsfF4zjfy
         HJg8aGytO4rTYu5/VudrQWFlk0r8YAb5OrhUTJhQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>, Jiri Kosina <jkosina@suse.cz>,
        Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 02/52] HID: logitech: check the return value of create_singlethread_workqueue
Date:   Wed, 24 Apr 2019 10:38:20 -0400
Message-Id: <20190424143911.28890-2-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190424143911.28890-1-sashal@kernel.org>
References: <20190424143911.28890-1-sashal@kernel.org>
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
index 19cc980eebce..8425d3548a41 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -1907,6 +1907,13 @@ static int hidpp_ff_init(struct hidpp_device *hidpp, u8 feature_index)
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
@@ -1951,7 +1958,6 @@ static int hidpp_ff_init(struct hidpp_device *hidpp, u8 feature_index)
 	/* ignore boost value at response.fap.params[2] */
 
 	/* init the hardware command queue */
-	data->wq = create_singlethread_workqueue("hidpp-ff-sendqueue");
 	atomic_set(&data->workqueue_size, 0);
 
 	/* initialize with zero autocenter to get wheel in usable state */
-- 
2.19.1

