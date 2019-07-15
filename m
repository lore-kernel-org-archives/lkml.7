Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 386BDC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 13:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 027382083D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 13:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563197756;
	bh=NZraKEDuaB6vwvz8xVUkIR+7IQqLDfLfw8tb08+gex4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=z88QgJqcqGL6jKhiW82/2kunbWPxbc0YzAaCQeB1sze28oTv+02s40n+QQbBCRyVA
	 +cSqsKmqfxlxgLN9T333rYFZHY8Dg6d3crxYuWZN+kDC62C/0qjTsbCVnRvXYkEVP5
	 TcEaduKz/oN22JgJLfsyAa/EJduh1Y/wRZnrGHvI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730377AbfGONfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 09:35:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:58960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730012AbfGONfy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 09:35:54 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EA9D2067C;
        Mon, 15 Jul 2019 13:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563197753;
        bh=NZraKEDuaB6vwvz8xVUkIR+7IQqLDfLfw8tb08+gex4=;
        h=From:To:Cc:Subject:Date:From;
        b=sA/q7qK/JT7OgOyOo3n+66mDEh2siS8VOyCKvH1uB8PDNL+AREhnM+nQDeoS+0kK1
         fhZX+ICWXsUTDKRY2KMI8kOCMBwp1xDlcb61/NLOZrcZonQy/MdxlcA82sSqdImDv+
         HxJqb7yymYjOdKfJbFYTtbS8SlyjONsHmU3JAH0w=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yingying Tang <yintang@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 001/249] ath10k: Check tx_stats before use it
Date:   Mon, 15 Jul 2019 09:31:42 -0400
Message-Id: <20190715133550.1772-1-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yingying Tang <yintang@codeaurora.org>

[ Upstream commit 9e7251fa38978b85108c44743e1436d48e8d0d76 ]

tx_stats will be freed and set to NULL before debugfs_sta node is
removed in station disconnetion process. So if read the debugfs_sta
node there may be NULL pointer error. Add check for tx_stats before
use it to resove this issue.

Signed-off-by: Yingying Tang <yintang@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath10k/debugfs_sta.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/debugfs_sta.c b/drivers/net/wireless/ath/ath10k/debugfs_sta.c
index c704ae371c4d..42931a669b02 100644
--- a/drivers/net/wireless/ath/ath10k/debugfs_sta.c
+++ b/drivers/net/wireless/ath/ath10k/debugfs_sta.c
@@ -663,6 +663,13 @@ static ssize_t ath10k_dbg_sta_dump_tx_stats(struct file *file,
 
 	mutex_lock(&ar->conf_mutex);
 
+	if (!arsta->tx_stats) {
+		ath10k_warn(ar, "failed to get tx stats");
+		mutex_unlock(&ar->conf_mutex);
+		kfree(buf);
+		return 0;
+	}
+
 	spin_lock_bh(&ar->data_lock);
 	for (k = 0; k < ATH10K_STATS_TYPE_MAX; k++) {
 		for (j = 0; j < ATH10K_COUNTER_TYPE_MAX; j++) {
-- 
2.20.1

