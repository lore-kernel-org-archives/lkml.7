Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545EDC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 217C3215E5
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574888655;
	bh=1EzmoxlhEX6IlHcaaJRCa8HqlvFEPSAV4f3se9ynVhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q+w4Aida7y5tAL8KI8Kju6i5ACSUvehB1fUxi3RkJ0mGvoAm8zS0+LcBotyLgVu8E
	 BCkye8foa8NhB8qeTK/kwJd93tycmGOcmMgGNQIAZul83GyLYRo+/xkPNaOwpVBpfN
	 QnTy0pfM1sthLGGY7QzHVUdh/aD75jJHzBg6sPpc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731818AbfK0VEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:04:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:57576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731521AbfK0VEK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 16:04:10 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 368952086A;
        Wed, 27 Nov 2019 21:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574888649;
        bh=1EzmoxlhEX6IlHcaaJRCa8HqlvFEPSAV4f3se9ynVhc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XqEATSGVtfDAeM3v/59zDrtje653+l1feYJaqd15lYPHk4lsyKEHj5Urn/pebjcMS
         HQ/qZ60jzLn0W2OeqXY6lZwHkANlmGvlrIkLbx3wRDp2DTZg9+NRLv5SP7DG0tvSPb
         jLFe9YxvaYiwagmT9cYm+G5xvLV3AVc1FoYbUS4w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lior David <liord@codeaurora.org>,
        Maya Erez <merez@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 216/306] wil6210: fix locking in wmi_call
Date:   Wed, 27 Nov 2019 21:31:06 +0100
Message-Id: <20191127203130.864518018@linuxfoundation.org>
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

From: Lior David <liord@codeaurora.org>

[ Upstream commit dc57731dbd535880fe6ced31c229262c34df7d64 ]

Switch from spin_lock to spin_lock_irqsave, because
wmi_ev_lock is used inside interrupt handler.

Signed-off-by: Lior David <liord@codeaurora.org>
Signed-off-by: Maya Erez <merez@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/wil6210/wmi.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/wmi.c b/drivers/net/wireless/ath/wil6210/wmi.c
index 2010f771478df..8a603432f5317 100644
--- a/drivers/net/wireless/ath/wil6210/wmi.c
+++ b/drivers/net/wireless/ath/wil6210/wmi.c
@@ -1639,16 +1639,17 @@ int wmi_call(struct wil6210_priv *wil, u16 cmdid, u8 mid, void *buf, u16 len,
 {
 	int rc;
 	unsigned long remain;
+	ulong flags;
 
 	mutex_lock(&wil->wmi_mutex);
 
-	spin_lock(&wil->wmi_ev_lock);
+	spin_lock_irqsave(&wil->wmi_ev_lock, flags);
 	wil->reply_id = reply_id;
 	wil->reply_mid = mid;
 	wil->reply_buf = reply;
 	wil->reply_size = reply_size;
 	reinit_completion(&wil->wmi_call);
-	spin_unlock(&wil->wmi_ev_lock);
+	spin_unlock_irqrestore(&wil->wmi_ev_lock, flags);
 
 	rc = __wmi_send(wil, cmdid, mid, buf, len);
 	if (rc)
@@ -1668,12 +1669,12 @@ int wmi_call(struct wil6210_priv *wil, u16 cmdid, u8 mid, void *buf, u16 len,
 	}
 
 out:
-	spin_lock(&wil->wmi_ev_lock);
+	spin_lock_irqsave(&wil->wmi_ev_lock, flags);
 	wil->reply_id = 0;
 	wil->reply_mid = U8_MAX;
 	wil->reply_buf = NULL;
 	wil->reply_size = 0;
-	spin_unlock(&wil->wmi_ev_lock);
+	spin_unlock_irqrestore(&wil->wmi_ev_lock, flags);
 
 	mutex_unlock(&wil->wmi_mutex);
 
-- 
2.20.1



