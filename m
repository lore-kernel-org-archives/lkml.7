Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF909C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 967DD2147A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563997969;
	bh=wicaEYmtIV5y6GmC0+a9QH9oZedC4bhe34jblgb4bnw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NEzB6SJy45KMKjGyexjN7NVcsXe8Du3xMY9jravzTg11A1H3tCo4X64rYiS+RTyHf
	 GbYr2tGPHwlxpjwi2XRC5fNllXxk2iQ9ApMKxZH6DOjWqAPVqxxyU2owg9A3oRKSQh
	 E1C8unUt0zqlGwcC+bd6yO8gZBsvVqhGjfGvXUDY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391786AbfGXTws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:52:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:34822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391769AbfGXTwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:52:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE10F20665;
        Wed, 24 Jul 2019 19:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563997965;
        bh=wicaEYmtIV5y6GmC0+a9QH9oZedC4bhe34jblgb4bnw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xW8MOp2RA2c5Tkri2pZwV/LhA0RA3D3qpbJNzf04vB4IvUD3T31EONE3HIYLzOeCd
         rhGsM0wg0neTJ736VHZI7xBEfiVWzYpl5/Xby4hhOnAermnnvNBZpecXnXpy8XBW88
         HGjZ9YJweE5uTbA8OBzd9yIKVWDoHcZSBtfirsTA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ahmad Masri <amasri@codeaurora.org>,
        Maya Erez <merez@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 166/371] wil6210: drop old event after wmi_call timeout
Date:   Wed, 24 Jul 2019 21:18:38 +0200
Message-Id: <20190724191737.695395668@linuxfoundation.org>
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

[ Upstream commit 1a276003111c0404f6bfeffe924c5a21f482428b ]

This change fixes a rare race condition of handling WMI events after
wmi_call expires.

wmi_recv_cmd immediately handles an event when reply_buf is defined and
a wmi_call is waiting for the event.
However, in case the wmi_call has already timed-out, there will be no
waiting/running wmi_call and the event will be queued in WMI queue and
will be handled later in wmi_event_handle.
Meanwhile, a new similar wmi_call for the same command and event may
be issued. In this case, when handling the queued event we got WARN_ON
printed.

Fixing this case as a valid timeout and drop the unexpected event.

Signed-off-by: Ahmad Masri <amasri@codeaurora.org>
Signed-off-by: Maya Erez <merez@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/wil6210/wmi.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/wil6210/wmi.c b/drivers/net/wireless/ath/wil6210/wmi.c
index 63116f4b62c7..de52e532c105 100644
--- a/drivers/net/wireless/ath/wil6210/wmi.c
+++ b/drivers/net/wireless/ath/wil6210/wmi.c
@@ -3211,7 +3211,18 @@ static void wmi_event_handle(struct wil6210_priv *wil,
 		/* check if someone waits for this event */
 		if (wil->reply_id && wil->reply_id == id &&
 		    wil->reply_mid == mid) {
-			WARN_ON(wil->reply_buf);
+			if (wil->reply_buf) {
+				/* event received while wmi_call is waiting
+				 * with a buffer. Such event should be handled
+				 * in wmi_recv_cmd function. Handling the event
+				 * here means a previous wmi_call was timeout.
+				 * Drop the event and do not handle it.
+				 */
+				wil_err(wil,
+					"Old event (%d, %s) while wmi_call is waiting. Drop it and Continue waiting\n",
+					id, eventid2name(id));
+				return;
+			}
 
 			wmi_evt_call_handler(vif, id, evt_data,
 					     len - sizeof(*wmi));
-- 
2.20.1



