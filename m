Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4A2C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65B9622BF3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564033213;
	bh=ecra6NhndktQb1ABtB6XprMkB2KL9fmxi/wiwOzJF8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YzQrQzQ8xRRvuRa1nGhulemjTffnnU936PyDtd64OmIKjtQv/UaLy4oYkzrSNF5cI
	 i2ypgqh6eA2d+0avic6yuDgwK4Nu2kQyxDMWjOzgxI3DiZqDs/qC74H3sAdU+yTx8G
	 JzRk701qF9AwSl8IJJ+7pAt4fEk+zqpIVMW/TGEM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404304AbfGYFkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 01:40:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:54582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404285AbfGYFkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 01:40:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1783922C7D;
        Thu, 25 Jul 2019 05:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564033207;
        bh=ecra6NhndktQb1ABtB6XprMkB2KL9fmxi/wiwOzJF8M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S4CfKy6Ir/4+69EGMalCCapXCOHjePHXymLeYdHJjmAx/GLqeifukSnbkIj3aB5oN
         G0sAlghhsMH3/BbcLx78fPDx3kMyWGeIkoIDKSMCwVisLj6yr8tOfI/dnSbRQt7Il4
         WW8Kn1cancgkoxUjN9Yys0lhhosNA/lxQtGvSO4o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ahmad Masri <amasri@codeaurora.org>,
        Maya Erez <merez@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 122/271] wil6210: drop old event after wmi_call timeout
Date:   Wed, 24 Jul 2019 21:19:51 +0200
Message-Id: <20190724191705.729673847@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191655.268628197@linuxfoundation.org>
References: <20190724191655.268628197@linuxfoundation.org>
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
index 6e3b3031f29b..2010f771478d 100644
--- a/drivers/net/wireless/ath/wil6210/wmi.c
+++ b/drivers/net/wireless/ath/wil6210/wmi.c
@@ -2816,7 +2816,18 @@ static void wmi_event_handle(struct wil6210_priv *wil,
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



