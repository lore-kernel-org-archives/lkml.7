Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E633AC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD50A214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563997473;
	bh=MPPw1uoU0k3SyAgvQYcNjMXtfzBpCdPnQhRHIqRxuuM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aeRDbKzznBxhdx1qo7eMrsQ5mIuhX0V94qP+81WIOhEfpIbGne6X3vWfV1/65s26T
	 ZKE6AKluUzq8bdGmOh5DlzAxJ4Se/OkEdsMutTPXoaLGUZe7fhTePv7EhUXhvvImf5
	 FGMSpFmdCrmRWI5G5dUuV85bpgM/6yOPKyq0fBfk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390828AbfGXToc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:44:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:47300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390810AbfGXTo1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:44:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3B0B214AF;
        Wed, 24 Jul 2019 19:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563997466;
        bh=MPPw1uoU0k3SyAgvQYcNjMXtfzBpCdPnQhRHIqRxuuM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vjoKBkZzkUO3XRYNtgapNVumIsUgBnTpp/qDnpDibo1vR11uSUTsEiqcltL5skdyt
         eYDO/zkc9unyFYnRGe42nQyGaEsM+QZHDO+TVV4rgPWNGM/a9RCydu/atwFQ3Qh3sq
         a8JT+1lmBvAWFt6DwIOBxKha8/XoPMgIWzkN6b40=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yingying Tang <yintang@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 006/371] ath10k: Check tx_stats before use it
Date:   Wed, 24 Jul 2019 21:15:58 +0200
Message-Id: <20190724191724.968079553@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191724.382593077@linuxfoundation.org>
References: <20190724191724.382593077@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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



