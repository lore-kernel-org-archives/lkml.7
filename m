Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B744EC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90D95222CD
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573611097;
	bh=VgPPyE22Zgxe2jV9lOAP3R21u862evy97/e4M8bGaoo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mCjjCHZL0VNeZV8bJhlsOMzTSWDnn1ngkUz+i+A11zMEvENJAyn3xGoDTcRo3iTXB
	 CCDHQJEyt7+wTDaHgz3HtKWV2sp65kC4F2hFi8+qqgL77+GjJLOxhYGBgYBKkJIZpC
	 CwWoeJMlIO2gQXwiyaEQluQCUEFDM9aM0orpN9jg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbfKMCLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 21:11:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:52660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730089AbfKMB6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 20:58:43 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3375E2053B;
        Wed, 13 Nov 2019 01:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573610322;
        bh=VgPPyE22Zgxe2jV9lOAP3R21u862evy97/e4M8bGaoo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dwQJEedrzBtEBKTIYBRY96kzBig89VjTImCrPEPZMZj9lySP75nZlK387vZEK2WgE
         dWsnxcziFY0T03/YXMPHDBBSxmmsxYC7hh5XRJ2fxqON+iaMMH4BBobfNqASiT17BT
         naH/YDk4MU5Bou5kawfcYzwbEddg46jba6UwcpBQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 084/115] reset: Fix potential use-after-free in __of_reset_control_get()
Date:   Tue, 12 Nov 2019 20:55:51 -0500
Message-Id: <20191113015622.11592-84-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113015622.11592-1-sashal@kernel.org>
References: <20191113015622.11592-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit b790c8ea5593d6dc3580adfad8e117eeb56af874 ]

Calling of_node_put() decreases the reference count of a device tree
object, and may free some data.

However, the of_phandle_args structure embedding it is passed to
reset_controller_dev.of_xlate() after that, so it may still be accessed.

Move the call to of_node_put() down to fix this.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[p.zabel@pengutronix.de: moved of_node_put after mutex_unlock]
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/reset/core.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index da4292e9de978..72b96b5c75a8f 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -466,28 +466,29 @@ struct reset_control *__of_reset_control_get(struct device_node *node,
 			break;
 		}
 	}
-	of_node_put(args.np);
 
 	if (!rcdev) {
-		mutex_unlock(&reset_list_mutex);
-		return ERR_PTR(-EPROBE_DEFER);
+		rstc = ERR_PTR(-EPROBE_DEFER);
+		goto out;
 	}
 
 	if (WARN_ON(args.args_count != rcdev->of_reset_n_cells)) {
-		mutex_unlock(&reset_list_mutex);
-		return ERR_PTR(-EINVAL);
+		rstc = ERR_PTR(-EINVAL);
+		goto out;
 	}
 
 	rstc_id = rcdev->of_xlate(rcdev, &args);
 	if (rstc_id < 0) {
-		mutex_unlock(&reset_list_mutex);
-		return ERR_PTR(rstc_id);
+		rstc = ERR_PTR(rstc_id);
+		goto out;
 	}
 
 	/* reset_list_mutex also protects the rcdev's reset_control list */
 	rstc = __reset_control_get_internal(rcdev, rstc_id, shared);
 
+out:
 	mutex_unlock(&reset_list_mutex);
+	of_node_put(args.np);
 
 	return rstc;
 }
-- 
2.20.1

